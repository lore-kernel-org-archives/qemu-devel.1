Received: from eggs.gnu.org ([2001:4830:134:3::10]:53898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0W-0003MG-1y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0U-0004kp-RO
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0U-0004Vl-JX
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:06 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:01 +0800
Message-Id: <1482127152-84732-27-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 26/37] vhost-pci-slave/msg:
 VHOST_USER_GET_VRING_BASE
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
 hw/virtio/vhost-pci-slave.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 2cb84ed..ff9a251 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -224,6 +224,16 @@ static void vp_slave_set_vring_base(VhostUserMsg *msg)
     pvq_node->last_avail_idx = msg->payload.u64;
 }
 
+static int vp_slave_get_vring_base(CharBackend *chr_be, VhostUserMsg *msg)
+{
+    /* send back vring base to qemu */
+    msg->flags |= VHOST_USER_REPLY_MASK;
+    msg->size = sizeof(m.payload.state);
+    msg->payload.state.num = 0;
+
+    return vp_slave_write(chr_be, msg);
+}
+
 static void vp_slave_set_vring_addr(VhostUserMsg *msg)
 {
     PeerVqNode *pvq_node = QLIST_FIRST(&vp_slave->pvq_list);
@@ -330,6 +340,12 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_BASE:
         vp_slave_set_vring_base(&msg);
         break;
+    case VHOST_USER_GET_VRING_BASE:
+        ret = vp_slave_get_vring_base(chr_be, &msg);
+        if (ret < 0) {
+            goto err_handling;
+        }
+        break;
     case VHOST_USER_SET_VRING_ADDR:
         vp_slave_set_vring_addr(&msg);
         break;
-- 
2.7.4
