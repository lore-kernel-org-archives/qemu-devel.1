Received: from eggs.gnu.org ([2001:4830:134:3::10]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzo-0000Kz-Tl
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzn-0000jX-36
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUSzm-0000hu-PJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A661B81227
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:37 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:23 +0800
Message-Id: <20170710072027.7948-2-famz@redhat.com>
In-Reply-To: <20170710072027.7948-1-famz@redhat.com>
References: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/5] aio: Wrap poll parameters into
 AioContextPollParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The same set of parameters will also be wanted by the coming iothread
group object, make a structure to slightly reduce the code duplication.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/aio.h       | 18 ++++++++++++------
 include/sysemu/iothread.h |  5 +----
 iothread.c                | 24 +++++++++---------------
 util/aio-posix.c          | 10 +++++-----
 util/aio-win32.c          |  4 ++--
 5 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeae..fcf1faf 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -551,17 +551,23 @@ static inline bool aio_context_in_iothread(AioContext *ctx)
  */
 void aio_context_setup(AioContext *ctx);
 
+typedef struct {
+    /* how long to busy poll for, in nanoseconds. 0 means don't poll */
+    int64_t max_ns;
+    /* polling time growth factor */
+    int64_t grow;
+    /* polling time shrink factor */
+    int64_t shrink;
+} AioContextPollParams;
+
 /**
  * aio_context_set_poll_params:
  * @ctx: the aio context
- * @max_ns: how long to busy poll for, in nanoseconds
- * @grow: polling time growth factor
- * @shrink: polling time shrink factor
+ * @params: the new params to update to
  *
- * Poll mode can be disabled by setting poll_max_ns to 0.
+ * Poll mode can be disabled by setting params.max_ns to 0.
  */
-void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink,
+void aio_context_set_poll_params(AioContext *ctx, AioContextPollParams params,
                                  Error **errp);
 
 #endif
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index e6da1a4..eecfc19 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -29,10 +29,7 @@ typedef struct {
     bool stopping;
     int thread_id;
 
-    /* AioContext poll parameters */
-    int64_t poll_max_ns;
-    int64_t poll_grow;
-    int64_t poll_shrink;
+    AioContextPollParams poll_params;
 } IOThread;
 
 #define IOTHREAD(obj) \
diff --git a/iothread.c b/iothread.c
index beeb870..f5a01bb 100644
--- a/iothread.c
+++ b/iothread.c
@@ -81,7 +81,7 @@ static void iothread_instance_init(Object *obj)
 {
     IOThread *iothread = IOTHREAD(obj);
 
-    iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
+    iothread->poll_params.max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
 }
 
 static void iothread_instance_finalize(Object *obj)
@@ -111,10 +111,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
         return;
     }
 
-    aio_context_set_poll_params(iothread->ctx,
-                                iothread->poll_max_ns,
-                                iothread->poll_grow,
-                                iothread->poll_shrink,
+    aio_context_set_poll_params(iothread->ctx, iothread->poll_params,
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -151,13 +148,13 @@ typedef struct {
 } PollParamInfo;
 
 static PollParamInfo poll_max_ns_info = {
-    "poll-max-ns", offsetof(IOThread, poll_max_ns),
+    "poll-max-ns", offsetof(IOThread, poll_params.max_ns),
 };
 static PollParamInfo poll_grow_info = {
-    "poll-grow", offsetof(IOThread, poll_grow),
+    "poll-grow", offsetof(IOThread, poll_params.grow),
 };
 static PollParamInfo poll_shrink_info = {
-    "poll-shrink", offsetof(IOThread, poll_shrink),
+    "poll-shrink", offsetof(IOThread, poll_params.shrink),
 };
 
 static void iothread_get_poll_param(Object *obj, Visitor *v,
@@ -193,10 +190,7 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     *field = value;
 
     if (iothread->ctx) {
-        aio_context_set_poll_params(iothread->ctx,
-                                    iothread->poll_max_ns,
-                                    iothread->poll_grow,
-                                    iothread->poll_shrink,
+        aio_context_set_poll_params(iothread->ctx, iothread->poll_params,
                                     &local_err);
     }
 
@@ -268,9 +262,9 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
-    info->poll_max_ns = iothread->poll_max_ns;
-    info->poll_grow = iothread->poll_grow;
-    info->poll_shrink = iothread->poll_shrink;
+    info->poll_max_ns = iothread->poll_params.max_ns;
+    info->poll_grow = iothread->poll_params.grow;
+    info->poll_shrink = iothread->poll_params.shrink;
 
     elem = g_new0(IOThreadInfoList, 1);
     elem->value = info;
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2d51239..1db8f3c 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -713,16 +713,16 @@ void aio_context_setup(AioContext *ctx)
 #endif
 }
 
-void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **errp)
+void aio_context_set_poll_params(AioContext *ctx, AioContextPollParams params,
+                                 Error **errp)
 {
     /* No thread synchronization here, it doesn't matter if an incorrect value
      * is used once.
      */
-    ctx->poll_max_ns = max_ns;
+    ctx->poll_max_ns = params.max_ns;
     ctx->poll_ns = 0;
-    ctx->poll_grow = grow;
-    ctx->poll_shrink = shrink;
+    ctx->poll_grow = params.grow;
+    ctx->poll_shrink = params.shrink;
 
     aio_notify(ctx);
 }
diff --git a/util/aio-win32.c b/util/aio-win32.c
index bca496a..d8a1b20 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -400,8 +400,8 @@ void aio_context_setup(AioContext *ctx)
 {
 }
 
-void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
-                                 int64_t grow, int64_t shrink, Error **errp)
+void aio_context_set_poll_params(AioContext *ctx, AioContextPollParams params,
+                                 Error **errp)
 {
     error_setg(errp, "AioContext polling is not implemented on Windows");
 }
-- 
2.9.4
