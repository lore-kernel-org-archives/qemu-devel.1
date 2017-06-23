Received: from eggs.gnu.org ([2001:4830:134:3::10]:59697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM1-0001FU-NT
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORM0-0007hl-67
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:21 +0200
Message-Id: <1498234919-27316-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/61] qcow2: Merge the writing of the COW
 regions with the guest data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

If the guest tries to write data that results on the allocation of a
new cluster, instead of writing the guest data first and then the data
from the COW regions, write everything together using one single I/O
operation.

This can improve the write performance by 25% or more, depending on
several factors such as the media type, the cluster size and the I/O
request size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 40 ++++++++++++++++++++++++--------
 block/qcow2.c         | 64 +++++++++++++++++++++++++++++++++++++++++++--------
 block/qcow2.h         |  7 ++++++
 3 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3ac26d6..01f2101 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -776,6 +776,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
     assert(start->nb_bytes + end->nb_bytes <= UINT_MAX - data_bytes);
     assert(start->offset + start->nb_bytes <= end->offset);
+    assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
     if (start->nb_bytes == 0 && end->nb_bytes == 0) {
         return 0;
@@ -807,7 +808,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     /* The part of the buffer where the end region is located */
     end_buffer = start_buffer + buffer_size - end->nb_bytes;
 
-    qemu_iovec_init(&qiov, 1);
+    qemu_iovec_init(&qiov, 2 + (m->data_qiov ? m->data_qiov->niov : 0));
 
     qemu_co_mutex_unlock(&s->lock);
     /* First we read the existing data from both COW regions. We
@@ -842,17 +843,36 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
         }
     }
 
-    /* And now we can write everything */
-    qemu_iovec_reset(&qiov);
-    qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
-    ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
-    if (ret < 0) {
-        goto fail;
+    /* And now we can write everything. If we have the guest data we
+     * can write everything in one single operation */
+    if (m->data_qiov) {
+        qemu_iovec_reset(&qiov);
+        if (start->nb_bytes) {
+            qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
+        }
+        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
+        if (end->nb_bytes) {
+            qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+        }
+        /* NOTE: we have a write_aio blkdebug event here followed by
+         * a cow_write one in do_perform_cow_write(), but there's only
+         * one single I/O operation */
+        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
+    } else {
+        /* If there's no guest data then write both COW regions separately */
+        qemu_iovec_reset(&qiov);
+        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
+        ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        qemu_iovec_reset(&qiov);
+        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+        ret = do_perform_cow_write(bs, m->alloc_offset, end->offset, &qiov);
     }
 
-    qemu_iovec_reset(&qiov);
-    qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
-    ret = do_perform_cow_write(bs, m->alloc_offset, end->offset, &qiov);
 fail:
     qemu_co_mutex_lock(&s->lock);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index b3ba5da..328b1d4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1575,6 +1575,44 @@ fail:
     return ret;
 }
 
+/* Check if it's possible to merge a write request with the writing of
+ * the data from the COW regions */
+static bool merge_cow(uint64_t offset, unsigned bytes,
+                      QEMUIOVector *hd_qiov, QCowL2Meta *l2meta)
+{
+    QCowL2Meta *m;
+
+    for (m = l2meta; m != NULL; m = m->next) {
+        /* If both COW regions are empty then there's nothing to merge */
+        if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
+            continue;
+        }
+
+        /* The data (middle) region must be immediately after the
+         * start region */
+        if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
+            continue;
+        }
+
+        /* The end region must be immediately after the data (middle)
+         * region */
+        if (m->offset + m->cow_end.offset != offset + bytes) {
+            continue;
+        }
+
+        /* Make sure that adding both COW regions to the QEMUIOVector
+         * does not exceed IOV_MAX */
+        if (hd_qiov->niov > IOV_MAX - 2) {
+            continue;
+        }
+
+        m->data_qiov = hd_qiov;
+        return true;
+    }
+
+    return false;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1657,16 +1695,22 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
-        qemu_co_mutex_unlock(&s->lock);
-        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        trace_qcow2_writev_data(qemu_coroutine_self(),
-                                cluster_offset + offset_in_cluster);
-        ret = bdrv_co_pwritev(bs->file,
-                              cluster_offset + offset_in_cluster,
-                              cur_bytes, &hd_qiov, 0);
-        qemu_co_mutex_lock(&s->lock);
-        if (ret < 0) {
-            goto fail;
+        /* If we need to do COW, check if it's possible to merge the
+         * writing of the guest data together with that of the COW regions.
+         * If it's not possible (or not necessary) then write the
+         * guest data now. */
+        if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
+            qemu_co_mutex_unlock(&s->lock);
+            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+            trace_qcow2_writev_data(qemu_coroutine_self(),
+                                    cluster_offset + offset_in_cluster);
+            ret = bdrv_co_pwritev(bs->file,
+                                  cluster_offset + offset_in_cluster,
+                                  cur_bytes, &hd_qiov, 0);
+            qemu_co_mutex_lock(&s->lock);
+            if (ret < 0) {
+                goto fail;
+            }
         }
 
         while (l2meta != NULL) {
diff --git a/block/qcow2.h b/block/qcow2.h
index c26ee0a..87b15eb 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -343,6 +343,13 @@ typedef struct QCowL2Meta
      */
     Qcow2COWRegion cow_end;
 
+    /**
+     * The I/O vector with the data from the actual guest write request.
+     * If non-NULL, this is meant to be merged together with the data
+     * from @cow_start and @cow_end into one single write operation.
+     */
+    QEMUIOVector *data_qiov;
+
     /** Pointer to next L2Meta of the same write request */
     struct QCowL2Meta *next;
 
-- 
1.8.3.1
