Received: from eggs.gnu.org ([2001:4830:134:3::10]:44307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunb-00057z-6u
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunY-0001dk-9c
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:46 +0200
Message-Id: <20180710154304.18304-7-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/24] block: split flags in copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Pass read flags and write flags separately. This is needed to handle
coming BDRV_REQ_NO_SERIALISING clearly in following patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h          |  3 ++-
 include/block/block_int.h      | 14 +++++++++----
 include/sysemu/block-backend.h |  3 ++-
 block/backup.c                 |  2 +-
 block/block-backend.c          |  5 +++--
 block/file-posix.c             | 21 +++++++++++--------
 block/io.c                     | 46 +++++++++++++++++++++++-------------------
 block/iscsi.c                  |  9 ++++++---
 block/qcow2.c                  | 20 +++++++++---------
 block/raw-format.c             | 24 ++++++++++++++--------
 qemu-img.c                     |  2 +-
 11 files changed, 90 insertions(+), 59 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f7ddff45b6..e474f2541b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -699,5 +699,6 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
  **/
 int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags flags);
+                                    uint64_t bytes, BdrvRequestFlags read_flags,
+                                    BdrvRequestFlags write_flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 81cd3db7a9..920d3d122b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -218,7 +218,8 @@ struct BlockDriver {
                                                 BdrvChild *dst,
                                                 uint64_t dst_offset,
                                                 uint64_t bytes,
-                                                BdrvRequestFlags flags);
+                                                BdrvRequestFlags read_flags,
+                                                BdrvRequestFlags write_flags);
 
     /* Map [offset, offset + nbytes) range onto a child of bs to copy data to,
      * and invoke bdrv_co_copy_range_to(child, src, ...), or perform the copy
@@ -234,7 +235,8 @@ struct BlockDriver {
                                               BdrvChild *dst,
                                               uint64_t dst_offset,
                                               uint64_t bytes,
-                                              BdrvRequestFlags flags);
+                                              BdrvRequestFlags read_flags,
+                                              BdrvRequestFlags write_flags);
 
     /*
      * Building block for bdrv_block_status[_above] and
@@ -1156,10 +1158,14 @@ void blockdev_close_all_bdrv_states(void);
 
 int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
                                          BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes, BdrvRequestFlags flags);
+                                         uint64_t bytes,
+                                         BdrvRequestFlags read_flags,
+                                         BdrvRequestFlags write_flags);
 int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes, BdrvRequestFlags flags);
+                                       uint64_t bytes,
+                                       BdrvRequestFlags read_flags,
+                                       BdrvRequestFlags write_flags);
 
 int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8d03d493c2..830d873f24 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -234,6 +234,7 @@ void blk_unregister_buf(BlockBackend *blk, void *host);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags flags);
+                                   int bytes, BdrvRequestFlags read_flags,
+                                   BdrvRequestFlags write_flags);
 
 #endif
diff --git a/block/backup.c b/block/backup.c
index 81895ddbe2..f3e4e814b6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -163,7 +163,7 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
                   nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0, 0);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
         hbitmap_set(job->copy_bitmap, start / job->cluster_size,
diff --git a/block/block-backend.c b/block/block-backend.c
index 6b75bca317..ac8c3e0b1c 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2218,7 +2218,8 @@ void blk_unregister_buf(BlockBackend *blk, void *host)
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags flags)
+                                   int bytes, BdrvRequestFlags read_flags,
+                                   BdrvRequestFlags write_flags)
 {
     int r;
     r = blk_check_byte_request(blk_in, off_in, bytes);
@@ -2231,5 +2232,5 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
     }
     return bdrv_co_copy_range(blk_in->root, off_in,
                               blk_out->root, off_out,
-                              bytes, flags);
+                              bytes, read_flags, write_flags);
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index 98987b80f1..4fec8cb53c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2589,18 +2589,23 @@ static void raw_abort_perm_update(BlockDriverState *bs)
     raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
 }
 
-static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
-                                               BdrvChild *src, uint64_t src_offset,
-                                               BdrvChild *dst, uint64_t dst_offset,
-                                               uint64_t bytes, BdrvRequestFlags flags)
+static int coroutine_fn raw_co_copy_range_from(
+        BlockDriverState *bs, BdrvChild *src, uint64_t src_offset,
+        BdrvChild *dst, uint64_t dst_offset, uint64_t bytes,
+        BdrvRequestFlags read_flags, BdrvRequestFlags write_flags)
 {
-    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes, flags);
+    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes,
+                                 read_flags, write_flags);
 }
 
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
-                                             BdrvChild *src, uint64_t src_offset,
-                                             BdrvChild *dst, uint64_t dst_offset,
-                                             uint64_t bytes, BdrvRequestFlags flags)
+                                             BdrvChild *src,
+                                             uint64_t src_offset,
+                                             BdrvChild *dst,
+                                             uint64_t dst_offset,
+                                             uint64_t bytes,
+                                             BdrvRequestFlags read_flags,
+                                             BdrvRequestFlags write_flags)
 {
     BDRVRawState *s = bs->opaque;
     BDRVRawState *src_s;
diff --git a/block/io.c b/block/io.c
index 3a321d69d3..75ab26fd58 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2910,13 +2910,11 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
     }
 }
 
-static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
-                                                    uint64_t src_offset,
-                                                    BdrvChild *dst,
-                                                    uint64_t dst_offset,
-                                                    uint64_t bytes,
-                                                    BdrvRequestFlags flags,
-                                                    bool recurse_src)
+static int coroutine_fn bdrv_co_copy_range_internal(
+        BdrvChild *src, uint64_t src_offset, BdrvChild *dst,
+        uint64_t dst_offset, uint64_t bytes,
+        BdrvRequestFlags read_flags, BdrvRequestFlags write_flags,
+        bool recurse_src)
 {
     BdrvTrackedRequest req;
     int ret;
@@ -2928,8 +2926,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
     if (ret) {
         return ret;
     }
-    if (flags & BDRV_REQ_ZERO_WRITE) {
-        return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, flags);
+    if (write_flags & BDRV_REQ_ZERO_WRITE) {
+        return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, write_flags);
     }
 
     if (!src || !src->bs) {
@@ -2951,14 +2949,15 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
         tracked_request_begin(&req, src->bs, src_offset, bytes,
                               BDRV_TRACKED_READ);
 
-        if (!(flags & BDRV_REQ_NO_SERIALISING)) {
+        if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
             wait_serialising_requests(&req);
         }
 
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
                                                     dst, dst_offset,
-                                                    bytes, flags);
+                                                    bytes,
+                                                    read_flags, write_flags);
 
         tracked_request_end(&req);
         bdrv_dec_in_flight(src->bs);
@@ -2967,15 +2966,15 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
         tracked_request_begin(&req, dst->bs, dst_offset, bytes,
                               BDRV_TRACKED_WRITE);
 
-        /* BDRV_REQ_NO_SERIALISING is only for read operation,
-         * so we ignore it in flags.
-         */
+        /* BDRV_REQ_NO_SERIALISING is only for read operation */
+        assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
         wait_serialising_requests(&req);
 
         ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
                                                   src, src_offset,
                                                   dst, dst_offset,
