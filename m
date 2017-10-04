Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjK-0000ju-JH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzYjJ-0001Mq-2O
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:44:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 20:43:46 -0500
Message-Id: <20171004014347.25099-5-eblake@redhat.com>
In-Reply-To: <20171004014347.25099-1-eblake@redhat.com>
References: <20171004014347.25099-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] block: Perform copy-on-read in loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Improve our braindead copy-on-read implementation.  Pre-patch,
we have multiple issues:
- we create a bounce buffer and perform a write for the entire
request, even if the active image already has 99% of the
clusters occupied, and really only needs to copy-on-read the
remaining 1% of the clusters
- our bounce buffer was as large as the read request, and can
needlessly exhaust our memory by using double the memory of
the request size (the original request plus our bounce buffer),
rather than a capped maximum overhead beyond the original
- if a driver has a max_transfer limit, we are bypassing the
normal code in bdrv_aligned_preadv() that fragments to that
limit, and instead attempt to read the entire buffer from the
driver in one go, which some drivers may assert on
- a client can request a large request of nearly 2G such that
rounding the request out to cluster boundaries results in a
byte count larger than 2G.  While this cannot exceed 32 bits,
it DOES have some follow-on problems:
-- the call to bdrv_driver_pread() can assert for exceeding
BDRV_REQUEST_MAX_BYTES, if the driver is old and lacks
.bdrv_co_preadv
-- if the buffer is all zeroes, the subsequent call to
bdrv_co_do_pwrite_zeroes is a no-op due to a negative size,
which means we did not actually copy on read

Fix all of these issues by breaking up the action into a loop,
where each iteration is capped to sane limits.  Also, querying
the allocation status allows us to optimize: when data is
already present in the active layer, we don't need to bounce.

Note that the code has a telling comment that copy-on-read
should probably be a filter driver rather than a bolt-in hack
in io.c; but that remains a task for another day.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: avoid uninit ret on 0-length op [patchew, Kevin]
---
 block/io.c | 120 +++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index d656a0485b..1e246315a7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -34,6 +34,9 @@

 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */

+/* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
+#define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);

@@ -945,11 +948,14 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,

     BlockDriver *drv = bs->drv;
     struct iovec iov;
-    QEMUIOVector bounce_qiov;
+    QEMUIOVector local_qiov;
     int64_t cluster_offset;
     unsigned int cluster_bytes;
     size_t skip_bytes;
     int ret;
+    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
+                                    BDRV_REQUEST_MAX_BYTES);
+    unsigned int progress = 0;

     /* FIXME We cannot require callers to have write permissions when all they
      * are doing is a read request. If we did things right, write permissions
@@ -961,53 +967,95 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     // assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));

     /* Cover entire cluster so no additional backing file I/O is required when
-     * allocating cluster in the image file.
+     * allocating cluster in the image file.  Note that this value may exceed
+     * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
+     * is one reason we loop rather than doing it all at once.
      */
     bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
+    skip_bytes = offset - cluster_offset;

     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
                                    cluster_offset, cluster_bytes);

-    iov.iov_len = cluster_bytes;
-    iov.iov_base = bounce_buffer = qemu_try_blockalign(bs, iov.iov_len);
+    bounce_buffer = qemu_try_blockalign(bs,
+                                        MIN(MIN(max_transfer, cluster_bytes),
+                                            MAX_BOUNCE_BUFFER));
     if (bounce_buffer == NULL) {
         ret = -ENOMEM;
         goto err;
     }

