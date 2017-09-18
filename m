Received: from eggs.gnu.org ([2001:4830:134:3::10]:42926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiU-0000hH-Kz
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiP-0006PI-Pz
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20177
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dtwiP-0006OH-El
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:08:01 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 22:05:18 +0800
Message-ID: <bbac9b87b76e8e54837d427f9d0f2cd520f34c09.1505737465.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/6] dev-storage: Fix the unusual function
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The function name of usb_msd_{realize,unrealize}_*,
usb_msd_class_initfn_* are unusual. Rename it to
usb_msd_*_{realize,unrealize}, usb_msd_class_*_initfn.

Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-storage.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 801f552..2a05cd5 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -596,7 +596,7 @@ static void usb_msd_unrealize_storage(USBDevice *dev, Error **errp)
     object_unref(OBJECT(&s->bus));
 }
 
-static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
+static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
     BlockBackend *blk = s->conf.blk;
@@ -643,14 +643,14 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
     s->scsi_dev = scsi_dev;
 }
 
-static void usb_msd_unrealize_bot(USBDevice *dev, Error **errp)
+static void usb_msd_bot_unrealize(USBDevice *dev, Error **errp)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
 
     object_unref(OBJECT(&s->bus));
 }
 
-static void usb_msd_realize_bot(USBDevice *dev, Error **errp)
+static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
     DeviceState *d = DEVICE(dev);
@@ -764,12 +764,12 @@ static void usb_msd_class_initfn_common(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_usb_msd;
 }
 
-static void usb_msd_class_initfn_storage(ObjectClass *klass, void *data)
+static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
 
-    uc->realize = usb_msd_realize_storage;
+    uc->realize = usb_msd_storage_realize;
     uc->unrealize = usb_msd_unrealize_storage;
     dc->props = msd_properties;
 }
@@ -828,26 +828,26 @@ static void usb_msd_instance_init(Object *obj)
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
 
-static void usb_msd_class_initfn_bot(ObjectClass *klass, void *data)
+static void usb_msd_class_bot_initfn(ObjectClass *klass, void *data)
 {
     USBDeviceClass *uc = USB_DEVICE_CLASS(klass);
 
-    uc->realize = usb_msd_realize_bot;
-    uc->unrealize = usb_msd_unrealize_bot;
+    uc->realize = usb_msd_bot_realize;
+    uc->unrealize = usb_msd_bot_unrealize;
     uc->attached_settable = true;
 }
 
 static const TypeInfo msd_info = {
     .name          = "usb-storage",
     .parent        = TYPE_USB_STORAGE,
-    .class_init    = usb_msd_class_initfn_storage,
+    .class_init    = usb_msd_class_storage_initfn,
     .instance_init = usb_msd_instance_init,
 };
 
 static const TypeInfo bot_info = {
     .name          = "usb-bot",
     .parent        = TYPE_USB_STORAGE,
-    .class_init    = usb_msd_class_initfn_bot,
+    .class_init    = usb_msd_class_bot_initfn,
 };
 
 static void usb_msd_register_types(void)
-- 
2.9.4
