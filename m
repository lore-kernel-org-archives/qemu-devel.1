Received: from eggs.gnu.org ([2001:4830:134:3::10]:34834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjj-00083M-Mz
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002CD-ID
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:05 +0300
Message-Id: <20181123165511.416480-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 05/11] qcow2-threads: split out generic path
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
 block/qcow2-threads.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 028cf3175e..a09f07e2f9 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,7 +31,33 @@
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
+    Qcow2ThreadsState *thr = &s->threads;
+    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+
+    while (thr->count >= QCOW2_MAX_THREADS) {
+        qemu_co_queue_wait(&thr->task_queue, NULL);
+    }
+
+    thr->count++;
+    ret = thread_pool_submit_co(pool, func, arg);
+    thr->count--;
+
+    qemu_co_queue_next(&thr->task_queue);
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
@@ -144,9 +170,6 @@ static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
-    BDRVQcow2State *s = bs->opaque;
-    Qcow2ThreadsState *thr = &s->threads;
-    ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
         .dest_size = dest_size,
@@ -155,15 +178,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
-    while (thr->count >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&thr->task_queue, NULL);
-    }
-
-    thr->count++;
-    thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-    thr->count--;
-
-    qemu_co_queue_next(&thr->task_queue);
+    qcow2_co_process(bs, qcow2_compress_pool_func, &arg);
 
     return arg.ret;
 }
-- 
2.18.0
