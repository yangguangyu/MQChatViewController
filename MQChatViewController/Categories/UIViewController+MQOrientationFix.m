//
//  UIViewController_MQOrientation.m
//  MeiQiaSDK
//
//  Created by ian luo on 16/3/14.
//  Copyright © 2016年 MeiQia Inc. All rights reserved.
//

#import "UIViewController+MQOrientationFix.h"

@implementation UIViewController(MQOrientationFix)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([self supportsPortait]) {
        return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    }
    
    if ([self supportsLandscape]) {
        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    }
    
    return YES;
}

- (BOOL)shouldAutorotate {
    return [self supportsLandscape] && [self supportsPortait];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIInterfaceOrientationMask supportedOrientation = 0;
    if ([self supportsLandscape]) {
        supportedOrientation |= UIInterfaceOrientationMaskLandscape;
    }
    
    if ([self supportsPortait]) {
        supportedOrientation |= UIInterfaceOrientationMaskPortrait;
        supportedOrientation |= UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    
    return supportedOrientation;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [UIApplication sharedApplication].statusBarOrientation;
}

#pragma mark - private

- (NSArray *)supportedOrientations {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UISupportedInterfaceOrientations"];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UISupportedInterfaceOrientations~ipad"];
    } else {
        return @[@"UIInterfaceOrientationPortrait"];
    }
}

- (BOOL)supportsPortait {
    NSArray *supportedOrientation = [self supportedOrientations];
    BOOL support = NO;
    
    if ([supportedOrientation containsObject:@"UIInterfaceOrientationPortrait"] ||
        [supportedOrientation containsObject:@"UIInterfaceOrientationPortraitUpsideDown"]) {
        support = YES;
    }
    
    return support;
}

- (BOOL)supportsLandscape {
    NSArray *supportedOrientation = [self supportedOrientations];
    BOOL support = NO;
    
    if ([supportedOrientation containsObject:@"UIInterfaceOrientationLandscapeLeft"] ||
        [supportedOrientation containsObject:@"UIInterfaceOrientationLandscapeRight"]) {
        support = YES;
    }
    
    return support;
}

@end