Received: from eggs.gnu.org ([2001:4830:134:3::10]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gFYxb-00058H-92
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gFYxR-0004kZ-1O
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:17:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gFYxQ-0004il-8o
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:17:24 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 25 Oct 2018 09:17:00 +0300
Message-Id: <20181025061700.17050-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH] hw/pvrdma: Check the correct return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

Return value of 0 means ok, we want to free the memory only in case of
error.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 4faeb21631..57d6f41ae6 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -232,7 +232,7 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
                                      cmd->start, cmd->length, host_virt,
                                      cmd->access_flags, &resp->mr_handle,
                                      &resp->lkey, &resp->rkey);
-    if (host_virt && !resp->hdr.err) {
+    if (resp->hdr.err && host_virt) {
         munmap(host_virt, cmd->length);
     }
 
-- 
2.17.2
