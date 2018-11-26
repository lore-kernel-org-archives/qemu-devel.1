Received: from eggs.gnu.org ([2001:4830:134:3::10]:52610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5V-0007Az-BR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5T-0008Bi-Tw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5T-0008BX-MT
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F011C307D96E
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:06 +0100
Message-Id: <20181126200009.862-14-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/16] virtio: split virtio serial bits rom
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

Virtio console and qga tests also depend on CONFIG_VIRTIO_SERIAL.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs       |   1 +
 hw/virtio/virtio-pci.c        |  75 -----------------------
 hw/virtio/virtio-pci.h        |  14 -----
 hw/virtio/virtio-serial-pci.c | 112 ++++++++++++++++++++++++++++++++++
 tests/Makefile.include        |   6 +-
 5 files changed, 116 insertions(+), 92 deletions(-)
 create mode 100644 hw/virtio/virtio-serial-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 0810553ab8..3d88b60d27 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
 obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net-pci.o
+obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-serial-pci.o
 endif
=20
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) +=3D=
 vhost-stub.o
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb03bfa597..5a54b144a5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
=20
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -1892,79 +1891,6 @@ static const TypeInfo virtio_pci_info =3D {
     },
 };
=20
-/* virtio-serial-pci */
-
-static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
-{
-    VirtIOSerialPCI *dev =3D VIRTIO_SERIAL_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-    DeviceState *proxy =3D DEVICE(vpci_dev);
-    char *bus_name;
-
-    if (vpci_dev->class_code !=3D PCI_CLASS_COMMUNICATION_OTHER &&
-        vpci_dev->class_code !=3D PCI_CLASS_DISPLAY_OTHER && /* qemu 0.1=
0 */
-        vpci_dev->class_code !=3D PCI_CLASS_OTHERS) {        /* qemu-kvm=
  */
-            vpci_dev->class_code =3D PCI_CLASS_COMMUNICATION_OTHER;
-    }
-
-    /* backwards-compatibility with machines that were created with
-       DEV_NVECTORS_UNSPECIFIED */
-    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.serial.max_virtserial_ports + 1=
;
-    }
-
-    /*
-     * For command line compatibility, this sets the virtio-serial-devic=
e bus
-     * name as before.
-     */
-    if (proxy->id) {
-        bus_name =3D g_strdup_printf("%s.0", proxy->id);
-        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
-        g_free(bus_name);
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static Property virtio_serial_pci_properties[] =3D {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
-    k->realize =3D virtio_serial_pci_realize;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-    dc->props =3D virtio_serial_pci_properties;
-    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_CONSOLE;
-    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id =3D PCI_CLASS_COMMUNICATION_OTHER;
-}
-
-static void virtio_serial_pci_instance_init(Object *obj)
-{
-    VirtIOSerialPCI *dev =3D VIRTIO_SERIAL_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_SERIAL);
-}
-
-static const TypeInfo virtio_serial_pci_info =3D {
-    .name          =3D TYPE_VIRTIO_SERIAL_PCI,
-    .parent        =3D TYPE_VIRTIO_PCI,
-    .instance_size =3D sizeof(VirtIOSerialPCI),
-    .instance_init =3D virtio_serial_pci_instance_init,
-    .class_init    =3D virtio_serial_pci_class_init,
-};
-
 /* virtio-pci-bus */
=20
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2014,7 +1940,6 @@ static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-    type_register_static(&virtio_serial_pci_info);
 }
=20
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index ab0c7907e4..59016d553b 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -16,13 +16,11 @@
 #define QEMU_VIRTIO_PCI_H
=20
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
=20
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
@@ -181,18 +179,6 @@ static inline void virtio_pci_disable_modern(VirtIOP=
CIProxy *proxy)
     proxy->disable_modern =3D true;
 }