-                                                  bytes, flags);
+                                                  bytes,
+                                                  read_flags, write_flags);
 
         tracked_request_end(&req);
         bdrv_dec_in_flight(dst->bs);
@@ -2990,10 +2989,12 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
  * semantics. */
 int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
                                          BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes, BdrvRequestFlags flags)
+                                         uint64_t bytes,
+                                         BdrvRequestFlags read_flags,
+                                         BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
-                                       bytes, flags, true);
+                                       bytes, read_flags, write_flags, true);
 }
 
 /* Copy range from @src to @dst.
@@ -3002,19 +3003,22 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
  * semantics. */
 int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes, BdrvRequestFlags flags)
+                                       uint64_t bytes,
+                                       BdrvRequestFlags read_flags,
+                                       BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
-                                       bytes, flags, false);
+                                       bytes, read_flags, write_flags, false);
 }
 
 int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags flags)
+                                    uint64_t bytes, BdrvRequestFlags read_flags,
+                                    BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_from(src, src_offset,
                                    dst, dst_offset,
-                                   bytes, flags);
+                                   bytes, read_flags, write_flags);
 }
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs)
diff --git a/block/iscsi.c b/block/iscsi.c
index ead2bd5aa7..38b917a1e5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2193,9 +2193,11 @@ static int coroutine_fn iscsi_co_copy_range_from(BlockDriverState *bs,
                                                  BdrvChild *dst,
                                                  uint64_t dst_offset,
                                                  uint64_t bytes,
-                                                 BdrvRequestFlags flags)
+                                                 BdrvRequestFlags read_flags,
+                                                 BdrvRequestFlags write_flags)
 {
-    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes, flags);
+    return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes,
+                                 read_flags, write_flags);
 }
 
 static struct scsi_task *iscsi_xcopy_task(int param_len)
