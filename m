Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLt-00018f-T3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLs-0007eg-KP
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:18 +0200
Message-Id: <1498234919-27316-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/61] qcow2: Split do_perform_cow() into
 _read(), _encrypt() and _write()
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

This patch splits do_perform_cow() into three separate functions to
read, encrypt and write the COW regions.

perform_cow() can now read both regions first, then encrypt them and
finally write them to disk. The memory allocation is also done in
this function now, using one single buffer large enough to hold both
regions.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 117 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 30 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4c03639..3c9ace8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -403,34 +403,26 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
     return 0;
 }
 
-static int coroutine_fn do_perform_cow(BlockDriverState *bs,
-                                       uint64_t src_cluster_offset,
-                                       uint64_t cluster_offset,
-                                       unsigned offset_in_cluster,
-                                       unsigned bytes)
+static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
+                                            uint64_t src_cluster_offset,
+                                            unsigned offset_in_cluster,
+                                            uint8_t *buffer,
+                                            unsigned bytes)
 {
-    BDRVQcow2State *s = bs->opaque;
     QEMUIOVector qiov;
-    struct iovec iov;
+    struct iovec iov = { .iov_base = buffer, .iov_len = bytes };
     int ret;
 
     if (bytes == 0) {
         return 0;
     }
 
-    iov.iov_len = bytes;
-    iov.iov_base = qemu_try_blockalign(bs, iov.iov_len);
-    if (iov.iov_base == NULL) {
-        return -ENOMEM;
-    }
-
     qemu_iovec_init_external(&qiov, &iov, 1);
 
     BLKDBG_EVENT(bs->file, BLKDBG_COW_READ);
 
     if (!bs->drv) {
-        ret = -ENOMEDIUM;
-        goto out;
+        return -ENOMEDIUM;
     }
 
     /* Call .bdrv_co_readv() directly instead of using the public block-layer
@@ -440,39 +432,63 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
     ret = bs->drv->bdrv_co_preadv(bs, src_cluster_offset + offset_in_cluster,
                                   bytes, &qiov, 0);
     if (ret < 0) {
-        goto out;
+        return ret;
     }
 
-    if (bs->encrypted) {
+    return 0;
+}
+
+static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
+                                                uint64_t src_cluster_offset,
+                                                unsigned offset_in_cluster,
+                                                uint8_t *buffer,
+                                                unsigned bytes)
+{
+    if (bytes && bs->encrypted) {
+        BDRVQcow2State *s = bs->opaque;
         int64_t sector = (src_cluster_offset + offset_in_cluster)
                          >> BDRV_SECTOR_BITS;
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
-        if (qcow2_encrypt_sectors(s, sector, iov.iov_base, iov.iov_base,
+        if (qcow2_encrypt_sectors(s, sector, buffer, buffer,
                                   bytes >> BDRV_SECTOR_BITS, true, NULL) < 0) {
-            ret = -EIO;
-            goto out;
+            return false;
         }
     }
+    return true;
+}
+
+static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
+                                             uint64_t cluster_offset,
+                                             unsigned offset_in_cluster,
+                                             uint8_t *buffer,
+                                             unsigned bytes)
+{
+    QEMUIOVector qiov;
+    struct iovec iov = { .iov_base = buffer, .iov_len = bytes };
+    int ret;
+
+    if (bytes == 0) {
+        return 0;
+    }
+
+    qemu_iovec_init_external(&qiov, &iov, 1);
 
     ret = qcow2_pre_write_overlap_check(bs, 0,
             cluster_offset + offset_in_cluster, bytes);
     if (ret < 0) {
-        goto out;
+        return ret;
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_COW_WRITE);
     ret = bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster,
                           bytes, &qiov, 0);
     if (ret < 0) {
-        goto out;
+        return ret;
     }
 
-    ret = 0;
-out:
-    qemu_vfree(iov.iov_base);
-    return ret;
+    return 0;
 }
 
 
@@ -760,22 +776,62 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     BDRVQcow2State *s = bs->opaque;
     Qcow2COWRegion *start = &m->cow_start;
     Qcow2COWRegion *end = &m->cow_end;
+    unsigned buffer_size;
+    uint8_t *start_buffer, *end_buffer;
     int ret;
 
+    assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
+
     if (start->nb_bytes == 0 && end->nb_bytes == 0) {
         return 0;
     }
 
+    /* Reserve a buffer large enough to store the data from both the
+     * start and end COW regions. Add some padding in the middle if
+     * necessary to make sure that the end region is optimally aligned */
+    buffer_size = QEMU_ALIGN_UP(start->nb_bytes, bdrv_opt_mem_align(bs)) +
+        end->nb_bytes;
+    start_buffer = qemu_try_blockalign(bs, buffer_size);
+    if (start_buffer == NULL) {
+        return -ENOMEM;
+    }
+    /* The part of the buffer where the end region is located */
+    end_buffer = start_buffer + buffer_size - end->nb_bytes;
+
     qemu_co_mutex_unlock(&s->lock);
-    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
-                         start->offset, start->nb_bytes);
+    /* First we read the existing data from both COW regions */
+    ret = do_perform_cow_read(bs, m->offset, start->offset,
+                              start_buffer, start->nb_bytes);
     if (ret < 0) {
         goto fail;
     }
 
-    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
-                         end->offset, end->nb_bytes);
+    ret = do_perform_cow_read(bs, m->offset, end->offset,
+                              end_buffer, end->nb_bytes);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    /* Encrypt the data if necessary before writing it */
+    if (bs->encrypted) {
+        if (!do_perform_cow_encrypt(bs, m->offset, start->offset,
+                                    start_buffer, start->nb_bytes) ||
+            !do_perform_cow_encrypt(bs, m->offset, end->offset,
+                                    end_buffer, end->nb_bytes)) {
+            ret = -EIO;
+            goto fail;
+        }
+    }
+
+    /* And now we can write everything */
+    ret = do_perform_cow_write(bs, m->alloc_offset, start->offset,
+                               start_buffer, start->nb_bytes);
+    if (ret < 0) {
+        goto fail;
+    }
 
+    ret = do_perform_cow_write(bs, m->alloc_offset, end->offset,
+                               end_buffer, end->nb_bytes);
 fail:
     qemu_co_mutex_lock(&s->lock);
 
@@ -788,6 +844,7 @@ fail:
         qcow2_cache_depends_on_flush(s->l2_table_cache);
     }
 
+    qemu_vfree(start_buffer);
     return ret;
 }
 
-- 
1.8.3.1
