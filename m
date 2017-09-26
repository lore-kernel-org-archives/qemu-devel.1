Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwo6m-0003IO-Cw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwo6i-00059n-Ca
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwo6i-00058T-3x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDCB981DF8
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:32:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 13:32:43 +0200
Message-Id: <20170926113243.26081-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

qemu uses wheel-up/down button events for mouse wheel input, however
linux applications typically want REL_WHEEL events.

This fixes wheel with linux guests. Tested with X11/wayland, and
windows virtio-input driver.

Based on a patch from Marc.
Added property to enable/disable wheel axis.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/compat.h              |  10 +++-
 include/hw/virtio/virtio-input.h |   1 +
 hw/input/virtio-input-hid.c      | 119 +++++++++++++++++++++++++++++++++=
++++--
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 9cc14dd798..cf389b4e85 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,15 @@
 #define HW_COMPAT_H
=20
 #define HW_COMPAT_2_10 \
-    /* empty */
+    {\
+        .driver   =3D "virtio-mouse-device",\
+        .property =3D "wheel-axis",\
+        .value    =3D "false",\
+    },{\
+        .driver   =3D "virtio-tablet-device",\
+        .property =3D "wheel-axis",\
+        .value    =3D "false",\
+    },
=20
 #define HW_COMPAT_2_9 \
     {\
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 91df57eca4..054c38836f 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -89,6 +89,7 @@ struct VirtIOInputHID {
     QemuInputHandler                  *handler;
     QemuInputHandlerState             *hs;
     int                               ledstate;
+    bool                              wheel_axis;
 };
=20
 struct VirtIOInputHost {
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 4d3afc1b14..e78faec0b1 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -190,6 +190,7 @@ static void virtio_input_key_config(VirtIOInput *vinp=
ut,
 static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src=
,
                                       InputEvent *evt)
 {
+    VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(dev);
     VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
     virtio_input_event event;
     int qcode;
@@ -215,7 +216,14 @@ static void virtio_input_handle_event(DeviceState *d=
ev, QemuConsole *src,
         break;
     case INPUT_EVENT_KIND_BTN:
         btn =3D evt->u.btn.data;
-        if (keymap_button[btn->button]) {
+        if (vhid->wheel_axis && (btn->button =3D=3D INPUT_BUTTON_WHEEL_U=
P ||
+                                 btn->button =3D=3D INPUT_BUTTON_WHEEL_D=
OWN)) {
+            event.type  =3D cpu_to_le16(EV_REL);
+            event.code  =3D cpu_to_le16(REL_WHEEL);
+            event.value =3D cpu_to_le32(btn->button =3D=3D INPUT_BUTTON_=
WHEEL_UP
+                                      ? 1 : -1);
+            virtio_input_send(vinput, &event);
+        } else if (keymap_button[btn->button]) {
             event.type  =3D cpu_to_le16(EV_KEY);
             event.code  =3D cpu_to_le16(keymap_button[btn->button]);
             event.value =3D cpu_to_le32(btn->down ? 1 : 0);
@@ -407,7 +415,7 @@ static QemuInputHandler virtio_mouse_handler =3D {
     .sync  =3D virtio_input_handle_sync,
 };
=20
-static struct virtio_input_config virtio_mouse_config[] =3D {
+static struct virtio_input_config virtio_mouse_config_v1[] =3D {
     {
         .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
         .size      =3D sizeof(VIRTIO_ID_NAME_MOUSE),
@@ -432,13 +440,53 @@ static struct virtio_input_config virtio_mouse_conf=
ig[] =3D {
     { /* end of list */ },
 };
=20
+static struct virtio_input_config virtio_mouse_config_v2[] =3D {
+    {
+        .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
+        .size      =3D sizeof(VIRTIO_ID_NAME_MOUSE),
+        .u.string  =3D VIRTIO_ID_NAME_MOUSE,
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_ID_DEVIDS,
+        .size      =3D sizeof(struct virtio_input_devids),
+        .u.ids     =3D {
+            .bustype =3D const_le16(BUS_VIRTUAL),
+            .vendor  =3D const_le16(0x0627), /* same we use for usb hid =
devices */
+            .product =3D const_le16(0x0002),
+            .version =3D const_le16(0x0002),
+        },
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
+        .subsel    =3D EV_REL,
+        .size      =3D 2,
+        .u.bitmap  =3D {
+            (1 << REL_X) | (1 << REL_Y),
+            (1 << (REL_WHEEL - 8))
+        },
+    },
+    { /* end of list */ },
+};
+
+static Property virtio_mouse_properties[] =3D {
+    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_mouse_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props  =3D virtio_mouse_properties;
+}
+
 static void virtio_mouse_init(Object *obj)
 {
     VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(obj);
     VirtIOInput *vinput =3D VIRTIO_INPUT(obj);
=20
     vhid->handler =3D &virtio_mouse_handler;
-    virtio_input_init_config(vinput, virtio_mouse_config);
+    virtio_input_init_config(vinput, vhid->wheel_axis
+                             ? virtio_mouse_config_v2
+                             : virtio_mouse_config_v1);
     virtio_input_key_config(vinput, keymap_button,
                             ARRAY_SIZE(keymap_button));
 }
@@ -448,6 +496,7 @@ static const TypeInfo virtio_mouse_info =3D {
     .parent        =3D TYPE_VIRTIO_INPUT_HID,
     .instance_size =3D sizeof(VirtIOInputHID),
     .instance_init =3D virtio_mouse_init,
+    .class_init    =3D virtio_mouse_class_init,
 };
=20
 /* ----------------------------------------------------------------- */
@@ -459,7 +508,7 @@ static QemuInputHandler virtio_tablet_handler =3D {
     .sync  =3D virtio_input_handle_sync,
 };
=20
-static struct virtio_input_config virtio_tablet_config[] =3D {
+static struct virtio_input_config virtio_tablet_config_v1[] =3D {
     {
         .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
         .size      =3D sizeof(VIRTIO_ID_NAME_TABLET),
@@ -496,13 +545,72 @@ static struct virtio_input_config virtio_tablet_con=
fig[] =3D {
     { /* end of list */ },
 };
=20
+static struct virtio_input_config virtio_tablet_config_v2[] =3D {
+    {
+        .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
+        .size      =3D sizeof(VIRTIO_ID_NAME_TABLET),
+        .u.string  =3D VIRTIO_ID_NAME_TABLET,
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_ID_DEVIDS,
+        .size      =3D sizeof(struct virtio_input_devids),
+        .u.ids     =3D {
+            .bustype =3D const_le16(BUS_VIRTUAL),
+            .vendor  =3D const_le16(0x0627), /* same we use for usb hid =
devices */
+            .product =3D const_le16(0x0003),
+            .version =3D const_le16(0x0002),
+        },
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
+        .subsel    =3D EV_ABS,
+        .size      =3D 1,
+        .u.bitmap  =3D {
+            (1 << ABS_X) | (1 << ABS_Y),
+        },
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
+        .subsel    =3D EV_REL,
+        .size      =3D 2,
+        .u.bitmap  =3D {
+            0,
+            (1 << (REL_WHEEL - 8))
+        },
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    =3D ABS_X,
+        .size      =3D sizeof(virtio_input_absinfo),
+        .u.abs.min =3D const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max =3D const_le32(INPUT_EVENT_ABS_MAX),
+    },{
+        .select    =3D VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    =3D ABS_Y,
+        .size      =3D sizeof(virtio_input_absinfo),
+        .u.abs.min =3D const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max =3D const_le32(INPUT_EVENT_ABS_MAX),
+    },
+    { /* end of list */ },
+};
+
+static Property virtio_tablet_properties[] =3D {
+    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_tablet_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->props  =3D virtio_tablet_properties;
+}
+
 static void virtio_tablet_init(Object *obj)
 {
     VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(obj);
     VirtIOInput *vinput =3D VIRTIO_INPUT(obj);
=20
     vhid->handler =3D &virtio_tablet_handler;
-    virtio_input_init_config(vinput, virtio_tablet_config);
+    virtio_input_init_config(vinput, vhid->wheel_axis
+                             ? virtio_tablet_config_v2
+                             : virtio_tablet_config_v1);
     virtio_input_key_config(vinput, keymap_button,
                             ARRAY_SIZE(keymap_button));
 }
@@ -512,6 +620,7 @@ static const TypeInfo virtio_tablet_info =3D {
     .parent        =3D TYPE_VIRTIO_INPUT_HID,
     .instance_size =3D sizeof(VirtIOInputHID),
     .instance_init =3D virtio_tablet_init,
+    .class_init    =3D virtio_tablet_class_init,
 };
=20
 /* ----------------------------------------------------------------- */
--=20
2.9.3
