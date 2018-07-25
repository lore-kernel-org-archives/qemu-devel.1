Received: from eggs.gnu.org ([2001:4830:134:3::10]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImg-0006CN-EG
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImd-0002VB-Ds
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:22 +0200
Message-Id: <1532521224-27235-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 08/10] hw/s390x: Move vhost-vsock-ccw
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

The code should only be enabled if CONFIG_VHOST_VSOCK has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Makefile.objs     |  1 +
 hw/s390x/vhost-vsock-ccw.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c      | 47 ------------------------------------
 3 files changed, 61 insertions(+), 47 deletions(-)
 create mode 100644 hw/s390x/vhost-vsock-ccw.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 1073cfa..f1c058e 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
+obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
new file mode 100644
index 0000000..cddc5cf
--- /dev/null
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -0,0 +1,60 @@
+/*
+ * vhost vsock ccw implementation
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
+static Property vhost_vsock_ccw_properties[] = {
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VHostVSockCCWState *dev = VHOST_VSOCK_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = vhost_vsock_ccw_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props = vhost_vsock_ccw_properties;
+}
+
+static void vhost_vsock_ccw_instance_init(Object *obj)
+{
+    VHostVSockCCWState *dev = VHOST_VSOCK_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_VSOCK);
+}
+
+static const TypeInfo vhost_vsock_ccw_info = {
+    .name          = TYPE_VHOST_VSOCK_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VHostVSockCCWState),
+    .instance_init = vhost_vsock_ccw_instance_init,
+    .class_init    = vhost_vsock_ccw_class_init,
+};
+
+static void vhost_vsock_ccw_register(void)
+{
+    type_register_static(&vhost_vsock_ccw_info);
+}
+
+type_init(vhost_vsock_ccw_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 19c310c..eff4214 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1461,59 +1461,12 @@ static const TypeInfo virtio_ccw_bus_info = {
     .class_init = virtio_ccw_bus_class_init,
 };
 
-#ifdef CONFIG_VHOST_VSOCK
-
-static Property vhost_vsock_ccw_properties[] = {
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VHostVSockCCWState *dev = VHOST_VSOCK_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = vhost_vsock_ccw_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = vhost_vsock_ccw_properties;
-}
-
-static void vhost_vsock_ccw_instance_init(Object *obj)
-{
-    VHostVSockCCWState *dev = VHOST_VSOCK_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_VSOCK);
-}
-
-static const TypeInfo vhost_vsock_ccw_info = {
-    .name          = TYPE_VHOST_VSOCK_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VHostVSockCCWState),
-    .instance_init = vhost_vsock_ccw_instance_init,
-    .class_init    = vhost_vsock_ccw_class_init,
-};
-#endif
-
 static void virtio_ccw_register(void)
 {
     type_register_static(&virtio_ccw_bus_info);
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
-#ifdef CONFIG_VHOST_VSOCK
-    type_register_static(&vhost_vsock_ccw_info);
-#endif
     type_register_static(&virtio_ccw_gpu);
     type_register_static(&virtio_ccw_input);
     type_register_static(&virtio_ccw_input_hid);
-- 
1.8.3.1
