Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWk-0006XU-Tf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWd-0006wq-8k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWc-0006vL-Tv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:12 +0000
Message-Id: <20171218143530.12082-6-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/23] dev-storage: Fix the unusual function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

The function name of usb_msd_{realize,unrealize}_*,
usb_msd_class_initfn_* are unusual. Rename it to
usb_msd_*_{realize,unrealize}, usb_msd_class_*_initfn.

Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 11e6003433abce35f3f4970e1acc71ee92dbcf51.1511317952.git.maozy=
.fnst@cn.fujitsu.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/usb/dev-storage.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index a9bcc67e67..9722ac854c 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -596,7 +596,7 @@ static void usb_msd_unrealize_storage(USBDevice *dev,=
 Error **errp)
     object_unref(OBJECT(&s->bus));
 }
=20
-static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
+static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
     BlockBackend *blk =3D s->conf.blk;
@@ -643,14 +643,14 @@ static void usb_msd_realize_storage(USBDevice *dev,=
 Error **errp)
     s->scsi_dev =3D scsi_dev;
 }
=20
-static void usb_msd_unrealize_bot(USBDevice *dev, Error **errp)
+static void usb_msd_bot_unrealize(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
=20
     object_unref(OBJECT(&s->bus));
 }
=20
-static void usb_msd_realize_bot(USBDevice *dev, Error **errp)
+static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s =3D USB_STORAGE_DEV(dev);
     DeviceState *d =3D DEVICE(dev);
@@ -764,12 +764,12 @@ static void usb_msd_class_initfn_common(ObjectClass=
 *klass, void *data)
     dc->vmsd =3D &vmstate_usb_msd;
 }
=20
-static void usb_msd_class_initfn_storage(ObjectClass *klass, void *data)
+static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
-    uc->realize =3D usb_msd_realize_storage;
+    uc->realize =3D usb_msd_storage_realize;
     uc->unrealize =3D usb_msd_unrealize_storage;
     dc->props =3D msd_properties;
 }
@@ -828,26 +828,26 @@ static void usb_msd_instance_init(Object *obj)
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
=20
-static void usb_msd_class_initfn_bot(ObjectClass *klass, void *data)
+static void usb_msd_class_bot_initfn(ObjectClass *klass, void *data)
 {
     USBDeviceClass *uc =3D USB_DEVICE_CLASS(klass);
=20
-    uc->realize =3D usb_msd_realize_bot;
-    uc->unrealize =3D usb_msd_unrealize_bot;
+    uc->realize =3D usb_msd_bot_realize;
+    uc->unrealize =3D usb_msd_bot_unrealize;
     uc->attached_settable =3D true;
 }
=20
 static const TypeInfo msd_info =3D {
     .name          =3D "usb-storage",
     .parent        =3D TYPE_USB_STORAGE,
-    .class_init    =3D usb_msd_class_initfn_storage,
+    .class_init    =3D usb_msd_class_storage_initfn,
     .instance_init =3D usb_msd_instance_init,
 };
=20
 static const TypeInfo bot_info =3D {
     .name          =3D "usb-bot",
     .parent        =3D TYPE_USB_STORAGE,
-    .class_init    =3D usb_msd_class_initfn_bot,
+    .class_init    =3D usb_msd_class_bot_initfn,
 };
=20
 static void usb_msd_register_types(void)
--=20
2.14.3
