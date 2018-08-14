Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fpW7p-00014x-59
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fpW7m-0005oT-0F
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:00:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fpW7l-0005nO-OF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:00:25 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 14 Aug 2018 13:00:10 +0300
Message-Id: <20180814100010.2546-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/rdma: Abort send-op if fail to create addr
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Function create_ah might return NULL, let's exit with an error.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 35726bda2e..59d02eb567 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -402,6 +402,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     if (qp_type == IBV_QPT_UD) {
         wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
                                 backend_dev->backend_gid_idx, dgid);
+        if (!wr.wr.ud.ah) {
+            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx, 0);
+            goto out_dealloc_cqe_ctx;
+        }
         wr.wr.ud.remote_qpn = dqpn;
         wr.wr.ud.remote_qkey = dqkey;
     }
-- 
2.17.1
