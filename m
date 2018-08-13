Received: from eggs.gnu.org ([2001:4830:134:3::10]:53454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2Ta-0003su-PT
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TX-0008Qc-Uc
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:05 +0200
Message-Id: <20180813022006.7216-17-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 16/17] mirror: Support COR with write-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

This patch adds a .bdrv_co_block_status() implementation for the mirror
block job that reports an area as allocated iff source and target are
in sync.  This allows putting a copy-on-read node on top of a mirror
node which automatically copies all data read from the source to the
target.

To make this perform better, bdrv_mirror_top_do_write() is modified to
ignore BDRV_REQ_WRITE_UNCHANGED requests regarding the source, and only
write them to the target (in write-blocking mode).  Otherwise, using COR
would result in all data read from the source that is not in sync with
the target to be re-written to the source (which is not the intention of
COR).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 88 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index cba7de610e..625297fec1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1304,29 +1304,40 @@ static int coroutine_fn bdrv_mirror_top_do_write(BlockDriverState *bs,
     MirrorBDSOpaque *s = bs->opaque;
     int ret = 0;
     bool copy_to_target;
+    bool write_to_source;
 
     copy_to_target = s->job->ret >= 0 &&
                      s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
 
+    /* WRITE_UNCHANGED requests are allocating writes, which in this
+     * case means that we should ensure the target is in sync with the
+     * source (by writing the data to the target).  Therefore, if we
+     * do write to the target (only in write-blocking mode), skip
+     * writing the (unchanged) data to the source. */
+    write_to_source = s->job->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING ||
+                      !(flags & BDRV_REQ_WRITE_UNCHANGED);
+
     if (copy_to_target) {
         op = active_write_prepare(s->job, offset, bytes);
     }
 
-    switch (method) {
-    case MIRROR_METHOD_COPY:
-        ret = bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
-        break;
+    if (write_to_source) {
+        switch (method) {
+        case MIRROR_METHOD_COPY:
+            ret = bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+            break;
 
-    case MIRROR_METHOD_ZERO:
-        ret = bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
-        break;
+        case MIRROR_METHOD_ZERO:
+            ret = bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+            break;
 
-    case MIRROR_METHOD_DISCARD:
-        ret = bdrv_co_pdiscard(bs->backing, offset, bytes);
-        break;
+        case MIRROR_METHOD_DISCARD:
+            ret = bdrv_co_pdiscard(bs->backing, offset, bytes);
+            break;
 
-    default:
-        abort();
+        default:
+            abort();
+        }
     }
 
     if (ret < 0) {
@@ -1403,6 +1414,57 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
                                     NULL, 0);
 }
 
+/**
+ * Allocation status is determined by whether source and target are in
+ * sync:
+ * - If they are (dirty bitmap is clean), the data is considered to be
+ *   allocated in this layer.  Then, return BDRV_BLOCK_RAW so the
+ *   request is forwarded to the source.
+ * - Dirty (unsynced) areas are considered unallocated.  For those,
+ *   return 0.
+ */
+static int coroutine_fn bdrv_mirror_top_block_status(BlockDriverState *bs,
+                                                     bool want_zero,
+                                                     int64_t offset,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     int64_t *map,
+                                                     BlockDriverState **file)
+{
+    MirrorBDSOpaque *s = bs->opaque;
+    BdrvDirtyBitmapIter *iter;
+    uint64_t dirty_offset, clean_offset;
+    int ret;
+
+    *map = offset;
+    *file = bs->backing->bs;
+
+    iter = bdrv_dirty_iter_new(s->job->dirty_bitmap);
+    bdrv_set_dirty_iter(iter, offset);
+
+    bdrv_dirty_bitmap_lock(s->job->dirty_bitmap);
+    dirty_offset = bdrv_dirty_iter_next(iter);
+    bdrv_dirty_iter_free(iter);
+    if (dirty_offset > offset) {
+        /* Clean area */
+        *pnum = MIN(dirty_offset - offset, bytes);
+        ret = BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
+        goto out;
+    }
+
+    /* Dirty area, find next clean area */
+    clean_offset = bdrv_dirty_bitmap_next_zero(s->job->dirty_bitmap, offset);
+    bdrv_dirty_bitmap_unlock(s->job->dirty_bitmap);
+
+    assert(clean_offset > offset);
+    *pnum = MIN(clean_offset - offset, bytes);
+    ret = 0;
+
+out:
+    bdrv_dirty_bitmap_unlock(s->job->dirty_bitmap);
+    return ret;
+}
+
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     if (bs->backing == NULL) {
@@ -1442,7 +1504,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+    .bdrv_co_block_status       = bdrv_mirror_top_block_status,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
-- 
2.17.1
