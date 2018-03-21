Received: from eggs.gnu.org ([2001:4830:134:3::10]:32854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyd2i-0001lc-GX
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eyd2f-00045j-EP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:40:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eyd2f-00045F-9j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:40:33 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 21 Mar 2018 14:40:26 +0200
Message-Id: <20180321124026.70292-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/rdma: fix clang compilation errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com

Fix some enum castings and extra parentheses.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/vmw/pvrdma_cmd.c  | 5 +++--
 hw/rdma/vmw/pvrdma_main.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 293dfed29f..25f747a190 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -73,7 +73,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
     tbl_idx = 1;
     addr_idx = 1;
     while (addr_idx < nchunks) {
-        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
+        if (tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t))) {
             tbl_idx = 0;
             dir_idx++;
             pr_dbg("Mapping to table %d\n", dir_idx);
@@ -507,7 +507,8 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rsp->hdr.err = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
                                  cmd->qp_handle, cmd->attr_mask,
                                  (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
-                                 cmd->attrs.dest_qp_num, cmd->attrs.qp_state,
+                                 (enum ibv_qp_state)cmd->attrs.dest_qp_num,
+                                 (enum ibv_qp_state)cmd->attrs.qp_state,
                                  cmd->attrs.qkey, cmd->attrs.rq_psn,
                                  cmd->attrs.sq_psn);
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 99787812ba..0e3469287f 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -91,7 +91,7 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
         goto out_free_tbl;
     }
     /* RX ring is the second */
-    (struct pvrdma_ring *)(*ring_state)++;
+    (*ring_state)++;
     rc = pvrdma_ring_init(ring, name, pci_dev,
                           (struct pvrdma_ring *)*ring_state,
                           (num_pages - 1) * TARGET_PAGE_SIZE /
@@ -292,7 +292,8 @@ static void init_ports(PVRDMADev *dev, Error **errp)
     memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
 
     for (i = 0; i < MAX_PORTS; i++) {
-        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
+        dev->rdma_dev_res.ports[i].state =
+            (enum ibv_port_state)PVRDMA_PORT_DOWN;
 
         dev->rdma_dev_res.ports[i].pkey_tbl =
             g_malloc0(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
-- 
2.13.5
