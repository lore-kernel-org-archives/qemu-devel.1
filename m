Received: from eggs.gnu.org ([2001:4830:134:3::10]:44866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968l-0005cx-6l
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968j-0001rT-Pv
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968j-0001je-H8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:33 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:37 +0800
Message-Id: <1494578148-102868-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 05/16] vhost-pci-net-pci: add
 vhost-pci-net-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/Makefile.objs                        |  2 +-
 hw/net/vhost-pci-net.c                      |  6 ----
 hw/virtio/virtio-pci.c                      | 54 +++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h                      | 14 ++++++++
 include/hw/pci/pci.h                        |  1 +
 include/standard-headers/linux/virtio_ids.h |  1 +
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 6a95d92..3b218b0 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -33,7 +33,7 @@ obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
 obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
-obj-$(CONFIG_VIRTIO) += virtio-net.o
+obj-$(CONFIG_VIRTIO) += virtio-net.o vhost-pci-net.o
 obj-y += vhost_net.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 8e194ba..e36803a 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -117,12 +117,6 @@ static void vpnet_send_ctrlq_msg_remoteq(VhostPCINet *vpnet)
 static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
-    uint16_t vq_num = vpnet->vq_pairs * 2;
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusState *vbus = VIRTIO_BUS(qbus);
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    VirtQueue *vq;
-    int r, i;
 
     /* Send the ctrlq messages to the driver when the ctrlq is ready */
     if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244..b60e683 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2367,6 +2367,59 @@ static const TypeInfo virtio_net_pci_info = {
     .class_init    = virtio_net_pci_class_init,
 };
 
+/* vhost-pci-net */
+
+static Property vpnet_pci_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+#define REMOTE_MEM_BAR_ID 2
+static void vpnet_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+
+    pci_register_bar(&vpci_dev->pci_dev, REMOTE_MEM_BAR_ID,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     vp_dev->bar_mr);
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
@@ -2596,6 +2649,7 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_keyboard_pci_info);
     type_register_static(&virtio_mouse_pci_info);
     type_register_static(&virtio_tablet_pci_info);
+    type_register_static(&vpnet_pci_info);
 #ifdef CONFIG_LINUX
     type_register_static(&virtio_host_pci_info);
 #endif
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index b095dfc..6ffacd9 100644
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
@@ -278,6 +280,18 @@ struct VirtIONetPCI {
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
index a37a2d5..63903d6 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -83,6 +83,7 @@
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VHOST_PCI_NET      0x1014
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2..333bbd1 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_VHOST_PCI_NET 21 /* vhost-pci-net */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.7.4
