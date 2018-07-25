Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImZ-00067h-Te
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImW-0002Jl-T2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:43 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:20 +0200
Message-Id: <1532521224-27235-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 06/10] hw/s390x: Move virtio-ccw-9p
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

The code should only be enabled if CONFIG_VIRTIO_9P and CONFIG_VIRTFS
have been set. This can be done best if the code resides in a separate
file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs   |  1 +
 hw/s390x/virtio-ccw-9p.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c    | 48 -----------------------------------
 3 files changed, 66 insertions(+), 48 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-9p.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 181efd1..08a8c10 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -12,6 +12,7 @@ obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
+obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
new file mode 100644
index 0000000..d6be172
--- /dev/null
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -0,0 +1,65 @@
+/*
+ * virtio ccw 9p implementation
+ *
+ * Copyright 2012, 2015 IBM Corp.
+ * Author(s): Pierre Morel <pmorel@linux.vnet.ibm.com>
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
+static void virtio_ccw_9p_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    V9fsCCWState *dev = VIRTIO_9P_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_ccw_9p_instance_init(Object *obj)
+{
+    V9fsCCWState *dev = VIRTIO_9P_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_9P);
+}
+
+static Property virtio_ccw_9p_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+            VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_9p_realize;
+    dc->props = virtio_ccw_9p_properties;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_9p_info = {
+    .name          = TYPE_VIRTIO_9P_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(V9fsCCWState),
+    .instance_init = virtio_ccw_9p_instance_init,
+    .class_init    = virtio_ccw_9p_class_init,
+};
+
+static void virtio_ccw_9p_register(void)
+{
+    type_register_static(&virtio_ccw_9p_info);
+}
+
+type_init(virtio_ccw_9p_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 844c0a5..f8c1ca2 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1515,51 +1515,6 @@ static const TypeInfo virtio_ccw_bus_info = {
     .class_init = virtio_ccw_bus_class_init,
 };
 
-#ifdef CONFIG_VIRTFS
-static Property virtio_ccw_9p_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-            VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_9p_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    V9fsCCWState *dev = VIRTIO_9P_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_9p_realize;
-    dc->props = virtio_ccw_9p_properties;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static void virtio_ccw_9p_instance_init(Object *obj)
-{
-    V9fsCCWState *dev = VIRTIO_9P_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_9P);
-}
-
-static const TypeInfo virtio_ccw_9p_info = {
-    .name          = TYPE_VIRTIO_9P_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(V9fsCCWState),
-    .instance_init = virtio_ccw_9p_instance_init,
-    .class_init    = virtio_ccw_9p_class_init,
-};
-#endif
-
 #ifdef CONFIG_VHOST_VSOCK
 
 static Property vhost_vsock_ccw_properties[] = {
@@ -1610,9 +1565,6 @@ static void virtio_ccw_register(void)
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
-#ifdef CONFIG_VIRTFS
-    type_register_static(&virtio_ccw_9p_info);
-#endif
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_ccw_info);
 #endif
-- 
1.8.3.1
