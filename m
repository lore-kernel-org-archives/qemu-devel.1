Received: from eggs.gnu.org ([2001:4830:134:3::10]:34326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0J-00011b-2u
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0H-00069b-MB
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 21:00:33 -0500
Message-Id: <20171004020048.26379-9-eblake@redhat.com>
In-Reply-To: <20171004020048.26379-1-eblake@redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/23] block: Switch
 bdrv_co_get_block_status() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change); and as with its public counterpart,
rename to bdrv_co_block_status() to make the compiler enforce that
we catch all uses.  For now, we assert that callers still pass
aligned data, but ultimately, this will be the function where we
hand off to a byte-based driver callback, and will eventually need
to add logic to ensure we round calls according to the driver's
request_alignment then touch up the result handed back to the
caller, to start permitting a caller to pass unaligned offsets.

Note that we are now prepared to accepts 'bytes' larger than INT_MAX;
this is okay as long as we clamp things internally before violating
any 32-bit limits, and makes no difference to how a client will
use the information (clients looping over the entire file must
already be prepared for consecutive calls to return the same status,
as drivers are already free to return shorter-than-maximal status
due to any other convenient split points, such as when the L2 table
crosses cluster boundaries in qcow2).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: rebase to earlier changes in 1/23, add comment
v4: no change
v3: rebase to allocation/mapping sense change, clamp bytes to 32-bits
when needed, drop R-b
v2: rebase to earlier changes
---
 block/io.c | 103 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 41 deletions(-)

diff --git a/block/io.c b/block/io.c
index ab1853dc2d..b879e26154 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1792,76 +1792,91 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
  * bits particularly if it allows for a larger value in 'pnum'.
  *
- * If 'sector_num' is beyond the end of the disk image the return value is
+ * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
- * 'pnum' is set to the number of sectors (including and immediately following
- * the specified sector) that are known to be in the same
- * allocated/unallocated state.
+ * 'pnum' is set to the number of bytes (including and immediately following
+ * the specified offset) that are known to be in the same
+ * allocated/unallocated state.  It may be NULL.
  *
- * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
+ * 'bytes' is the max value 'pnum' should be set to.  If bytes goes
  * beyond the end of the disk image it will be clamped; if 'pnum' is set to
  * the end of the image, then the returned value will include BDRV_BLOCK_EOF.
  *
  * If returned value is positive, BDRV_BLOCK_OFFSET_VALID bit is set, and
- * 'file' is non-NULL, then '*file' points to the BDS which the sector range
- * is allocated in.
+ * 'file' is non-NULL, then '*file' points to the BDS which owns the
+ * allocated sector that contains offset.
  */
-static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
-                                                     bool mapping,
-                                                     int64_t sector_num,
-                                                     int nb_sectors, int *pnum,
-                                                     BlockDriverState **file)
+static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
+                                                 bool mapping,
+                                                 int64_t offset, int64_t bytes,
+                                                 int64_t *pnum,
+                                                 BlockDriverState **file)
 {
-    int64_t total_sectors;
-    int64_t n;
+    int64_t total_size;
+    int64_t n; /* bytes */
     int64_t ret, ret2;
     BlockDriverState *local_file = NULL;
-    int local_pnum = 0;
+    int64_t local_pnum = 0;
+    int count; /* sectors */

     assert(pnum);
-    total_sectors = bdrv_nb_sectors(bs);
-    if (total_sectors < 0) {
-        ret = total_sectors;
+    total_size = bdrv_getlength(bs);
+    if (total_size < 0) {
+        ret = total_size;
         goto early_out;
     }

-    if (sector_num >= total_sectors || !nb_sectors) {
-        ret = sector_num >= total_sectors ? BDRV_BLOCK_EOF : 0;
+    if (offset >= total_size || !bytes) {
+        ret = offset >= total_size ? BDRV_BLOCK_EOF : 0;
         goto early_out;
     }

-    n = total_sectors - sector_num;
-    if (n < nb_sectors) {
-        nb_sectors = n;
+    n = total_size - offset;
+    if (n < bytes) {
+        bytes = n;
     }

     if (!bs->drv->bdrv_co_get_block_status) {
-        local_pnum = nb_sectors;
+        local_pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
-        if (sector_num + nb_sectors == total_sectors) {
+        if (offset + bytes == total_size) {
             ret |= BDRV_BLOCK_EOF;
         }
         if (bs->drv->protocol_name) {
-            ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+            ret |= BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);
             local_file = bs;
         }
         goto early_out;
     }

     bdrv_inc_in_flight(bs);
-    ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors,
-                                            &local_pnum, &local_file);
+    /*
+     * TODO: Rather than require aligned offsets, we could instead
+     * round to the driver's request_alignment here, then touch up
+     * count afterwards back to the caller's expectations.
+     */
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    /*
+     * The contract allows us to return pnum smaller than bytes, even
+     * if the next query would see the same status; we truncate the
+     * request to avoid overflowing the driver's 32-bit interface.
+     */
+    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
+    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
+                                            bytes >> BDRV_SECTOR_BITS, &count,
+                                            &local_file);
     if (ret < 0) {
-        local_pnum = 0;
         goto out;
     }
+    local_pnum = count * BDRV_SECTOR_SIZE;

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_get_block_status(local_file, mapping,
-                                       ret >> BDRV_SECTOR_BITS,
-                                       local_pnum, &local_pnum, &local_file);
+        ret = bdrv_co_block_status(local_file, mapping,
+                                   ret & BDRV_BLOCK_OFFSET_MASK,
+                                   local_pnum, &local_pnum, &local_file);
+        assert(ret < 0 || QEMU_IS_ALIGNED(local_pnum, BDRV_SECTOR_SIZE));
         goto out;
     }

@@ -1872,8 +1887,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
             ret |= BDRV_BLOCK_ZERO;
         } else if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
-            int64_t nb_sectors2 = bdrv_nb_sectors(bs2);
-            if (nb_sectors2 >= 0 && sector_num >= nb_sectors2) {
+            int64_t size2 = bdrv_getlength(bs2);
+            if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
         }
@@ -1882,11 +1897,11 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     if (mapping && local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
-        int file_pnum;
+        int64_t file_pnum;

-        ret2 = bdrv_co_get_block_status(local_file, mapping,
-                                        ret >> BDRV_SECTOR_BITS,
-                                        local_pnum, &file_pnum, NULL);
+        ret2 = bdrv_co_block_status(local_file, mapping,
+                                    ret & BDRV_BLOCK_OFFSET_MASK,
+                                    local_pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -1909,7 +1924,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,

  out:
     bdrv_dec_in_flight(bs);
-    if (ret >= 0 && sector_num + local_pnum == total_sectors) {
+    if (ret >= 0 && offset + local_pnum == total_size) {
         ret |= BDRV_BLOCK_EOF;
     }
  early_out:
@@ -1934,11 +1949,17 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        ret = bdrv_co_get_block_status(p, mapping, sector_num, nb_sectors,
-                                       pnum, file);
+        int64_t count;
+
+        ret = bdrv_co_block_status(p, mapping,
+                                   sector_num * BDRV_SECTOR_SIZE,
+                                   nb_sectors * BDRV_SECTOR_SIZE, &count,
+                                   file);
         if (ret < 0) {
             break;
         }
+        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+        *pnum = count >> BDRV_SECTOR_BITS;
         if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
             /*
              * Reading beyond the end of the file continues to read
-- 
2.13.6
