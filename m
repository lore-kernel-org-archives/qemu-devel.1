Received: from eggs.gnu.org ([209.51.188.92]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpM-0001Gs-00
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpK-0000t9-IV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 17:44:17 +0300
Message-Id: <20190211144421.106232-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190211144421.106232-1-vsementsov@virtuozzo.com>
References: <20190211144421.106232-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 5/9] qcow2-threads: split out generic path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

Move generic part out of qcow2_co_do_compress, to reuse it for
encryption and rename things that would be shared with encryption path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  4 ++--
 block/qcow2-threads.c | 47 ++++++++++++++++++++++++++++---------------
 block/qcow2.c         |  2 +-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ca9f8ce093..c8a87bfe6b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -339,8 +339,8 @@ typedef struct BDRVQcow2State {
     char *image_backing_file;
     char *image_backing_format;
 
-    CoQueue compress_wait_queue;
-    int nb_compress_threads;
+    CoQueue thread_task_queue;
+    int nb_threads;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 156e0667be..e3066075da 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,7 +31,36 @@
 #include "qcow2.h"
 #include "block/thread-pool.h"
 
-#define MAX_COMPRESS_THREADS 4
+#define QCOW2_MAX_THREADS 4
+
+static int coroutine_fn
+qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+
+    qemu_co_mutex_lock(&s->lock);
+    while (s->nb_threads >= QCOW2_MAX_THREADS) {
+        qemu_co_queue_wait(&s->thread_task_queue, &s->lock);
+    }
+    s->nb_threads++;
+    qemu_co_mutex_unlock(&s->lock);
+
+    ret = thread_pool_submit_co(pool, func, arg);
+
+    qemu_co_mutex_lock(&s->lock);
+    s->nb_threads--;
+    qemu_co_queue_next(&s->thread_task_queue);
+    qemu_co_mutex_unlock(&s->lock);
+
+    return ret;
+}
+
+
+/*
+ * Compression
+ */
 
 typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
                                      const void *src, size_t src_size);
@@ -148,8 +177,6 @@ static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
-    BDRVQcow2State *s = bs->opaque;
-    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
         .dest_size = dest_size,
@@ -158,19 +185,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
-    qemu_co_mutex_lock(&s->lock);
-    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, &s->lock);
-    }
-    s->nb_compress_threads++;
-    qemu_co_mutex_unlock(&s->lock);
-
-    thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-
-    qemu_co_mutex_lock(&s->lock);
-    s->nb_compress_threads--;
-    qemu_co_queue_next(&s->compress_wait_queue);
-    qemu_co_mutex_unlock(&s->lock);
+    qcow2_co_process(bs, qcow2_compress_pool_func, &arg);
 
     return arg.ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index d08f2e921a..2dfaaab046 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1599,7 +1599,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    qemu_co_queue_init(&s->compress_wait_queue);
+    qemu_co_queue_init(&s->thread_task_queue);
 
     return ret;
 
-- 
2.18.0
