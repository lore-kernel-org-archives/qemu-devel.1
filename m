Received: from eggs.gnu.org ([2001:4830:134:3::10]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvl-00068o-46
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvh-0006Gq-D9
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvf-0006EK-EC
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so7504234wrp.3
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:42 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:06 +0200
Message-Id: <20181222095036.29743-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 01/31] hw/pvrdma: Check the correct return
 value
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

Return value of 0 means ok, we want to free the memory only in case of
error.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20181025061700.17050-1-yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.1
