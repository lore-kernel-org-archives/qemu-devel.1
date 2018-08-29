Received: from eggs.gnu.org ([2001:4830:134:3::10]:42857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqx-0001gO-Ft
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynC-0007LC-AN
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynC-0007L2-4w
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFCDB8574D
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:37:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:15 +0200
Message-Id: <20180829113730.14992-2-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/16] virtio: split vhost vsock bits from
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>

---

Updated copyright info
Also split virtio-pci.h bits
---
 hw/virtio/Makefile.objs     |  2 +-
 hw/virtio/vhost-vsock-pci.c | 82 +++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c      | 51 -----------------------
 hw/virtio/virtio-pci.h      | 18 --------
 4 files changed, 83 insertions(+), 70 deletions(-)
 create mode 100644 hw/virtio/vhost-vsock-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 1b2799cfd8..4fbf7de84b 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -10,7 +10,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
+obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
new file mode 100644
index 0000000000..5cafa8335c
--- /dev/null
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -0,0 +1,82 @@
+/*
+ * Vhost vsock PCI Bindings
+ *
+ * Copyright 2015 Red Hat, Inc.
+ *
+ * Authors:
+ *  Stefan Hajnoczi <stefanha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/vhost-vsock.h"
+
+typedef struct VHostVSockPCI VHostVSockPCI;
+
+/*
+ * vhost-vsock-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci"
+#define VHOST_VSOCK_PCI(obj) \
+        OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
+
+struct VHostVSockPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostVSock vdev;
+};
+
+static Property vhost_vsock_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_vsock_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props = vhost_vsock_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_vsock_pci_instance_init(Object *obj)
+{
+    VHostVSockPCI *dev = VHOST_VSOCK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_VSOCK);
+}
+
+static const TypeInfo vhost_vsock_pci_info = {
+    .name          = TYPE_VHOST_VSOCK_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VHostVSockPCI),
+    .instance_init = vhost_vsock_pci_instance_init,
+    .class_init    = vhost_vsock_pci_class_init,
+};
+
+static void virtio_pci_vhost_register(void)
+{
+    type_register_static(&vhost_vsock_pci_info);
+}
+
+type_init(virtio_pci_vhost_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..66e280aea1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2238,54 +2238,6 @@ static const TypeInfo vhost_user_scsi_pci_info = {
 };
 #endif
 
-/* vhost-vsock-pci */
-
-#ifdef CONFIG_VHOST_VSOCK
-static Property vhost_vsock_pci_properties[] = {
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void vhost_vsock_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    k->realize = vhost_vsock_pci_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    dc->props = vhost_vsock_pci_properties;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
-    pcidev_k->revision = 0x00;
-    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
-}
-
-static void vhost_vsock_pci_instance_init(Object *obj)
-{
-    VHostVSockPCI *dev = VHOST_VSOCK_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VHOST_VSOCK);
-}
-
-static const TypeInfo vhost_vsock_pci_info = {
-    .name          = TYPE_VHOST_VSOCK_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VHostVSockPCI),
-    .instance_init = vhost_vsock_pci_instance_init,
-    .class_init    = vhost_vsock_pci_class_init,
-};
-#endif
-
 /* virtio-balloon-pci */
 
 static Property virtio_balloon_pci_properties[] = {
@@ -2720,9 +2672,6 @@ static void virtio_pci_register_types(void)
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
     type_register_static(&vhost_user_scsi_pci_info);
 #endif
-#ifdef CONFIG_VHOST_VSOCK
-    type_register_static(&vhost_vsock_pci_info);
-#endif
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..25d225bc7d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -37,9 +37,6 @@
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
 #endif
-#ifdef CONFIG_VHOST_VSOCK
-#include "hw/virtio/vhost-vsock.h"
-#endif
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
@@ -55,7 +52,6 @@ typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
-typedef struct VHostVSockPCI VHostVSockPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
 /* virtio-pci-bus */
@@ -388,20 +384,6 @@ struct VirtIOGPUPCI {
     VirtIOGPU vdev;
 };
 
-#ifdef CONFIG_VHOST_VSOCK
-/*
- * vhost-vsock-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VHOST_VSOCK_PCI "vhost-vsock-pci"
-#define VHOST_VSOCK_PCI(obj) \
-        OBJECT_CHECK(VHostVSockPCI, (obj), TYPE_VHOST_VSOCK_PCI)
-
-struct VHostVSockPCI {
-    VirtIOPCIProxy parent_obj;
-    VHostVSock vdev;
-};
-#endif
-
 /*
  * virtio-crypto-pci: This extends VirtioPCIProxy.
  */
-- 
2.17.1
