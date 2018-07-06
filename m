Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fbGsp-000398-OE
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 22:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fbGsk-0006U9-Tn
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 22:54:07 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:46985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fbGsk-0006Tn-Oz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 22:54:02 -0400
Received: by mail-io0-x241.google.com with SMTP id p7-v6so9575956ioh.13
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 19:54:02 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Jul 2018 22:53:52 -0400
Message-Id: <20180706025352.42643-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] ui/cocoa.m: replace scrollingDeltaY with
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
up. So we simply replace scrollingDeltaY with deltaY.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
- Added a condition that drops scroll events that have a deltaY value of zero.

 ui/cocoa.m | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2991ed4..f371469 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -802,14 +802,15 @@ QemuCocoaView *cocoaView;
              * This is in-line with standard Mac OS X UI behaviour.
              */
 
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
2.7.2
