Received: from eggs.gnu.org ([2001:4830:134:3::10]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqX-00023e-3B
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqU-0008GU-JF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:49 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqU-0008GC-CT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:46 -0400
Received: by mail-wm0-x241.google.com with SMTP id o78-v6so511859wmg.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:46 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:18 +0300
Message-Id: <20180503182125.20310-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 1/8] hw/rdma: Fix possible munmap call on a NULL
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

Coverity CID 1390620: we call munmap() on a NULL pointer.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20180430200223.4119-2-marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 99019d8741..f9dd78cb27 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -232,7 +232,7 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
                                      cmd->start, cmd->length, host_virt,
                                      cmd->access_flags, &resp->mr_handle,
                                      &resp->lkey, &resp->rkey);
-    if (!resp->hdr.err) {
+    if (host_virt && !resp->hdr.err) {
         munmap(host_virt, cmd->length);
     }
 
-- 
2.14.3
