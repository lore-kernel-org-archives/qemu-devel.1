Received: from eggs.gnu.org ([2001:4830:134:3::10]:48474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxU-0000ja-0H
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxS-0008Rv-Np
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxS-0008RF-GE
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AFC37B2B2
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:21 +0200
Message-Id: <20180808114830.7169-14-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/22] virtio: split rng bits from virtio-pci
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
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/virtio-pci.c     | 52 -------------------------
 hw/virtio/virtio-rng-pci.c | 77 ++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include     |  4 +-
 4 files changed, 80 insertions(+), 54 deletions(-)
 create mode 100644 hw/virtio/virtio-rng-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 6819ed4e14..2efa544a2d 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
+obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 992d3bc3b4..309fb20fef 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2409,57 +2409,6 @@ static const TypeInfo virtio_net_pci_info = {
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
-static const TypeInfo virtio_rng_pci_info = {
-    .name          = TYPE_VIRTIO_RNG_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIORngPCI),
-    .instance_init = virtio_rng_initfn,
-    .class_init    = virtio_rng_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2507,7 +2456,6 @@ static const TypeInfo virtio_pci_bus_info = {
 
 static void virtio_pci_register_types(void)
 {
-    type_register_static(&virtio_rng_pci_info);
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
new file mode 100644
index 0000000000..b7651c8b66
--- /dev/null
+++ b/hw/virtio/virtio-rng-pci.c
@@ -0,0 +1,77 @@
+/*
+ * Virtio rng PCI Bindings
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
+#include "virtio-pci.h"
+#include "qapi/error.h"
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
+static const TypeInfo virtio_rng_pci_info = {
+    .name          = TYPE_VIRTIO_RNG_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIORngPCI),
+    .instance_init = virtio_rng_initfn,
+    .class_init    = virtio_rng_pci_class_init,
+};
+
+static void virtio_rng_pci_register(void)
+{
+    type_register_static(&virtio_rng_pci_info);
+}
+
+type_init(virtio_rng_pci_register)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 47a5b66cde..6f46f9e812 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -195,8 +195,8 @@ check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
-gcov-files-virtio-y += hw/virtio/virtio-rng.c
+check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_RNG) += hw/virtio/virtio-rng.c
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
-- 
2.17.1
