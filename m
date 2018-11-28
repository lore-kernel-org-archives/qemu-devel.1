Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gRoLB-00046W-0b
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gRoL6-00033c-Ua
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:08:32 -0500
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130]:54956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gRoL6-000331-P2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:08:28 -0500
Received: by mail-it1-x130.google.com with SMTP id m123-v6so1734114ita.4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 17:08:28 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue, 27 Nov 2018 20:08:17 -0500
Message-Id: <20181128010817.6191-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, berkus@gmail.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

>From af4497f2b161bb4165acb8eee5cae3f2a7ea2227 Mon Sep 17 00:00:00 2001
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue, 27 Nov 2018 20:01:20 -0500
Subject: [PATCH] ui/cocoa.m: fix crash due to cocoa_refresh() on Mac OS 10.14

Mac OS 10.14 only wants UI code to be called from the main thread. The
cocoa_refresh() function is called on another thread and this causes a
crash to take place. To fix this problem the cocoa_refresh() code is
called from the main thread only. 

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 59 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ecf12bfc2e..17c168d08f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -972,6 +972,8 @@ - (void)openDocumentation:(NSString *)filename;
 - (IBAction) do_about_menu_item: (id) sender;
 - (void)make_about_window;
 - (void)adjustSpeed:(id)sender;
+- (void) cocoa_refresh;
+- (void) cocoa_refresh_internal: (id) dummy;
 @end
 
 @implementation QemuCocoaAppController
@@ -1406,6 +1408,37 @@ - (void)adjustSpeed:(id)sender
     COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentage(), '%');
 }
 
+- (void) cocoa_refresh
+{
+    [self performSelectorOnMainThread: @selector(cocoa_refresh_internal:) withObject: nil waitUntilDone: YES];
+}
+
+- (void) cocoa_refresh_internal: (id) dummy
+{
+    COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
+    graphic_hw_update(NULL);
+
+    if (qemu_input_is_absolute()) {
+        if (![cocoaView isAbsoluteEnabled]) {
+            if ([cocoaView isMouseGrabbed]) {
+                [cocoaView ungrabMouse];
+            }
+        }
+        [cocoaView setAbsoluteEnabled:YES];
+    }
+
+    NSDate *distantPast;
+    NSEvent *event;
+    distantPast = [NSDate distantPast];
+    do {
+        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
+                                      inMode: NSDefaultRunLoopMode dequeue:YES];
+        if (event != nil) {
+            [cocoaView handleEvent:event];
+        }
+    } while(event != nil);
+}
+
 @end
 
 
@@ -1579,31 +1612,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 
 static void cocoa_refresh(DisplayChangeListener *dcl)
 {
-    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
-
-    COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
-    graphic_hw_update(NULL);
-
-    if (qemu_input_is_absolute()) {
-        if (![cocoaView isAbsoluteEnabled]) {
-            if ([cocoaView isMouseGrabbed]) {
-                [cocoaView ungrabMouse];
-            }
-        }
-        [cocoaView setAbsoluteEnabled:YES];
-    }
-
-    NSDate *distantPast;
-    NSEvent *event;
-    distantPast = [NSDate distantPast];
-    do {
-        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
-                        inMode: NSDefaultRunLoopMode dequeue:YES];
-        if (event != nil) {
-            [cocoaView handleEvent:event];
-        }
-    } while(event != nil);
-    [pool release];
+    [[NSApp delegate] cocoa_refresh];
 }
 
 static void cocoa_cleanup(void)
-- 
2.14.3 (Apple Git-98)
