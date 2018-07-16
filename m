Received: from eggs.gnu.org ([2001:4830:134:3::10]:55273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey8A-0001NL-9W
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey87-00079u-6z
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey86-00079U-SS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:11 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:35 +0300
Message-Id: <20180716074038.3364-11-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 10/13] hw/rdma: Cosmetic change - move to
 generic function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

To ease maintenance of struct comp_thread move all related code to
dedicated function.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 52981d652d..d29acc505b 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -146,10 +146,10 @@ static void *comp_handler_thread(void *arg)
     return NULL;
 }
 
-static void stop_comp_thread(RdmaBackendDev *backend_dev)
+static void stop_backend_thread(RdmaBackendThread *thread)
 {
-    backend_dev->comp_thread.run = false;
-    while (backend_dev->comp_thread.is_running) {
+    thread->run = false;
+    while (thread->is_running) {
         pr_dbg("Waiting for thread to complete\n");
         sleep(THR_POLL_TO / SCALE_US / 2);
     }
@@ -159,7 +159,7 @@ static void start_comp_thread(RdmaBackendDev *backend_dev)
 {
     char thread_name[THR_NAME_LEN] = {0};
 
-    stop_comp_thread(backend_dev);
+    stop_backend_thread(&backend_dev->comp_thread);
 
     snprintf(thread_name, sizeof(thread_name), "rdma_comp_%s",
              ibv_get_device_name(backend_dev->ib_dev));
@@ -876,7 +876,7 @@ void rdma_backend_start(RdmaBackendDev *backend_dev)
 void rdma_backend_stop(RdmaBackendDev *backend_dev)
 {
     pr_dbg("Stopping rdma_backend\n");
-    stop_comp_thread(backend_dev);
+    stop_backend_thread(&backend_dev->comp_thread);
 }
 
 void rdma_backend_fini(RdmaBackendDev *backend_dev)
-- 
2.17.1
