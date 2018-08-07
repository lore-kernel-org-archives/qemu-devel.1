Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Th-5h
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00021w-DP
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:11 +0300
Message-Id: <20180807174311.32454-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/7] qcow2: async scheme for qcow2_co_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Start several async requests instead of read chunk by chunk.

Iotest 026 output is changed, as because of async io error path has
changed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c                      | 47 ++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/026.out         | 18 ++++++++-------
 tests/qemu-iotests/026.out.nocache | 20 ++++++++--------
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 88b3fb8080..c7501adfc6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1874,6 +1874,7 @@ typedef struct Qcow2WorkerTask {
     uint64_t offset;
     uint64_t bytes;
     uint64_t bytes_done;
+    QCowL2Meta *l2meta;
 } Qcow2WorkerTask;
 
 typedef int (*Qcow2DoWorkFunc)(BlockDriverState *bs, QEMUIOVector *qiov,
@@ -1965,11 +1966,16 @@ static coroutine_fn void qcow2_rw_worker(void *opaque)
     }
 }
 
+/* qcow2_rws_add_task
+* l2meta - opaque pointer for do_work_func, so behavior depends on
+*          do_work_func, specified in qcow2_init_rws
+*/
 static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
                                             uint64_t file_cluster_offset,
                                             uint64_t offset,
                                             uint64_t bytes,
-                                            uint64_t bytes_done)
+                                            uint64_t bytes_done,
+                                            QCowL2Meta *l2meta)
 {
     Qcow2Worker *w;
 
@@ -1980,7 +1986,8 @@ static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
             .file_cluster_offset = file_cluster_offset,
             .offset = offset,
             .bytes = bytes,
-            .bytes_done = bytes_done
+            .bytes_done = bytes_done,
+            .l2meta = l2meta
         };
         rws->ret = rws->do_work_func(rws->bs, rws->qiov, &task);
         return;
@@ -2006,6 +2013,7 @@ static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
     w->task.offset = offset;
     w->task.bytes = bytes;
     w->task.bytes_done = bytes_done;
+    w->task.l2meta = l2meta;
 
     qemu_coroutine_enter(w->co);
 }
@@ -2137,7 +2145,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             qemu_co_mutex_unlock(&s->lock);
 
             qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes,
-                               bytes_done);
+                               bytes_done, NULL);
             if (rws.ret < 0) {
                 ret = rws.ret;
                 goto fail_nolock;
@@ -2289,6 +2297,19 @@ fail:
     return ret;
 }
 
+static coroutine_fn int qcow2_co_do_pwritev_task(BlockDriverState *bs,
+                                                 QEMUIOVector *qiov,
+                                                 Qcow2WorkerTask *task)
+{
+    return qcow2_co_do_pwritev(bs,
+                               task->file_cluster_offset,
+                               task->offset,
+                               task->bytes,
+                               qiov,
+                               task->bytes_done,
+                               task->l2meta);
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -2299,16 +2320,19 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     uint64_t bytes_done = 0;
     uint8_t *cluster_data = NULL;
     QCowL2Meta *l2meta = NULL;
+    Qcow2RWState rws = {0};
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
+    qcow2_init_rws(&rws, bs, qiov, bytes, qcow2_co_do_pwritev_task);
+
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     s->cluster_cache_offset = -1; /* disable compressed cache */
 
     qemu_co_mutex_lock(&s->lock);
 
-    while (bytes != 0) {
+    while (bytes != 0 && rws.ret == 0) {
         int offset_in_cluster = offset_into_cluster(s, offset);
         unsigned int cur_bytes = MIN(bytes, INT_MAX); /* number of sectors in
                                                          current iteration */
@@ -2340,11 +2364,11 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
         qemu_co_mutex_unlock(&s->lock);
 
-
-        ret = qcow2_co_do_pwritev(bs, cluster_offset, offset, cur_bytes,
-                                  qiov, bytes_done, l2meta);
-        l2meta = NULL; /* l2meta is consumed by qcow2_co_do_pwritev() */
-        if (ret < 0) {
+        qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes, bytes_done,
+                           l2meta);
+        l2meta = NULL; /* l2meta is consumed */
+        if (rws.ret < 0) {
+            ret = rws.ret;
             goto fail_nometa;
         }
 
@@ -2362,6 +2386,11 @@ fail:
 
     qemu_co_mutex_unlock(&s->lock);
 
+    qcow2_finalize_rws(&rws);
+    if (ret == 0) {
+        ret = rws.ret;
+    }
+
 fail_nometa:
 
     qemu_iovec_destroy(&hd_qiov);
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index dd10a82b51..8dd19f1b53 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -481,7 +481,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-55 leaked clusters were found on the image.
+119 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -508,7 +508,9 @@ Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-No errors were found on the image.
+
+64 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
@@ -533,7 +535,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -542,7 +544,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -561,7 +563,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -570,7 +572,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -589,7 +591,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -598,7 +600,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.out.nocache
index 1ca6cda15c..10218c1aa6 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -489,7 +489,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-55 leaked clusters were found on the image.
+119 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -516,8 +516,10 @@ Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
-No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
+
+64 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
 Failed to flush the L2 table cache: No space left on device
@@ -541,7 +543,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -550,7 +552,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -569,7 +571,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -578,7 +580,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -597,7 +599,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-10 leaked clusters were found on the image.
+74 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 
 
@@ -606,7 +608,7 @@ Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
 
-23 leaked clusters were found on the image.
+87 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 
 === L1 growth tests ===
-- 
2.11.1
