Received: from eggs.gnu.org ([209.51.188.92]:34821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyO-0007Rk-1m
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyF-0003AU-HS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUy9-0002zu-Lo
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:55 -0500
Date: Tue, 15 Jan 2019 15:05:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-30-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 29/49] virtio: split virtio net bits from
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h     | 14 ------
 hw/virtio/virtio-net-pci.c | 98 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 59 -----------------------
 hw/virtio/Makefile.objs    |  1 +
 tests/Makefile.include     |  2 +-
 5 files changed, 100 insertions(+), 74 deletions(-)
 create mode 100644 hw/virtio/virtio-net-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index b805c02c11..8bfd4b9601 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -16,7 +16,6 @@
 #define QEMU_VIRTIO_PCI_H
 
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
@@ -24,7 +23,6 @@
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
-typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -195,18 +193,6 @@ struct VirtIOSerialPCI {
     VirtIOSerial vdev;
 };
 
-/*
- * virtio-net-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
-#define VIRTIO_NET_PCI(obj) \
-        OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
-
-struct VirtIONetPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIONet vdev;
-};
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
new file mode 100644
index 0000000000..db07ab9e21
--- /dev/null
+++ b/hw/virtio/virtio-net-pci.c
@@ -0,0 +1,98 @@
+/*
+ * Virtio net PCI Bindings
+ *
+ * Copyright IBM, Corp. 2007
+ * Copyright (c) 2009 CodeSourcery
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Paul Brook        <paul@codesourcery.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-net.h"
+#include "virtio-pci.h"
+#include "qapi/error.h"
+
+typedef struct VirtIONetPCI VirtIONetPCI;
+
+/*
+ * virtio-net-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
+#define VIRTIO_NET_PCI(obj) \
+        OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
+
+struct VirtIONetPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIONet vdev;
+};
+
+static Property virtio_net_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    DeviceState *qdev = DEVICE(vpci_dev);
+    VirtIONetPCI *dev = VIRTIO_NET_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
+                                  object_get_typename(OBJECT(qdev)));
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    k->romfile = "efi-virtio.rom";
+    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
+    k->revision = VIRTIO_PCI_ABI_VERSION;
+    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->props = virtio_net_properties;
+    vpciklass->realize = virtio_net_pci_realize;
+}
+
+static void virtio_net_pci_instance_init(Object *obj)
+{
+    VirtIONetPCI *dev = VIRTIO_NET_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_NET);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
+    .base_name             = TYPE_VIRTIO_NET_PCI,
+    .generic_name          = "virtio-net-pci",
+    .transitional_name     = "virtio-net-pci-transitional",
+    .non_transitional_name = "virtio-net-pci-non-transitional",
+    .instance_size = sizeof(VirtIONetPCI),
+    .instance_init = virtio_net_pci_instance_init,
+    .class_init    = virtio_net_pci_class_init,
+};
+
+static void virtio_net_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_net_pci_info);
+}
+
+type_init(virtio_net_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 859b03ae5b..c3e3791b70 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
 
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
@@ -2075,63 +2074,6 @@ static const VirtioPCIDeviceTypeInfo virtio_serial_pci_info = {
     .class_init    = virtio_serial_pci_class_init,
 };
 
-/* virtio-net-pci */
-
-static Property virtio_net_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    DeviceState *qdev = DEVICE(vpci_dev);
-    VirtIONetPCI *dev = VIRTIO_NET_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
-                                  object_get_typename(OBJECT(qdev)));
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
-
-    k->romfile = "efi-virtio.rom";
-    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
-    k->revision = VIRTIO_PCI_ABI_VERSION;
-    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->props = virtio_net_properties;
-    vpciklass->realize = virtio_net_pci_realize;
-}
-
-static void virtio_net_pci_instance_init(Object *obj)
-{
-    VirtIONetPCI *dev = VIRTIO_NET_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_NET);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
-    .base_name             = TYPE_VIRTIO_NET_PCI,
-    .generic_name          = "virtio-net-pci",
-    .transitional_name     = "virtio-net-pci-transitional",
-    .non_transitional_name = "virtio-net-pci-non-transitional",
-    .instance_size = sizeof(VirtIONetPCI),
-    .instance_init = virtio_net_pci_instance_init,
-    .class_init    = virtio_net_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2185,7 +2127,6 @@ static void virtio_pci_register_types(void)
 
     /* Implementations: */
     virtio_pci_types_register(&virtio_serial_pci_info);
-    virtio_pci_types_register(&virtio_net_pci_info);
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 557ad06231..4c31acb017 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -23,6 +23,7 @@ obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
+obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
 endif
 endif
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03dbc6bfde..590ee0cbd6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -146,7 +146,7 @@ check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
 check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 
-check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_NET) += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
-- 
MST
