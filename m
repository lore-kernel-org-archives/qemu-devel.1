Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBY-0005f2-L1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwzu-000335-23
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:41 +0200
Message-Id: <20180829094143.2102-18-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 17/19] hw/s390x: Move virtio-ccw-net code to a
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

The code should only be enabled if CONFIG_VIRTIO_NET has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1532542056-8927-1-git-send-email-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/Makefile.objs    |  1 +
 hw/s390x/virtio-ccw-net.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c     | 49 ---------------------------------
 3 files changed, 71 insertions(+), 49 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-net.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 0d7e162598..172ba55455 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -15,6 +15,7 @@ obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
 obj-$(CONFIG_VIRTIO_GPU) += virtio-ccw-gpu.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-ccw-input.o
+obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
 obj-y += css-bridge.o
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
new file mode 100644
index 0000000000..0c0410c643
--- /dev/null
+++ b/hw/s390x/virtio-ccw-net.c
@@ -0,0 +1,70 @@
+/*
+ * virtio ccw net implementation
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
+static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    DeviceState *qdev = DEVICE(ccw_dev);
+    VirtIONetCcw *dev = VIRTIO_NET_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
+                                  object_get_typename(OBJECT(qdev)));
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_ccw_net_instance_init(Object *obj)
+{
+    VirtIONetCcw *dev = VIRTIO_NET_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_NET);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static Property virtio_ccw_net_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_net_realize;
+    dc->props = virtio_ccw_net_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_net = {
+    .name          = TYPE_VIRTIO_NET_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIONetCcw),
+    .instance_init = virtio_ccw_net_instance_init,
+    .class_init    = virtio_ccw_net_class_init,
+};
+
+static void virtio_ccw_net_register(void)
+{
+    type_register_static(&virtio_ccw_net);
+}
+
+type_init(virtio_ccw_net_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ca0e3294c6..be6939bdec 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -767,28 +767,6 @@ static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
     }
 }
 
-static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    DeviceState *qdev = DEVICE(ccw_dev);
-    VirtIONetCcw *dev = VIRTIO_NET_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
-                                  object_get_typename(OBJECT(qdev)));
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_ccw_net_instance_init(Object *obj)
-{
-    VirtIONetCcw *dev = VIRTIO_NET_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_NET);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
 static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
@@ -1182,32 +1160,6 @@ static void virtio_ccw_device_unplugged(DeviceState *d)
 }
 /**************** Virtio-ccw Bus Device Descriptions *******************/
 
-static Property virtio_ccw_net_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_net_realize;
-    dc->props = virtio_ccw_net_properties;
-    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_net = {
-    .name          = TYPE_VIRTIO_NET_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtIONetCcw),
-    .instance_init = virtio_ccw_net_instance_init,
-    .class_init    = virtio_ccw_net_class_init,
-};
-
 static Property virtio_ccw_blk_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
@@ -1324,7 +1276,6 @@ static void virtio_ccw_register(void)
     type_register_static(&virtio_ccw_bus_info);
     type_register_static(&virtio_ccw_device_info);
     type_register_static(&virtio_ccw_blk);
-    type_register_static(&virtio_ccw_net);
 }
 
 type_init(virtio_ccw_register)
-- 
2.14.4
