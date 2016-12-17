Received: from eggs.gnu.org ([2001:4830:134:3::10]:53503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUv-0008ON-2N
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUt-0008MG-KF
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUt-0007ss-CH
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:47 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:38 +0800
Message-Id: <1481971427-11094-29-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 28/37] vhost-pci-net: pass the mem and vring
 info to the driver
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

When DRIVER_OK, the device sends the mem and vring info to the driver
via the controlq.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c                         | 68 ++++++++++++++++++++++++++
 include/standard-headers/linux/vhost_pci_net.h | 17 +++++++
 2 files changed, 85 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 38f69d1..d8b13c8 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/iov.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/vhost-pci-net.h"
 
@@ -55,8 +56,75 @@ static void vpnet_handle_crq(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
 
+static size_t vpnet_send_crq_msg(VhostPCINet *vpnet,
+                                 struct vpnet_controlq_msg *msg)
+{
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    size_t msg_len = VPNET_CQ_MSG_HDR_SIZE + msg->size;
+
+    vq = vpnet->crq;
+    if (!virtio_queue_ready(vq)) {
+        return 0;
+    }
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return 0;
+    }
+
+    /* TODO: detect a buffer that's too short, set NEEDS_RESET */
+    iov_from_buf(elem->in_sg, elem->in_num, 0, msg, msg_len);
+
+    virtqueue_push(vq, elem, msg_len);
+    virtio_notify(VIRTIO_DEVICE(vpnet), vq);
+    g_free(elem);
+
+    return msg_len;
+}
+
+static void vpnet_send_peer_mem_msg(VhostPCINet *vpnet)
+{
+    struct vpnet_controlq_msg msg = {
+        .class = VHOST_PCI_CTRL_PEER_MEM_MSG,
+        .size = sizeof(struct peer_mem_msg),
+    };
+    memcpy(&msg.payload.pmem_msg, &vp_slave->pmem_msg, msg.size);
+    vpnet_send_crq_msg(vpnet, &msg);
+}
+
+static void vpnet_send_peer_vq_msg(VhostPCINet *vpnet)
+{
+    struct vpnet_controlq_msg *msg;
+    struct peer_vqs_msg *pvqs_msg;
+    struct peer_vq_msg *pvq_msg;
+    uint16_t pvq_num, msg_size, payload_size;
+
+    pvq_num = vpnet->peer_vq_num;
+    payload_size = sizeof(struct peer_vqs_msg)
+                   + sizeof(struct peer_vq_msg) * pvq_num;
+    msg_size = VPNET_CQ_MSG_HDR_SIZE + payload_size;
+    msg = g_malloc(msg_size);
+    msg->class = VHOST_PCI_CTRL_PEER_VQ_MSG,
+    msg->size = msg_size;
+
+    pvqs_msg = &msg->payload.pvqs_msg;
+    pvqs_msg->nvqs = pvq_num;
+    pvq_msg = pvqs_msg->pvq_msg;
+    memcpy(pvq_msg, vpnet->pvq_msg, payload_size);
+
+    vpnet_send_crq_msg(vpnet, msg);
+    g_free(msg);
+}
+
 static void vpnet_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
+    VhostPCINet *vpnet = VHOST_PCI_NET(vdev);
+
+    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+        vpnet_send_peer_mem_msg(vpnet);
+        vpnet_send_peer_vq_msg(vpnet);
+    }
 }
 
 static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features, Error **errp)
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
index e525569..770171e 100644
--- a/include/standard-headers/linux/vhost_pci_net.h
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -65,4 +65,21 @@ struct peer_vqs_msg {
 	struct peer_vq_msg pvq_msg[];
 };
 
+#define VHOST_PCI_CTRL_PEER_MEM_MSG    0
+#define VHOST_PCI_CTRL_PEER_VQ_MSG     1
+struct vpnet_controlq_msg {
+	uint8_t class;
+	uint8_t cmd;
+	uint16_t size;
+        union {
+		struct peer_mem_msg pmem_msg;
+		struct peer_vqs_msg pvqs_msg;
+	} payload;
+} __attribute__((packed));
+
+static struct vpnet_controlq_msg vpnet_msg __attribute__ ((unused));
+#define VPNET_CQ_MSG_HDR_SIZE (sizeof(vpnet_msg.class) \
+			      + sizeof(vpnet_msg.cmd)  \
+			      + sizeof(vpnet_msg.size))
+
 #endif
-- 
2.7.4
