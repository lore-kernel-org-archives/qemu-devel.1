Received: from eggs.gnu.org ([209.51.188.92]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghKGu-0007yp-H7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ghKGt-000105-K7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:16:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1ghKGt-0000zY-BK
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:16:15 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed,  9 Jan 2019 22:15:59 +0200
Message-Id: <20190109201559.3906-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/pvrdma: Post CQE when receive invalid gid
 index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

This error should propagate back to guest.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.h      | 1 +
 hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index a9ba40ae48..5114c90e67 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -32,6 +32,7 @@
 #define VENDOR_ERR_INVLKEY          0x207
 #define VENDOR_ERR_MR_SMALL         0x208
 #define VENDOR_ERR_INV_MAD_BUFF     0x209
+#define VENDOR_ERR_INV_GID_IDX      0x210
 
 /* Add definition for QP0 and QP1 as there is no userspace enums for them */
 enum ibv_special_qp_type {
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 465bee8641..0565eba981 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
         if (!sgid) {
             pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
-            return -EIO;
+            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
+            continue;
         }
         pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
                sgid->global.interface_id);
@@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         if (sgid_idx <= 0) {
             pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
                    wqe->hdr.wr.ud.av.gid_index);
-            return -EIO;
+            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
+            continue;
         }
 
         if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
-- 
2.17.2
