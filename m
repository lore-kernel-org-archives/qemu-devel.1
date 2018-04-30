Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzm-0003jZ-8H
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzk-0005qU-BK
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:58 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzk-0005q5-4l
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id v5-v6so9131386wrf.9
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:01:55 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:17 +0300
Message-Id: <20180430200223.4119-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] hw/rdma: Fix possible munmap call on a
 NULL pointer
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

Coverity CID 1390620: we call munmap() on a NULL pointer.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
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
