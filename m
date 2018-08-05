Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4e-00073i-L8
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4a-0006Ph-IR
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmL4a-0006Om-9z
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:00 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 Aug 2018 18:35:09 +0300
Message-Id: <20180805153518.2983-5-yuval.shaia@oracle.com>
In-Reply-To: <20180805153518.2983-1-yuval.shaia@oracle.com>
References: <20180805153518.2983-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH v2 04/13] hw/pvrdma: Clean CQE before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Next CQE is fetched from CQ ring, clean it before usage as it still
carries old CQE values.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 99bb51111e..a8664f40c8 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -69,6 +69,7 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
         return -EINVAL;
     }
 
+    memset(cqe1, 0, sizeof(*cqe1));
     cqe1->wr_id = cqe->wr_id;
     cqe1->qp = cqe->qp;
     cqe1->opcode = cqe->opcode;
-- 
2.17.1
