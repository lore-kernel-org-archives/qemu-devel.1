Received: from eggs.gnu.org ([208.118.235.92]:44394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2gK-0008DP-OF
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2gG-0003b6-Ji
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:05:04 -0500
Received: from m12-18.163.com ([220.181.12.18]:59531)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2gF-0003Xl-6h
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:05:00 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  3 Jan 2019 05:03:38 -0800
Message-Id: <20190103130338.49081-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: pvrdma: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Li Qiang <liq3ea@163.com>

Spotted by Coverity: CID 1398595

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 300471a4c9..584be2043e 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -168,6 +168,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
         if (!sgid) {
             pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
+            g_free(comp_ctx);
             return -EIO;
         }
         pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
@@ -179,6 +180,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         if (sgid_idx <= 0) {
             pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
                    wqe->hdr.wr.ud.av.gid_index);
+            g_free(comp_ctx);
             return -EIO;
         }
 
-- 
2.17.1
