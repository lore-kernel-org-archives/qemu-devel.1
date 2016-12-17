Received: from eggs.gnu.org ([2001:4830:134:3::10]:53395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUm-00086W-4t
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUi-0008GS-UA
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUi-0007ss-Iq
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:36 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:32 +0800
Message-Id: <1481971427-11094-23-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 22/37] vhost-pci-slave/msg:
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
index e176d59..3e00e35 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -238,6 +238,18 @@ static void vp_slave_set_vring_call(int fd)
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
@@ -332,6 +344,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
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
