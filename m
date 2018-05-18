Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbXD-0006r7-K1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbXC-00042Q-CA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fJbXC-000428-6g
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 May 2018 17:18:28 +0800
Message-Id: <20180518091828.12814-3-famz@redhat.com>
In-Reply-To: <20180518091828.12814-1-famz@redhat.com>
References: <20180518091828.12814-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] iothread: fix epollfd leak in the process
 of delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Jie Wang <wangjie88@huawei.com>

When we call addIOThread, the epollfd created in aio_context_setup,
but not close it in the process of delIOThread, so the epollfd will leak.

Reorder the code in aio_epoll_disable and reuse it.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
Message-Id: <1526517763-11108-1-git-send-email-wangjie88@huawei.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
[Mention change to aio_epoll_disable in commit message. - Fam]
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/aio.h |  8 ++++++++
 util/aio-posix.c    | 13 ++++++++++---
 util/aio-win32.c    |  4 ++++
 util/async.c        |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index a1d6b9e249..ae6f354e6c 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -554,6 +554,14 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
  */
 void aio_context_setup(AioContext *ctx);
 
+/**
+ * aio_context_destroy:
+ * @ctx: the aio context
+ *
+ * Destroy the aio context.
+ */
+void aio_context_destroy(AioContext *ctx);
+
 /**
  * aio_context_set_poll_params:
  * @ctx: the aio context
diff --git a/util/aio-posix.c b/util/aio-posix.c
index d8f0cb4af8..118bf5784b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -45,11 +45,11 @@ struct AioHandler
 
 static void aio_epoll_disable(AioContext *ctx)
 {
-    ctx->epoll_available = false;
-    if (!ctx->epoll_enabled) {
+    ctx->epoll_enabled = false;
+    if (!ctx->epoll_available) {
         return;
     }
-    ctx->epoll_enabled = false;
+    ctx->epoll_available = false;
     close(ctx->epollfd);
 }
 
@@ -713,6 +713,13 @@ void aio_context_setup(AioContext *ctx)
 #endif
 }
 
+void aio_context_destroy(AioContext *ctx)
+{
+#ifdef CONFIG_EPOLL_CREATE1
+    aio_epoll_disable(ctx);
+#endif
+}
+
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/aio-win32.c b/util/aio-win32.c
index a67b00c6ad..e676a8d9b2 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -407,6 +407,10 @@ void aio_context_setup(AioContext *ctx)
 {
 }
 
+void aio_context_destroy(AioContext *ctx)
+{
+}
+
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/async.c b/util/async.c
index 4dd9d95a9e..03f62787f2 100644
--- a/util/async.c
+++ b/util/async.c
@@ -298,6 +298,7 @@ aio_ctx_finalize(GSource     *source)
     qemu_rec_mutex_destroy(&ctx->lock);
     qemu_lockcnt_destroy(&ctx->list_lock);
     timerlistgroup_deinit(&ctx->tlg);
+    aio_context_destroy(ctx);
 }
 
 static GSourceFuncs aio_source_funcs = {
-- 
2.14.3
