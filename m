Received: from eggs.gnu.org ([2001:4830:134:3::10]:43889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYZ-0008RN-QM
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYZ-0000cp-83
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:15 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYZ-0000cF-1T
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:15 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n11-v6so13716668wmc.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:14 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:49 +0300
Message-Id: <20180819202300.10590-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 04/15] hw/pvrdma: Clean CQE before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

Next CQE is fetched from CQ ring, clean it before usage as it still
carries old CQE values.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-5-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
