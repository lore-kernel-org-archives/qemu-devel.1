Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzt-0002ot-A2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzp-0004VV-SL
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:8534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzp-0004Ug-Jh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:25 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:37 +0800
Message-Id: <1482127152-84732-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 02/37] vhost-pci-net: the fundamental
 implementation of vhost-pci-net-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/virtio-pci.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h | 14 ++++++++++++++
 include/hw/pci/pci.h   |  1 +
 3 files changed, 61 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 21c2b9d..baf70b4 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-pci-net.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
@@ -2309,6 +2310,50 @@ static const TypeInfo virtio_net_pci_info = {
     .class_init    = virtio_net_pci_class_init,
 };
 
+/* vhost-pci-net */
+
+static Property vpnet_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vpnet_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vpnet_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    k->device_id = PCI_DEVICE_ID_VHOST_PCI_NET;
+    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->props = vpnet_pci_properties;
+    vpciklass->realize = vpnet_pci_realize;
+}
+
+static void vpnet_pci_instance_init(Object *obj)
+{
+    VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_PCI_NET);
+}
+
+static const TypeInfo vpnet_pci_info = {
+    .name          = TYPE_VHOST_PCI_NET_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VhostPCINetPCI),
+    .instance_init = vpnet_pci_instance_init,
+    .class_init    = vpnet_pci_class_init,
+};
+
 /* virtio-rng-pci */
 
 static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2537,6 +2582,7 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_keyboard_pci_info);
     type_register_static(&virtio_mouse_pci_info);
     type_register_static(&virtio_tablet_pci_info);
+    type_register_static(&vpnet_pci_info);
 #ifdef CONFIG_LINUX
     type_register_static(&virtio_host_pci_info);
 #endif
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 5e07886..0b4b04f 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -18,6 +18,7 @@
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-pci-net.h"
 #include "hw/virtio/virtio-rng.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
@@ -43,6 +44,7 @@ typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
 typedef struct VirtIONetPCI VirtIONetPCI;
+typedef struct VhostPCINetPCI VhostPCINetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
@@ -262,6 +264,18 @@ struct VirtIONetPCI {
     VirtIONet vdev;
 };
 
+ /*
+ * vhost-pci-net-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_PCI_NET_PCI "vhost-pci-net-pci"
+#define VHOST_PCI_NET_PCI(obj) \
+        OBJECT_CHECK(VhostPCINetPCI, (obj), TYPE_VHOST_PCI_NET_PCI)
+
+struct VhostPCINetPCI {
+    VirtIOPCIProxy parent_obj;
+    VhostPCINet vdev;
+};
+
 /*
  * virtio-9p-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 772692f..ef8468b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -83,6 +83,7 @@
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VHOST_PCI_NET      0x1014
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
-- 
2.7.4
