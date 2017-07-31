Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSj-0004nr-Bg
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSg-0005Ng-Er
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:33 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:21:53 +0300
Message-Id: <1501518125-29851-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 01/13] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The flag is supposed to indicate that the region of the disk image has
to be sufficiently allocated so it reads as zeroes. The call with the flag
set has to return -ENOTSUP if allocation cannot be done efficiently
(i.e. without falling back to writing actual buffers)

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 include/block/block.h     |  6 +++++-
 include/block/block_int.h |  2 +-
 block/io.c                | 20 +++++++++++++++++---
 block/trace-events        |  1 +
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 34770bb..dbce3c9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -65,9 +65,13 @@ typedef enum {
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
+    /* The BDRV_REQ_ALLOCATE flag is used to indicate that the driver has to
+     * efficiently allocate the space so it reads as zeroes, or return an error.
+     */
+    BDRV_REQ_ALLOCATE           = 0x40,
 
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3f,
+    BDRV_REQ_MASK               = 0x7f,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7..1883143 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -578,7 +578,7 @@ struct BlockDriverState {
     /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
     unsigned int supported_write_flags;
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
-     * BDRV_REQ_MAY_UNMAP) */
+     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */
     unsigned int supported_zero_flags;
 
     /* the following member gives a name to every node on the bs graph. */
diff --git a/block/io.c b/block/io.c
index d9dc822..b3f9d61 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1275,7 +1275,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP) {
+        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
@@ -1362,8 +1362,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
-        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov)) {
+        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE) &&
+        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
         flags |= BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
             flags |= BDRV_REQ_MAY_UNMAP;
@@ -1441,6 +1441,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
+        if (flags & BDRV_REQ_ALLOCATE) {
+            return -ENOTSUP;
+        }
         buf = qemu_blockalign(bs, align);
         iov = (struct iovec) {
             .iov_base   = buf,
@@ -1539,6 +1542,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         return ret;
     }
 
+    /* allocation request with qiov provided doesn't make much sense */
+    assert(!(qiov && flags & BDRV_REQ_ALLOCATE));
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
@@ -1670,6 +1676,14 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
+    assert(!(flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE));
+
+    if (flags & BDRV_REQ_ALLOCATE &&
+        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
+    {
+        return -ENOTSUP;
+    }
+
     if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
diff --git a/block/trace-events b/block/trace-events
index 8d10a82..b9746a7 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -12,6 +12,7 @@ blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flag
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
+bdrv_co_allocate(void *bs, int64_t offset, int count) "bs %p offset %"PRId64" count %d"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
 
 # block/stream.c
-- 
2.7.4
