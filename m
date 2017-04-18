Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I27-00059W-79
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I26-0003fV-10
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:32 -0500
Message-Id: <20170418013356.3578-8-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 07/31] block: Switch bdrv_co_get_block_status()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change), and as with its public counterpart,
rename to bdrv_co_block_status() to make the compiler enforce that
we catch all uses.  For now, we assert that callers still pass
aligned data, but ultimately, this will be the function where we
hand off to a byte-based driver callback, and will eventually need
to add logic to ensure we round calls according to the driver's
request_alignment then touch up the result handed back to the
caller, if we start permitting a caller to pass unaligned offsets.

While at it, adjust the function to accept NULL for pnum or file,
while still guaranteeing the driver callback has a non-NULL pointer
to write into.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 88 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5cdb1f0..e804bdd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1696,69 +1696,83 @@ typedef struct BdrvCoGetBlockStatusData {
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
- * If 'sector_num' is beyond the end of the disk image the return value is 0
+ * If 'offset' is beyond the end of the disk image the return value is 0
  * and 'pnum' is set to 0.
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
  * beyond the end of the disk image it will be clamped.
  *
- * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
- * points to the BDS which the sector range is allocated in.
+ * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, and
+ * 'file' is not NULL, then *file points to the BDS which owns the allocated
+ * sector that contains offset.
  */
-static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
-                                                     int64_t sector_num,
-                                                     int nb_sectors, int *pnum,
-                                                     BlockDriverState **file)
+static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
+                                                 int64_t offset, int64_t bytes,
+                                                 int64_t *pnum,
+                                                 BlockDriverState **file)
 {
-    int64_t total_sectors;
-    int64_t n;
+    int64_t total_size;
+    int64_t n; /* bytes */
     int64_t ret, ret2;
+    int count; /* sectors */
+    BlockDriverState *tmp_file;

-    total_sectors = bdrv_nb_sectors(bs);
-    if (total_sectors < 0) {
-        return total_sectors;
+    total_size = bdrv_getlength(bs);
+    if (total_size < 0) {
+        return total_size;
     }

-    if (sector_num >= total_sectors) {
+    if (!pnum) {
+        pnum = &n;
+    }
+    if (offset >= total_size) {
         *pnum = 0;
         return 0;
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
         if (bs->drv->protocol_name) {
-            ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+            ret |= BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);
         }
         return ret;
     }

+    if (!file) {
+        file = &tmp_file;
+    }
     *file = NULL;
     bdrv_inc_in_flight(bs);
-    ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
+    /* TODO: Rather than require aligned offsets, we could instead
+     * round to the driver's request_alignment here, then touch up
+     * count afterwards back to the caller's expectations.  But first
+     * we want to switch the driver callback to likewise be
+     * byte-based. */
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
+                                            bytes >> BDRV_SECTOR_BITS, &count,
                                             file);
     if (ret < 0) {
         *pnum = 0;
         goto out;
     }
+    *pnum = count * BDRV_SECTOR_SIZE;

     if (ret & BDRV_BLOCK_RAW) {
-        int64_t bytes = *pnum * BDRV_SECTOR_SIZE;
-
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
         ret = bdrv_block_status(*file, ret & BDRV_BLOCK_OFFSET_MASK,
-                                bytes, &bytes, file);
-        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
-        *pnum = bytes >> BDRV_SECTOR_BITS;
+                                *pnum, pnum, file);
+        assert(QEMU_IS_ALIGNED(*pnum, BDRV_SECTOR_SIZE));
         goto out;
     }

@@ -1769,8 +1783,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
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
@@ -1779,11 +1793,10 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     if (*file && *file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
-        BlockDriverState *file2;
-        int file_pnum;
+        int64_t file_pnum;

-        ret2 = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                        *pnum, &file_pnum, &file2);
+        ret2 = bdrv_co_block_status(*file, ret & BDRV_BLOCK_OFFSET_MASK,
+                                    *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -1818,7 +1831,12 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        ret = bdrv_co_get_block_status(p, sector_num, nb_sectors, pnum, file);
+        int64_t count;
+
+        ret = bdrv_co_block_status(p, sector_num * BDRV_SECTOR_SIZE,
+                                   nb_sectors * BDRV_SECTOR_SIZE, &count,
+                                   file);
+        *pnum = count >> BDRV_SECTOR_BITS;
         if (ret < 0 || ret & BDRV_BLOCK_ALLOCATED) {
             break;
         }
-- 
2.9.3
