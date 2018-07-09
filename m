Received: from eggs.gnu.org ([2001:4830:134:3::10]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fcXgh-0004wT-GQ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fcXgc-0005Me-Ht
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:02:51 -0400
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:38386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fcXgc-0005M2-Cr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:02:46 -0400
Received: by mail-io0-x232.google.com with SMTP id v26-v6so17335160iog.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:02:46 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon,  9 Jul 2018 11:02:35 -0400
Message-Id: <20180709150235.7573-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3] ui/cocoa.m: replace scrollingDeltaY with
 deltaY
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

The NSEvent class method scrollingDeltaY is available
for Mac OS 10.7 and newer. Since QEMU supports Mac OS
10.5 and up, we need to be using a method that is
available on these version of Mac OS X. The deltaY
method is a method that does the same thing as
scrollingDeltaY and is available on Mac OS 10.5 and
up. So we replace scrollingDeltaY with deltaY. 

We only check deltaY's value if it is not zero
because zero means no scrolling took place.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v3 changes:
- Added a comment explaining why we drop scrolling events in both the code and
the patch comment.

v2 changes:
- Added a condition that drops scroll events that have a deltaY value of zero.

 ui/cocoa.m | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2991ed4f19..3bae090101 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -802,14 +802,19 @@ - (void) handleEvent:(NSEvent *)event
              * This is in-line with standard Mac OS X UI behaviour.
              */
 
+            /*
+             * When deltaY is zero, it means the scrolling device did not move
+             * for this event. So we drop the event.
+             */
+            if ([event deltaY] != 0) {
             /* Determine if this is a scroll up or scroll down event */
-            buttons = ([event scrollingDeltaY] > 0) ?
-                INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
-            qemu_input_queue_btn(dcl->con, buttons, true);
-            qemu_input_event_sync();
-            qemu_input_queue_btn(dcl->con, buttons, false);
-            qemu_input_event_sync();
-
+                buttons = ([event deltaY] > 0) ?
+                    INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN;
+                qemu_input_queue_btn(dcl->con, buttons, true);
+                qemu_input_event_sync();
+                qemu_input_queue_btn(dcl->con, buttons, false);
+                qemu_input_event_sync();
+            }
             /*
              * Since deltaY also reports scroll wheel events we prevent mouse
              * movement code from executing.
-- 
2.14.3 (Apple Git-98)
