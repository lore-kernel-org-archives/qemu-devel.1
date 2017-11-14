Received: from eggs.gnu.org ([2001:4830:134:3::10]:48251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHT-0003AF-Rk
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEYHN-00079q-Sg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:17:23 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 14 Nov 2017 13:16:51 +0300
Message-Id: <1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/5] block: support compressed write for
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/io.c         | 30 ++++++++++++++++++++++++------
 block/trace-events |  2 +-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3d5ef2c..93c6b24 100644
--- a/block/io.c
+++ b/block/io.c
@@ -953,7 +953,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov)
+        int64_t offset, unsigned int bytes, QEMUIOVector *qiov, int flags)
 {
     BlockDriverState *bs = child->bs;
 
@@ -988,12 +988,13 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
      * allocating cluster in the image file.  Note that this value may exceed
      * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
      * is one reason we loop rather than doing it all at once.
+     * Also this is crucial for compressed copy-on-read.
      */
     bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
     skip_bytes = offset - cluster_offset;
 
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
-                                   cluster_offset, cluster_bytes);
+                                   cluster_offset, cluster_bytes, flags);
 
     bounce_buffer = qemu_try_blockalign(bs,
                                         MIN(MIN(max_transfer, cluster_bytes),
@@ -1041,8 +1042,13 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
-                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
-                                          &local_qiov, 0);
+                if (flags & BDRV_REQ_WRITE_COMPRESSED) {
+                    ret = bdrv_driver_pwritev_compressed(bs, cluster_offset,
+                                                         pnum, &local_qiov);
+                } else {
+                    ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                                              &local_qiov, 0);
+                }
             }
 
             if (ret < 0) {
@@ -1107,7 +1113,12 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
      * potential fallback support, if we ever implement any read flags
      * to pass through to drivers.  For now, there aren't any
      * passthrough flags.  */
-    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ)));
+    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
+                       BDRV_REQ_WRITE_COMPRESSED)));
+
+    /* write compressed only makes sense with copy on read */
+    assert(!(flags & BDRV_REQ_WRITE_COMPRESSED) ||
+           (flags & BDRV_REQ_COPY_ON_READ));
 
     /* Handle Copy on Read and associated serialisation */
     if (flags & BDRV_REQ_COPY_ON_READ) {
@@ -1132,7 +1143,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         }
 
         if (!ret || pnum != bytes) {
-            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
+            ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov, flags);
             goto out;
         }
     }
@@ -1209,6 +1220,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
         return ret;
     }
 
+    /* write compressed only makes sense with copy on read */
+    if ((flags & BDRV_REQ_WRITE_COMPRESSED) &&
+        !(flags & BDRV_REQ_COPY_ON_READ))
+    {
+        return -EINVAL;
+    }
+
     bdrv_inc_in_flight(bs);
 
     /* Don't do copy-on-read if we read data before write operation */
diff --git a/block/trace-events b/block/trace-events
index 11c8d5f..12fe188 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -12,7 +12,7 @@ blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flag
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes, int flags) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64" flags 0x%x"
 
 # block/stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-- 
2.7.4
