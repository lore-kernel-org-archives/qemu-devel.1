Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBW-0005TA-Ku
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwzu-00033i-64
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:40 +0200
Message-Id: <20180829094143.2102-17-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] hw/s390x: Move virtio-ccw-input code to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The code should only be enabled if CONFIG_VIRTIO_INPUT has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1532521224-27235-11-git-send-email-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs      |   1 +
 hw/s390x/virtio-ccw-input.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c       |  98 ------------------------------------
 3 files changed, 119 insertions(+), 98 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-input.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 9c858c1dde..0d7e162598 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
 obj-$(CONFIG_VIRTIO_GPU) += virtio-ccw-gpu.o
+obj-$(CONFIG_VIRTIO_INPUT) += virtio-ccw-input.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
 obj-y += css-bridge.o
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
new file mode 100644
index 0000000000..79c87cb3f2
--- /dev/null
+++ b/hw/s390x/virtio-ccw-input.c
@@ -0,0 +1,118 @@
+/*
+ * virtio ccw scsi implementation
+ *
+ * Copyright 2012, 2015 IBM Corp.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio.h"
+#include "qapi/error.h"
+#include "virtio-ccw.h"
+
+static void virtio_ccw_input_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOInputCcw *dev = VIRTIO_INPUT_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static Property virtio_ccw_input_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_input_realize;
+    dc->props = virtio_ccw_input_properties;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static void virtio_ccw_keyboard_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_KEYBOARD);
+}
+
+static void virtio_ccw_mouse_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MOUSE);
+}
+
+static void virtio_ccw_tablet_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_TABLET);
+}
+
+static const TypeInfo virtio_ccw_input = {
+    .name          = TYPE_VIRTIO_INPUT_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOInputCcw),
+    .class_init    = virtio_ccw_input_class_init,
+    .abstract = true,
+};
+
+static const TypeInfo virtio_ccw_input_hid = {
+    .name          = TYPE_VIRTIO_INPUT_HID_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .abstract = true,
+};
+
+static const TypeInfo virtio_ccw_keyboard = {
+    .name          = TYPE_VIRTIO_KEYBOARD_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_keyboard_instance_init,
+};
+
+static const TypeInfo virtio_ccw_mouse = {
+    .name          = TYPE_VIRTIO_MOUSE_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_mouse_instance_init,
+};
+
+static const TypeInfo virtio_ccw_tablet = {
+    .name          = TYPE_VIRTIO_TABLET_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_tablet_instance_init,
+};
+
+static void virtio_ccw_input_register(void)
+{
+    type_register_static(&virtio_ccw_input);
+    type_register_static(&virtio_ccw_input_hid);
+    type_register_static(&virtio_ccw_keyboard);
+    type_register_static(&virtio_ccw_mouse);
+    type_register_static(&virtio_ccw_tablet);
+}
+
+type_init(virtio_ccw_input_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8746b9ce92..ca0e3294c6 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -808,15 +808,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static void virtio_ccw_input_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtIOInputCcw *dev = VIRTIO_INPUT_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
 /* DeviceState to VirtioCcwDevice. Note: used on datapath,
  * be careful and test performance if you change this.
  */
@@ -1243,90 +1234,6 @@ static const TypeInfo virtio_ccw_blk = {
     .class_init    = virtio_ccw_blk_class_init,
 };
 
-static Property virtio_ccw_input_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_input_realize;
-    dc->props = virtio_ccw_input_properties;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-}
-
-static void virtio_ccw_keyboard_instance_init(Object *obj)
-{
-    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
-    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
-
-    ccw_dev->force_revision_1 = true;
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_KEYBOARD);
-}
-
-static void virtio_ccw_mouse_instance_init(Object *obj)
-{
-    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
-    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
-
-    ccw_dev->force_revision_1 = true;
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_MOUSE);
-}
-
-static void virtio_ccw_tablet_instance_init(Object *obj)
-{
-    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
-    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
-
-    ccw_dev->force_revision_1 = true;
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_TABLET);
-}
-
-static const TypeInfo virtio_ccw_input = {
-    .name          = TYPE_VIRTIO_INPUT_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIOInputCcw),
-    .class_init    = virtio_ccw_input_class_init,
-    .abstract = true,
-};
-
-static const TypeInfo virtio_ccw_input_hid = {
-    .name          = TYPE_VIRTIO_INPUT_HID_CCW,
-    .parent        = TYPE_VIRTIO_INPUT_CCW,
-    .instance_size = sizeof(VirtIOInputHIDCcw),
-    .abstract = true,
-};
-
-static const TypeInfo virtio_ccw_keyboard = {
-    .name          = TYPE_VIRTIO_KEYBOARD_CCW,
-    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
-    .instance_size = sizeof(VirtIOInputHIDCcw),
-    .instance_init = virtio_ccw_keyboard_instance_init,
-};
-
-static const TypeInfo virtio_ccw_mouse = {
-    .name          = TYPE_VIRTIO_MOUSE_CCW,
-    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
-    .instance_size = sizeof(VirtIOInputHIDCcw),
-    .instance_init = virtio_ccw_mouse_instance_init,
-};
-
-static const TypeInfo virtio_ccw_tablet = {
-    .name          = TYPE_VIRTIO_TABLET_CCW,
-    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
-    .instance_size = sizeof(VirtIOInputHIDCcw),
-    .instance_init = virtio_ccw_tablet_instance_init,
-};
-
 static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
@@ -1418,11 +1325,6 @@ static void virtio_ccw_register(void)
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
-    type_register_static(&virtio_ccw_input);
-    type_register_static(&virtio_ccw_input_hid);
-    type_register_static(&virtio_ccw_keyboard);
-    type_register_static(&virtio_ccw_mouse);
-    type_register_static(&virtio_ccw_tablet);
 }
 
 type_init(virtio_ccw_register)
-- 
2.14.4
