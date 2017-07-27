Received: from eggs.gnu.org ([2001:4830:134:3::10]:33556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLI-0003HO-1M
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLD-0001rg-Rl
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dajLD-0001pH-5q
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17C54E7B6B
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:00:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 16:00:25 +0200
Message-Id: <20170727140025.392-8-kraxel@redhat.com>
In-Reply-To: <20170727140025.392-1-kraxel@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] ps2: fix sending of PAUSE/BREAK scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The processing of the scancodes for PAUSE/BREAK  has been broken since
the conversion to qcodes in:

  commit 8c10e0baf0260b59a4e984744462a18016662e3e
  Author: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
  Date:   Thu Sep 15 22:06:26 2016 +0200

    ps2: use QEMU qcodes instead of scancodes

When using a VNC client, with the raw scancode extension, the client
will send a scancode of 0xc6 for both PAUSE and BREAK. There is mistakenl=
y
no entry in the qcode_to_number table for this scancode, so
ps2_keyboard_event() just generates a log message and discards the
scancode

When using a SPICE client, it will also send 0xc6 for BREAK, but
will send 0xe1 0x1d 0x45 0xe1 0x9d 0xc5 for PAUSE. There is no
entry in the qcode_to_number table for the scancode 0xe1 because
it is a special XT keyboard prefix not mapping to any QKeyCode.
Again ps2_keyboard_event() just generates a log message and discards
the scancode. The following 0x1d, 0x45, 0x9d, 0xc5 scancodes get
handled correctly. Rather than trying to handle 3 byte sequences
of scancodes in the PS/2 driver, special case the SPICE input
code so that it captures the 3 byte pause sequence and turns it
into a Pause QKeyCode.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170727113243.23991-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.h      |  1 +
 ui/input-keymap.c |  1 +
 ui/spice-input.c  | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 47d061343e..8757465529 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -59,6 +59,7 @@ typedef struct {
 /* "grey" keys will usually need a 0xe0 prefix */
 #define SCANCODE_GREY   0x80
 #define SCANCODE_EMUL0  0xE0
+#define SCANCODE_EMUL1  0xE1
 /* "up" flag */
 #define SCANCODE_UP     0x80
=20
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index f96adf4165..0d9ddde9c9 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -233,6 +233,7 @@ static const int qcode_to_number[] =3D {
     [Q_KEY_CODE_KP_ENTER] =3D 0x9c,
     [Q_KEY_CODE_KP_DECIMAL] =3D 0x53,
     [Q_KEY_CODE_SYSRQ] =3D 0x54,
+    [Q_KEY_CODE_PAUSE] =3D 0xc6,
=20
     [Q_KEY_CODE_KP_0] =3D 0x52,
     [Q_KEY_CODE_KP_1] =3D 0x4f,
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 918580239d..cda9976469 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -32,6 +32,7 @@ typedef struct QemuSpiceKbd {
     SpiceKbdInstance sin;
     int ledstate;
     bool emul0;
+    size_t pauseseq;
 } QemuSpiceKbd;
=20
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
@@ -64,6 +65,25 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_=
t scancode)
         keycode |=3D SCANCODE_GREY;
     }
=20
+    if (scancode =3D=3D SCANCODE_EMUL1) {
+        kbd->pauseseq++;
+        return;
+    } else if (kbd->pauseseq =3D=3D 1) {
+        if (keycode =3D=3D 0x1d) {
+            kbd->pauseseq++;
+            return;
+        } else {
+            kbd->pauseseq =3D 0;
+        }
+    } else if (kbd->pauseseq =3D=3D 2) {
+        if (keycode =3D=3D 0x45) {
+            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, !up)=
;
+            kbd->pauseseq =3D 0;
+            return;
+        }
+        kbd->pauseseq =3D 0;
+    }
+
     qemu_input_event_send_key_number(NULL, keycode, !up);
 }
=20
--=20
2.9.3
