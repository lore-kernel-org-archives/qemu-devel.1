Received: from eggs.gnu.org ([2001:4830:134:3::10]:38475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY6r-0001PB-72
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY6n-0003Vc-CU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:27 -0500
Received: from trasno.trasno.org ([83.165.45.250]:42148 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gXY6m-00034C-0S
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:24 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Dec 2018 22:00:46 +0100
Message-Id: <20181213210057.3676-6-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/16] virtio: split virtio balloon bits
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
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
index 032ba2ff0e..9e33104ce6 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -16,6 +16,7 @@ obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
+obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
 endif
 endif
 
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
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
@@ -2237,62 +2236,6 @@ static const TypeInfo vhost_user_scsi_pci_info = {
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
index aa4e89704d..dd7c882cc5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -146,7 +146,7 @@ check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
 check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
-- 
2.19.2
