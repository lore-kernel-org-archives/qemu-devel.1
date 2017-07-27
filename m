Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dajVl-0004nN-0j
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dajVi-0000wv-CA
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dajVi-0000wW-3H
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:11:30 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 27 Jul 2017 15:11:20 +0100
Message-Id: <20170727141120.4970-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] ps2: fix sending of PAUSE/BREAK scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Daniel P. Berrange" <berrange@redhat.com>

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
---

Changed in v3:

 - Treat entire '0xe1 0x1d 0x45 0xe1 0x9d 0xc5' as make code,
   there is no break code for PAUSE.

 ui/input-keymap.c |  1 +
 ui/spice-input.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 8a1476fc48..9211f835be 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -98,6 +98,7 @@ static const int qcode_to_number[] =3D {
     [Q_KEY_CODE_KP_ENTER] =3D 0x9c,
     [Q_KEY_CODE_KP_DECIMAL] =3D 0x53,
     [Q_KEY_CODE_SYSRQ] =3D 0x54,
+    [Q_KEY_CODE_PAUSE] =3D 0xc6,
=20
     [Q_KEY_CODE_KP_0] =3D 0x52,
     [Q_KEY_CODE_KP_1] =3D 0x4f,
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 918580239d..3d41aa1831 100644
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
@@ -49,6 +50,7 @@ static const SpiceKbdInterface kbd_interface =3D {
=20
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
 {
+    static const uint8_t pauseseq[] =3D { 0xe1, 0x1d, 0x45, 0xe1, 0x9d, =
0xc5 };
     QemuSpiceKbd *kbd =3D container_of(sin, QemuSpiceKbd, sin);
     int keycode;
     bool up;
@@ -57,6 +59,18 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_=
t scancode)
         kbd->emul0 =3D true;
         return;
     }
+
+    if (scancode =3D=3D pauseseq[kbd->pauseseq]) {
+        kbd->pauseseq++;
+        if (kbd->pauseseq =3D=3D G_N_ELEMENTS(pauseseq)) {
+            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, true=
);
+            kbd->pauseseq =3D 0;
+        }
+        return;
+    } else {
+        kbd->pauseseq =3D 0;
+    }
+
     keycode =3D scancode & ~SCANCODE_UP;
     up =3D scancode & SCANCODE_UP;
     if (kbd->emul0) {
--=20
2.13.3
