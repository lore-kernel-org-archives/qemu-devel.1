Received: from eggs.gnu.org ([2001:4830:134:3::10]:33324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ez-0001Th-65
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eM4Ex-0007QB-9n
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:32277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eM4Ex-0007JF-0Q
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:49:51 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:15 +0800
Message-Id: <1512444796-30615-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 6/7] vhost-pci-slave: handle
 VHOST_USER_SET_VHOST_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>

This patch implements the slave part handling of the
VHOST_USER_SET_VHOST_PCI msg.

Receiving a "true" from the master will set the LINK_UP status of the
vhost-pci device config status, and a config interrupt will be injected
to the guest to notify that the device is ready to use. The driver is
expected to start reading the metadata for remote memory and vring setup
after this LINK_UP interrupt is received.

Receiving a "false" from the master will clear the LINK_UP status and
inject a config interrupt to the guest to notify the driver to stop
sending and receiving packets.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_pci_net.c                         | 13 +++++++++++++
 hw/virtio/vhost-pci-slave.c                    |  3 +++
 include/hw/virtio/vhost-pci-net.h              |  2 ++
 include/standard-headers/linux/vhost_pci_net.h |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/hw/net/vhost_pci_net.c b/hw/net/vhost_pci_net.c
index 11184c3..39eb28d 100644
--- a/hw/net/vhost_pci_net.c
+++ b/hw/net/vhost_pci_net.c
@@ -32,6 +32,19 @@ static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
+void vpnet_set_link_up(VhostPCINet *vpnet, bool up)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vpnet);
+
+    if (up) {
+        vpnet->status |= VPNET_S_LINK_UP;
+    } else {
+        vpnet->status &= ~VPNET_S_LINK_UP;
+    }
+
+    virtio_notify_config(vdev);
+}
+
 static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 8052884..6554efb 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -287,6 +287,9 @@ void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_ENABLE:
         vp_slave_set_vring_enable(vpnet, &msg);
         break;
+    case VHOST_USER_SET_VHOST_PCI:
+        vpnet_set_link_up(vpnet, (bool)msg.payload.u64);
+        break;
     case VHOST_USER_SET_LOG_BASE:
         break;
     case VHOST_USER_SET_LOG_FD:
diff --git a/include/hw/virtio/vhost-pci-net.h b/include/hw/virtio/vhost-pci-net.h
index 6f4ab6a..2d0e94c 100644
--- a/include/hw/virtio/vhost-pci-net.h
+++ b/include/hw/virtio/vhost-pci-net.h
@@ -37,4 +37,6 @@ typedef struct VhostPCINet {
     CharBackend chr_be;
 } VhostPCINet;
 
+void vpnet_set_link_up(VhostPCINet *vpnet, bool up);
+
 #endif
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
index 792261e..ab91989 100644
--- a/include/standard-headers/linux/vhost_pci_net.h
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -35,6 +35,8 @@
 
 #define MAX_REMOTE_REGION 8
 
+/* Set by the device to indicate that the device (e.g. metadata) is ready */
+#define VPNET_S_LINK_UP 1
 struct vpnet_config {
 	uint16_t status;
 };
-- 
2.7.4
