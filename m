Received: from eggs.gnu.org ([2001:4830:134:3::10]:36062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0R-0008Rb-SY
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0N-0007jR-Su
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0N-0007im-Mq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:23 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:03 +0300
Message-Id: <20180323155306.83812-6-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH PULL 5/8] hw/rdma: fix clang compilation errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

Fix some enum castings and extra parentheses.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Message-Id: <20180321140316.96045-1-marcel@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_cmd.c  | 5 +++--
 hw/rdma/vmw/pvrdma_main.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 0646f87ff2..5bd4643f2d 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -73,7 +73,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
     tbl_idx = 1;
     addr_idx = 1;
     while (addr_idx < nchunks) {
-        if ((tbl_idx == (TARGET_PAGE_SIZE / sizeof(uint64_t)))) {
+        if (tbl_idx == TARGET_PAGE_SIZE / sizeof(uint64_t)) {
             tbl_idx = 0;
             dir_idx++;
             pr_dbg("Mapping to table %d\n", dir_idx);
@@ -507,7 +507,8 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rsp->hdr.err = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
                                  cmd->qp_handle, cmd->attr_mask,
                                  (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
-                                 cmd->attrs.dest_qp_num, cmd->attrs.qp_state,
+                                 cmd->attrs.dest_qp_num,
+                                 (enum ibv_qp_state)cmd->attrs.qp_state,
                                  cmd->attrs.qkey, cmd->attrs.rq_psn,
                                  cmd->attrs.sq_psn);
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 25ea02af62..44de6a4a29 100644
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
@@ -292,7 +292,7 @@ static void init_ports(PVRDMADev *dev, Error **errp)
     memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
 
     for (i = 0; i < MAX_PORTS; i++) {
-        dev->rdma_dev_res.ports[i].state = PVRDMA_PORT_DOWN;
+        dev->rdma_dev_res.ports[i].state = IBV_PORT_DOWN;
 
         dev->rdma_dev_res.ports[i].pkey_tbl =
             g_malloc0(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
-- 
2.13.5
