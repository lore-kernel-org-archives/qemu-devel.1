Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxV-0000km-IJ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxU-0008U4-2U
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxT-0008TW-Rx
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B75740241C3
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:22 +0200
Message-Id: <20180808114830.7169-15-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/22] virtio: split balloon bits from
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs        |  1 +
 hw/virtio/virtio-balloon-pci.c | 82 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c         | 57 -----------------------
 tests/Makefile.include         |  4 +-
 4 files changed, 85 insertions(+), 59 deletions(-)
 create mode 100644 hw/virtio/virtio-balloon-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 2efa544a2d..0f0b846a45 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
+obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
new file mode 100644
index 0000000000..629083759c
--- /dev/null
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -0,0 +1,82 @@
+/*
+ * Virtio balloon PCI Bindings
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
+static Property virtio_balloon_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->class_code != PCI_CLASS_OTHERS &&
+        vpci_dev->class_code != PCI_CLASS_MEMORY_RAM) { /* qemu < 1.1 */
+        vpci_dev->class_code = PCI_CLASS_OTHERS;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = virtio_balloon_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props = virtio_balloon_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_balloon_pci_instance_init(Object *obj)
+{
+    VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BALLOON);
+    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
+                                  "guest-stats", &error_abort);
+    object_property_add_alias(obj, "guest-stats-polling-interval",
+                              OBJECT(&dev->vdev),
+                              "guest-stats-polling-interval", &error_abort);
+}
+
+static const TypeInfo virtio_balloon_pci_info = {
+    .name          = TYPE_VIRTIO_BALLOON_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOBalloonPCI),
+    .instance_init = virtio_balloon_pci_instance_init,
+    .class_init    = virtio_balloon_pci_class_init,
+};
+
+static void virtio_balloon_pci_register(void)
+{
+    type_register_static(&virtio_balloon_pci_info);
+}
+
+type_init(virtio_balloon_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 309fb20fef..f34817d040 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2225,62 +2225,6 @@ static const TypeInfo vhost_user_scsi_pci_info = {
 };
 #endif
 
-/* virtio-balloon-pci */
-
-static Property virtio_balloon_pci_properties[] = {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    if (vpci_dev->class_code != PCI_CLASS_OTHERS &&
-        vpci_dev->class_code != PCI_CLASS_MEMORY_RAM) { /* qemu < 1.1 */
-        vpci_dev->class_code = PCI_CLASS_OTHERS;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    k->realize = virtio_balloon_pci_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = virtio_balloon_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_OTHERS;
-}
-
-static void virtio_balloon_pci_instance_init(Object *obj)
-{
-    VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BALLOON);
-    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
-                                  "guest-stats", &error_abort);
-    object_property_add_alias(obj, "guest-stats-polling-interval",
-                              OBJECT(&dev->vdev),
-                              "guest-stats-polling-interval", &error_abort);
-}
-
-static const TypeInfo virtio_balloon_pci_info = {
-    .name          = TYPE_VIRTIO_BALLOON_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIOBalloonPCI),
-    .instance_init = virtio_balloon_pci_instance_init,
-    .class_init    = virtio_balloon_pci_class_init,
-};
-
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2466,7 +2410,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&vhost_user_blk_pci_info);
 #endif
     type_register_static(&virtio_scsi_pci_info);
-    type_register_static(&virtio_balloon_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
 #ifdef CONFIG_VHOST_SCSI
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6f46f9e812..d0432e4132 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -191,8 +191,8 @@ gcov-files-virtioserial-y += hw/char/virtio-console.c
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
-check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
-gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
+check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_BALLOON) += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
-- 
2.17.1
