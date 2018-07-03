Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1faAcU-0006bT-2u
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1faAcP-0004db-4P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:00:42 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:46634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1faAcO-0004cj-V4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:00:37 -0400
Received: by mail-io0-x22b.google.com with SMTP id p7-v6so295902ioh.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 19:00:36 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon,  2 Jul 2018 22:00:17 -0400
Message-Id: <20180703020017.1032-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] ui/cocoa.m: prevent stuck command key when
 going into full screen mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

When the user pushes Command-F in QEMU while the mouse is ungrabbed, QEMU
goes into full screen mode. When the user finally releases the command key,
it is sent to the guest as an event. The makes the guest operating system
think the command key is down when it is really up. To prevent this situation
from happening, we simply drop the first command key event after the user has
gone into full screen mode using Command-F.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
Code changes now confined to the handleEvent: method.

 ui/cocoa.m | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2991ed4..9be4811 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -637,6 +637,7 @@ QemuCocoaView *cocoaView;
     int buttons = 0;
     int keycode = 0;
     bool mouse_event = false;
+    static bool switched_to_fullscreen = false;
     NSPoint p = [event locationInWindow];
 
     switch ([event type]) {
@@ -681,7 +682,11 @@ QemuCocoaView *cocoaView;
                     keycode == Q_KEY_CODE_NUM_LOCK) {
                     [self toggleStatefulModifier:keycode];
                 } else if (qemu_console_is_graphic(NULL)) {
-                  [self toggleModifier:keycode];
+                    if (switched_to_fullscreen) {
+                        switched_to_fullscreen = false;
+                    } else {
+                        [self toggleModifier:keycode];
+                    }
                 }
             }
 
@@ -691,6 +696,13 @@ QemuCocoaView *cocoaView;
 
             // forward command key combos to the host UI unless the mouse is grabbed
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
+                /*
+                 * Prevent the command key from being stuck down in the guest
+                 * when using Command-F to switch to full screen mode.
+                 */
+                if (keycode == Q_KEY_CODE_F) {
+                    switched_to_fullscreen = true;
+                }
                 [NSApp sendEvent:event];
                 return;
             }
-- 
2.7.2
