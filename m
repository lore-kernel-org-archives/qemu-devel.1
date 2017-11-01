Received: from eggs.gnu.org ([2001:4830:134:3::10]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCA-00086u-I9
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vC4-0006cF-Kq
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:46 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:43:56 +0300
Message-Id: <1509551048-129830-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 03/15] block: introduce BDRV_REQ_ALLOCATE
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
 include/block/block.h     |  6 +++++-
 include/block/block_int.h |  2 +-
 block/io.c                | 20 +++++++++++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index fbc21da..a291db9 100644
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
index a548277..3799f5f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -632,7 +632,7 @@ struct BlockDriverState {
     /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
     unsigned int supported_write_flags;
     /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
-     * BDRV_REQ_MAY_UNMAP) */
+     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */
     unsigned int supported_zero_flags;
 
     /* the following member gives a name to every node on the bs graph. */
diff --git a/block/io.c b/block/io.c
index 3d5ef2c..7506207 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1334,7 +1334,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP) {
+        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
@@ -1420,8 +1420,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
-        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov)) {
+        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE) &&
+        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
         flags |= BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
             flags |= BDRV_REQ_MAY_UNMAP;
@@ -1499,6 +1499,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
+        if (flags & BDRV_REQ_ALLOCATE) {
+            return -ENOTSUP;
+        }
         buf = qemu_blockalign(bs, align);
         iov = (struct iovec) {
             .iov_base   = buf,
@@ -1599,6 +1602,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         return ret;
     }
 
+    /* allocation request with qiov provided doesn't make much sense */
+    assert(!(qiov && (flags & BDRV_REQ_ALLOCATE)));
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
@@ -1728,6 +1734,14 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
+    assert(!((flags & BDRV_REQ_MAY_UNMAP) && (flags & BDRV_REQ_ALLOCATE)));
+
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
