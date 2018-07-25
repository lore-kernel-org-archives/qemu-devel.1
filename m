Received: from eggs.gnu.org ([2001:4830:134:3::10]:40536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImc-00068k-4h
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImZ-0002OT-42
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:21 +0200
Message-Id: <1532521224-27235-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 07/10] hw/s390x: Move virtio-ccw-crypto
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

The code should only be enabled if CONFIG_VIRTIO_CRYPTO has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs       |  1 +
 hw/s390x/virtio-ccw-crypto.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c        | 55 --------------------------------
 3 files changed, 76 insertions(+), 55 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-crypto.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 08a8c10..1073cfa 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -12,6 +12,7 @@ obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
+obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
new file mode 100644
index 0000000..aab6a95
--- /dev/null
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -0,0 +1,75 @@
+/*
+ * virtio ccw crypto implementation
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
+static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    Error *err = NULL;
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_link(OBJECT(vdev),
+                             OBJECT(dev->vdev.conf.cryptodev), "cryptodev",
+                             NULL);
+}
+
+static void virtio_ccw_crypto_instance_init(Object *obj)
+{
+    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_CRYPTO);
+}
+
+static Property virtio_ccw_crypto_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_crypto_realize;
+    dc->props = virtio_ccw_crypto_properties;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_crypto = {
+    .name          = TYPE_VIRTIO_CRYPTO_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOCryptoCcw),
+    .instance_init = virtio_ccw_crypto_instance_init,
+    .class_init    = virtio_ccw_crypto_class_init,
+};
+
+static void virtio_ccw_crypto_register(void)
+{
+    type_register_static(&virtio_ccw_crypto);
+}
+
+type_init(virtio_ccw_crypto_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f8c1ca2..19c310c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -811,24 +811,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    object_property_set_link(OBJECT(vdev),
-                             OBJECT(dev->vdev.conf.cryptodev), "cryptodev",
-                             NULL);
-}
-
 static void virtio_ccw_gpu_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOGPUCcw *dev = VIRTIO_GPU_CCW(ccw_dev);
@@ -1273,42 +1255,6 @@ static const TypeInfo virtio_ccw_blk = {
     .class_init    = virtio_ccw_blk_class_init,
 };
 
-static Property virtio_ccw_crypto_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_crypto_instance_init(Object *obj)
-{
-    VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(obj);
-    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
-
-    ccw_dev->force_revision_1 = true;
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_CRYPTO);
-}
-
-static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_crypto_realize;
-    dc->props = virtio_ccw_crypto_properties;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_crypto = {
-    .name          = TYPE_VIRTIO_CRYPTO_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIOCryptoCcw),
-    .instance_init = virtio_ccw_crypto_instance_init,
-    .class_init    = virtio_ccw_crypto_class_init,
-};
-
 static Property virtio_ccw_gpu_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
@@ -1568,7 +1514,6 @@ static void virtio_ccw_register(void)
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_ccw_info);
 #endif
-    type_register_static(&virtio_ccw_crypto);
     type_register_static(&virtio_ccw_gpu);
     type_register_static(&virtio_ccw_input);
     type_register_static(&virtio_ccw_input_hid);
-- 
1.8.3.1
