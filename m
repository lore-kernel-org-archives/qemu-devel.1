Received: from eggs.gnu.org ([2001:4830:134:3::10]:53735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0E-00036l-Sr
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0D-0004hE-Qz
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0D-0004Vl-Ic
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:49 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:51 +0800
Message-Id: <1482127152-84732-17-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 16/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VRING_NUM
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

The protocol doesn't have a message to tell the slave how many virtqueues
that the master device has. So, the slave side implementation uses a list to
manage the virtqueue info sent from the master. SET_VRING_NUM is the
first virtqueue info passed from the master, so the slave allocates a node
when receiving this message, and inserts the node to the head of the
list. Subsequent virtqueue info (e.g. base, addresses) will be updated
to the head node.

The list of virtqueue info will be packed together and delievered to the
driver via the controlq.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 9d42566..77a2f68 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -30,6 +30,7 @@ static void vp_slave_cleanup(void)
 {
     int ret;
     uint32_t i, nregions;
+    PeerVqNode *pvq_node;
 
     nregions = vp_slave->pmem_msg.nregions;
     for (i = 0; i < nregions; i++) {
@@ -39,6 +40,13 @@ static void vp_slave_cleanup(void)
         }
         memory_region_del_subregion(vp_slave->bar_mr, vp_slave->sub_mr + i);
     }
+
+    if (!QLIST_EMPTY(&vp_slave->pvq_list)) {
+        QLIST_FOREACH(pvq_node, &vp_slave->pvq_list, node)
+            g_free(pvq_node);
+    }
+    QLIST_INIT(&vp_slave->pvq_list);
+    vp_slave->pvq_num = 0;
 }
 
 static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
@@ -194,6 +202,20 @@ static int vp_slave_set_mem_table(VhostUserMsg *msg, int *fds, int fd_num)
     return 0;
 }
 
+static void vp_slave_alloc_pvq_node(void)
+{
+    PeerVqNode *pvq_node = g_malloc0(sizeof(PeerVqNode));
+    QLIST_INSERT_HEAD(&vp_slave->pvq_list, pvq_node, node);
+    vp_slave->pvq_num++;
+}
+
+static void vp_slave_set_vring_num(VhostUserMsg *msg)
+{
+    PeerVqNode *pvq_node = QLIST_FIRST(&vp_slave->pvq_list);
+
+    pvq_node->vring_num = msg->payload.u64;
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -260,6 +282,10 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
         fd_num = qemu_chr_fe_get_msgfds(chr_be, fds, sizeof(fds) / sizeof(int));
         vp_slave_set_mem_table(&msg, fds, fd_num);
         break;
+    case VHOST_USER_SET_VRING_NUM:
+        vp_slave_alloc_pvq_node();
+        vp_slave_set_vring_num(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
@@ -295,6 +321,8 @@ int vhost_pci_slave_init(QemuOpts *opts)
     vp_slave->feature_bits =  1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
     vp_slave->bar_mr = NULL;
     vp_slave->sub_mr = NULL;
+    QLIST_INIT(&vp_slave->pvq_list);
+    vp_slave->pvq_num = 0;
     qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&vp_slave->chr_be, vp_slave_can_read,
                              vp_slave_read, vp_slave_event,
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 03e23eb..fe4824c 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -5,6 +5,11 @@
 #include "exec/memory.h"
 #include "standard-headers/linux/vhost_pci_net.h"
 
+typedef struct PeerVqNode {
+    uint32_t vring_num;
+    QLIST_ENTRY(PeerVqNode) node;
+} PeerVqNode;
+
 typedef struct VhostPCISlave {
     CharBackend chr_be;
     uint16_t dev_type;
@@ -16,6 +21,8 @@ typedef struct VhostPCISlave {
     void *mr_map_base[MAX_GUEST_REGION];
     uint64_t mr_map_size[MAX_GUEST_REGION];
     struct peer_mem_msg pmem_msg;
+    uint16_t pvq_num;
+    QLIST_HEAD(, PeerVqNode) pvq_list;
 } VhostPCISlave;
 
 extern VhostPCISlave *vp_slave;
-- 
2.7.4
