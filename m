Received: from eggs.gnu.org ([2001:4830:134:3::10]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzm-0003jb-Jg
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzl-0005rp-T6
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:58 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzl-0005r3-M5
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:57 -0400
Received: by mail-wr0-x242.google.com with SMTP id i14-v6so5965740wre.2
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:01:57 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:18 +0300
Message-Id: <20180430200223.4119-3-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] hw/rdma: Fix possible usage of a NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

Coverity CID 1390586; The cq handle is provided by the guest
and cannot be trusted to be previuosly allocated.
Fix it by exiting the completion flow.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_qp_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 750ade6c31..99bb51111e 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -216,6 +216,7 @@ void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
     cq = rdma_rm_get_cq(dev_res, cq_handle);
     if (!cq) {
         pr_dbg("Invalid CQ# %d\n", cq_handle);
+        return;
     }
 
     rdma_backend_poll_cq(dev_res, &cq->backend_cq);
-- 
2.14.3
