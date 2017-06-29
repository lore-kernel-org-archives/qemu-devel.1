Received: from eggs.gnu.org ([2001:4830:134:3::10]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUQ-0005x8-Rr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUL-0001Rw-AK
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:10 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:47 +0200
Message-Id: <20170629132749.997-10-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/11] qed: protect table cache with CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

This makes the driver thread-safe.  The CoMutex is dropped temporarily
while accessing the data clusters or the backing file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        RFC->v2: add bdrv_qed_invalidate_cache change; invalidate_cache
                 can run in a coroutine when called by block migration.

 block/qed-cluster.c  |   4 +-
 block/qed-l2-cache.c |   6 +++
 block/qed-table.c    |  24 +++++++---
 block/qed.c          | 133 +++++++++++++++++++++++++++++++++++----------------
 block/qed.h          |  11 +++--
 5 files changed, 124 insertions(+), 54 deletions(-)

diff --git a/block/qed-cluster.c b/block/qed-cluster.c
index d8d6e66a0f..672e2e654b 100644
--- a/block/qed-cluster.c
+++ b/block/qed-cluster.c
@@ -85,6 +85,8 @@ static unsigned int qed_count_contiguous_clusters(BDRVQEDState *s,
  *
  * On failure QED_CLUSTER_L2 or QED_CLUSTER_L1 is returned for missing L2 or L1
  * table offset, respectively. len is number of contiguous unallocated bytes.
+ *
+ * Called with table_lock held.
  */
 int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
                                   uint64_t pos, size_t *len,
@@ -112,7 +114,6 @@ int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
     }
 
     ret = qed_read_l2_table(s, request, l2_offset);
-    qed_acquire(s);
     if (ret) {
         goto out;
     }
@@ -137,6 +138,5 @@ int coroutine_fn qed_find_cluster(BDRVQEDState *s, QEDRequest *request,
 
 out:
     *img_offset = offset;
-    qed_release(s);
     return ret;
 }
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index 5cba794650..b548362398 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -101,6 +101,8 @@ CachedL2Table *qed_alloc_l2_cache_entry(L2TableCache *l2_cache)
 /**
  * Decrease an entry's reference count and free if necessary when the reference
  * count drops to zero.
+ *
+ * Called with table_lock held.
  */
 void qed_unref_l2_cache_entry(CachedL2Table *entry)
 {
@@ -122,6 +124,8 @@ void qed_unref_l2_cache_entry(CachedL2Table *entry)
  *
  * For a cached entry, this function increases the reference count and returns
  * the entry.
+ *
+ * Called with table_lock held.
  */
 CachedL2Table *qed_find_l2_cache_entry(L2TableCache *l2_cache, uint64_t offset)
 {
@@ -150,6 +154,8 @@ CachedL2Table *qed_find_l2_cache_entry(L2TableCache *l2_cache, uint64_t offset)
  * N.B. This function steals a reference to the l2_table from the caller so the
  * caller must obtain a new reference by issuing a call to
  * qed_find_l2_cache_entry().
+ *
+ * Called with table_lock held.
  */
 void qed_commit_l2_cache_entry(L2TableCache *l2_cache, CachedL2Table *l2_table)
 {
diff --git a/block/qed-table.c b/block/qed-table.c
index ebee2c50f0..eead8b0fc7 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -18,6 +18,7 @@
 #include "qed.h"
 #include "qemu/bswap.h"
 
+/* Called either from qed_check or with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 {
     QEMUIOVector qiov;
@@ -32,18 +33,22 @@ static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 
     trace_qed_read_table(s, offset, table);
 
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->table_lock);
+    }
     ret = bdrv_preadv(s->bs->file, offset, &qiov);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->table_lock);
+    }
     if (ret < 0) {
         goto out;
     }
 
     /* Byteswap offsets */
-    qed_acquire(s);
     noffsets = qiov.size / sizeof(uint64_t);
     for (i = 0; i < noffsets; i++) {
         table->offsets[i] = le64_to_cpu(table->offsets[i]);
     }
-    qed_release(s);
 
     ret = 0;
 out:
@@ -61,6 +66,8 @@ out:
  * @index:      Index of first element
  * @n:          Number of elements
  * @flush:      Whether or not to sync to disk
+ *
+ * Called either from qed_check or with table_lock held.
  */
 static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
                            unsigned int index, unsigned int n, bool flush)
@@ -97,16 +104,20 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     /* Adjust for offset into table */
     offset += start * sizeof(uint64_t);
 
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->table_lock);
+    }
     ret = bdrv_pwritev(s->bs->file, offset, &qiov);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->table_lock);
