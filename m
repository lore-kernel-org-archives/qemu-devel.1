Received: from eggs.gnu.org ([2001:4830:134:3::10]:46937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fRNaH-0006Rw-L4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fRNaE-0004hj-Hs
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:02:05 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fRNaE-0004hZ-CV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:02:02 -0400
Received: by mail-it0-x244.google.com with SMTP id k17-v6so5917471ita.0
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 13:02:02 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Fri,  8 Jun 2018 16:01:50 -0400
Message-Id: <20180608200150.7032-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: fix absolute mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Fix the cocoa front-end to correctly be able to use absolute mode.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2991ed4f19..dda99ad638 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -350,9 +350,20 @@ - (BOOL) isOpaque
     return YES;
 }
 
-- (BOOL) screenContainsPoint:(NSPoint) p
+/* Returns YES if the host mouse cursor is in the QEMU window, NO otherwise */
+- (BOOL) mouseInWindow
 {
-    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.height);
+    NSPoint p = [NSEvent mouseLocation];
+    BOOL return_value = NO;
+    float x, y, width, height;
+    x = [normalWindow frame].origin.x;
+    y = [normalWindow frame].origin.y;
+    width = [[normalWindow contentView] frame].size.width;
+    height = [[normalWindow contentView] frame].size.height;
+    if (p.x >= x && p.y >= y && p.x <= (x + width) && p.y <= (y + height)) {
+        return_value = YES;
+    }
+    return return_value;
 }
 
 - (void) hideCursor
@@ -637,7 +648,6 @@ - (void) handleEvent:(NSEvent *)event
     int buttons = 0;
     int keycode = 0;
     bool mouse_event = false;
-    NSPoint p = [event locationInWindow];
 
     switch ([event type]) {
         case NSEventTypeFlagsChanged:
@@ -738,17 +748,22 @@ - (void) handleEvent:(NSEvent *)event
             break;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
-                if (![self screenContainsPoint:p] || ![[self window] isKeyWindow]) {
+                if ([self mouseInWindow]) {
+                    mouse_event = true;
+                }
+
+                if (![self mouseInWindow] || ![[self window] isKeyWindow]) {
                     if (isMouseGrabbed) {
                         [self ungrabMouse];
                     }
                 } else {
-                    if (!isMouseGrabbed) {
+                    if (!isMouseGrabbed && [self mouseInWindow]) {
                         [self grabMouse];
                     }
                 }
+            } else {
+                mouse_event = true;
             }
-            mouse_event = true;
             break;
         case NSEventTypeLeftMouseDown:
             if ([event modifierFlags] & NSEventModifierFlagCommand) {
@@ -784,7 +799,7 @@ - (void) handleEvent:(NSEvent *)event
             break;
         case NSEventTypeLeftMouseUp:
             mouse_event = true;
-            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
+            if (!isMouseGrabbed && [self mouseInWindow]) {
                 if([[self window] isKeyWindow]) {
                     [self grabMouse];
                 }
@@ -844,7 +859,8 @@ - (void) handleEvent:(NSEvent *)event
                  * The check on screenContainsPoint is to avoid sending out of range values for
                  * clicks in the titlebar.
                  */
-                if ([self screenContainsPoint:p]) {
+                if ([self mouseInWindow]) {
+                    NSPoint p = [event locationInWindow];
                     qemu_input_queue_abs(dcl->con, INPUT_AXIS_X, p.x, 0, screen.width);
                     qemu_input_queue_abs(dcl->con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
                 }
-- 
2.14.3 (Apple Git-98)
