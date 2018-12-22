Received: from eggs.gnu.org ([2001:4830:134:3::10]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvt-0006BM-9R
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvr-0006Ne-IJ
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvr-0006MS-Bn
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so7494483wrt.13
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:55 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:15 +0200
Message-Id: <20181222095036.29743-11-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 10/31] hw/pvrdma: Set the correct opcode
 for send completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

opcode for WC should be set by the device and not taken from work
element.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 7b0f440fda..3388be1926 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -154,7 +154,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx->cq_handle = qp->send_cq_handle;
         comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
         comp_ctx->cqe.qp = qp_handle;
-        comp_ctx->cqe.opcode = wqe->hdr.opcode;
+        comp_ctx->cqe.opcode = IBV_WC_SEND;
 
         rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
-- 
2.17.1