+    }
     trace_qed_write_table_cb(s, table, flush, ret);
     if (ret < 0) {
         goto out;
     }
 
     if (flush) {
-        qed_acquire(s);
         ret = bdrv_flush(s->bs);
-        qed_release(s);
         if (ret < 0) {
             goto out;
         }
@@ -123,6 +134,7 @@ int qed_read_l1_table_sync(BDRVQEDState *s)
     return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
 
+/* Called either from qed_check or with table_lock held.  */
 int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
@@ -136,6 +148,7 @@ int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
     return qed_write_l1_table(s, index, n);
 }
 
+/* Called either from qed_check or with table_lock held.  */
 int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
 {
     int ret;
@@ -154,7 +167,6 @@ int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
     BLKDBG_EVENT(s->bs->file, BLKDBG_L2_LOAD);
     ret = qed_read_table(s, offset, request->l2_table->table);
 
-    qed_acquire(s);
     if (ret) {
         /* can't trust loaded L2 table anymore */
         qed_unref_l2_cache_entry(request->l2_table);
@@ -170,7 +182,6 @@ int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
         request->l2_table = qed_find_l2_cache_entry(&s->l2_cache, offset);
         assert(request->l2_table != NULL);
     }
-    qed_release(s);
 
     return ret;
 }
@@ -180,6 +191,7 @@ int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset
     return qed_read_l2_table(s, request, offset);
 }
 
