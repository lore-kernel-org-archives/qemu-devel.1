Received: from eggs.gnu.org ([2001:4830:134:3::10]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN4w-0006k0-0y
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRN4r-00085Q-B5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:01:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRN4r-000857-21
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:01:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B41689AD3
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 20:01:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 26 Nov 2018 20:59:58 +0100
Message-Id: <20181126200009.862-6-quintela@redhat.com>
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/16] virtio: split virtio balloon bits
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs        |  1 +
 hw/virtio/virtio-balloon-pci.c | 94 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c         | 58 ---------------------
 hw/virtio/virtio-pci.h         | 14 -----
 tests/Makefile.include         |  2 +-
 5 files changed, 96 insertions(+), 73 deletions(-)
 create mode 100644 hw/virtio/virtio-balloon-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 2efa544a2d..0f0b846a45 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o vhost-vsoc=
k-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
+obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
 endif
=20
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) +=3D=
 vhost-stub.o
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pc=
i.c
new file mode 100644
index 0000000000..2e9d92990b
--- /dev/null
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -0,0 +1,94 @@
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
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-balloon.h"
+#include "qapi/error.h"
+
+typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
+
+/*
+ * virtio-balloon-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_BALLOON_PCI "virtio-balloon-pci"
+#define VIRTIO_BALLOON_PCI(obj) \
+        OBJECT_CHECK(VirtIOBalloonPCI, (obj), TYPE_VIRTIO_BALLOON_PCI)
+
+struct VirtIOBalloonPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOBalloon vdev;
+};
+
+static Property virtio_balloon_pci_properties[] =3D {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
+{
+    VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(vpci_dev);
+    DeviceState *vdev =3D DEVICE(&dev->vdev);
+
+    if (vpci_dev->class_code !=3D PCI_CLASS_OTHERS &&
+        vpci_dev->class_code !=3D PCI_CLASS_MEMORY_RAM) { /* qemu < 1.1 =
*/
+        vpci_dev->class_code =3D PCI_CLASS_OTHERS;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data=
)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
+    k->realize =3D virtio_balloon_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props =3D virtio_balloon_pci_properties;
+    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BALLOON;
+    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
+}
+
+static void virtio_balloon_pci_instance_init(Object *obj)
+{
+    VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_BALLOON);
+    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
+                                  "guest-stats", &error_abort);
+    object_property_add_alias(obj, "guest-stats-polling-interval",
+                              OBJECT(&dev->vdev),
+                              "guest-stats-polling-interval", &error_abo=
rt);
+}
+
+static const TypeInfo virtio_balloon_pci_info =3D {
+    .name          =3D TYPE_VIRTIO_BALLOON_PCI,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VirtIOBalloonPCI),
+    .instance_init =3D virtio_balloon_pci_instance_init,
+    .class_init    =3D virtio_balloon_pci_class_init,
+};
+
+static void virtio_balloon_pci_register(void)
+{
+    type_register_static(&virtio_balloon_pci_info);
+}
+
+type_init(virtio_balloon_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 433ece611d..855a7fdd40 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -23,7 +23,6 @@
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
-#include "hw/virtio/virtio-balloon.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -2237,62 +2236,6 @@ static const TypeInfo vhost_user_scsi_pci_info =3D=
 {
 };
 #endif
=20
-/* virtio-balloon-pci */
-
-static Property virtio_balloon_pci_properties[] =3D {
-    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
-{
-    VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(vpci_dev);
-    DeviceState *vdev =3D DEVICE(&dev->vdev);
-
-    if (vpci_dev->class_code !=3D PCI_CLASS_OTHERS &&
-        vpci_dev->class_code !=3D PCI_CLASS_MEMORY_RAM) { /* qemu < 1.1 =
*/
-        vpci_dev->class_code =3D PCI_CLASS_OTHERS;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data=
)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
-    k->realize =3D virtio_balloon_pci_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props =3D virtio_balloon_pci_properties;
-    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BALLOON;
-    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
-}
-
-static void virtio_balloon_pci_instance_init(Object *obj)
-{
-    VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_BALLOON);
-    object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
-                                  "guest-stats", &error_abort);
-    object_property_add_alias(obj, "guest-stats-polling-interval",
-                              OBJECT(&dev->vdev),
-                              "guest-stats-polling-interval", &error_abo=
rt);
-}
-
-static const TypeInfo virtio_balloon_pci_info =3D {
-    .name          =3D TYPE_VIRTIO_BALLOON_PCI,
-    .parent        =3D TYPE_VIRTIO_PCI,
-    .instance_size =3D sizeof(VirtIOBalloonPCI),
-    .instance_init =3D virtio_balloon_pci_instance_init,
-    .class_init    =3D virtio_balloon_pci_class_init,
-};
-
 /* virtio-serial-pci */
=20
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
@@ -2478,7 +2421,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&vhost_user_blk_pci_info);
 #endif
     type_register_static(&virtio_scsi_pci_info);
-    type_register_static(&virtio_balloon_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
 #ifdef CONFIG_VHOST_SCSI
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 2415eb6a4d..093fde7f4f 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -20,7 +20,6 @@
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
-#include "hw/virtio/virtio-balloon.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
@@ -39,7 +38,6 @@
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
-typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
@@ -264,18 +262,6 @@ struct VirtIOBlkPCI {
     VirtIOBlock vdev;
 };
=20
-/*
- * virtio-balloon-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_BALLOON_PCI "virtio-balloon-pci"
-#define VIRTIO_BALLOON_PCI(obj) \
-        OBJECT_CHECK(VirtIOBalloonPCI, (obj), TYPE_VIRTIO_BALLOON_PCI)
-
-struct VirtIOBalloonPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOBalloon vdev;
-};
-
 /*
  * virtio-serial-pci: This extends VirtioPCIProxy.
  */
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e8235890ec..89800e76ca 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -146,7 +146,7 @@ check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESU=
F)
 check-qtest-virtioserial-y +=3D tests/virtio-console-test$(EXESUF)
=20
 check-qtest-virtio-y +=3D tests/virtio-net-test$(EXESUF)
-check-qtest-virtio-y +=3D tests/virtio-balloon-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) +=3D tests/virtio-balloon-te=
st$(EXESUF)
 check-qtest-virtio-y +=3D tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-y +=3D tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) +=3D tests/virtio-rng-test$(EXES=
UF)
--=20
2.19.1
