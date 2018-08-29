Received: from eggs.gnu.org ([2001:4830:134:3::10]:42693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqk-0001VR-Sg
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynY-0007SB-0I
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynX-0007S5-R8
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 840D087A82
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:38:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:26 +0200
Message-Id: <20180829113730.14992-13-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/16] virtio: split virtio net bits rom
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/virtio-net-pci.c | 96 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 57 ----------------------
 hw/virtio/virtio-pci.h     | 14 ------
 tests/Makefile.include     |  4 +-
 5 files changed, 99 insertions(+), 73 deletions(-)
 create mode 100644 hw/virtio/virtio-net-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index c28b740dca..0810553ab8 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -21,6 +21,7 @@ obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
+obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
new file mode 100644
index 0000000000..0b676f078d
--- /dev/null
+++ b/hw/virtio/virtio-net-pci.c
@@ -0,0 +1,96 @@
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
+#define TYPE_VIRTIO_NET_PCI "virtio-net-pci"
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
+static const TypeInfo virtio_net_pci_info = {
+    .name          = TYPE_VIRTIO_NET_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIONetPCI),
+    .instance_init = virtio_net_pci_instance_init,
+    .class_init    = virtio_net_pci_class_init,
+};
+
+static void virtio_net_pci_register(void)
+{
+    type_register_static(&virtio_net_pci_info);
+}
+
+type_init(virtio_net_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bbb8f8e216..5c075f0887 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
 
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
@@ -1966,61 +1965,6 @@ static const TypeInfo virtio_serial_pci_info = {
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
-static const TypeInfo virtio_net_pci_info = {
-    .name          = TYPE_VIRTIO_NET_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIONetPCI),
-    .instance_init = virtio_net_pci_instance_init,
-    .class_init    = virtio_net_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2071,7 +2015,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
     type_register_static(&virtio_serial_pci_info);
-    type_register_static(&virtio_net_pci_info);
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 3c9bbf9287..ab0c7907e4 100644
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
-#define TYPE_VIRTIO_NET_PCI "virtio-net-pci"
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 405755b2de..a9140043ed 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -197,8 +197,8 @@ check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 gcov-files-virtioserial-y += hw/char/virtio-console.c
 
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
-check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
-gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
+check-qtest-virtio-$(CONFIG_VIRTIO_NET) += tests/virtio-net-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_NET) += i386-softmmu/hw/net/virtio-net.c
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
 gcov-files-virtio-$(CONFIG_VIRTIO_BALLOON) += i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-$(CONFIG_VIRTIO_BLK) += tests/virtio-blk-test$(EXESUF)
-- 
2.17.1
