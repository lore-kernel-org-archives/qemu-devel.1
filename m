Received: from eggs.gnu.org ([2001:4830:134:3::10]:40471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImX-00065E-Hz
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImT-0002DB-4J
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:40 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:18 +0200
Message-Id: <1532521224-27235-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 04/10] hw/s390x: Move virtio-ccw-scsi
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

The code should only be enabled if CONFIG_VIRTIO_SCSI has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs     |   1 +
 hw/s390x/virtio-ccw-scsi.c | 125 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c      | 104 -------------------------------------
 3 files changed, 126 insertions(+), 104 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-scsi.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index ac98350..9ca1ab0 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -10,6 +10,7 @@ obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
+obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
new file mode 100644
index 0000000..c9a804f
--- /dev/null
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -0,0 +1,125 @@
+/*
+ * virtio ccw scsi implementation
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
+static void virtio_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOSCSICcw *dev = VIRTIO_SCSI_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    DeviceState *qdev = DEVICE(ccw_dev);
+    char *bus_name;
+
+    /*
+     * For command line compatibility, this sets the virtio-scsi-device bus
+     * name as before.
+     */
+    if (qdev->id) {
+        bus_name = g_strdup_printf("%s.0", qdev->id);
+        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
+        g_free(bus_name);
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_ccw_scsi_instance_init(Object *obj)
+{
+    VirtIOSCSICcw *dev = VIRTIO_SCSI_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SCSI);
+}
+
+static Property virtio_ccw_scsi_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_scsi_realize;
+    dc->props = virtio_ccw_scsi_properties;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_scsi = {
+    .name          = TYPE_VIRTIO_SCSI_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOSCSICcw),
+    .instance_init = virtio_ccw_scsi_instance_init,
+    .class_init    = virtio_ccw_scsi_class_init,
+};
+
+#ifdef CONFIG_VHOST_SCSI
+
+static void vhost_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VHostSCSICcw *dev = VHOST_SCSI_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_ccw_scsi_instance_init(Object *obj)
+{
+    VHostSCSICcw *dev = VHOST_SCSI_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_SCSI);
+}
+
+static Property vhost_ccw_scsi_properties[] = {
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = vhost_ccw_scsi_realize;
+    dc->props = vhost_ccw_scsi_properties;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo vhost_ccw_scsi = {
+    .name          = TYPE_VHOST_SCSI_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VHostSCSICcw),
+    .instance_init = vhost_ccw_scsi_instance_init,
+    .class_init    = vhost_ccw_scsi_class_init,
+};
+
+#endif
+
+static void virtio_ccw_scsi_register(void)
+{
+    type_register_static(&virtio_ccw_scsi);
+#ifdef CONFIG_VHOST_SCSI
+    type_register_static(&vhost_ccw_scsi);
+#endif
+}
+
+type_init(virtio_ccw_scsi_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 3480a2e..3e470a1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -811,54 +811,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static void virtio_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtIOSCSICcw *dev = VIRTIO_SCSI_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    DeviceState *qdev = DEVICE(ccw_dev);
-    char *bus_name;
-
-    /*
-     * For command line compatibility, this sets the virtio-scsi-device bus
-     * name as before.
-     */
-    if (qdev->id) {
-        bus_name = g_strdup_printf("%s.0", qdev->id);
-        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
-        g_free(bus_name);
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_ccw_scsi_instance_init(Object *obj)
-{
-    VirtIOSCSICcw *dev = VIRTIO_SCSI_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_SCSI);
-}
-
-#ifdef CONFIG_VHOST_SCSI
-static void vhost_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VHostSCSICcw *dev = VHOST_SCSI_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_ccw_scsi_instance_init(Object *obj)
-{
-    VHostSCSICcw *dev = VHOST_SCSI_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_SCSI);
-}
-#endif
-
 static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIORNGCcw *dev = VIRTIO_RNG_CCW(ccw_dev);
@@ -1339,58 +1291,6 @@ static const TypeInfo virtio_ccw_blk = {
     .class_init    = virtio_ccw_blk_class_init,
 };
 
-static Property virtio_ccw_scsi_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_scsi_realize;
-    dc->props = virtio_ccw_scsi_properties;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_scsi = {
-    .name          = TYPE_VIRTIO_SCSI_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIOSCSICcw),
-    .instance_init = virtio_ccw_scsi_instance_init,
-    .class_init    = virtio_ccw_scsi_class_init,
-};
-
-#ifdef CONFIG_VHOST_SCSI
-static Property vhost_ccw_scsi_properties[] = {
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = vhost_ccw_scsi_realize;
-    dc->props = vhost_ccw_scsi_properties;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-}
-
-static const TypeInfo vhost_ccw_scsi = {
-    .name          = TYPE_VHOST_SCSI_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VHostSCSICcw),
-    .instance_init = vhost_ccw_scsi_instance_init,
-    .class_init    = vhost_ccw_scsi_class_init,
-};
-#endif
-
 static void virtio_ccw_rng_instance_init(Object *obj)
 {
     VirtIORNGCcw *dev = VIRTIO_RNG_CCW(obj);
@@ -1762,10 +1662,6 @@ static void virtio_ccw_register(void)
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
-    type_register_static(&virtio_ccw_scsi);
-#ifdef CONFIG_VHOST_SCSI
-    type_register_static(&vhost_ccw_scsi);
-#endif
     type_register_static(&virtio_ccw_rng);
 #ifdef CONFIG_VIRTFS
     type_register_static(&virtio_ccw_9p_info);
-- 
1.8.3.1
