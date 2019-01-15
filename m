Received: from eggs.gnu.org ([209.51.188.92]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyq-00084y-9Y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyR-0003Ra-6n
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyP-000313-Ls
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:10 -0500
Date: Tue, 15 Jan 2019 15:05:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-31-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 30/49] virtio: split virtio serial bits from
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

Virtio console and qga tests also depend on CONFIG_VIRTIO_SERIAL.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h        |  14 -----
 hw/virtio/virtio-pci.c        |  79 -----------------------
 hw/virtio/virtio-serial-pci.c | 115 ++++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs       |   1 +
 tests/Makefile.include        |   6 +-
 5 files changed, 119 insertions(+), 96 deletions(-)
 create mode 100644 hw/virtio/virtio-serial-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 8bfd4b9601..d4491e2544 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -16,13 +16,11 @@
 #define QEMU_VIRTIO_PCI_H
 
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -181,18 +179,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
     proxy->disable_modern = true;
 }
 
-/*
- * virtio-serial-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_SERIAL_PCI "virtio-serial-pci-base"
-#define VIRTIO_SERIAL_PCI(obj) \
-        OBJECT_CHECK(VirtIOSerialPCI, (obj), TYPE_VIRTIO_SERIAL_PCI)
-
-struct VirtIOSerialPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOSerial vdev;
-};
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c3e3791b70..b282109343 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
 
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -1999,81 +1998,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     }
 }
 
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
-static const VirtioPCIDeviceTypeInfo virtio_serial_pci_info = {
-    .base_name             = TYPE_VIRTIO_SERIAL_PCI,
-    .generic_name          = "virtio-serial-pci",
-    .transitional_name     = "virtio-serial-pci-transitional",
-    .non_transitional_name = "virtio-serial-pci-non-transitional",
-    .instance_size = sizeof(VirtIOSerialPCI),
-    .instance_init = virtio_serial_pci_instance_init,
-    .class_init    = virtio_serial_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2124,9 +2048,6 @@ static void virtio_pci_register_types(void)
     /* Base types: */
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-
-    /* Implementations: */
-    virtio_pci_types_register(&virtio_serial_pci_info);
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
new file mode 100644
index 0000000000..971b2eb8d8
--- /dev/null
+++ b/hw/virtio/virtio-serial-pci.c
@@ -0,0 +1,115 @@
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
+#include "hw/virtio/virtio-serial.h"
+#include "virtio-pci.h"
+
+typedef struct VirtIOSerialPCI VirtIOSerialPCI;
+
+/*
+ * virtio-serial-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_SERIAL_PCI "virtio-serial-pci-base"
+#define VIRTIO_SERIAL_PCI(obj) \
+        OBJECT_CHECK(VirtIOSerialPCI, (obj), TYPE_VIRTIO_SERIAL_PCI)
+
+struct VirtIOSerialPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOSerial vdev;
+};
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
+static const VirtioPCIDeviceTypeInfo virtio_serial_pci_info = {
+    .base_name             = TYPE_VIRTIO_SERIAL_PCI,
+    .generic_name          = "virtio-serial-pci",
+    .transitional_name     = "virtio-serial-pci-transitional",
+    .non_transitional_name = "virtio-serial-pci-non-transitional",
+    .instance_size = sizeof(VirtIOSerialPCI),
+    .instance_init = virtio_serial_pci_instance_init,
+    .class_init    = virtio_serial_pci_class_init,
+};
+
+static void virtio_serial_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_serial_pci_info);
+}
+
+type_init(virtio_serial_pci_register)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 4c31acb017..ea7913d532 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -24,6 +24,7 @@ obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
 obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
+obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
 endif
 endif
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 590ee0cbd6..aa68eb5ef4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -108,7 +108,7 @@ check-unit-y += tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(CONFIG_LINUX) += tests/test-qga$(EXESUF)
+check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
 check-unit-y += tests/test-util-sockets$(EXESUF)
@@ -144,7 +144,7 @@ check-qtest-generic-y += tests/cdrom-test$(EXESUF)
 
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 
-check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
+check-qtest-virtioserial-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-console-test$(EXESUF)
 
 check-qtest-virtio-$(CONFIG_VIRTIO_NET) += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
@@ -154,7 +154,7 @@ check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-$(CONFIG_VIRTIO_9P) += tests/virtio-9p-test$(EXESUF)
 endif
-check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-serial-test$(EXESUF)
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
-- 
MST
