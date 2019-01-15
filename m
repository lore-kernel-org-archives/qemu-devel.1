Received: from eggs.gnu.org ([209.51.188.92]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUym-00080D-FG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyP-0003Ml-5Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyN-0002uk-VW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:08 -0500
Date: Tue, 15 Jan 2019 15:05:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-22-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 21/49] virtio: split virtio rng bits from
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h     | 14 ------
 hw/virtio/virtio-pci.c     | 54 -----------------------
 hw/virtio/virtio-rng-pci.c | 88 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs    |  1 +
 tests/Makefile.include     |  2 +-
 5 files changed, 90 insertions(+), 69 deletions(-)
 create mode 100644 hw/virtio/virtio-rng-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index f1c75b0a89..a8b2e491c8 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -18,7 +18,6 @@
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
-#include "hw/virtio/virtio-rng.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
@@ -46,7 +45,6 @@ typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
-typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -319,18 +317,6 @@ typedef struct V9fsPCIState {
 
 #endif
 
-/*
- * virtio-rng-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_RNG_PCI "virtio-rng-pci-base"
-#define VIRTIO_RNG_PCI(obj) \
-        OBJECT_CHECK(VirtIORngPCI, (obj), TYPE_VIRTIO_RNG_PCI)
-
-struct VirtIORngPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIORNG vdev;
-};
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 185db53bc0..2e3eafd8b2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2546,59 +2546,6 @@ static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .class_init    = virtio_net_pci_class_init,
 };
 
-/* virtio-rng-pci */
-
-static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&vrng->vdev);
-    Error *err = NULL;
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    object_property_set_link(OBJECT(vrng),
-                             OBJECT(vrng->vdev.conf.rng), "rng",
-                             NULL);
-}
-
-static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = virtio_rng_pci_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RNG;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_OTHERS;
-}
-
-static void virtio_rng_initfn(Object *obj)
-{
-    VirtIORngPCI *dev = VIRTIO_RNG_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_RNG);
-}
-
-static const VirtioPCIDeviceTypeInfo virtio_rng_pci_info = {
-    .base_name             = TYPE_VIRTIO_RNG_PCI,
-    .generic_name          = "virtio-rng-pci",
-    .transitional_name     = "virtio-rng-pci-transitional",
-    .non_transitional_name = "virtio-rng-pci-non-transitional",
-    .instance_size = sizeof(VirtIORngPCI),
-    .instance_init = virtio_rng_initfn,
-    .class_init    = virtio_rng_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2651,7 +2598,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_info);
 
     /* Implementations: */
-    virtio_pci_types_register(&virtio_rng_pci_info);
 #ifdef CONFIG_VIRTFS
     virtio_pci_types_register(&virtio_9p_pci_info);
 #endif
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
new file mode 100644
index 0000000000..6cc6374289
--- /dev/null
+++ b/hw/virtio/virtio-rng-pci.c
@@ -0,0 +1,88 @@
+/*
+ * Virtio rng PCI Bindings
+ *
+ * Copyright 2012 Red Hat, Inc.
+ * Copyright 2012 Amit Shah <amit.shah@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-rng.h"
+#include "qapi/error.h"
+
+typedef struct VirtIORngPCI VirtIORngPCI;
+
+/*
+ * virtio-rng-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_RNG_PCI "virtio-rng-pci-base"
+#define VIRTIO_RNG_PCI(obj) \
+        OBJECT_CHECK(VirtIORngPCI, (obj), TYPE_VIRTIO_RNG_PCI)
+
+struct VirtIORngPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORNG vdev;
+};
+
+static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vrng->vdev);
+    Error *err = NULL;
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_link(OBJECT(vrng),
+                             OBJECT(vrng->vdev.conf.rng), "rng",
+                             NULL);
+}
+
+static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_rng_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RNG;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_rng_initfn(Object *obj)
+{
+    VirtIORngPCI *dev = VIRTIO_RNG_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_RNG);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_rng_pci_info = {
+    .base_name             = TYPE_VIRTIO_RNG_PCI,
+    .generic_name          = "virtio-rng-pci",
+    .transitional_name     = "virtio-rng-pci-transitional",
+    .non_transitional_name = "virtio-rng-pci-non-transitional",
+    .instance_size = sizeof(VirtIORngPCI),
+    .instance_init = virtio_rng_initfn,
+    .class_init    = virtio_rng_pci_class_init,
+};
+
+static void virtio_rng_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_rng_pci_info);
+}
+
+type_init(virtio_rng_pci_register)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index c61bcd106b..032ba2ff0e 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -15,6 +15,7 @@ ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
+obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 endif
 endif
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 601ef4f64c..3a50b3ba79 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -149,7 +149,7 @@ check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
-- 
MST
