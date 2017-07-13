Received: from eggs.gnu.org ([2001:4830:134:3::10]:53951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLJ-0004wM-2H
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLF-0005rR-Uh
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:46:56 -0500
Message-Id: <20170713154711.32374-9-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/23] block: Switch
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

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
v3: rebase to allocation/mapping sense change, clamp bytes to 32-bits
when needed, drop R-b
v2: rebase to earlier changes
---
 block/io.c | 91 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/block/io.c b/block/io.c
index dcea3e3..6be3650 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1724,42 +1724,43 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * possible; otherwise, the result may omit that bit particularly if
  * it allows for a larger value in 'pnum'.
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
+    int count; /* sectors */

     assert(pnum);
-    total_sectors = bdrv_nb_sectors(bs);
-    if (total_sectors < 0) {
+    total_size = bdrv_getlength(bs);
+    if (total_size < 0) {
         if (file) {
             *file = NULL;
         }
-        return total_sectors;
+        return total_size;
     }

-    if (sector_num >= total_sectors) {
+    if (offset >= total_size) {
         *pnum = 0;
         if (file) {
             *file = NULL;
@@ -1767,19 +1768,19 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         return BDRV_BLOCK_EOF;
     }

-    n = total_sectors - sector_num;
-    if (n < nb_sectors) {
-        nb_sectors = n;
+    n = total_size - offset;
+    if (n < bytes) {
+        bytes = n;
     }

     if (!bs->drv->bdrv_co_get_block_status) {
-        *pnum = nb_sectors;
+        *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
-        if (sector_num + nb_sectors == total_sectors) {
+        if (offset + bytes == total_size) {
             ret |= BDRV_BLOCK_EOF;
         }
         if (bs->drv->protocol_name) {
-            ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+            ret |= BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);
             if (file) {
                 *file = bs;
             }
@@ -1790,18 +1791,28 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     }

     bdrv_inc_in_flight(bs);
-    ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
+    /*
+     * TODO: Rather than require aligned offsets, we could instead
+     * round to the driver's request_alignment here, then touch up
+     * count afterwards back to the caller's expectations.
+     */
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
+    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
+                                            bytes >> BDRV_SECTOR_BITS, &count,
                                             &local_file);
     if (ret < 0) {
         *pnum = 0;
         goto out;
     }
+    *pnum = count * BDRV_SECTOR_SIZE;

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_get_block_status(local_file, mapping,
-                                       ret >> BDRV_SECTOR_BITS,
-                                       *pnum, pnum, &local_file);
+        ret = bdrv_co_block_status(local_file, mapping,
+                                   ret & BDRV_BLOCK_OFFSET_MASK,
+                                   *pnum, pnum, &local_file);
+        assert(QEMU_IS_ALIGNED(*pnum, BDRV_SECTOR_SIZE));
         goto out;
     }

@@ -1812,8 +1823,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
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
@@ -1822,11 +1833,11 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     if (mapping && local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
-        int file_pnum;
+        int64_t file_pnum;

-        ret2 = bdrv_co_get_block_status(local_file, mapping,
-                                        ret >> BDRV_SECTOR_BITS,
-                                        *pnum, &file_pnum, NULL);
+        ret2 = bdrv_co_block_status(local_file, mapping,
+                                    ret & BDRV_BLOCK_OFFSET_MASK,
+                                    *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -1852,7 +1863,7 @@ out:
         *file = local_file;
     }
     bdrv_dec_in_flight(bs);
-    if (ret >= 0 && sector_num + *pnum == total_sectors) {
+    if (ret >= 0 && offset + *pnum == total_size) {
         ret |= BDRV_BLOCK_EOF;
     }
     return ret;
@@ -1872,11 +1883,17 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

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
2.9.4
