Received: from eggs.gnu.org ([2001:4830:134:3::10]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eYbpV-0000MK-IJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eYbpR-0001xX-Ji
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:07:25 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eYbpR-0001wt-EL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:07:21 -0500
Received: by mail-io0-x243.google.com with SMTP id e20so15511851iof.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:07:21 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon,  8 Jan 2018 13:07:07 -0500
Message-Id: <20180108180707.7976-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] cocoa.m: Fix scroll wheel support
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

When using a mouse's scroll wheel in a guest with
the cocoa front-end, the mouse pointer moves up
and down instead of scrolling the window. This
patch fixes this problem.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..6be9848391 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -786,11 +786,24 @@ - (void) handleEvent:(NSEvent *)event
             mouse_event = true;
             break;
         case NSEventTypeScrollWheel:
-            if (isMouseGrabbed) {
-                buttons |= ([event deltaY] < 0) ?
-                    MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
-            }
-            mouse_event = true;
+            /*
+             * Send wheel events to the guest regardless of window focus.
+             * This is in-line with standard Mac OS X UI behaviour.
+             */
+
+            /* Determine if this is a scroll up or scroll down event */
+            buttons = ([event scrollingDeltaY] > 0) ?
+                INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
+            qemu_input_queue_btn(dcl->con, buttons, true);
+            qemu_input_event_sync();
+            qemu_input_queue_btn(dcl->con, buttons, false);
+            qemu_input_event_sync();
+
+            /*
+             * Since deltaY also reports scroll wheel events we prevent mouse
+             * movement code from executing.
+             */
+            mouse_event = false;
             break;
         default:
             [NSApp sendEvent:event];
@@ -809,9 +822,7 @@ - (void) handleEvent:(NSEvent *)event
             static uint32_t bmap[INPUT_BUTTON__MAX] = {
                 [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
                 [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON,
-                [INPUT_BUTTON_WHEEL_UP]   = MOUSE_EVENT_WHEELUP,
-                [INPUT_BUTTON_WHEEL_DOWN] = MOUSE_EVENT_WHEELDN,
+                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
             };
             qemu_input_update_buttons(dcl->con, bmap, last_buttons, buttons);
             last_buttons = buttons;
-- 
2.14.3 (Apple Git-98)
