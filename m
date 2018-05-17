Received: from eggs.gnu.org ([2001:4830:134:3::10]:42679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fJAg6-0003pb-42
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fJAg5-0001y7-7X
	for qemu-devel@nongnu.org; Thu, 17 May 2018 00:38:10 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Thu, 17 May 2018 10:25:22 +0800
Message-ID: <1526523922-67479-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/2] iothread: fix epollfd leak in the
 process of delIOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, peterx@redhat.com, stefanha@redhat.com, eblake@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com, wu.wubin@huawei.com, wangjie88@huawei.com

When we call addIOThread, the epollfd created in aio_context_setup,
but not close it in the process of delIOThread, so the epollfd will leak.

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 include/block/aio.h | 8 ++++++++
 util/aio-posix.c    | 9 +++++++++
 util/aio-win32.c    | 4 ++++
 util/async.c        | 1 +
 4 files changed, 22 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index a1d6b9e..ae6f354 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -555,6 +555,14 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
 void aio_context_setup(AioContext *ctx);
 
 /**
+ * aio_context_destroy:
+ * @ctx: the aio context
+ *
+ * Destroy the aio context.
+ */
+void aio_context_destroy(AioContext *ctx);
+
+/**
  * aio_context_set_poll_params:
  * @ctx: the aio context
  * @max_ns: how long to busy poll for, in nanoseconds
diff --git a/util/aio-posix.c b/util/aio-posix.c
index d8f0cb4..0ade2c7 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -713,6 +713,15 @@ void aio_context_setup(AioContext *ctx)
 #endif
 }
 
+void aio_context_destroy(AioContext *ctx)
+{
+#ifdef CONFIG_EPOLL_CREATE1
+    if (ctx->epollfd >= 0) {
+        close(ctx->epollfd);
+    }
+#endif
+}
+
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/aio-win32.c b/util/aio-win32.c
index a67b00c..e676a8d 100644
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
index 4dd9d95..03f6278 100644
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
1.8.3.1
