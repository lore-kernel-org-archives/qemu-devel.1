Received: from eggs.gnu.org ([209.51.188.92]:34913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyO-0007TS-Tc
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyL-0003HB-H4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyF-0002xv-HN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:01 -0500
Date: Tue, 15 Jan 2019 15:05:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-28-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/49] virtio: split virtio scsi bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Notice that we can't still run tests with it disabled.  Both cdrom-test and
drive_del-test use virtio-scsi without checking if it is enabled.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h      |  14 -----
 hw/virtio/virtio-pci.c      |  71 ------------------------
 hw/virtio/virtio-scsi-pci.c | 107 ++++++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs     |   1 +
 tests/Makefile.include      |   2 +-
 5 files changed, 109 insertions(+), 86 deletions(-)
 create mode 100644 hw/virtio/virtio-scsi-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index b14d83a454..d00f6d6b9d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -19,14 +19,12 @@
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
-#include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
-typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
@@ -187,18 +185,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
     proxy->disable_modern = true;
 }
 
-/*
- * virtio-scsi-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_SCSI_PCI "virtio-scsi-pci-base"
-#define VIRTIO_SCSI_PCI(obj) \
-        OBJECT_CHECK(VirtIOSCSIPCI, (obj), TYPE_VIRTIO_SCSI_PCI)
-
-struct VirtIOSCSIPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOSCSI vdev;
-};
-
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b2ed6b3942..da812b7844 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -22,7 +22,6 @@
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
-#include "hw/virtio/virtio-scsi.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -2061,75 +2060,6 @@ static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info = {
     .class_init    = virtio_blk_pci_class_init,
 };
 
-/* virtio-scsi-pci */
-
-static Property virtio_scsi_pci_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
-    DeviceState *proxy = DEVICE(vpci_dev);
-    char *bus_name;
-
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
-    }
-
-    /*
-     * For command line compatibility, this sets the virtio-scsi-device bus
-     * name as before.
-     */
-    if (proxy->id) {
-        bus_name = g_strdup_printf("%s.0", proxy->id);
-        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
-        g_free(bus_name);
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_scsi_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = virtio_scsi_pci_realize;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_scsi_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
-    pcidev_k->revision = 0x00;
-    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
-}
-
-static void virtio_scsi_pci_instance_init(Object *obj)
-{
-    VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_SCSI);
-}
-
-static const VirtioPCIDeviceTypeInfo virtio_scsi_pci_info = {
-    .base_name              = TYPE_VIRTIO_SCSI_PCI,
-    .generic_name           = "virtio-scsi-pci",
-    .transitional_name      = "virtio-scsi-pci-transitional",
-    .non_transitional_name  = "virtio-scsi-pci-non-transitional",
-    .instance_size = sizeof(VirtIOSCSIPCI),
-    .instance_init = virtio_scsi_pci_instance_init,
-    .class_init    = virtio_scsi_pci_class_init,
-};
-
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2315,7 +2245,6 @@ static void virtio_pci_register_types(void)
 
     /* Implementations: */
     virtio_pci_types_register(&virtio_blk_pci_info);
-    virtio_pci_types_register(&virtio_scsi_pci_info);
     virtio_pci_types_register(&virtio_serial_pci_info);
     virtio_pci_types_register(&virtio_net_pci_info);
 }
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
new file mode 100644
index 0000000000..2830849729
--- /dev/null
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -0,0 +1,107 @@
+/*
+ * Virtio scsi PCI Bindings
+ *
+ * Copyright IBM, Corp. 2007
+ * Copyright (c) 2009 CodeSourcery
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Paul Brook        <paul@codesourcery.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-scsi.h"
+#include "virtio-pci.h"
+
+typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
+
+/*
+ * virtio-scsi-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SCSI_PCI "virtio-scsi-pci-base"
+#define VIRTIO_SCSI_PCI(obj) \
+        OBJECT_CHECK(VirtIOSCSIPCI, (obj), TYPE_VIRTIO_SCSI_PCI)
+
+struct VirtIOSCSIPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOSCSI vdev;
+};
+
+static Property virtio_scsi_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+    DeviceState *proxy = DEVICE(vpci_dev);
+    char *bus_name;
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = vs->conf.num_queues + 3;
+    }
+
+    /*
+     * For command line compatibility, this sets the virtio-scsi-device bus
+     * name as before.
+     */
+    if (proxy->id) {
+        bus_name = g_strdup_printf("%s.0", proxy->id);
+        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
+        g_free(bus_name);
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_scsi_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_scsi_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = virtio_scsi_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void virtio_scsi_pci_instance_init(Object *obj)
+{
+    VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SCSI);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_scsi_pci_info = {
+    .base_name              = TYPE_VIRTIO_SCSI_PCI,
+    .generic_name           = "virtio-scsi-pci",
+    .transitional_name      = "virtio-scsi-pci-transitional",
+    .non_transitional_name  = "virtio-scsi-pci-non-transitional",
+    .instance_size = sizeof(VirtIOSCSIPCI),
+    .instance_init = virtio_scsi_pci_instance_init,
+    .class_init    = virtio_scsi_pci_class_init,
+};
+
+static void virtio_scsi_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_scsi_pci_info);
+}
+
+type_init(virtio_scsi_pci_register)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 0a56946c1a..012b6f74a7 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -21,6 +21,7 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
+obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 endif
 endif
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c2845b67aa..ba82235bd4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -150,7 +150,7 @@ check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-$(CONFIG_VIRTIO_9P) += tests/virtio-9p-test$(EXESUF)
 endif
-- 
MST
