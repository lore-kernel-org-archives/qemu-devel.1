Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBc-0005Yy-Rj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwzG-0002eE-Uj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:32 +0200
Message-Id: <20180829094143.2102-9-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/19] hw/s390x: Move virtio-ccw-serial code to
 a separate file
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

The code should only be enabled if CONFIG_VIRTIO_SERIAL has been set.
This can be done best if the code resides in a separate file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1532521224-27235-3-git-send-email-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                  |  2 +-
 hw/s390x/Makefile.objs       |  1 +
 hw/s390x/virtio-ccw-serial.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.c        | 58 --------------------------------
 4 files changed, 80 insertions(+), 59 deletions(-)
 create mode 100644 hw/s390x/virtio-ccw-serial.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fd1bce176f..03fe7893bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1237,7 +1237,7 @@ virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
-F: hw/s390x/virtio-ccw.[hc]
+F: hw/s390x/virtio-ccw*.[hc]
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 93282f7c59..939b045f2d 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -8,6 +8,7 @@ obj-y += css.o
 obj-y += s390-virtio-ccw.o
 obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
+obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
new file mode 100644
index 0000000000..3851fc9c9b
--- /dev/null
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -0,0 +1,78 @@
+/*
+ * virtio ccw serial implementation
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
+#include "hw/virtio/virtio-serial.h"
+#include "virtio-ccw.h"
+
+static void virtio_ccw_serial_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtioSerialCcw *dev = VIRTIO_SERIAL_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    DeviceState *proxy = DEVICE(ccw_dev);
+    char *bus_name;
+
+    /*
+     * For command line compatibility, this sets the virtio-serial-device bus
+     * name as before.
+     */
+    if (proxy->id) {
+        bus_name = g_strdup_printf("%s.0", proxy->id);
+        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
+        g_free(bus_name);
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+
+static void virtio_ccw_serial_instance_init(Object *obj)
+{
+    VirtioSerialCcw *dev = VIRTIO_SERIAL_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SERIAL);
+}
+
+static Property virtio_ccw_serial_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_serial_realize;
+    dc->props = virtio_ccw_serial_properties;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_serial = {
+    .name          = TYPE_VIRTIO_SERIAL_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioSerialCcw),
+    .instance_init = virtio_ccw_serial_instance_init,
+    .class_init    = virtio_ccw_serial_class_init,
+};
+
+static void virtio_ccw_serial_register(void)
+{
+    type_register_static(&virtio_ccw_serial);
+}
+
+type_init(virtio_ccw_serial_register)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8de797743f..affbe1e8bf 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -17,7 +17,6 @@
 #include "sysemu/kvm.h"
 #include "net/net.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
@@ -809,36 +808,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
                               "bootindex", &error_abort);
 }
 
-static void virtio_ccw_serial_realize(VirtioCcwDevice *ccw_dev, Error **errp)
-{
-    VirtioSerialCcw *dev = VIRTIO_SERIAL_CCW(ccw_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    DeviceState *proxy = DEVICE(ccw_dev);
-    char *bus_name;
-
-    /*
-     * For command line compatibility, this sets the virtio-serial-device bus
-     * name as before.
-     */
-    if (proxy->id) {
-        bus_name = g_strdup_printf("%s.0", proxy->id);
-        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
-        g_free(bus_name);
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-
-static void virtio_ccw_serial_instance_init(Object *obj)
-{
-    VirtioSerialCcw *dev = VIRTIO_SERIAL_CCW(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_SERIAL);
-}
-
 static void virtio_ccw_balloon_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOBalloonCcw *dev = VIRTIO_BALLOON_CCW(ccw_dev);
@@ -1389,32 +1358,6 @@ static const TypeInfo virtio_ccw_blk = {
     .class_init    = virtio_ccw_blk_class_init,
 };
 
-static Property virtio_ccw_serial_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
-                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
-                       VIRTIO_CCW_MAX_REV),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
-
-    k->realize = virtio_ccw_serial_realize;
-    dc->props = virtio_ccw_serial_properties;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-}
-
-static const TypeInfo virtio_ccw_serial = {
-    .name          = TYPE_VIRTIO_SERIAL_CCW,
-    .parent        = TYPE_VIRTIO_CCW_DEVICE,
-    .instance_size = sizeof(VirtioSerialCcw),
-    .instance_init = virtio_ccw_serial_instance_init,
-    .class_init    = virtio_ccw_serial_class_init,
-};
-
 static Property virtio_ccw_balloon_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
@@ -1862,7 +1805,6 @@ static void virtio_ccw_register(void)
 {
     type_register_static(&virtio_ccw_bus_info);
     type_register_static(&virtio_ccw_device_info);
-    type_register_static(&virtio_ccw_serial);
     type_register_static(&virtio_ccw_blk);
     type_register_static(&virtio_ccw_net);
     type_register_static(&virtio_ccw_balloon);
-- 
2.14.4
