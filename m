Received: from eggs.gnu.org ([2001:4830:134:3::10]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqm-0001cf-H4
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynT-0007Qt-EB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynT-0007QU-8Y
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED6B68076895
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:38:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:23 +0200
Message-Id: <20180829113730.14992-10-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/16] virtio: split vhost scsi bits from
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/vhost-scsi-pci.c | 95 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 59 -----------------------
 hw/virtio/virtio-pci.h     | 19 --------
 4 files changed, 96 insertions(+), 78 deletions(-)
 create mode 100644 hw/virtio/vhost-scsi-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index a5d2e38d3a..6e6e001449 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
+obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
new file mode 100644
index 0000000000..2be2c567ea
--- /dev/null
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -0,0 +1,95 @@
+/*
+ * Vhost scsi PCI bindings
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
+ *
+ * Changes for QEMU mainline + tcm_vhost kernel upstream:
+ *  Nicholas Bellinger <nab@risingtidesystems.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "standard-headers/linux/virtio_pci.h"
+#include "hw/virtio/vhost-scsi.h"
+#include "qapi/error.h"
+#include "virtio-pci.h"
+
+typedef struct VHostSCSIPCI VHostSCSIPCI;
+
+/*
+ * vhost-scsi-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_SCSI_PCI "vhost-scsi-pci"
+#define VHOST_SCSI_PCI(obj) \
+        OBJECT_CHECK(VHostSCSIPCI, (obj), TYPE_VHOST_SCSI_PCI)
+
+struct VHostSCSIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostSCSI vdev;
+};
+
+static Property vhost_scsi_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = vs->conf.num_queues + 3;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_scsi_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_scsi_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_scsi_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_scsi_pci_instance_init(Object *obj)
+{
+    VHostSCSIPCI *dev = VHOST_SCSI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_SCSI);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_scsi_pci_info = {
+    .name          = TYPE_VHOST_SCSI_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VHostSCSIPCI),
+    .instance_init = vhost_scsi_pci_instance_init,
+    .class_init    = vhost_scsi_pci_class_init,
+};
+
+static void vhost_scsi_pci_register(void)
+{
+    type_register_static(&vhost_scsi_pci_info);
+}
+
+type_init(vhost_scsi_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc2ba6cb2..fa37f36e02 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2019,62 +2019,6 @@ static const TypeInfo virtio_scsi_pci_info = {
     .class_init    = virtio_scsi_pci_class_init,
 };
 
-/* vhost-scsi-pci */
-
-#ifdef CONFIG_VHOST_SCSI
-static Property vhost_scsi_pci_properties[] = {
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
-
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_scsi_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    k->realize = vhost_scsi_pci_realize;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_scsi_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
-    pcidev_k->revision = 0x00;
-    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
-}
-
-static void vhost_scsi_pci_instance_init(Object *obj)
-{
-    VHostSCSIPCI *dev = VHOST_SCSI_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_SCSI);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo vhost_scsi_pci_info = {
-    .name          = TYPE_VHOST_SCSI_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VHostSCSIPCI),
-    .instance_init = vhost_scsi_pci_instance_init,
-    .class_init    = vhost_scsi_pci_class_init,
-};
-#endif
-
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2256,9 +2200,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_scsi_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
-#ifdef CONFIG_VHOST_SCSI
-    type_register_static(&vhost_scsi_pci_info);
-#endif
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 7f06d7f331..eb7cdbad25 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -24,16 +24,11 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 
-#ifdef CONFIG_VHOST_SCSI
-#include "hw/virtio/vhost-scsi.h"
-#endif
-
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
-typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -204,20 +199,6 @@ struct VirtIOSCSIPCI {
     VirtIOSCSI vdev;
 };
 
-#ifdef CONFIG_VHOST_SCSI
-/*
- * vhost-scsi-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VHOST_SCSI_PCI "vhost-scsi-pci"
-#define VHOST_SCSI_PCI(obj) \
-        OBJECT_CHECK(VHostSCSIPCI, (obj), TYPE_VHOST_SCSI_PCI)
-
-struct VHostSCSIPCI {
-    VirtIOPCIProxy parent_obj;
-    VHostSCSI vdev;
-};
-#endif
-
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
-- 
2.17.1
