Received: from eggs.gnu.org ([2001:4830:134:3::10]:53845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN71D-0002hN-UE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN718-0005pS-OF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:31 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:34 -0600
Message-Id: <20181115020334.1189829-14-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/13] block: Enforce non-zero
 bl.max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

The raw format driver and the filter drivers default to picking
up the same limits as what they wrap, and I've audited that they
are otherwise simple enough in their passthrough to be 64-bit
clean; it's not worth changing their .bdrv_refresh_limits to
advertise anything different.  Previous patches changed all
remaining byte-based format and protocol drivers to supply an
explicit max_transfer consistent with an audit (or lack thereof)
of their code.  And for drivers still using sector-based
callbacks (gluster, iscsi, parallels, qed, replication, sheepdog,
ssh, vhdx), we can easily supply a 2G default limit while waiting
for a later per-driver conversion and auditing while moving to
byte-based callbacks.

With that, we can assert that max_transfer is now always set (either
by sector-based default, by merge with a backing layer, or by
explicit settings), and enforce that it be non-zero by the end
of bdrv_refresh_limits().  This in turn lets us simplify portions
of the block layer to use MIN() instead of MIN_NON_ZERO(), while
still fragmenting things to no larger than 2G chunks.  Also, we no
longer need to rewrite the driver's bl.max_transfer to a value below
2G.  There should be no semantic change from this patch, although
it does open the door if a future patch wants to let the block layer
choose a larger value than 2G while still honoring bl.max_transfer
for fragmentation.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

[hmm - in sending this email, I realize that I didn't specifically
check whether quorum always picks up a sane limit from its children,
since it is byte-based but lacks a .bdrv_refresh_limits]

 include/block/block_int.h | 10 +++++-----
 block/io.c                | 25 ++++++++++++-------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index b19d94dac5f..410553bb0cc 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -548,11 +548,11 @@ typedef struct BlockLimits {
     uint32_t opt_transfer;

     /* Maximal transfer length in bytes.  Need not be power of 2, but
-     * must be multiple of opt_transfer and bl.request_alignment, or 0
-     * for no 32-bit limit.  The block layer fragments all actions
-     * below 2G, so setting this value to anything larger than INT_MAX
-     * implies that the driver has been audited for 64-bit
-     * cleanness. */
+     * must be larger than opt_transfer and request_alignment (the
+     * block layer rounds it down as needed).  The block layer
+     * fragments all actions below 2G, so setting this value to
+     * anything larger than INT_MAX implies that the driver has been
+     * audited for 64-bit cleanness. */
     uint64_t max_transfer;

     /* memory alignment, in bytes so that no bounce buffer is needed */
diff --git a/block/io.c b/block/io.c
index 4911a1123eb..0024be0bf31 100644
--- a/block/io.c
+++ b/block/io.c
@@ -129,6 +129,9 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
     /* Default alignment based on whether driver has byte interface */
     bs->bl.request_alignment = (drv->bdrv_co_preadv ||
                                 drv->bdrv_aio_preadv) ? 1 : 512;
+    /* Default cap at 2G for drivers without byte interface */
+    if (bs->bl.request_alignment == 1)
+        bs->bl.max_transfer = BDRV_REQUEST_MAX_BYTES;

     /* Take some limits from the children as a default */
     if (bs->file) {
@@ -160,12 +163,11 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
         drv->bdrv_refresh_limits(bs, errp);
     }

-    /* Clamp max_transfer to 2G */
-    if (bs->bl.max_transfer > UINT32_MAX) {
-        bs->bl.max_transfer = QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
-                                              MAX(bs->bl.opt_transfer,
-                                                  bs->bl.request_alignment));
-    }
+    /* Check that we got a maximum cap, and round it down as needed */
+    assert(bs->bl.max_transfer);
+    bs->bl.max_transfer = QEMU_ALIGN_DOWN(bs->bl.max_transfer,
+                                          MAX(bs->bl.opt_transfer,
+                                              bs->bl.request_alignment));
 }

 /**
@@ -1145,8 +1147,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     int64_t cluster_bytes;
     size_t skip_bytes;
     int ret;
-    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
-                                    BDRV_REQUEST_MAX_BYTES);
+    int max_transfer = MIN(bs->bl.max_transfer, BDRV_REQUEST_MAX_BYTES);
     unsigned int progress = 0;

     if (!drv) {
@@ -1286,8 +1287,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || bytes == qiov->size);
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
-    max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
-                                   align);
+    max_transfer = QEMU_ALIGN_DOWN(MIN(bs->bl.max_transfer, INT_MAX), align);

     /* TODO: We would need a per-BDS .supported_read_flags and
      * potential fallback support, if we ever implement any read flags
@@ -1460,7 +1460,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
-    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
+    int max_transfer = MIN(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);

     if (!drv) {
         return -ENOMEDIUM;
@@ -1668,8 +1668,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert(!qiov || bytes == qiov->size);
-    max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
-                                   align);
+    max_transfer = QEMU_ALIGN_DOWN(MIN(bs->bl.max_transfer, INT_MAX), align);

     ret = bdrv_co_write_req_prepare(child, offset, bytes, req, flags);

-- 
2.17.2
