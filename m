Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9BEC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 17:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DB6206D3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 17:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvtLEIen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DB6206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixwEM-0004eA-0P
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixwDH-0004Fd-LH
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixwDD-00028K-8q
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:05:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:50390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixwDD-000275-1N
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 12:05:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id a5so11358139wmb.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vJZdGsFepjnpm6WZn1dpww8GMlowz78uy3Ennd3ZNH8=;
 b=FvtLEIen8dECoa/cmWKa709ELjTV32pXMjntxvtPLD5ckR0BhgRlSMo0liLD7L/xFQ
 /IHnUrgU1GXgzE1Jayi9uJjfDS+1z3sSOrQ6nPZ0+4WtMWmi+kqVAx2A2oYJsO6slEnz
 NMfNbbfVTNNsV4IPqDiowuaXpStUFarXp3OSnb2S2lssrXKY6LkUDLTBlwWqxS/4mAMC
 EJ6iEaBAhPXJz3HqAMANAZzym5EjdB1dZMGneZuuMdDmCcAa69bdPBj7M7CvByGQGGyn
 TmurHSDhzgBKlGFTMVdZQoPJ63CU8WvoJyGJPm9xjNrQ/g/AZ0QQY2QRpFvZ0bOY215Q
 TJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vJZdGsFepjnpm6WZn1dpww8GMlowz78uy3Ennd3ZNH8=;
 b=E0mLikRdHj7TaEWwnyjiW1vr1pP/R/Br+lCEKG6fg14xrCpzF3akieuaBPu+BxC2yn
 KV1rD9J5uiqSVj6oWhwGbCmBi6mmWTiJ0hxDF34XmUpQeiEF6rAW6b0E8QHE8QK67dXD
 vVOvS/RIceUSR+o07KIoMPTmtPI8r8BBKbsViy16ivvDnVxuIWM8SYzvVtcrsKZW1l6b
 DmkHSyJZGMTbF7uHvQ5glLaciBSwu6IemFN//2f99ah7mpUQUWCpse3BIBYA34czrhpE
 Oz2oa6bGMb61FpH7OMo/vjtcCLAHVTJF80+1KB1lybRPCScqnE6JDyeRQqfkxWGwsUOc
 WG+g==
X-Gm-Message-State: APjAAAXM53a/RqPfDX5Pmblvc9IaSy91g1euU76YxEn1XQeHpJp+GfE0
 RHQncH+oKQ1JxYyYvSzX38ZRjnR/G29luA==
X-Google-Smtp-Source: APXvYqzTW8FV48zDWwppsYE6OhjLG4Gv7q0pl6F58+U+eT95oloLbbHWupSGXSFpf0h1J+5xG1qVow==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr18823891wml.171.1580576736706; 
 Sat, 01 Feb 2020 09:05:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o4sm17266215wrx.25.2020.02.01.09.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 09:05:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
Date: Sat,  1 Feb 2020 17:05:34 +0000
Message-Id: <20200201170534.22123-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our official OSX support policy covers the last two released versions.
Currently that is 10.14 and 10.15.  We also may work on older versions, but
don't guarantee it.

In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
versions (see LP:1861551). We don't intend to fix that, so we might
as well drop the code in ui/cocoa.m which caters for pre-10.12
versions as well. (For reference, 10.11 fell out of Apple extended
security support in September 2018.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The bug report is recent, but this was also pointed out on
the mailing list back in June 2019. Since nobody has cared
to try to fix it, we clearly don't care about 10.11 in
practice as well as in theory.]
---
 ui/cocoa.m | 59 ------------------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fbb5b1b45f..f9945bc712 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -42,60 +42,10 @@
 #include <Carbon/Carbon.h>
 #include "hw/core/cpu.h"
 
-#ifndef MAC_OS_X_VERSION_10_5
-#define MAC_OS_X_VERSION_10_5 1050
-#endif
-#ifndef MAC_OS_X_VERSION_10_6
-#define MAC_OS_X_VERSION_10_6 1060
-#endif
-#ifndef MAC_OS_X_VERSION_10_9
-#define MAC_OS_X_VERSION_10_9 1090
-#endif
-#ifndef MAC_OS_X_VERSION_10_10
-#define MAC_OS_X_VERSION_10_10 101000
-#endif
-#ifndef MAC_OS_X_VERSION_10_12
-#define MAC_OS_X_VERSION_10_12 101200
-#endif
 #ifndef MAC_OS_X_VERSION_10_13
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
 
-/* macOS 10.12 deprecated many constants, #define the new names for older SDKs */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
-#define NSEventMaskAny                  NSAnyEventMask
-#define NSEventModifierFlagCapsLock     NSAlphaShiftKeyMask
-#define NSEventModifierFlagShift        NSShiftKeyMask
-#define NSEventModifierFlagCommand      NSCommandKeyMask
-#define NSEventModifierFlagControl      NSControlKeyMask
-#define NSEventModifierFlagOption       NSAlternateKeyMask
-#define NSEventTypeFlagsChanged         NSFlagsChanged
-#define NSEventTypeKeyUp                NSKeyUp
-#define NSEventTypeKeyDown              NSKeyDown
-#define NSEventTypeMouseMoved           NSMouseMoved
-#define NSEventTypeLeftMouseDown        NSLeftMouseDown
-#define NSEventTypeRightMouseDown       NSRightMouseDown
-#define NSEventTypeOtherMouseDown       NSOtherMouseDown
-#define NSEventTypeLeftMouseDragged     NSLeftMouseDragged
-#define NSEventTypeRightMouseDragged    NSRightMouseDragged
-#define NSEventTypeOtherMouseDragged    NSOtherMouseDragged
-#define NSEventTypeLeftMouseUp          NSLeftMouseUp
-#define NSEventTypeRightMouseUp         NSRightMouseUp
-#define NSEventTypeOtherMouseUp         NSOtherMouseUp
-#define NSEventTypeScrollWheel          NSScrollWheel
-#define NSTextAlignmentCenter           NSCenterTextAlignment
-#define NSWindowStyleMaskBorderless     NSBorderlessWindowMask
-#define NSWindowStyleMaskClosable       NSClosableWindowMask
-#define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
-#define NSWindowStyleMaskTitled         NSTitledWindowMask
-#endif
-/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
- * NSModalResponseOK, which was introduced in 10.9. Define
- * it for older versions.
- */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
-#define NSModalResponseOK NSFileHandlingPanelOKButton
-#endif
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -465,11 +415,7 @@ - (void) drawRect:(NSRect) rect
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
 
     // get CoreGraphic context
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10
-    CGContextRef viewContextRef = [[NSGraphicsContext currentContext] graphicsPort];
-#else
     CGContextRef viewContextRef = [[NSGraphicsContext currentContext] CGContext];
-#endif
 
     CGContextSetInterpolationQuality (viewContextRef, kCGInterpolationNone);
     CGContextSetShouldAntialias (viewContextRef, NO);
@@ -1075,9 +1021,7 @@ - (void) raiseAllKeys
  ------------------------------------------------------
 */
 @interface QemuCocoaAppController : NSObject
-#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6)
                                        <NSWindowDelegate, NSApplicationDelegate>
-#endif
 {
 }
 - (void)doToggleFullScreen:(id)sender;
@@ -1126,9 +1070,6 @@ - (id) init
         [normalWindow setAcceptsMouseMovedEvents:YES];
         [normalWindow setTitle:@"QEMU"];
         [normalWindow setContentView:cocoaView];
-#if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10)
-        [normalWindow useOptimizedDrawing:YES];
-#endif
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
         [normalWindow setDelegate: self];
-- 
2.17.2 (Apple Git-113)


