Received: from eggs.gnu.org ([2001:4830:134:3::10]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5O-00071y-Df
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN5J-00089k-U5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN5J-00089K-Dw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6E1CA705
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:01 +0100
Message-Id: <20181126200009.862-9-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/16] virtio: split vhost user scsi bits
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
 hw/virtio/Makefile.objs         |   1 +
 hw/virtio/vhost-user-scsi-pci.c | 101 ++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c          |  58 ------------------
 hw/virtio/virtio-pci.h          |  11 ----
 4 files changed, 102 insertions(+), 69 deletions(-)
 create mode 100644 hw/virtio/vhost-user-scsi-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 2c95c55bd0..a5d2e38d3a 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -12,6 +12,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO=
_PCI)) +=3D virtio-crypto-p
 obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
+obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-user-scsi-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-=
pci.c
new file mode 100644
index 0000000000..5baec9c356
--- /dev/null
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -0,0 +1,101 @@
+/*
+ * Vhost user scsi PCI Bindings
+ *
+ * Copyright (c) 2016 Nutanix Inc. All rights reserved.
+ *
+ * Author:
+ *  Felipe Franciosi <felipe@nutanix.com>
+ *
+ * This work is largely based on the "vhost-scsi" implementation by:
+ *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
+ *  Nicholas Bellinger <nab@risingtidesystems.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "standard-headers/linux/virtio_pci.h"
+#include "hw/virtio/vhost-user-scsi.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-scsi.h"
+#include "hw/pci/pci.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/loader.h"
+#include "sysemu/kvm.h"
+#include "virtio-pci.h"
+
+typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
+
+#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
+#define VHOST_USER_SCSI_PCI(obj) \
+        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
+
+struct VHostUserSCSIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSCSI vdev;
+};
+
+static Property vhost_user_scsi_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
+{
+    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
+
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *dat=
a)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+    k->realize =3D vhost_user_scsi_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props =3D vhost_user_scsi_pci_properties;
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SCSI;
+    pcidev_k->revision =3D 0x00;
+    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_scsi_pci_instance_init(Object *obj)
+{
+    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SCSI);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_user_scsi_pci_info =3D {
+    .name          =3D TYPE_VHOST_USER_SCSI_PCI,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VHostUserSCSIPCI),
+    .instance_init =3D vhost_user_scsi_pci_instance_init,
+    .class_init    =3D vhost_user_scsi_pci_class_init,
+};
+
+static void vhost_user_scsi_pci_register(void)
+{
+    type_register_static(&vhost_user_scsi_pci_info);
+}
+
+type_init(vhost_user_scsi_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e9c562b1c0..7c99d9385a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2075,61 +2075,6 @@ static const TypeInfo vhost_scsi_pci_info =3D {
 };
 #endif
=20
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-/* vhost-user-scsi-pci */
-static Property vhost_user_scsi_pci_properties[] =3D {
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
-{
-    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
-
-    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D vs->conf.num_queues + 3;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *dat=
a)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
-    k->realize =3D vhost_user_scsi_pci_realize;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props =3D vhost_user_scsi_pci_properties;
-    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SCSI;
-    pcidev_k->revision =3D 0x00;
-    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
-}
-
-static void vhost_user_scsi_pci_instance_init(Object *obj)
-{
-    VHostUserSCSIPCI *dev =3D VHOST_USER_SCSI_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_USER_SCSI);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo vhost_user_scsi_pci_info =3D {
-    .name          =3D TYPE_VHOST_USER_SCSI_PCI,
-    .parent        =3D TYPE_VIRTIO_PCI,
-    .instance_size =3D sizeof(VHostUserSCSIPCI),
-    .instance_init =3D vhost_user_scsi_pci_instance_init,
-    .class_init    =3D vhost_user_scsi_pci_class_init,
-};
-#endif
-
 /* virtio-serial-pci */
=20
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
@@ -2314,9 +2259,6 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_scsi_pci_info);
-#endif
 }
=20
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 5e37982f88..7f06d7f331 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -23,7 +23,6 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
-#include "hw/virtio/vhost-user-scsi.h"
=20
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
@@ -35,7 +34,6 @@ typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
-typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
@@ -220,15 +218,6 @@ struct VHostSCSIPCI {
 };
 #endif
=20
-#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci"
-#define VHOST_USER_SCSI_PCI(obj) \
-        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
-
-struct VHostUserSCSIPCI {
-    VirtIOPCIProxy parent_obj;
-    VHostUserSCSI vdev;
-};
-
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
--=20
2.19.1
