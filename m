Received: from eggs.gnu.org ([2001:4830:134:3::10]:34896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjm-00088p-CX
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002Cr-ML
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:04 +0300
Message-Id: <20181123165511.416480-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 04/11] qcow2: split out data processing threads
 state from BDRVQcow2State
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

The state will grow in further commits, so it's good to give it its own
structure.

Make naming generic, as threads will be used for encryption too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  8 ++++++--
 block/qcow2-threads.c | 11 ++++++-----
 block/qcow2.c         |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index be84d7c96a..abe51a385c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -257,6 +257,11 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+typedef struct Qcow2ThreadsState {
+    CoQueue task_queue;
+    int count;
+} Qcow2ThreadsState;
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -336,8 +341,7 @@ typedef struct BDRVQcow2State {
     char *image_backing_file;
     char *image_backing_format;
 
-    CoQueue compress_wait_queue;
-    int nb_compress_threads;
+    Qcow2ThreadsState threads;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 8c10191f2f..028cf3175e 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -145,6 +145,7 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
     BDRVQcow2State *s = bs->opaque;
+    Qcow2ThreadsState *thr = &s->threads;
     ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
@@ -154,15 +155,15 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
-    while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
+    while (thr->count >= MAX_COMPRESS_THREADS) {
+        qemu_co_queue_wait(&thr->task_queue, NULL);
     }
 
-    s->nb_compress_threads++;
+    thr->count++;
     thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-    s->nb_compress_threads--;
+    thr->count--;
 
-    qemu_co_queue_next(&s->compress_wait_queue);
+    qemu_co_queue_next(&thr->task_queue);
 
     return arg.ret;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index 3fcb80d747..295ae926ee 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1600,7 +1600,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    qemu_co_queue_init(&s->compress_wait_queue);
+    qemu_co_queue_init(&s->threads.task_queue);
 
     return ret;
 
-- 
2.18.0
