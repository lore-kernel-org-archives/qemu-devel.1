Received: from eggs.gnu.org ([2001:4830:134:3::10]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxb-0000pD-LG
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxW-00006U-NI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxW-00005c-Hl
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11B8A81663D8
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:24 +0200
Message-Id: <20180808114830.7169-17-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/22] virtio: split vhost-user-blk bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs        |  1 +
 hw/virtio/vhost-user-blk-pci.c | 88 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c         | 60 -----------------------
 3 files changed, 89 insertions(+), 60 deletions(-)
 create mode 100644 hw/virtio/vhost-user-blk-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index bc802db4e8..2c95c55bd0 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,6 +11,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
+obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
new file mode 100644
index 0000000000..a344b533c1
--- /dev/null
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -0,0 +1,88 @@
+/*
+ * Virtio PCI Bindings
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
+#include "standard-headers/linux/virtio_pci.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-blk.h"
+#include "hw/pci/pci.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "virtio-pci.h"
+
+/* vhost-user-blk */
+
+static Property vhost_user_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_user_blk_pci_properties;
+    k->realize = vhost_user_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_blk_pci_instance_init(Object *obj)
+{
+    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_user_blk_pci_info = {
+    .name           = TYPE_VHOST_USER_BLK_PCI,
+    .parent         = TYPE_VIRTIO_PCI,
+    .instance_size  = sizeof(VHostUserBlkPCI),
+    .instance_init  = vhost_user_blk_pci_instance_init,
+    .class_init     = vhost_user_blk_pci_class_init,
+};
+
+static void vhost_user_blk_pci_register(void)
+{
+    type_register_static(&vhost_user_blk_pci_info);
+}
+
+type_init(vhost_user_blk_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d81821c5a8..b4acbebbab 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1941,63 +1941,6 @@ static const TypeInfo virtio_blk_pci_info = {
     .class_init    = virtio_blk_pci_class_init,
 };
 
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-/* vhost-user-blk */
-
-static Property vhost_user_blk_pci_properties[] = {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = dev->vdev.num_queues + 1;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_user_blk_pci_properties;
-    k->realize = vhost_user_blk_pci_realize;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
-}
-
-static void vhost_user_blk_pci_instance_init(Object *obj)
-{
-    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_USER_BLK);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo vhost_user_blk_pci_info = {
-    .name           = TYPE_VHOST_USER_BLK_PCI,
-    .parent         = TYPE_VIRTIO_PCI,
-    .instance_size  = sizeof(VHostUserBlkPCI),
-    .instance_init  = vhost_user_blk_pci_instance_init,
-    .class_init     = vhost_user_blk_pci_class_init,
-};
-#endif
-
 /* virtio-scsi-pci */
 
 static Property virtio_scsi_pci_properties[] = {
@@ -2354,9 +2297,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
     type_register_static(&virtio_blk_pci_info);
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_blk_pci_info);
-#endif
     type_register_static(&virtio_scsi_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
-- 
2.17.1