=20
-/*
- * virtio-serial-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_SERIAL_PCI "virtio-serial-pci"
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
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.=
c
new file mode 100644
index 0000000000..acb23427ac
--- /dev/null
+++ b/hw/virtio/virtio-serial-pci.c
@@ -0,0 +1,112 @@
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
+#define TYPE_VIRTIO_SERIAL_PCI "virtio-serial-pci"
+#define VIRTIO_SERIAL_PCI(obj) \
+        OBJECT_CHECK(VirtIOSerialPCI, (obj), TYPE_VIRTIO_SERIAL_PCI)
+
+struct VirtIOSerialPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOSerial vdev;
+};
+
+static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
+{
+    VirtIOSerialPCI *dev =3D VIRTIO_SERIAL_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+    DeviceState *proxy =3D DEVICE(vpci_dev);
+    char *bus_name;
+
+    if (vpci_dev->class_code !=3D PCI_CLASS_COMMUNICATION_OTHER &&
+        vpci_dev->class_code !=3D PCI_CLASS_DISPLAY_OTHER && /* qemu 0.1=
0 */
+        vpci_dev->class_code !=3D PCI_CLASS_OTHERS) {        /* qemu-kvm=
  */
+            vpci_dev->class_code =3D PCI_CLASS_COMMUNICATION_OTHER;
+    }
+
+    /* backwards-compatibility with machines that were created with
+       DEV_NVECTORS_UNSPECIFIED */
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D dev->vdev.serial.max_virtserial_ports + 1=
;
+    }
+
+    /*
+     * For command line compatibility, this sets the virtio-serial-devic=
e bus
+     * name as before.
+     */
+    if (proxy->id) {
+        bus_name =3D g_strdup_printf("%s.0", proxy->id);
+        virtio_device_set_child_bus_name(VIRTIO_DEVICE(vdev), bus_name);
+        g_free(bus_name);
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static Property virtio_serial_pci_properties[] =3D {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_serial_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+    k->realize =3D virtio_serial_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    dc->props =3D virtio_serial_pci_properties;
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_CONSOLE;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void virtio_serial_pci_instance_init(Object *obj)
+{
+    VirtIOSerialPCI *dev =3D VIRTIO_SERIAL_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_SERIAL);
+}
+
+static const TypeInfo virtio_serial_pci_info =3D {
+    .name          =3D TYPE_VIRTIO_SERIAL_PCI,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VirtIOSerialPCI),
+    .instance_init =3D virtio_serial_pci_instance_init,
+    .class_init    =3D virtio_serial_pci_class_init,
+};
+static void virtio_serial_pci_register(void)
+{
+    type_register_static(&virtio_serial_pci_info);
+}
+
+type_init(virtio_serial_pci_register)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0a3878f3ab..d09a6af706 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -107,7 +107,7 @@ check-unit-y +=3D tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(CONFIG_LINUX) +=3D tests/test-qga$(EXESUF)
+check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests/te=
st-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-y +=3D tests/test-util-sockets$(EXESUF)
@@ -143,7 +143,7 @@ check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
=20
 check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESUF)
=20
-check-qtest-virtioserial-y +=3D tests/virtio-console-test$(EXESUF)
+check-qtest-virtioserial-$(CONFIG_VIRTIO_SERIAL) +=3D tests/virtio-conso=
le-test$(EXESUF)
=20
 check-qtest-virtio-$(CONFIG_VIRTIO_NET) +=3D tests/virtio-net-test$(EXES=
UF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) +=3D tests/virtio-balloon-te=
st$(EXESUF)
@@ -153,7 +153,7 @@ check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) +=3D tests/v=
irtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-y +=3D tests/virtio-9p-test$(EXESUF)
 endif
-check-qtest-virtio-y +=3D tests/virtio-serial-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) +=3D tests/virtio-serial-test=
$(EXESUF)
 check-qtest-virtio-y +=3D $(check-qtest-virtioserial-y)
=20
 check-qtest-pci-y +=3D tests/e1000-test$(EXESUF)
--=20
2.19.1
