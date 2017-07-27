Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dams9-0007O3-M4
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 13:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dams4-0002RH-V6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 13:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dams4-0002QI-OZ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 13:46:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE443C0D473F
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 17:46:47 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 27 Jul 2017 18:46:40 +0100
Message-Id: <20170727174640.30359-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: correctly detect spice PAUSE scancode
 sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The SPICE input code is currently detcting 0xe1 0x1d 0x45 as
the PAUSE key make sequence and 0xe1 0x9d 0xc5 as the break
sequence. This is incorrect, because all 6 scancodes together
are the make sequence, and there is no break sequence.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/spice-input.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index cda9976469..3d41aa1831 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -50,6 +50,7 @@ static const SpiceKbdInterface kbd_interface = {
 
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
 {
+    static const uint8_t pauseseq[] = { 0xe1, 0x1d, 0x45, 0xe1, 0x9d, 0xc5 };
     QemuSpiceKbd *kbd = container_of(sin, QemuSpiceKbd, sin);
     int keycode;
     bool up;
@@ -58,32 +59,25 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
         kbd->emul0 = true;
         return;
     }
-    keycode = scancode & ~SCANCODE_UP;
-    up = scancode & SCANCODE_UP;
-    if (kbd->emul0) {
-        kbd->emul0 = false;
-        keycode |= SCANCODE_GREY;
-    }
 
-    if (scancode == SCANCODE_EMUL1) {
+    if (scancode == pauseseq[kbd->pauseseq]) {
         kbd->pauseseq++;
-        return;
-    } else if (kbd->pauseseq == 1) {
-        if (keycode == 0x1d) {
-            kbd->pauseseq++;
-            return;
-        } else {
-            kbd->pauseseq = 0;
-        }
-    } else if (kbd->pauseseq == 2) {
-        if (keycode == 0x45) {
-            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, !up);
+        if (kbd->pauseseq == G_N_ELEMENTS(pauseseq)) {
+            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, true);
             kbd->pauseseq = 0;
-            return;
         }
+        return;
+    } else {
         kbd->pauseseq = 0;
     }
 
+    keycode = scancode & ~SCANCODE_UP;
+    up = scancode & SCANCODE_UP;
+    if (kbd->emul0) {
+        kbd->emul0 = false;
+        keycode |= SCANCODE_GREY;
+    }
+
     qemu_input_event_send_key_number(NULL, keycode, !up);
 }
 
-- 
2.13.3
