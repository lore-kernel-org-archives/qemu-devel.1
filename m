Received: from eggs.gnu.org ([2001:4830:134:3::10]:49057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eVK1j-0006Zz-7A
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 11:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eVK1e-0007Jy-Rr
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 11:30:26 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:39164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eVK1e-0007J0-NF
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 11:30:22 -0500
Received: by mail-io0-x244.google.com with SMTP id g70so31162864ioj.6
	for <qemu-devel@nongnu.org>; Sat, 30 Dec 2017 08:30:22 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Sat, 30 Dec 2017 11:30:12 -0500
Message-Id: <20171230163012.95032-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] cocoa.m: Fix scroll wheel support
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

When using a mouse's scroll wheel in a guest with the cocoa front-end, the mouse pointer moves up and down instead of scrolling the window. This patch fixes this problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..d2e5f80b74 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -786,11 +786,18 @@ - (void) handleEvent:(NSEvent *)event
             mouse_event = true;
             break;
         case NSEventTypeScrollWheel:
-            if (isMouseGrabbed) {
-                buttons |= ([event deltaY] < 0) ?
-                    MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
-            }
-            mouse_event = true;
+            /* Determine if this is a scroll up or scroll down event */
+            buttons = ([event scrollingDeltaY] > 0) ?
+                INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
+            qemu_input_queue_btn(dcl->con, buttons, true);
+            qemu_input_event_sync();
+            qemu_input_queue_btn(dcl->con, buttons, false);
+            qemu_input_event_sync();
+            /*
+             * Since deltaY also reports scroll wheel events we prevent mouse
+             * movement code from executing.
+             */
+            mouse_event = false;
             break;
         default:
             [NSApp sendEvent:event];
-- 
2.14.3 (Apple Git-98)
