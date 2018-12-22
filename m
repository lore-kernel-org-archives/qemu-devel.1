Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zg-N8
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwM-0006kq-Qb
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwM-0006do-KE
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id 96so7530874wrb.2
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:17 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:31 +0200
Message-Id: <20181222095036.29743-27-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 26/31] rdma: check num_sge does not exceed
 MAX_SGE
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

From: Prasad J Pandit <pjp@fedoraproject.org>

rdma back-end has scatter/gather array ibv_sge[MAX_SGE=4] set
to have 4 elements. A guest could send a 'PvrdmaSqWqe' ring element
with 'num_sge' set to > MAX_SGE, which may lead to OOB access issue.
Add check to avoid it.

Reported-by: Saar Amar <saaramar5@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index ae1e4dcb29..bd4710d16f 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -476,9 +476,9 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     }
 
     pr_dbg("num_sge=%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=0\n");
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=%d\n", num_sge);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
         return;
     }
 
@@ -603,9 +603,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
     }
 
     pr_dbg("num_sge=%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=0\n");
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=%d\n", num_sge);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
         return;
     }
 
-- 
2.17.1
