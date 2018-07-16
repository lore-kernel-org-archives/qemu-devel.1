Received: from eggs.gnu.org ([2001:4830:134:3::10]:55176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey7y-0001EO-7v
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey7x-00071X-Ei
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey7x-000716-5R
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:01 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:29 +0300
Message-Id: <20180716074038.3364-5-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH 04/13] hw/pvrdma: Clean CQE before use
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
