Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUe-0007lR-3l
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUd-0008D3-7G
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUc-0007ss-VM
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:31 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:29 +0800
Message-Id: <1481971427-11094-20-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 19/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VRING_ADDR
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

Update the virtqueue addresses to the head node of the list.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 10 ++++++++++
 include/hw/virtio/vhost-pci-slave.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index e33c59e..a55861a 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -216,6 +216,13 @@ static void vp_slave_set_vring_base(VhostUserMsg *msg)
     pvq_node->last_avail_idx = msg->payload.u64;
 }
 
+static void vp_slave_set_vring_addr(VhostUserMsg *msg)
+{
+    PeerVqNode *pvq_node = QLIST_FIRST(&vp_slave->pvq_list);
+    memcpy(&pvq_node->addr, &msg->payload.addr,
+           sizeof(struct vhost_vring_addr));
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -285,6 +292,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_BASE:
         vp_slave_set_vring_base(&msg);
         break;
+    case VHOST_USER_SET_VRING_ADDR:
+        vp_slave_set_vring_addr(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index cfe4107..439198d 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_VHOST_PCI_SLAVE_H
 #define QEMU_VHOST_PCI_SLAVE_H
 
+#include <linux/vhost.h>
+
 #include "sysemu/char.h"
 #include "exec/memory.h"
 #include "standard-headers/linux/vhost_pci_net.h"
@@ -8,6 +10,7 @@
 typedef struct PeerVqNode {
     uint16_t last_avail_idx;
     uint32_t vring_num;
+    struct vhost_vring_addr addr;
     QLIST_ENTRY(PeerVqNode) node;
 } PeerVqNode;
 
-- 
2.7.4
