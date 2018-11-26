Received: from eggs.gnu.org ([2001:4830:134:3::10]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN50-0006na-5z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN4y-00086H-UC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN4y-00086B-NI
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:02:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C71E30026D1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:02:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 21:00:00 +0100
Message-Id: <20181126200009.862-8-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/16] virtio: split vhost user blk bits
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs        |   1 +
 hw/virtio/vhost-user-blk-pci.c | 101 +++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c         |  60 --------------------
 hw/virtio/virtio-pci.h         |  18 ------
 4 files changed, 102 insertions(+), 78 deletions(-)
 create mode 100644 hw/virtio/vhost-user-blk-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index bc802db4e8..2c95c55bd0 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,6 +11,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO=
_PCI)) +=3D virtio-crypto-p
=20
 obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o vhost-vsock-pci.o
+obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pc=
i.c
new file mode 100644
index 0000000000..29ffcc4361
--- /dev/null
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -0,0 +1,101 @@
+/*
+ * Vhost user blk PCI Bindings
+ *
+ * Copyright(C) 2017 Intel Corporation.
+ *
+ * Authors:
+ *  Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * Largely based on the "vhost-user-scsi.c" and "vhost-scsi.c" implement=
ed by:
+ * Felipe Franciosi <felipe@nutanix.com>
+ * Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
+ * Nicholas Bellinger <nab@risingtidesystems.com>
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
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-user-blk.h"
+#include "hw/pci/pci.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "virtio-pci.h"
+
+typedef struct VHostUserBlkPCI VHostUserBlkPCI;
+
+/*
+ * vhost-user-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_USER_BLK_PCI "vhost-user-blk-pci"
+#define VHOST_USER_BLK_PCI(obj) \
+        OBJECT_CHECK(VHostUserBlkPCI, (obj), TYPE_VHOST_USER_BLK_PCI)
+
+struct VHostUserBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserBlk vdev;
+};
+
+static Property vhost_user_blk_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
+{
+    VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data=
)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props =3D vhost_user_blk_pci_properties;
+    k->realize =3D vhost_user_blk_pci_realize;
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_blk_pci_instance_init(Object *obj)
+{
+    VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_user_blk_pci_info =3D {
+    .name           =3D TYPE_VHOST_USER_BLK_PCI,
+    .parent         =3D TYPE_VIRTIO_PCI,
+    .instance_size  =3D sizeof(VHostUserBlkPCI),
+    .instance_init  =3D vhost_user_blk_pci_instance_init,
+    .class_init     =3D vhost_user_blk_pci_class_init,
+};
+
+static void vhost_user_blk_pci_register(void)
+{
+    type_register_static(&vhost_user_blk_pci_info);
+}
+
+type_init(vhost_user_blk_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bad9279f19..e9c562b1c0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1952,63 +1952,6 @@ static const TypeInfo virtio_blk_pci_info =3D {
     .class_init    =3D virtio_blk_pci_class_init,
 };
=20
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-/* vhost-user-blk */
-
-static Property vhost_user_blk_pci_properties[] =3D {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
-{
-    VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-
-    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data=
)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props =3D vhost_user_blk_pci_properties;
-    k->realize =3D vhost_user_blk_pci_realize;
-    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BLOCK;
-    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id =3D PCI_CLASS_STORAGE_SCSI;
-}
-
-static void vhost_user_blk_pci_instance_init(Object *obj)
-{
-    VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_USER_BLK);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const TypeInfo vhost_user_blk_pci_info =3D {
-    .name           =3D TYPE_VHOST_USER_BLK_PCI,
-    .parent         =3D TYPE_VIRTIO_PCI,
-    .instance_size  =3D sizeof(VHostUserBlkPCI),
-    .instance_init  =3D vhost_user_blk_pci_instance_init,
-    .class_init     =3D vhost_user_blk_pci_class_init,
-};
-#endif
-
 /* virtio-scsi-pci */
=20
 static Property virtio_scsi_pci_properties[] =3D {
@@ -2365,9 +2308,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
     type_register_static(&virtio_blk_pci_info);
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    type_register_static(&vhost_user_blk_pci_info);
-#endif
     type_register_static(&virtio_scsi_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 200950de0a..5e37982f88 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -24,9 +24,6 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user-scsi.h"
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-#include "hw/virtio/vhost-user-blk.h"
-#endif
=20
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
@@ -39,7 +36,6 @@ typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
-typedef struct VHostUserBlkPCI VHostUserBlkPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
=20
@@ -233,20 +229,6 @@ struct VHostUserSCSIPCI {
     VHostUserSCSI vdev;
 };
=20
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-/*
- * vhost-user-blk-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VHOST_USER_BLK_PCI "vhost-user-blk-pci"
-#define VHOST_USER_BLK_PCI(obj) \
-        OBJECT_CHECK(VHostUserBlkPCI, (obj), TYPE_VHOST_USER_BLK_PCI)
-
-struct VHostUserBlkPCI {
-    VirtIOPCIProxy parent_obj;
-    VHostUserBlk vdev;
-};
-#endif
-
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
--=20
2.19.1
