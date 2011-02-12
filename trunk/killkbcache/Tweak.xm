/** Name: KillKBCache
    Type: SpringBoard extension
    Desc: Disable KBCache in iOS 4.2.1+ (Inspired by ashikase's ShowCase)
          ( https://github.com/ashikase/ShowCase )
    License: New BSD
*/


#include <objc/runtime.h>
@interface CALayer : NSObject
- (void)_display;
@end

@interface UIKeyboardImpl : UIView
+ (id)activeInstance;
@end

@interface UIKBKeyplaneView : UIView @end

@interface UIKeyboardLayout : UIView @end
@interface UIKeyboardLayoutStar : UIKeyboardLayout
@property(assign, nonatomic) BOOL shift;
@end

@interface UIKBShape : NSObject @end
@interface UIKBKey : UIKBShape
@property(copy, nonatomic) NSString *name;
@end


%hook UIKeyboardCache

- (void)displayView:(id)view withKey:(id)key fromLayout:(id)layout
{
    // Complete disable keyboard cache function
    [[view layer] _display];
}

%end


__attribute__((constructor)) static void init()
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    if (objc_getClass("UIKeyboardCache") != nil)
        %init;

    [pool release];
}

