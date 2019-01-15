Received: from eggs.gnu.org ([209.51.188.92]:34838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyN-0007S2-W5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyF-0003Ai-Hi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUy9-0002wx-Ph
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:55 -0500
Date: Tue, 15 Jan 2019 15:05:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-26-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 25/49] virtio: split vhost user scsi bits
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h          |  11 ----
 hw/virtio/vhost-user-scsi-pci.c | 103 ++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c          |  60 -------------------
 hw/virtio/Makefile.objs         |   1 +
 4 files changed, 104 insertions(+), 71 deletions(-)
 create mode 100644 hw/virtio/vhost-user-scsi-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index acbbe5c4e8..ce6c194f1c 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -23,7 +23,6 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
-#include "hw/virtio/vhost-user-scsi.h"
 
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
@@ -35,7 +34,6 @@ typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
-typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -220,15 +218,6 @@ struct VHostSCSIPCI {
 };
 #endif
 
-#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci-base"
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
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
new file mode 100644
index 0000000000..46f7193cc7
--- /dev/null
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -0,0 +1,103 @@
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
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
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
+#define TYPE_VHOST_USER_SCSI_PCI "vhost-user-scsi-pci-base"
+#define VHOST_USER_SCSI_PCI(obj) \
+        OBJECT_CHECK(VHostUserSCSIPCI, (obj), TYPE_VHOST_USER_SCSI_PCI)
+
+struct VHostUserSCSIPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserSCSI vdev;
+};
+
+static Property vhost_user_scsi_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = vs->conf.num_queues + 3;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_scsi_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_user_scsi_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_user_scsi_pci_instance_init(Object *obj)
+{
+    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_SCSI);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_scsi_pci_info = {
+    .base_name             = TYPE_VHOST_USER_SCSI_PCI,
+    .generic_name          = "vhost-user-scsi-pci",
+    .transitional_name     = "vhost-user-scsi-pci-transitional",
+    .non_transitional_name = "vhost-user-scsi-pci-non-transitional",
+    .instance_size = sizeof(VHostUserSCSIPCI),
+    .instance_init = vhost_user_scsi_pci_instance_init,
+    .class_init    = vhost_user_scsi_pci_class_init,
+};
+
+static void vhost_user_scsi_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_scsi_pci_info);
+}
+
+type_init(vhost_user_scsi_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 44cc022a28..13cb13274e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2188,63 +2188,6 @@ static const VirtioPCIDeviceTypeInfo vhost_scsi_pci_info = {
 };
 #endif
 
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-/* vhost-user-scsi-pci */
-static Property vhost_user_scsi_pci_properties[] = {
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
-                       DEV_NVECTORS_UNSPECIFIED),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
-
-    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
-    }
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_user_scsi_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    k->realize = vhost_user_scsi_pci_realize;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = vhost_user_scsi_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_SCSI;
-    pcidev_k->revision = 0x00;
-    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
-}
-
-static void vhost_user_scsi_pci_instance_init(Object *obj)
-{
-    VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_USER_SCSI);
-    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
-}
-
-static const VirtioPCIDeviceTypeInfo vhost_user_scsi_pci_info = {
-    .base_name             = TYPE_VHOST_USER_SCSI_PCI,
-    .generic_name          = "vhost-user-scsi-pci",
-    .transitional_name     = "vhost-user-scsi-pci-transitional",
-    .non_transitional_name = "vhost-user-scsi-pci-non-transitional",
-    .instance_size = sizeof(VHostUserSCSIPCI),
-    .instance_init = vhost_user_scsi_pci_instance_init,
-    .class_init    = vhost_user_scsi_pci_class_init,
-};
-#endif
-
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2436,9 +2379,6 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     virtio_pci_types_register(&vhost_scsi_pci_info);
 #endif
-#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    virtio_pci_types_register(&vhost_user_scsi_pci_info);
-#endif
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 35b7698446..f851a6f2b5 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
+obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
-- 
MST
