Received: from eggs.gnu.org ([2001:4830:134:3::10]:35565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rw-0005ml-Av
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rl-0008Ku-Eu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db4rl-0008KD-5j
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3F81ADA1F
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:59:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 14:59:33 +0200
Message-Id: <20170728125935.18167-2-kraxel@redhat.com>
In-Reply-To: <20170728125935.18167-1-kraxel@redhat.com>
References: <20170728125935.18167-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] ui: correctly detect spice PAUSE scancode
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The SPICE input code is currently detcting 0xe1 0x1d 0x45 as
the PAUSE key make sequence and 0xe1 0x9d 0xc5 as the break
sequence. This is incorrect, because all 6 scancodes together
are the make sequence, and there is no break sequence.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170727174640.30359-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
@@ -58,6 +59,18 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
         kbd->emul0 = true;
         return;
     }
+
+    if (scancode == pauseseq[kbd->pauseseq]) {
+        kbd->pauseseq++;
+        if (kbd->pauseseq == G_N_ELEMENTS(pauseseq)) {
+            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, true);
+            kbd->pauseseq = 0;
+        }
+        return;
+    } else {
+        kbd->pauseseq = 0;
+    }
+
     keycode = scancode & ~SCANCODE_UP;
     up = scancode & SCANCODE_UP;
     if (kbd->emul0) {
@@ -65,25 +78,6 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
         keycode |= SCANCODE_GREY;
     }
 
-    if (scancode == SCANCODE_EMUL1) {
-        kbd->pauseseq++;
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
-            kbd->pauseseq = 0;
-            return;
-        }
-        kbd->pauseseq = 0;
-    }
-
     qemu_input_event_send_key_number(NULL, keycode, !up);
 }
 
-- 
2.9.3
