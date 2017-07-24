Received: from eggs.gnu.org ([2001:4830:134:3::10]:48931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZgUu-0007Ue-Rm
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZgUq-0000YF-U4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZgUq-0000XI-OK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:46:16 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 24 Jul 2017 17:46:01 +0100
Message-Id: <20170724164601.21063-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
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
handled correctly. Fixing this just requires special casing 0xe1 so
it is directly queued for sending to the guest, skipping any conversion
to QKeyCode.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/ps2.c    | 7 +++++++
 ui/input-keymap.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 3ba05efd06..a132d1ba72 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -607,6 +607,13 @@ static void ps2_keyboard_event(DeviceState *dev, Qem=
uConsole *src,
     assert(evt->type =3D=3D INPUT_EVENT_KIND_KEY);
     qcode =3D qemu_input_key_value_to_qcode(key->key);
=20
+    if (qcode =3D=3D 0 &&
+        key->key->type =3D=3D KEY_VALUE_KIND_NUMBER &&
+        key->key->u.number.data =3D=3D 0x61) {
+        ps2_put_keycode(s, 0xe1);
+        return;
+    }
+
     if (s->scancode_set =3D=3D 1) {
         if (qcode =3D=3D Q_KEY_CODE_PAUSE) {
             if (key->down) {
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
--=20
2.13.3
