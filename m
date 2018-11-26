Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5T-00079G-KV
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5S-0008BP-6H
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5R-0008BE-UU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C87D3086272
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:05 +0100
Message-Id: <20181126200009.862-13-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/16] virtio: split virtio net bits rom
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
 hw/virtio/virtio-net-pci.c | 96 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c     | 57 ----------------------
 hw/virtio/virtio-pci.h     | 14 ------
 tests/Makefile.include     |  2 +-
 5 files changed, 98 insertions(+), 72 deletions(-)
 create mode 100644 hw/virtio/virtio-net-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index c28b740dca..0810553ab8 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -21,6 +21,7 @@ obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
 obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
 obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
 obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
+obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net-pci.o
 endif
=20
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) +=3D=
 vhost-stub.o
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
+static Property virtio_net_properties[] =3D {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
+{
+    DeviceState *qdev =3D DEVICE(vpci_dev);
+    VirtIONetPCI *dev =3D VIRTIO_NET_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
+                                  object_get_typename(OBJECT(qdev)));
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass =3D VIRTIO_PCI_CLASS(klass);
+
+    k->romfile =3D "efi-virtio.rom";
+    k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id =3D PCI_DEVICE_ID_VIRTIO_NET;
+    k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->props =3D virtio_net_properties;
+    vpciklass->realize =3D virtio_net_pci_realize;
+}
+
+static void virtio_net_pci_instance_init(Object *obj)
+{
+    VirtIONetPCI *dev =3D VIRTIO_NET_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_NET);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo virtio_net_pci_info =3D {
+    .name          =3D TYPE_VIRTIO_NET_PCI,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VirtIONetPCI),
+    .instance_init =3D virtio_net_pci_instance_init,
+    .class_init    =3D virtio_net_pci_class_init,
+};
+
+static void virtio_net_pci_register(void)
+{
+    type_register_static(&virtio_net_pci_info);
+}
+
+type_init(virtio_net_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4fe71a56c8..cb03bfa597 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,7 +19,6 @@
=20
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
@@ -1966,61 +1965,6 @@ static const TypeInfo virtio_serial_pci_info =3D {
     .class_init    =3D virtio_serial_pci_class_init,
 };
=20
-/* virtio-net-pci */
-
-static Property virtio_net_properties[] =3D {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
-{
-    DeviceState *qdev =3D DEVICE(vpci_dev);
-    VirtIONetPCI *dev =3D VIRTIO_NET_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-
-    virtio_net_set_netclient_name(&dev->vdev, qdev->id,
-                                  object_get_typename(OBJECT(qdev)));
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
-    VirtioPCIClass *vpciklass =3D VIRTIO_PCI_CLASS(klass);
-
-    k->romfile =3D "efi-virtio.rom";
-    k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    k->device_id =3D PCI_DEVICE_ID_VIRTIO_NET;
-    k->revision =3D VIRTIO_PCI_ABI_VERSION;
-    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
-    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->props =3D virtio_net_properties;
-    vpciklass->realize =3D virtio_net_pci_realize;
-}
-
-static void virtio_net_pci_instance_init(Object *obj)
-{
-    VirtIONetPCI *dev =3D VIRTIO_NET_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_NET);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo virtio_net_pci_info =3D {
-    .name          =3D TYPE_VIRTIO_NET_PCI,
-    .parent        =3D TYPE_VIRTIO_PCI,
-    .instance_size =3D sizeof(VirtIONetPCI),
-    .instance_init =3D virtio_net_pci_instance_init,
-    .class_init    =3D virtio_net_pci_class_init,
-};
-
 /* virtio-pci-bus */
=20
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2071,7 +2015,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
     type_register_static(&virtio_serial_pci_info);
-    type_register_static(&virtio_net_pci_info);
 }
=20
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 3c9bbf9287..ab0c7907e4 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -16,7 +16,6 @@
 #define QEMU_VIRTIO_PCI_H
=20
 #include "hw/pci/msi.h"
-#include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
@@ -24,7 +23,6 @@
=20
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
-typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
@@ -195,18 +193,6 @@ struct VirtIOSerialPCI {
     VirtIOSerial vdev;
 };
=20
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
index 36d95fe913..0a3878f3ab 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -145,7 +145,7 @@ check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESU=
F)
=20
 check-qtest-virtioserial-y +=3D tests/virtio-console-test$(EXESUF)
=20
-check-qtest-virtio-y +=3D tests/virtio-net-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_NET) +=3D tests/virtio-net-test$(EXES=
UF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) +=3D tests/virtio-balloon-te=
st$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_BLK) +=3D tests/virtio-blk-test$(EXES=
UF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) +=3D tests/virtio-rng-test$(EXES=
UF)
--=20
2.19.1
