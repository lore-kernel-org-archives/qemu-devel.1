Received: from eggs.gnu.org ([2001:4830:134:3::10]:44011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYr-0000Cx-4Q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYm-0000io-Rh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYh-0000gE-Hh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id g1-v6so12896253wru.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:22 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:55 +0300
Message-Id: <20180819202300.10590-11-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 10/15] hw/rdma: Cosmetic change - move to
 generic function
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

To ease maintenance of struct comp_thread move all related code to
dedicated function.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-11-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
