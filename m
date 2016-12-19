Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0X-0003O0-Qa
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0W-0004lc-NS
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0W-0004Vl-GA
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:08 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:02 +0800
Message-Id: <1482127152-84732-28-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 27/37] vhost-pci-net: pass the info
 collected by vp_slave to the device
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

When the device is realized, pass the vring info to the device from
the slave maintained list. The device uses bar2 to hold the peer VM
memory.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c                         | 29 ++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c                         | 14 +++++++++++++
 include/hw/virtio/vhost-pci-net.h              |  9 ++++++++
 include/standard-headers/linux/vhost_pci_net.h | 14 +++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index b9141fd..b3475c2 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -20,6 +20,35 @@
 #define VPNET_CQ_SIZE 32
 #define VPNET_RQ_SIZE 256
 
+void vpnet_set_peer_vq_num(VhostPCINet *vpnet, uint16_t num)
+{
+    vpnet->peer_vq_num = num;
+}
+
+void vpnet_init_device_features(VhostPCINet *vpnet, uint64_t features)
+{
+    vpnet->device_features = features;
+}
+
+void vpnet_set_peer_vq_msg(VhostPCINet *vpnet, PeerVqNode *vq_node)
+{
+    struct peer_vq_msg *pvq_msg;
+    uint32_t vring_num = vq_node->vring_num;
+
+    if (vpnet->pvq_msg == NULL) {
+        vpnet->pvq_msg = g_malloc0(sizeof(struct peer_vq_msg) *
+                                  (vring_num + 1));
+    }
+
+    pvq_msg = vpnet->pvq_msg + vring_num;
+    pvq_msg->last_avail_idx = vq_node->last_avail_idx;
+    pvq_msg->vring_num = vring_num;
+    pvq_msg->vring_enable = vq_node->enabled;
+    pvq_msg->desc_gpa = vq_node->addr.desc_user_addr;
+    pvq_msg->avail_gpa = vq_node->addr.avail_user_addr;
+    pvq_msg->used_gpa = vq_node->addr.used_user_addr;
+}
+
 static void vpnet_handle_rq(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index baf70b4..20cbefc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2320,7 +2320,21 @@ static void vpnet_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VhostPCINetPCI *dev = VHOST_PCI_NET_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    int bar_id = 2;
+    PeerVqNode *vq_node;
 
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+
+    pci_register_bar(&vpci_dev->pci_dev, bar_id,
+                      PCI_BASE_ADDRESS_SPACE_MEMORY |
+                      PCI_BASE_ADDRESS_MEM_PREFETCH |
+                      PCI_BASE_ADDRESS_MEM_TYPE_64,
+                      vp_slave->bar_mr);
+    vpnet_set_peer_vq_num(&dev->vdev, vp_slave->pvq_num);
+    vpnet_init_device_features(&dev->vdev, vp_slave->feature_bits);
+    QLIST_FOREACH(vq_node, &vp_slave->pvq_list, node) {
+        vpnet_set_peer_vq_msg(&dev->vdev, vq_node);
+    }
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
 
diff --git a/include/hw/virtio/vhost-pci-net.h b/include/hw/virtio/vhost-pci-net.h
index 8f2e65f..e813119 100644
--- a/include/hw/virtio/vhost-pci-net.h
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -16,6 +16,7 @@
 
 #include "standard-headers/linux/vhost_pci_net.h"
 #include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-pci-slave.h"
 
 #define TYPE_VHOST_PCI_NET "vhost-pci-net-device"
 #define VHOST_PCI_NET(obj) \
@@ -31,6 +32,14 @@ typedef struct VhostPCINet {
     uint16_t peer_vq_num;
     size_t config_size;
     uint64_t device_features;
+    struct peer_mem_msg pmem_msg;
+    struct peer_vq_msg *pvq_msg;
 } VhostPCINet;
 
+void vpnet_set_peer_vq_num(VhostPCINet *vpnet, uint16_t num);
+
+void vpnet_init_device_features(VhostPCINet *vpnet, uint64_t features);
+
+void vpnet_set_peer_vq_msg(VhostPCINet *vpnet, PeerVqNode *vq_node);
+
 #endif
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
index f4c8d0b..e525569 100644
--- a/include/standard-headers/linux/vhost_pci_net.h
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -51,4 +51,18 @@ struct vhost_pci_net_config {
 	uint16_t status;
 } QEMU_PACKED;
 
+struct peer_vq_msg {
+	uint16_t last_avail_idx;
+        int32_t  vring_enable;
+	uint32_t vring_num;
+	uint64_t desc_gpa;
+	uint64_t avail_gpa;
+	uint64_t used_gpa;
+};
+
+struct peer_vqs_msg {
+	uint32_t nvqs;
+	struct peer_vq_msg pvq_msg[];
+};
+
 #endif
-- 
2.7.4
