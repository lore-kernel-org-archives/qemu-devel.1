Received: from eggs.gnu.org ([2001:4830:134:3::10]:34829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjj-00083K-Kp
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002Bc-Fv
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:06 +0300
Message-Id: <20181123165511.416480-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/11] qcow2-threads: add per-thread data
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

We'll need per-thread data (crypto blocks) for encryption threads.
Prepare threads infrastructure for it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  6 ++++++
 block/qcow2-threads.c | 25 ++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index abe51a385c..7bef0393ce 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -257,9 +257,15 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+#define QCOW2_MAX_THREADS 4
+typedef struct Qcow2PerThreadData {
+    bool in_use;
+} Qcow2PerThreadData;
+
 typedef struct Qcow2ThreadsState {
     CoQueue task_queue;
     int count;
+    Qcow2PerThreadData per_thread[QCOW2_MAX_THREADS];
 } Qcow2ThreadsState;
 
 typedef struct BDRVQcow2State {
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index a09f07e2f9..3ed990ef2f 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -31,24 +31,42 @@
 #include "qcow2.h"
 #include "block/thread-pool.h"
 
-#define QCOW2_MAX_THREADS 4
+typedef struct Qcow2ProcessData {
+    Qcow2PerThreadData *self;
+    void *arg;
+} Qcow2ProcessData;
 
 static int coroutine_fn
 qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
 {
     int ret;
+    int ind;
     BDRVQcow2State *s = bs->opaque;
     Qcow2ThreadsState *thr = &s->threads;
     ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
+    Qcow2ProcessData data = {
+        .arg = arg
+    };
 
     while (thr->count >= QCOW2_MAX_THREADS) {
         qemu_co_queue_wait(&thr->task_queue, NULL);
     }
 
+    for (ind = 0; ind < QCOW2_MAX_THREADS; ind++) {
+        if (!thr->per_thread[ind].in_use) {
+            data.self = &thr->per_thread[ind];
+            thr->per_thread[ind].in_use = true;
+            break;
+        }
+    }
+    assert(ind < QCOW2_MAX_THREADS);
+
     thr->count++;
-    ret = thread_pool_submit_co(pool, func, arg);
+    ret = thread_pool_submit_co(pool, func, &data);
     thr->count--;
 
+    thr->per_thread[ind].in_use = false;
+
     qemu_co_queue_next(&thr->task_queue);
 
     return ret;
@@ -158,7 +176,8 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
 
 static int qcow2_compress_pool_func(void *opaque)
 {
-    Qcow2CompressData *data = opaque;
+    Qcow2ProcessData *pdata = opaque;
+    Qcow2CompressData *data = pdata->arg;
 
     data->ret = data->func(data->dest, data->dest_size,
                            data->src, data->src_size);
-- 
2.18.0
