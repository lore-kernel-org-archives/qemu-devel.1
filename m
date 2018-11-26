Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5R-000771-Nk
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5Q-0008B6-D2
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5Q-0008Av-5y
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8038EA8BF5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:04 +0100
Message-Id: <20181126200009.862-12-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/16] virtio: split virtio blk bits rom
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/virtio-blk-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 59 -----------------------
 hw/virtio/virtio-pci.h     | 14 ------
 tests/Makefile.include     |  5 +-
 5 files changed, 100 insertions(+), 76 deletions(-)
 create mode 100644 hw/virtio/virtio-blk-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 5d59302f89..c28b740dca 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -20,6 +20,7 @@ obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
+obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
 endif
=20
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) +=3D=
 vhost-stub.o
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
+static Property virtio_blk_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
+{
+    VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D dev->vdev.conf.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props =3D virtio_blk_pci_properties;
+    k->realize =3D virtio_blk_pci_realize;
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
+}
+
+static void virtio_blk_pci_instance_init(Object *obj)
+{
+    VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo virtio_blk_pci_info =3D {
+    .name          =3D TYPE_VIRTIO_BLK_PCI,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VirtIOBlkPCI),
+    .instance_init =3D virtio_blk_pci_instance_init,
+    .class_init    =3D virtio_blk_pci_class_init,
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
=20
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
@@ -1894,63 +1893,6 @@ static const TypeInfo virtio_pci_info =3D {
     },
 };
=20
-/* virtio-blk-pci */
-
-static Property virtio_blk_pci_properties[] =3D {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
-{
-    VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-
-    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.conf.num_queues + 1;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props =3D virtio_blk_pci_properties;
-    k->realize =3D virtio_blk_pci_realize;
-    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BLOCK;
-    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
-}
-
-static void virtio_blk_pci_instance_init(Object *obj)
-{
-    VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BLK);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo virtio_blk_pci_info =3D {
-    .name          =3D TYPE_VIRTIO_BLK_PCI,
-    .parent        =3D TYPE_VIRTIO_PCI,
-    .instance_size =3D sizeof(VirtIOBlkPCI),
-    .instance_init =3D virtio_blk_pci_instance_init,
-    .class_init    =3D virtio_blk_pci_class_init,
-};
-
 /* virtio-serial-pci */
=20
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
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
=20
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
@@ -24,7 +23,6 @@
 #include "hw/virtio/virtio-crypto.h"
=20
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
@@ -185,18 +183,6 @@ static inline void virtio_pci_disable_modern(VirtIOP=
CIProxy *proxy)
     proxy->disable_modern =3D true;
 }
=20
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
index 9b3e7d7403..36d95fe913 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -147,8 +147,7 @@ check-qtest-virtioserial-y +=3D tests/virtio-console-=
test$(EXESUF)
=20
 check-qtest-virtio-y +=3D tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) +=3D tests/virtio-balloon-te=
st$(EXESUF)
-check-qtest-virtio-y +=3D tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-y +=3D tests/virtio-rng-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_BLK) +=3D tests/virtio-blk-test$(EXES=
UF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) +=3D tests/virtio-rng-test$(EXES=
UF)
 check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) +=3D tests/virtio-scsi-test$(EX=
ESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
@@ -279,7 +278,7 @@ check-qtest-arm-y +=3D tests/tmp105-test$(EXESUF)
 check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
 check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
 check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
-check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
+check-qtest-arm-$(CONFIG_VIRTIO_BLK) +=3D tests/virtio-blk-test$(EXESUF)
 check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
 check-qtest-arm-y +=3D tests/boot-serial-test$(EXESUF)
 check-qtest-arm-$(CONFIG_SDHCI) +=3D tests/sdhci-test$(EXESUF)
--=20
2.19.1