@@ -2332,7 +2334,8 @@ static int coroutine_fn iscsi_co_copy_range_to(BlockDriverState *bs,
                                                BdrvChild *dst,
                                                uint64_t dst_offset,
                                                uint64_t bytes,
-                                               BdrvRequestFlags flags)
+                                               BdrvRequestFlags read_flags,
+                                               BdrvRequestFlags write_flags)
 {
     IscsiLun *dst_lun = dst->bs->opaque;
     IscsiLun *src_lun;
diff --git a/block/qcow2.c b/block/qcow2.c
index 33b61b7480..867ce02d50 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3253,13 +3253,14 @@ static int coroutine_fn
 qcow2_co_copy_range_from(BlockDriverState *bs,
                          BdrvChild *src, uint64_t src_offset,
                          BdrvChild *dst, uint64_t dst_offset,
-                         uint64_t bytes, BdrvRequestFlags flags)
+                         uint64_t bytes, BdrvRequestFlags read_flags,
+                         BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     BdrvChild *child = NULL;
-    BdrvRequestFlags cur_flags;
+    BdrvRequestFlags cur_write_flags;
 
     assert(!bs->encrypted);
     qemu_co_mutex_lock(&s->lock);
@@ -3268,7 +3269,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         uint64_t copy_offset = 0;
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
-        cur_flags = flags;
+        cur_write_flags = write_flags;
 
         ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &copy_offset);
         if (ret < 0) {
@@ -3280,20 +3281,20 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
-                    cur_flags |= BDRV_REQ_ZERO_WRITE;
+                    cur_write_flags |= BDRV_REQ_ZERO_WRITE;
                 } else {
                     child = bs->backing;
                     cur_bytes = MIN(cur_bytes, backing_length - src_offset);
                     copy_offset = src_offset;
                 }
             } else {
-                cur_flags |= BDRV_REQ_ZERO_WRITE;
+                cur_write_flags |= BDRV_REQ_ZERO_WRITE;
             }
             break;
 
         case QCOW2_CLUSTER_ZERO_PLAIN:
         case QCOW2_CLUSTER_ZERO_ALLOC:
-            cur_flags |= BDRV_REQ_ZERO_WRITE;
+            cur_write_flags |= BDRV_REQ_ZERO_WRITE;
             break;
 
         case QCOW2_CLUSTER_COMPRESSED:
@@ -3317,7 +3318,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         ret = bdrv_co_copy_range_from(child,
                                       copy_offset,
                                       dst, dst_offset,
-                                      cur_bytes, cur_flags);
+                                      cur_bytes, read_flags, cur_write_flags);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             goto out;
@@ -3338,7 +3339,8 @@ static int coroutine_fn
 qcow2_co_copy_range_to(BlockDriverState *bs,
                        BdrvChild *src, uint64_t src_offset,
                        BdrvChild *dst, uint64_t dst_offset,
-                       uint64_t bytes, BdrvRequestFlags flags)
+                       uint64_t bytes, BdrvRequestFlags read_flags,
+                       BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
@@ -3382,7 +3384,7 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
         ret = bdrv_co_copy_range_to(src, src_offset,
                                     bs->file,
                                     cluster_offset + offset_in_cluster,
-                                    cur_bytes, flags);
+                                    cur_bytes, read_flags, write_flags);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             goto fail;
diff --git a/block/raw-format.c b/block/raw-format.c
index b78da564d4..a3591985f6 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -498,9 +498,13 @@ static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 }
 
 static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
-                                               BdrvChild *src, uint64_t src_offset,
-                                               BdrvChild *dst, uint64_t dst_offset,
-                                               uint64_t bytes, BdrvRequestFlags flags)
+                                               BdrvChild *src,
+                                               uint64_t src_offset,
+                                               BdrvChild *dst,
+                                               uint64_t dst_offset,
+                                               uint64_t bytes,
+                                               BdrvRequestFlags read_flags,
+                                               BdrvRequestFlags write_flags)
 {
     int ret;
 
@@ -509,13 +513,17 @@ static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
         return ret;
     }
     return bdrv_co_copy_range_from(bs->file, src_offset, dst, dst_offset,
-                                   bytes, flags);
+                                   bytes, read_flags, write_flags);
 }
 
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
-                                             BdrvChild *src, uint64_t src_offset,
-                                             BdrvChild *dst, uint64_t dst_offset,
-                                             uint64_t bytes, BdrvRequestFlags flags)
+                                             BdrvChild *src,
+                                             uint64_t src_offset,
+                                             BdrvChild *dst,
+                                             uint64_t dst_offset,
+                                             uint64_t bytes,
+                                             BdrvRequestFlags read_flags,
+                                             BdrvRequestFlags write_flags)
 {
     int ret;
 
@@ -524,7 +532,7 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
         return ret;
     }
     return bdrv_co_copy_range_to(src, src_offset, bs->file, dst_offset, bytes,
-                                 flags);
+                                 read_flags, write_flags);
 }
 
 BlockDriver bdrv_raw = {
diff --git a/qemu-img.c b/qemu-img.c
index 7651d8172c..f4074ebf75 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1783,7 +1783,7 @@ static int coroutine_fn convert_co_copy_range(ImgConvertState *s, int64_t sector
 
         ret = blk_co_copy_range(blk, offset, s->target,
                                 sector_num << BDRV_SECTOR_BITS,
-                                n << BDRV_SECTOR_BITS, 0);
+                                n << BDRV_SECTOR_BITS, 0, 0);
         if (ret < 0) {
             return ret;
         }
-- 
2.13.6
