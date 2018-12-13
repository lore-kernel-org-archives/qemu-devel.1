Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY70-0001YJ-QF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY6w-00047d-Vu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:38 -0500
Received: from trasno.trasno.org ([83.165.45.250]:42246 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gXY6v-0003kO-8B
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:33 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Dec 2018 22:00:52 +0100
Message-Id: <20181213210057.3676-12-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/16] virtio: split virtio blk bits rom
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/virtio-blk-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 59 -----------------------
 hw/virtio/virtio-pci.h     | 14 ------
 tests/Makefile.include     |  4 +-
 5 files changed, 100 insertions(+), 75 deletions(-)
 create mode 100644 hw/virtio/virtio-blk-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 012b6f74a7..557ad06231 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
+obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
 endif
 endif
 
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
new file mode 100644
index 0000000000..c1c41ad3f0
--- /dev/null
+++ b/hw/virtio/virtio-blk-pci.c
@@ -0,0 +1,97 @@
+/*
+ * Virtio blk PCI Bindings
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
+#include "hw/virtio/virtio-blk.h"
+#include "virtio-pci.h"
+#include "qapi/error.h"
+
+typedef struct VirtIOBlkPCI VirtIOBlkPCI;
+
+/*
+ * virtio-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_BLK_PCI "virtio-blk-pci"
+#define VIRTIO_BLK_PCI(obj) \
+        OBJECT_CHECK(VirtIOBlkPCI, (obj), TYPE_VIRTIO_BLK_PCI)
+
+struct VirtIOBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOBlock vdev;
+};
+
+static Property virtio_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = virtio_blk_pci_properties;
+    k->realize = virtio_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void virtio_blk_pci_instance_init(Object *obj)
+{
+    VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo virtio_blk_pci_info = {
+    .name          = TYPE_VIRTIO_BLK_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOBlkPCI),
+    .instance_init = virtio_blk_pci_instance_init,
+    .class_init    = virtio_blk_pci_class_init,
+};
+static void virtio_blk_pci_register(void)
+{
+    type_register_static(&virtio_blk_pci_info);
+}
+
+type_init(virtio_blk_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index debd764523..4fe71a56c8 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
 
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
@@ -1894,63 +1893,6 @@ static const TypeInfo virtio_pci_info = {
     },
 };
 
-/* virtio-blk-pci */
-
-static Property virtio_blk_pci_properties[] = {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_blk_pci_properties;
-    k->realize = virtio_blk_pci_realize;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
-}
-
-static void virtio_blk_pci_instance_init(Object *obj)
-{
-    VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo virtio_blk_pci_info = {
-    .name          = TYPE_VIRTIO_BLK_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIOBlkPCI),
-    .instance_init = virtio_blk_pci_instance_init,
-    .class_init    = virtio_blk_pci_class_init,
-};
-
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2128,7 +2070,6 @@ static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-    type_register_static(&virtio_blk_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
 }
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 5e13d87110..3c9bbf9287 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -16,7 +16,6 @@
 #define QEMU_VIRTIO_PCI_H
 
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
@@ -24,7 +23,6 @@
 #include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
@@ -185,18 +183,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
     proxy->disable_modern = true;
 }
 
-/*
- * virtio-blk-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_BLK_PCI "virtio-blk-pci"
-#define VIRTIO_BLK_PCI(obj) \
-        OBJECT_CHECK(VirtIOBlkPCI, (obj), TYPE_VIRTIO_BLK_PCI)
-
-struct VirtIOBlkPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOBlock vdev;
-};
-
 /*
  * virtio-serial-pci: This extends VirtioPCIProxy.
  */
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0889b86d67..78d7cf2fde 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -147,7 +147,7 @@ check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
@@ -278,7 +278,7 @@ check-qtest-arm-y += tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/pca9552-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
-check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
+check-qtest-arm-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
-- 
2.19.2
