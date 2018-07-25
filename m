Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImX-00065B-I2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImR-0002A8-D7
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:38 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:17 +0200
Message-Id: <1532521224-27235-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 03/10] hw/s390x: Move
 virtio-ccw-balloon code to a separate file
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

The code should only be enabled if CONFIG_VIRTIO_BALLOON has been
set. This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs        |  1 +
 hw/s390x/virtio-ccw-balloon.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c         | 49 ------------------------------
 3 files changed, 71 insertions(+), 49 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-balloon.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 939b045..ac98350 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -9,6 +9,7 @@ obj-y += s390-virtio-ccw.o
 obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
+obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
new file mode 100644
index 0000000..28d171a
--- /dev/null
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -0,0 +1,70 @@
+/*
+ * virtio ccw balloon implementation
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
+static void virtio_ccw_balloon_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOBalloonCcw *dev = VIRTIO_BALLOON_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_ccw_balloon_instance_init(Object *obj)
+{
+    VirtIOBalloonCcw *dev = VIRTIO_BALLOON_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BALLOON);
+    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
+                              "guest-stats", &error_abort);
+    object_property_add_alias(obj, "guest-stats-polling-interval",
+                              OBJECT(&dev->vdev),
+                              "guest-stats-polling-interval", &error_abort);
+}
+
+static Property virtio_ccw_balloon_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_balloon_realize;
+    dc->props = virtio_ccw_balloon_properties;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_balloon = {
+    .name          = TYPE_VIRTIO_BALLOON_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOBalloonCcw),
+    .instance_init = virtio_ccw_balloon_instance_init,
+    .class_init    = virtio_ccw_balloon_class_init,
+};
+
+static void virtio_ccw_balloon_register(void)
+{
+    type_register_static(&virtio_ccw_balloon);
+}
+
+type_init(virtio_ccw_balloon_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e5e18ad..3480a2e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -811,28 +811,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static void virtio_ccw_balloon_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtIOBalloonCcw *dev = VIRTIO_BALLOON_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_ccw_balloon_instance_init(Object *obj)
-{
-    VirtIOBalloonCcw *dev = VIRTIO_BALLOON_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BALLOON);
-    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
-                              "guest-stats", &error_abort);
-    object_property_add_alias(obj, "guest-stats-polling-interval",
-                              OBJECT(&dev->vdev),
-                              "guest-stats-polling-interval", &error_abort);
-}
-
 static void virtio_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOSCSICcw *dev = VIRTIO_SCSI_CCW(ccw_dev);
@@ -1361,32 +1339,6 @@ static const TypeInfo virtio_ccw_blk = {
     .class_init    = virtio_ccw_blk_class_init,
 };
 
-static Property virtio_ccw_balloon_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_balloon_realize;
-    dc->props = virtio_ccw_balloon_properties;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_balloon = {
-    .name          = TYPE_VIRTIO_BALLOON_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIOBalloonCcw),
-    .instance_init = virtio_ccw_balloon_instance_init,
-    .class_init    = virtio_ccw_balloon_class_init,
-};
-
 static Property virtio_ccw_scsi_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
@@ -1810,7 +1762,6 @@ static void virtio_ccw_register(void)
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
-    type_register_static(&virtio_ccw_balloon);
     type_register_static(&virtio_ccw_scsi);
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_ccw_scsi);
-- 
1.8.3.1
