Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0P-0003Ek-01
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0O-0004jC-4o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0N-0004Vl-Sl
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:00 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:57 +0800
Message-Id: <1482127152-84732-23-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 22/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VRING_ENABLE
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

Enable/Disable the corresponding virtqueue pairs in the list.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 15 +++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 5bb1285..4b4d3c8 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -245,6 +245,18 @@ static void vp_slave_set_vring_call(int fd)
         pvq_node->callfd = fd;
 }
 
+static void vp_slave_set_vring_enable(VhostUserMsg *msg)
+{
+    struct vhost_vring_state *state = &msg->payload.state;
+    PeerVqNode *pvq_node;
+    QLIST_FOREACH(pvq_node, &vp_slave->pvq_list, node) {
+        if (pvq_node->vring_num == state->index) {
+            pvq_node->enabled = (int)state->num;
+            break;
+        }
+    }
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -343,6 +355,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
          */
         qemu_set_nonblock(fds[0]);
         break;
+    case VHOST_USER_SET_VRING_ENABLE:
+        vp_slave_set_vring_enable(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index f6206a1..3e0f4c7 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -12,6 +12,7 @@ typedef struct PeerVqNode {
     uint32_t vring_num;
     int kickfd;
     int callfd;
+    int enabled;
     struct vhost_vring_addr addr;
     QLIST_ENTRY(PeerVqNode) node;
 } PeerVqNode;
-- 
2.7.4
