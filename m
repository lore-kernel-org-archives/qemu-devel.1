Received: from eggs.gnu.org ([2001:4830:134:3::10]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqr-0001cf-1w
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynL-0007NZ-88
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynL-0007NN-2G
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB5398574D
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:37:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:20 +0200
Message-Id: <20180829113730.14992-7-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 06/16] virtio: split virtio 9p bits from
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
 hw/virtio/Makefile.objs   |  1 +
 hw/virtio/virtio-9p-pci.c | 86 +++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c    | 52 -----------------------
 hw/virtio/virtio-pci.h    | 20 ---------
 4 files changed, 87 insertions(+), 72 deletions(-)
 create mode 100644 hw/virtio/virtio-9p-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 0f0b846a45..bc802db4e8 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -15,6 +15,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
+obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
new file mode 100644
index 0000000000..74c6ca2ddb
--- /dev/null
+++ b/hw/virtio/virtio-9p-pci.c
@@ -0,0 +1,86 @@
+/*
+ * Virtio 9p PCI Bindings
+ *
+ * Copyright IBM, Corp. 2010
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
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
+#include "virtio-pci.h"
+#include "hw/9pfs/virtio-9p.h"
+
+/*
+ * virtio-9p-pci: This extends VirtioPCIProxy.
+ */
+
+#define TYPE_VIRTIO_9P_PCI "virtio-9p-pci"
+#define VIRTIO_9P_PCI(obj) \
+        OBJECT_CHECK(V9fsPCIState, (obj), TYPE_VIRTIO_9P_PCI)
+
+typedef struct V9fsPCIState {
+    VirtIOPCIProxy parent_obj;
+    V9fsVirtioState vdev;
+} V9fsPCIState;
+
+static void virtio_9p_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    V9fsPCIState *dev = VIRTIO_9P_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static Property virtio_9p_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+
+    k->realize = virtio_9p_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_9P;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = 0x2;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = virtio_9p_pci_properties;
+}
+
+static void virtio_9p_pci_instance_init(Object *obj)
+{
+    V9fsPCIState *dev = VIRTIO_9P_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_9P);
+}
+
+static const TypeInfo virtio_9p_pci_info = {
+    .name          = TYPE_VIRTIO_9P_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(V9fsPCIState),
+    .instance_init = virtio_9p_pci_instance_init,
+    .class_init    = virtio_9p_pci_class_init,
+};
+
+static void virtio_9p_pci_register(void)
+{
+    type_register_static(&virtio_9p_pci_info);
+}
+
+type_init(virtio_9p_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4bb2a5aab2..ab2f5c93cf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1077,55 +1077,6 @@ static void virtio_pci_vmstate_change(DeviceState *d, bool running)
     }
 }
 
-#ifdef CONFIG_VIRTFS
-static void virtio_9p_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    V9fsPCIState *dev = VIRTIO_9P_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static Property virtio_9p_pci_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-
-    k->realize = virtio_9p_pci_realize;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_9P;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = 0x2;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_9p_pci_properties;
-}
-
-static void virtio_9p_pci_instance_init(Object *obj)
-{
-    V9fsPCIState *dev = VIRTIO_9P_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_9P);
-}
-
-static const TypeInfo virtio_9p_pci_info = {
-    .name          = TYPE_VIRTIO_9P_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(V9fsPCIState),
-    .instance_init = virtio_9p_pci_instance_init,
-    .class_init    = virtio_9p_pci_class_init,
-};
-#endif /* CONFIG_VIRTFS */
-
 /*
  * virtio-pci: This is the PCIDevice which has a virtio-pci-bus.
  */
@@ -2413,9 +2364,6 @@ static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-#ifdef CONFIG_VIRTFS
-    type_register_static(&virtio_9p_pci_info);
-#endif
     type_register_static(&virtio_blk_pci_info);
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
     type_register_static(&vhost_user_blk_pci_info);
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 093fde7f4f..200950de0a 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -28,9 +28,6 @@
 #include "hw/virtio/vhost-user-blk.h"
 #endif
 
-#ifdef CONFIG_VIRTFS
-#include "hw/9pfs/virtio-9p.h"
-#endif
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
 #endif
@@ -286,23 +283,6 @@ struct VirtIONetPCI {
     VirtIONet vdev;
 };
 
-/*
- * virtio-9p-pci: This extends VirtioPCIProxy.
- */
-
-#ifdef CONFIG_VIRTFS
-
-#define TYPE_VIRTIO_9P_PCI "virtio-9p-pci"
-#define VIRTIO_9P_PCI(obj) \
-        OBJECT_CHECK(V9fsPCIState, (obj), TYPE_VIRTIO_9P_PCI)
-
-typedef struct V9fsPCIState {
-    VirtIOPCIProxy parent_obj;
-    V9fsVirtioState vdev;
-} V9fsPCIState;
-
-#endif
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
-- 
2.17.1
