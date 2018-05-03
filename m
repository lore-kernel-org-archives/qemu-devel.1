Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqa-00026b-Co
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqZ-0008Ik-GR
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqZ-0008IR-8r
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id t11so472516wmt.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:51 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:21 +0300
Message-Id: <20180503182125.20310-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 4/8] hw/rdma: Fix possible out of bounds access
 to GID table
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

From: Yuval Shaia <yuval.shaia@oracle.com>

Array size is MAX_PORT_GIDS, let's make sure the given index is in
range.

While there limit device table size to 1.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180430200223.4119-5-marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm_defs.h   | 2 +-
 hw/rdma/vmw/pvrdma_cmd.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 45503f14e0..4d22a20e4c 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -20,9 +20,9 @@
 
 #define MAX_PORTS             1
 #define MAX_PORT_GIDS         1
+#define MAX_GIDS              MAX_PORT_GIDS
 #define MAX_PORT_PKEYS        1
 #define MAX_PKEYS             MAX_PORT_PKEYS
-#define MAX_GIDS              2048
 #define MAX_UCS               512
 #define MAX_MR_SIZE           (1UL << 27)
 #define MAX_QP                1024
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index f9dd78cb27..14255d609f 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -576,7 +576,7 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     pr_dbg("index=%d\n", cmd->index);
 
-    if (cmd->index > MAX_PORT_GIDS) {
+    if (cmd->index >= MAX_PORT_GIDS) {
         return -EINVAL;
     }
 
@@ -603,7 +603,11 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
 
-    pr_dbg("clear index %d\n", cmd->index);
+    pr_dbg("index=%d\n", cmd->index);
+
+    if (cmd->index >= MAX_PORT_GIDS) {
+        return -EINVAL;
+    }
 
     memset(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, 0,
            sizeof(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw));
-- 
2.14.3
