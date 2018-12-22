Received: from eggs.gnu.org ([2001:4830:134:3::10]:41600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvt-0006BF-8z
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvr-0006NS-Gh
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvr-0006Lr-91
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:55 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so7392272wml.2
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:53 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:14 +0200
Message-Id: <20181222095036.29743-10-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 09/31] hw/pvrdma: Set the correct opcode
 for recv completion
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

The function pvrdma_post_cqe populates CQE entry with opcode from the
given completion element. For receive operation value was not set. Fix
it by setting it to IBV_WC_RECV.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 762700a205..7b0f440fda 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -196,8 +196,9 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx = g_malloc(sizeof(CompHandlerCtx));
         comp_ctx->dev = dev;
         comp_ctx->cq_handle = qp->recv_cq_handle;
-        comp_ctx->cqe.qp = qp_handle;
         comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+        comp_ctx->cqe.qp = qp_handle;
+        comp_ctx->cqe.opcode = IBV_WC_RECV;
 
         rdma_backend_post_recv(&dev->backend_dev, &dev->rdma_dev_res,
                                &qp->backend_qp, qp->qp_type,
-- 
2.17.1