+/* Called either from qed_check or with table_lock held.  */
 int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
                        unsigned int index, unsigned int n, bool flush)
 {
diff --git a/block/qed.c b/block/qed.c
index 8228a50f68..afad14fc01 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -93,6 +93,8 @@ int qed_write_header_sync(BDRVQEDState *s)
  *
  * This function only updates known header fields in-place and does not affect
  * extra data after the QED header.
+ *
+ * No new allocating reqs can start while this function runs.
  */
 static int coroutine_fn qed_write_header(BDRVQEDState *s)
 {
@@ -109,6 +111,8 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     QEMUIOVector qiov;
     int ret;
 
+    assert(s->allocating_acb || s->allocating_write_reqs_plugged);
+
     buf = qemu_blockalign(s->bs, len);
     iov = (struct iovec) {
         .iov_base = buf,
@@ -219,6 +223,8 @@ static int qed_read_string(BdrvChild *file, uint64_t offset, size_t n,
  * This function only produces the offset where the new clusters should be
  * written.  It updates BDRVQEDState but does not make any changes to the image
  * file.
+ *
+ * Called with table_lock held.
  */
 static uint64_t qed_alloc_clusters(BDRVQEDState *s, unsigned int n)
 {
@@ -236,6 +242,8 @@ QEDTable *qed_alloc_table(BDRVQEDState *s)
 
 /**
  * Allocate a new zeroed L2 table
+ *
+ * Called with table_lock held.
  */
 static CachedL2Table *qed_new_l2_table(BDRVQEDState *s)
 {
@@ -249,19 +257,32 @@ static CachedL2Table *qed_new_l2_table(BDRVQEDState *s)
     return l2_table;
 }
 
-static void qed_plug_allocating_write_reqs(BDRVQEDState *s)
+static bool qed_plug_allocating_write_reqs(BDRVQEDState *s)
 {
+    qemu_co_mutex_lock(&s->table_lock);
+
+    /* No reentrancy is allowed.  */
     assert(!s->allocating_write_reqs_plugged);
+    if (s->allocating_acb != NULL) {
+        /* Another allocating write came concurrently.  This cannot happen
+         * from bdrv_qed_co_drain, but it can happen when the timer runs.
+         */
+        qemu_co_mutex_unlock(&s->table_lock);
+        return false;
+    }
 
     s->allocating_write_reqs_plugged = true;
+    qemu_co_mutex_unlock(&s->table_lock);
+    return true;
 }
 
 static void qed_unplug_allocating_write_reqs(BDRVQEDState *s)
 {
+    qemu_co_mutex_lock(&s->table_lock);
     assert(s->allocating_write_reqs_plugged);
-
     s->allocating_write_reqs_plugged = false;
-    qemu_co_enter_next(&s->allocating_write_reqs);
+    qemu_co_queue_next(&s->allocating_write_reqs);
+    qemu_co_mutex_unlock(&s->table_lock);
 }
 
 static void coroutine_fn qed_need_check_timer_entry(void *opaque)
@@ -269,17 +290,14 @@ static void coroutine_fn qed_need_check_timer_entry(void *opaque)
     BDRVQEDState *s = opaque;
     int ret;
 
-    /* The timer should only fire when allocating writes have drained */
-    assert(!s->allocating_acb);
-
     trace_qed_need_check_timer_cb(s);
 
-    qed_acquire(s);
-    qed_plug_allocating_write_reqs(s);
+    if (!qed_plug_allocating_write_reqs(s)) {
+        return;
+    }
 
     /* Ensure writes are on disk before clearing flag */
     ret = bdrv_co_flush(s->bs->file->bs);
-    qed_release(s);
     if (ret < 0) {
         qed_unplug_allocating_write_reqs(s);
         return;
@@ -301,16 +319,6 @@ static void qed_need_check_timer_cb(void *opaque)
     qemu_coroutine_enter(co);
 }
 
-void qed_acquire(BDRVQEDState *s)
-{
-    aio_context_acquire(bdrv_get_aio_context(s->bs));
-}
-
-void qed_release(BDRVQEDState *s)
-{
-    aio_context_release(bdrv_get_aio_context(s->bs));
-}
-
 static void qed_start_need_check_timer(BDRVQEDState *s)
 {
     trace_qed_start_need_check_timer(s);
@@ -369,6 +377,7 @@ static void bdrv_qed_init_state(BlockDriverState *bs)
 
     memset(s, 0, sizeof(BDRVQEDState));
     s->bs = bs;
+    qemu_co_mutex_init(&s->table_lock);
     qemu_co_queue_init(&s->allocating_write_reqs);
 }
 
@@ -688,6 +697,7 @@ typedef struct {
     BlockDriverState **file;
 } QEDIsAllocatedCB;
 
+/* Called with table_lock held.  */
 static void qed_is_allocated_cb(void *opaque, int ret, uint64_t offset, size_t len)
 {
     QEDIsAllocatedCB *cb = opaque;
@@ -735,6 +745,7 @@ static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
     uint64_t offset;
     int ret;
 
+    qemu_co_mutex_lock(&s->table_lock);
     ret = qed_find_cluster(s, &request, cb.pos, &len, &offset);
     qed_is_allocated_cb(&cb, ret, offset, len);
 
@@ -742,6 +753,7 @@ static int64_t coroutine_fn bdrv_qed_co_get_block_status(BlockDriverState *bs,
     assert(cb.status != BDRV_BLOCK_OFFSET_MASK);
 
     qed_unref_l2_cache_entry(request.l2_table);
+    qemu_co_mutex_unlock(&s->table_lock);
 
     return cb.status;
 }
@@ -872,6 +884,8 @@ out:
  *
  * The cluster offset may be an allocated byte offset in the image file, the
  * zero cluster marker, or the unallocated cluster marker.
+ *
+ * Called with table_lock held.
  */
 static void coroutine_fn qed_update_l2_table(BDRVQEDState *s, QEDTable *table,
                                              int index, unsigned int n,
@@ -887,6 +901,7 @@ static void coroutine_fn qed_update_l2_table(BDRVQEDState *s, QEDTable *table,
     }
 }
 
+/* Called with table_lock held.  */
 static void coroutine_fn qed_aio_complete(QEDAIOCB *acb)
 {
     BDRVQEDState *s = acb_to_s(acb);
@@ -910,7 +925,7 @@ static void coroutine_fn qed_aio_complete(QEDAIOCB *acb)
     if (acb == s->allocating_acb) {
         s->allocating_acb = NULL;
         if (!qemu_co_queue_empty(&s->allocating_write_reqs)) {
-            qemu_co_enter_next(&s->allocating_write_reqs);
+            qemu_co_queue_next(&s->allocating_write_reqs);
         } else if (s->header.features & QED_F_NEED_CHECK) {
             qed_start_need_check_timer(s);
         }
@@ -919,6 +934,8 @@ static void coroutine_fn qed_aio_complete(QEDAIOCB *acb)
 
 /**
  * Update L1 table with new L2 table offset and write it out
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_l1_update(QEDAIOCB *acb)
 {
@@ -947,6 +964,8 @@ static int coroutine_fn qed_aio_write_l1_update(QEDAIOCB *acb)
 
 /**
  * Update L2 table with new cluster offsets and write them out
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 {
@@ -983,6 +1002,8 @@ static int coroutine_fn qed_aio_write_l2_update(QEDAIOCB *acb, uint64_t offset)
 
 /**
  * Write data to the image file
+ *
+ * Called with table_lock *not* held.
  */
 static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
 {
@@ -999,6 +1020,8 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
 
 /**
  * Populate untouched regions of new data cluster
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
 {
@@ -1006,6 +1029,8 @@ static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
     uint64_t start, len, offset;
     int ret;
 
+    qemu_co_mutex_unlock(&s->table_lock);
+
     /* Populate front untouched region of new data cluster */
     start = qed_start_of_cluster(s, acb->cur_pos);
     len = qed_offset_into_cluster(s, acb->cur_pos);
@@ -1013,7 +1038,7 @@ static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
     trace_qed_aio_write_prefill(s, acb, start, len, acb->cur_cluster);
     ret = qed_copy_from_backing_file(s, start, len, acb->cur_cluster);
     if (ret < 0) {
-        return ret;
+        goto out;
     }
 
     /* Populate back untouched region of new data cluster */
@@ -1026,12 +1051,12 @@ static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
     trace_qed_aio_write_postfill(s, acb, start, len, offset);
     ret = qed_copy_from_backing_file(s, start, len, offset);
     if (ret < 0) {
-        return ret;
+        goto out;
     }
 
     ret = qed_aio_write_main(acb);
     if (ret < 0) {
-        return ret;
+        goto out;
     }
 
     if (s->bs->backing) {
@@ -1046,12 +1071,11 @@ static int coroutine_fn qed_aio_write_cow(QEDAIOCB *acb)
          * cluster and before updating the L2 table.
          */
         ret = bdrv_co_flush(s->bs->file->bs);
-        if (ret < 0) {
-            return ret;
-        }
     }
 
-    return 0;
+out:
+    qemu_co_mutex_lock(&s->table_lock);
+    return ret;
 }
 
 /**
@@ -1074,6 +1098,8 @@ static bool qed_should_set_need_check(BDRVQEDState *s)
  * @len:        Length in bytes
  *
  * This path is taken when writing to previously unallocated clusters.
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
 {
@@ -1088,7 +1114,7 @@ static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
     /* Freeze this request if another allocating write is in progress */
     if (s->allocating_acb != acb || s->allocating_write_reqs_plugged) {
         if (s->allocating_acb != NULL) {
-            qemu_co_queue_wait(&s->allocating_write_reqs, NULL);
+            qemu_co_queue_wait(&s->allocating_write_reqs, &s->table_lock);
             assert(s->allocating_acb == NULL);
         }
         s->allocating_acb = acb;
@@ -1135,10 +1161,17 @@ static int coroutine_fn qed_aio_write_alloc(QEDAIOCB *acb, size_t len)
  * @len:        Length in bytes
  *
  * This path is taken when writing to already allocated clusters.
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset,
                                               size_t len)
 {
+    BDRVQEDState *s = acb_to_s(acb);
+    int r;
+
+    qemu_co_mutex_unlock(&s->table_lock);
+
     /* Allocate buffer for zero writes */
     if (acb->flags & QED_AIOCB_ZERO) {
         struct iovec *iov = acb->qiov->iov;
@@ -1146,7 +1179,8 @@ static int coroutine_fn qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset,
         if (!iov->iov_base) {
             iov->iov_base = qemu_try_blockalign(acb->bs, iov->iov_len);
             if (iov->iov_base == NULL) {
-                return -ENOMEM;
+                r = -ENOMEM;
+                goto out;
             }
             memset(iov->iov_base, 0, iov->iov_len);
         }
@@ -1156,8 +1190,11 @@ static int coroutine_fn qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset,
     acb->cur_cluster = offset;
     qemu_iovec_concat(&acb->cur_qiov, acb->qiov, acb->qiov_offset, len);
 
-    /* Do the actual write */
-    return qed_aio_write_main(acb);
+    /* Do the actual write.  */
+    r = qed_aio_write_main(acb);
+out:
+    qemu_co_mutex_lock(&s->table_lock);
+    return r;
 }
 
 /**
@@ -1167,6 +1204,8 @@ static int coroutine_fn qed_aio_write_inplace(QEDAIOCB *acb, uint64_t offset,
  * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2 or QED_CLUSTER_L1
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_write_data(void *opaque, int ret,
                                            uint64_t offset, size_t len)
@@ -1198,6 +1237,8 @@ static int coroutine_fn qed_aio_write_data(void *opaque, int ret,
  * @ret:        QED_CLUSTER_FOUND, QED_CLUSTER_L2 or QED_CLUSTER_L1
  * @offset:     Cluster offset in bytes
  * @len:        Length in bytes
+ *
+ * Called with table_lock held.
  */
 static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
                                           uint64_t offset, size_t len)
@@ -1205,6 +1246,9 @@ static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
     QEDAIOCB *acb = opaque;
     BDRVQEDState *s = acb_to_s(acb);
     BlockDriverState *bs = acb->bs;
+    int r;
+
+    qemu_co_mutex_unlock(&s->table_lock);
 
     /* Adjust offset into cluster */
     offset += qed_offset_into_cluster(s, acb->cur_pos);
@@ -1213,22 +1257,23 @@ static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
 
     qemu_iovec_concat(&acb->cur_qiov, acb->qiov, acb->qiov_offset, len);
 
-    /* Handle zero cluster and backing file reads */
+    /* Handle zero cluster and backing file reads, otherwise read
+     * data cluster directly.
+     */
     if (ret == QED_CLUSTER_ZERO) {
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
-        return 0;
+        r = 0;
     } else if (ret != QED_CLUSTER_FOUND) {
-        return qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                                     &acb->backing_qiov);
+        r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
+                                  &acb->backing_qiov);
+    } else {
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        r = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
+                           &acb->cur_qiov, 0);
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-    ret = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
-                         &acb->cur_qiov, 0);
-    if (ret < 0) {
-        return ret;
-    }
-    return 0;
+    qemu_co_mutex_lock(&s->table_lock);
+    return r;
 }
 
 /**
@@ -1241,6 +1286,7 @@ static int coroutine_fn qed_aio_next_io(QEDAIOCB *acb)
     size_t len;
     int ret;
 
+    qemu_co_mutex_lock(&s->table_lock);
     while (1) {
         trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
 
@@ -1280,6 +1326,7 @@ static int coroutine_fn qed_aio_next_io(QEDAIOCB *acb)
 
     trace_qed_aio_complete(s, acb, ret);
     qed_aio_complete(acb);
+    qemu_co_mutex_unlock(&s->table_lock);
     return ret;
 }
 
@@ -1469,7 +1516,13 @@ static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
     bdrv_qed_close(bs);
 
     bdrv_qed_init_state(bs);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->table_lock);
+    }
     ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->table_lock);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         error_prepend(errp, "Could not reopen qed layer: ");
diff --git a/block/qed.h b/block/qed.h
index dd3a2d5519..f35341f134 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -151,15 +151,21 @@ typedef struct QEDAIOCB {
 
 typedef struct {
     BlockDriverState *bs;           /* device */
-    uint64_t file_size;             /* length of image file, in bytes */
 
+    /* Written only by an allocating write or the timer handler (the latter
+     * while allocating reqs are plugged).
+     */
     QEDHeader header;               /* always cpu-endian */
+
+    /* Protected by table_lock.  */
+    CoMutex table_lock;
     QEDTable *l1_table;
     L2TableCache l2_cache;          /* l2 table cache */
     uint32_t table_nelems;
     uint32_t l1_shift;
     uint32_t l2_shift;
     uint32_t l2_mask;
+    uint64_t file_size;             /* length of image file, in bytes */
 
     /* Allocating write request queue */
     QEDAIOCB *allocating_acb;
@@ -177,9 +183,6 @@ enum {
     QED_CLUSTER_L1,            /* cluster missing in L1 */
 };
 
-void qed_acquire(BDRVQEDState *s);
-void qed_release(BDRVQEDState *s);
-
 /**
  * Header functions
  */
-- 
2.13.0
