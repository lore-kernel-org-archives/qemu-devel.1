Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqX-00023h-3w
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqW-0008H3-2o
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:49 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqV-0008Go-S2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:48 -0400
Received: by mail-wm0-x241.google.com with SMTP id a67so440357wmf.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:47 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:19 +0300
Message-Id: <20180503182125.20310-3-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/8] hw/rdma: Fix possible usage of a NULL
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
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org, f4bug@amsat.org

Coverity CID 1390586; The cq handle is provided by the guest
and cannot be trusted to be previuosly allocated.
Fix it by exiting the completion flow.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20180430200223.4119-3-marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
