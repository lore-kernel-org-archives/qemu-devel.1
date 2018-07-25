Received: from eggs.gnu.org ([2001:4830:134:3::10]:35776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiODE-00024D-8a
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 14:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiODB-0004lt-6f
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 14:08:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 20:08:30 +0200
Message-Id: <1532542110-9017-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 12/10] hw/s390x: Move virtio-ccw-blk
 code to a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

The code should only be enabled if CONFIG_VIRTIO_BLK has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs    |  1 +
 hw/s390x/virtio-ccw-blk.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c     | 46 --------------------------------
 3 files changed, 68 insertions(+), 46 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-blk.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 172ba55..5dbc00c 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -16,6 +16,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
 obj-$(CONFIG_VIRTIO_GPU) += virtio-ccw-gpu.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-ccw-input.o
 obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
+obj-$(CONFIG_VIRTIO_BLK) += virtio-ccw-blk.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
 obj-y += css-bridge.o
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
new file mode 100644
index 0000000..1f3d09a
--- /dev/null
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -0,0 +1,67 @@
+/*
+ * virtio ccw block implementation
+ *
+ * Copyright 2012, 2015 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
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
+static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_ccw_blk_instance_init(Object *obj)
+{
+    VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static Property virtio_ccw_blk_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_blk_realize;
+    dc->props = virtio_ccw_blk_properties;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_blk = {
+    .name          = TYPE_VIRTIO_BLK_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOBlkCcw),
+    .instance_init = virtio_ccw_blk_instance_init,
+    .class_init    = virtio_ccw_blk_class_init,
+};
+
+static void virtio_ccw_blk_register(void)
+{
+    type_register_static(&virtio_ccw_blk);
+}
+
+type_init(virtio_ccw_blk_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ca552d9..598de75 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -770,25 +770,6 @@ static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
     }
 }
 
-static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_ccw_blk_instance_init(Object *obj)
-{
-    VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
 /* DeviceState to VirtioCcwDevice. Note: used on datapath,
  * be careful and test performance if you change this.
  */
@@ -1163,32 +1144,6 @@ static void virtio_ccw_device_unplugged(DeviceState *d)
 }
 /**************** Virtio-ccw Bus Device Descriptions *******************/
 
-static Property virtio_ccw_blk_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_blk_realize;
-    dc->props = virtio_ccw_blk_properties;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_blk = {
-    .name          = TYPE_VIRTIO_BLK_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIOBlkCcw),
-    .instance_init = virtio_ccw_blk_instance_init,
-    .class_init    = virtio_ccw_blk_class_init,
-};
-
 static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
@@ -1278,7 +1233,6 @@ static void virtio_ccw_register(void)
 {
     type_register_static(&virtio_ccw_bus_info);
     type_register_static(&virtio_ccw_device_info);
-    type_register_static(&virtio_ccw_blk);
 }
 
 type_init(virtio_ccw_register)
-- 
1.8.3.1
