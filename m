Received: from eggs.gnu.org ([2001:4830:134:3::10]:33621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWI-0002k4-RR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWD-0006fE-RA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:30 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Mar 2018 13:16:53 +0300
Message-Id: <1520849818-6915-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 4/9] block: introduce BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The flag is supposed to indicate that the region of the disk image has
to be sufficiently allocated so it reads as zeroes.

The call with the flag set must return -ENOTSUP if allocation cannot
be done efficiently.
This has to be made sure of by both
  - the drivers that support the flag
  - and the common block layer (so it will not fall back to any slowpath
    (like writing zero buffers) in case the driver does not support
    the flag).

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h     |  8 +++++++-
 include/block/block_int.h |  2 +-
 block/io.c                | 18 ++++++++++++++++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b6db95..9747632 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,9 +53,15 @@ typedef enum {
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
+    /* The BDRV_REQ_ALLOCATE flag is used to indicate that the driver has to
+     * efficiently allocate the space so it reads as zeroes, or return an error.
+     * Must be used together with BDRV_REQ_ZERO_WRITE.
+     * Contradictory to BDRV_REQ_MAY_UNMAP so the two must not be used together.
+     */
+    BDRV_REQ_ALLOCATE           = 0x40,
 
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3f,
+    BDRV_REQ_MASK               = 0x7f,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 64a5700..9495e35 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -648,7 +648,7 @@ struct BlockDriverState {
     /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
     unsigned int supported_write_flags;
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
-     * BDRV_REQ_MAY_UNMAP) */
+     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */
     unsigned int supported_zero_flags;
 
     /* the following member gives a name to every node on the bs graph. */
diff --git a/block/io.c b/block/io.c
index 2b09c65..c4f2a07 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1418,7 +1418,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP) {
+        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
@@ -1511,7 +1511,9 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
         qemu_iovec_is_zero(qiov)) {
         flags |= BDRV_REQ_ZERO_WRITE;
-        if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
+        if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
+            !(flags & BDRV_REQ_ALLOCATE))
+        {
             flags |= BDRV_REQ_MAY_UNMAP;
         }
     }
@@ -1587,6 +1589,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
+        if (flags & BDRV_REQ_ALLOCATE) {
+            return -ENOTSUP;
+        }
         buf = qemu_blockalign(bs, align);
         iov = (struct iovec) {
             .iov_base   = buf,
@@ -1672,6 +1677,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     bool use_local_qiov = false;
     int ret;
 
+    assert(!((flags & BDRV_REQ_ALLOCATE) && (flags & BDRV_REQ_MAY_UNMAP)));
+    assert(!((flags & BDRV_REQ_ALLOCATE) && !(flags & BDRV_REQ_ZERO_WRITE)));
+
     trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
 
     if (!bs->drv) {
@@ -1816,6 +1824,12 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
+    if ((flags & BDRV_REQ_ALLOCATE) &&
+        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
+    {
+        return -ENOTSUP;
+    }
+
     if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
-- 
2.7.4