-    qemu_iovec_init_external(&bounce_qiov, &iov, 1);
+    while (cluster_bytes) {
+        int64_t pnum;

-    ret = bdrv_driver_preadv(bs, cluster_offset, cluster_bytes,
-                             &bounce_qiov, 0);
-    if (ret < 0) {
-        goto err;
-    }
+        ret = bdrv_is_allocated(bs, cluster_offset,
+                                MIN(cluster_bytes, max_transfer), &pnum);
+        if (ret < 0) {
+            /* Safe to treat errors in querying allocation as if
+             * unallocated; we'll probably fail again soon on the
+             * read, but at least that will set a decent errno.
+             */
+            pnum = MIN(cluster_bytes, max_transfer);
+        }

-    bdrv_debug_event(bs, BLKDBG_COR_WRITE);
-    if (drv->bdrv_co_pwrite_zeroes &&
-        buffer_is_zero(bounce_buffer, iov.iov_len)) {
-        /* FIXME: Should we (perhaps conditionally) be setting
-         * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
-         * that still correctly reads as zero? */
-        ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, cluster_bytes, 0);
-    } else {
-        /* This does not change the data on the disk, it is not necessary
-         * to flush even in cache=writethrough mode.
-         */
-        ret = bdrv_driver_pwritev(bs, cluster_offset, cluster_bytes,
-                                  &bounce_qiov, 0);
-    }
+        assert(skip_bytes < pnum);

-    if (ret < 0) {
-        /* It might be okay to ignore write errors for guest requests.  If this
-         * is a deliberate copy-on-read then we don't want to ignore the error.
-         * Simply report it in all cases.
-         */
-        goto err;
-    }
+        if (ret <= 0) {
+            /* Must copy-on-read; use the bounce buffer */
+            iov.iov_base = bounce_buffer;
+            iov.iov_len = pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
+            qemu_iovec_init_external(&local_qiov, &iov, 1);
+
+            ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
+                                     &local_qiov, 0);
+            if (ret < 0) {
+                goto err;
+            }

-    skip_bytes = offset - cluster_offset;
-    qemu_iovec_from_buf(qiov, 0, bounce_buffer + skip_bytes, bytes);
+            bdrv_debug_event(bs, BLKDBG_COR_WRITE);
+            if (drv->bdrv_co_pwrite_zeroes &&
+                buffer_is_zero(bounce_buffer, pnum)) {
+                /* FIXME: Should we (perhaps conditionally) be setting
+                 * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
+                 * that still correctly reads as zero? */
+                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum, 0);
+            } else {
+                /* This does not change the data on the disk, it is not
+                 * necessary to flush even in cache=writethrough mode.
+                 */
+                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                                          &local_qiov, 0);
+            }
+
+            if (ret < 0) {
+                /* It might be okay to ignore write errors for guest
+                 * requests.  If this is a deliberate copy-on-read
+                 * then we don't want to ignore the error.  Simply
+                 * report it in all cases.
+                 */
+                goto err;
+            }
+
+            qemu_iovec_from_buf(qiov, progress, bounce_buffer + skip_bytes,
+                                pnum - skip_bytes);
+        } else {
+            /* Read directly into the destination */
+            qemu_iovec_init(&local_qiov, qiov->niov);
+            qemu_iovec_concat(&local_qiov, qiov, progress, pnum - skip_bytes);
+            ret = bdrv_driver_preadv(bs, offset + progress, local_qiov.size,
+                                     &local_qiov, 0);
+            qemu_iovec_destroy(&local_qiov);
+            if (ret < 0) {
+                goto err;
+            }
+        }
+
+        cluster_offset += pnum;
+        cluster_bytes -= pnum;
+        progress += pnum - skip_bytes;
+        skip_bytes = 0;
+    }
+    ret = 0;

 err:
     qemu_vfree(bounce_buffer);
@@ -1213,9 +1261,6 @@ int coroutine_fn bdrv_co_readv(BdrvChild *child, int64_t sector_num,
     return bdrv_co_do_readv(child, sector_num, nb_sectors, qiov, 0);
 }

-/* Maximum buffer for write zeroes fallback, in bytes */
-#define MAX_WRITE_ZEROES_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
-
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1230,8 +1275,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
-    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
-                                    MAX_WRITE_ZEROES_BOUNCE_BUFFER);
+    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);

     assert(alignment % bs->bl.request_alignment == 0);
     head = offset % alignment;
-- 
2.13.6
