Received: from eggs.gnu.org ([2001:4830:134:3::10]:48582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxg-0000uB-8c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxe-0000La-Mj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxe-0000Kd-HC
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09B68402315B
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:49:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:30 +0200
Message-Id: <20180808114830.7169-23-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/22] virtio: split virtio-serial bits rom
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
 hw/virtio/Makefile.objs       |  1 +
 hw/virtio/virtio-pci.c        | 74 --------------------------
 hw/virtio/virtio-serial-pci.c | 97 +++++++++++++++++++++++++++++++++++
 tests/Makefile.include        | 12 ++---
 4 files changed, 104 insertions(+), 80 deletions(-)
 create mode 100644 hw/virtio/virtio-serial-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 0810553ab8..3d88b60d27 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
 obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
+obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 589e565746..da5161a9a1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1884,79 +1884,6 @@ static const TypeInfo virtio_pci_info = {
     },
 };
 
-/* virtio-serial-pci */
-
-static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIOSerialPCI *dev = VIRTIO_SERIAL_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    DeviceState *proxy = DEVICE(vpci_dev);
-    char *bus_name;
-
-    if (vpci_dev->class_code != PCI_CLASS_COMMUNICATION_OTHER &&
-        vpci_dev->class_code != PCI_CLASS_DISPLAY_OTHER && /* qemu 0.10 */
-        vpci_dev->class_code != PCI_CLASS_OTHERS) {        /* qemu-kvm  */
-            vpci_dev->class_code = PCI_CLASS_COMMUNICATION_OTHER;
-    }
-
-    /* backwards-compatibility with machines that were created with
-       DEV_NVECTORS_UNSPECIFIED */
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = dev->vdev.serial.max_virtserial_ports + 1;
-    }
-
-    /*
-     * For command line compatibility, this sets the virtio-serial-device bus
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
-static Property virtio_serial_pci_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    k->realize = virtio_serial_pci_realize;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props = virtio_serial_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_CONSOLE;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
-}
-
-static void virtio_serial_pci_instance_init(Object *obj)
-{
-    VirtIOSerialPCI *dev = VIRTIO_SERIAL_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_SERIAL);
-}
-
-static const TypeInfo virtio_serial_pci_info = {
-    .name          = TYPE_VIRTIO_SERIAL_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIOSerialPCI),
-    .instance_init = virtio_serial_pci_instance_init,
-    .class_init    = virtio_serial_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2006,7 +1933,6 @@ static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-    type_register_static(&virtio_serial_pci_info);
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
new file mode 100644
index 0000000000..453c6690fb
--- /dev/null
+++ b/hw/virtio/virtio-serial-pci.c
@@ -0,0 +1,97 @@
+/*
+ * Virtio serial PCI Bindings
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
+
+static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOSerialPCI *dev = VIRTIO_SERIAL_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    DeviceState *proxy = DEVICE(vpci_dev);
+    char *bus_name;
+
+    if (vpci_dev->class_code != PCI_CLASS_COMMUNICATION_OTHER &&
+        vpci_dev->class_code != PCI_CLASS_DISPLAY_OTHER && /* qemu 0.10 */
+        vpci_dev->class_code != PCI_CLASS_OTHERS) {        /* qemu-kvm  */
+            vpci_dev->class_code = PCI_CLASS_COMMUNICATION_OTHER;
+    }
+
+    /* backwards-compatibility with machines that were created with
+       DEV_NVECTORS_UNSPECIFIED */
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.serial.max_virtserial_ports + 1;
+    }
+
+    /*
+     * For command line compatibility, this sets the virtio-serial-device bus
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
+static Property virtio_serial_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = virtio_serial_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    dc->props = virtio_serial_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_CONSOLE;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void virtio_serial_pci_instance_init(Object *obj)
+{
+    VirtIOSerialPCI *dev = VIRTIO_SERIAL_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SERIAL);
+}
+
+static const TypeInfo virtio_serial_pci_info = {
+    .name          = TYPE_VIRTIO_SERIAL_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOSerialPCI),
+    .instance_init = virtio_serial_pci_instance_init,
+    .class_init    = virtio_serial_pci_class_init,
+};
+static void virtio_serial_pci_register(void)
+{
+    type_register_static(&virtio_serial_pci_info);
+}
+
+type_init(virtio_serial_pci_register)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a1352ccefb..8666206ea4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,7 +143,7 @@ check-unit-y += tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(CONFIG_LINUX) += tests/test-qga$(EXESUF)
+check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
 check-unit-y += tests/test-util-sockets$(EXESUF)
@@ -185,8 +185,8 @@ gcov-files-ipack-y += hw/ipack/ipack.c
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 gcov-files-ipack-y += hw/char/ipoctal232.c
 
-check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
-gcov-files-virtioserial-y += hw/char/virtio-console.c
+check-qtest-virtioserial-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-console-test$(EXESUF)
+gcov-files-virtioserial-$(CONFIG_VIRTIO_SERIAL) += hw/char/virtio-console.c
 
 gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
 check-qtest-virtio-$(CONFIG_VIRTIO_NET) += tests/virtio-net-test$(EXESUF)
@@ -204,8 +204,8 @@ check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
 gcov-files-virtio-y += hw/9pfs/virtio-9p.c
 gcov-files-virtio-y += i386-softmmu/hw/9pfs/virtio-9p-device.c
 endif
-check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
-gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
+check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-serial-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_SERIAL) += i386-softmmu/hw/char/virtio-serial-bus.c
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 gcov-files-virtio-y += $(gcov-files-virtioserial-y)
 
@@ -402,7 +402,7 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-serial-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
-- 
2.17.1
