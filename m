Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUa-0007hQ-Bf
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUZ-0008Bt-MM
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUZ-0007ss-EW
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:27 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:27 +0800
Message-Id: <1481971427-11094-18-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 17/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VRING_BASE
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

Update last_avail_idx to the head node in the list.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 10 ++++++++++
 include/hw/virtio/vhost-pci-slave.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 0deab2d..e33c59e 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -209,6 +209,13 @@ static void vp_slave_set_vring_num(VhostUserMsg *msg)
     pvq_node->vring_num = msg->payload.u64;
 }
 
+static void vp_slave_set_vring_base(VhostUserMsg *msg)
+{
+    PeerVqNode *pvq_node = QLIST_FIRST(&vp_slave->pvq_list);
+
+    pvq_node->last_avail_idx = msg->payload.u64;
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -275,6 +282,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
         vp_slave_alloc_pvq_node();
         vp_slave_set_vring_num(&msg);
         break;
+    case VHOST_USER_SET_VRING_BASE:
+        vp_slave_set_vring_base(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index fe4824c..cfe4107 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -6,6 +6,7 @@
 #include "standard-headers/linux/vhost_pci_net.h"
 
 typedef struct PeerVqNode {
+    uint16_t last_avail_idx;
     uint32_t vring_num;
     QLIST_ENTRY(PeerVqNode) node;
 } PeerVqNode;
-- 
2.7.4
