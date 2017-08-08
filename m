Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dfDIV-0003JB-Rp
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dfDIQ-0001no-Ts
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dfDIQ-0001mA-NN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 18:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F2E620272
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 22:48:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  9 Aug 2017 00:47:50 +0200
Message-Id: <20170808224750.23904-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for wheel
 buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

qemu uses wheel-up/down button events for mouse wheel input, however
linux applications typically want REL_WHEEL events.

This fixes wheel with linux guests. Tested with X11/wayland, and
windows virtio-input driver.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 46c038110c..f46857f0e4 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -196,6 +196,7 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,
     InputKeyEvent *key;
     InputMoveEvent *move;
     InputBtnEvent *btn;
+    unsigned int map;
=20
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
@@ -215,9 +216,15 @@ static void virtio_input_handle_event(DeviceState *d=
ev, QemuConsole *src,
         break;
     case INPUT_EVENT_KIND_BTN:
         btn =3D evt->u.btn.data;
-        if (keymap_button[btn->button]) {
+        map =3D keymap_button[btn->button];
+        if (map =3D=3D BTN_GEAR_DOWN || map =3D=3D BTN_GEAR_UP) {
+            event.type  =3D cpu_to_le16(EV_REL);
+            event.code  =3D cpu_to_le16(REL_WHEEL);
+            event.value =3D cpu_to_le32(map =3D=3D BTN_GEAR_DOWN ? -1 : =
1);
+            virtio_input_send(vinput, &event);
+        } else if (map) {
             event.type  =3D cpu_to_le16(EV_KEY);
-            event.code  =3D cpu_to_le16(keymap_button[btn->button]);
+            event.code  =3D cpu_to_le16(map);
             event.value =3D cpu_to_le32(btn->down ? 1 : 0);
             virtio_input_send(vinput, &event);
         } else {
@@ -424,9 +431,9 @@ static struct virtio_input_config virtio_mouse_config=
[] =3D {
     },{
         .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
         .subsel    =3D EV_REL,
-        .size      =3D 1,
+        .size      =3D 2,
         .u.bitmap  =3D {
-            (1 << REL_X) | (1 << REL_Y),
+            (1 << REL_X) | (1 << REL_Y),  (1 << (REL_WHEEL - 8))
         },
     },
     { /* end of list */ },
--=20
2.14.0.1.geff633fa0
