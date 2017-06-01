Received: from eggs.gnu.org ([2001:4830:134:3::10]:51515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoW-00007x-BM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoT-0004dx-MO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:04 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com
	([40.107.4.133]:34349
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoT-0004d9-Ez
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:01 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:19 +0300
Message-ID: <1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 01/15] block: introduce BDRV_REQ_ALLOCATE
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
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

The flag is supposed to indicate that the region of the disk image has
to be sufficiently allocated so it reads as zeroes. The call with the flag
set has to return -ENOTSUP if allocation cannot be done efficiently
(i.e. without falling back to writing actual buffers)

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/io.c            | 19 ++++++++++++++++---
 block/trace-events    |  1 +
 include/block/block.h |  6 +++++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index ed31810..d47efa9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1272,7 +1272,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP) {
+        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
@@ -1355,8 +1355,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
-        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
-        qemu_iovec_is_zero(qiov)) {
+        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE) &&
+        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
         flags |= BDRV_REQ_ZERO_WRITE;
         if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
             flags |= BDRV_REQ_MAY_UNMAP;
@@ -1436,6 +1436,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     assert(flags & BDRV_REQ_ZERO_WRITE);
     if (head_padding_bytes || tail_padding_bytes) {
+        if (flags & BDRV_REQ_ALLOCATE) {
+            return -ENOTSUP;
+        }
         buf = qemu_blockalign(bs, align);
         iov = (struct iovec) {
             .iov_base   = buf,
@@ -1534,6 +1537,11 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         return ret;
     }
 
+    if (qiov && flags & BDRV_REQ_ALLOCATE) {
+        /* allocation request with qiov provided doesn't make much sense */
+        return -ENOTSUP;
+    }
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
@@ -1665,6 +1673,11 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, count, flags);
 
+    if (flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE) {
+        /* nonsense */
+        return -ENOTSUP;
+    }
+
     if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
diff --git a/block/trace-events b/block/trace-events
index 9a71c7f..a15c2cc 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -15,6 +15,7 @@ bdrv_aio_writev(void *bs, int64_t sector_num, int nb_sectors, void *opaque) "bs
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
+bdrv_co_allocate(void *bs, int64_t offset, int count) "bs %p offset %"PRId64" count %d"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
 
 # block/stream.c
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e9..53a357c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -65,9 +65,13 @@ typedef enum {
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
+    /* BDRV_REQ_ALLOCATE is used to indicate that the driver is to
+     * efficiently allocate the space so it reads as zeroes or return an error
+     */
+    BDRV_REQ_ALLOCATE           = 0x40,
 
     /* Mask of valid flags */
-    BDRV_REQ_MASK               = 0x3f,
+    BDRV_REQ_MASK               = 0x7f,
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
-- 
2.7.4
