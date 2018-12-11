Received: from eggs.gnu.org ([2001:4830:134:3::10]:42064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl85-0001uD-EH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl84-0004KL-Bo
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 19:43:13 +0300
Message-Id: <20181211164317.32893-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/8] qcow2-threads: split out generic path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Move generic part out of qcow2_co_do_compress, to reuse it for
encryption and rename things that would be shared with encryption path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  4 ++--
 block/qcow2-threads.c | 39 +++++++++++++++++++++++++++------------
 block/qcow2.c         |  2 +-
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index be84d7c96a..9c2f6749ba 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -336,8 +336,8 @@ typedef struct BDRVQcow2State {
     char *image_backing_file;
     char *image_backing_format;
 
-    CoQueue compress_wait_queue;
-    int nb_compress_threads;
+    CoQueue thread_task_queue;
+    int nb_threads;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 8c10191f2f..84b3ede4f1 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,7 +31,32 @@
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
+    while (s->nb_threads >= QCOW2_MAX_THREADS) {
+        qemu_co_queue_wait(&s->thread_task_queue, NULL);
+    }
+
+    s->nb_threads++;
+    ret = thread_pool_submit_co(pool, func, arg);
+    s->nb_threads--;
+
+    qemu_co_queue_next(&s->thread_task_queue);
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
@@ -144,8 +169,6 @@ static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
-    BDRVQcow2State *s = bs->opaque;
-    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
         .dest_size = dest_size,
@@ -154,15 +177,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
-    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
-    }
-
-    s->nb_compress_threads++;
-    thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-    s->nb_compress_threads--;
-
-    qemu_co_queue_next(&s->compress_wait_queue);
+    qcow2_co_process(bs, qcow2_compress_pool_func, &arg);
 
     return arg.ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index e61dc54fd0..c4b716d4f6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1600,7 +1600,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    qemu_co_queue_init(&s->compress_wait_queue);
+    qemu_co_queue_init(&s->thread_task_queue);
 
     return ret;
 
-- 
2.18.0
