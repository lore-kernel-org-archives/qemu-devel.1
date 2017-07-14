Received: from eggs.gnu.org ([2001:4830:134:3::10]:46451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVF-0003ah-HM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVE-0003j7-C4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:40 -0500
Message-Id: <20170714121457.10322-4-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/20] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the file protocol driver accordingly.  In mapping
mode, note that the entire file is reported as allocated, so we can
take a shortcut and skip lseek().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: tweak comment, add mapping support
---
 block/file-posix.c | 57 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cfbb236..765a440 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2104,24 +2104,25 @@ static int find_allocation(BlockDriverState *bs, off_t start,
 }

 /*
- * Returns the allocation status of the specified sectors.
+ * Returns the allocation status of the specified offset.
  *
- * If 'sector_num' is beyond the end of the disk image the return value is 0
+ * If 'offset' is beyond the end of the disk image the return value is 0
  * and 'pnum' is set to 0.
  *
- * 'pnum' is set to the number of sectors (including and immediately following
- * the specified sector) that are known to be in the same
+ * 'pnum' is set to the number of bytes (including and immediately following
+ * the specified offset) that are known to be in the same
  * allocated/unallocated state.
  *
- * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
+ * 'bytes' is the max value 'pnum' should be set to.  If bytes goes
  * beyond the end of the disk image it will be clamped.
  */
-static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
-                                                    int64_t sector_num,
-                                                    int nb_sectors, int *pnum,
-                                                    BlockDriverState **file)
+static int64_t coroutine_fn raw_co_block_status(BlockDriverState *bs,
+                                                bool mapping,
+                                                int64_t offset,
+                                                int64_t bytes, int64_t *pnum,
+                                                BlockDriverState **file)
 {
-    off_t start, data = 0, hole = 0;
+    off_t data = 0, hole = 0;
     int64_t total_size;
     int ret;

@@ -2130,39 +2131,45 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
         return ret;
     }

-    start = sector_num * BDRV_SECTOR_SIZE;
     total_size = bdrv_getlength(bs);
     if (total_size < 0) {
         return total_size;
-    } else if (start >= total_size) {
+    } else if (offset >= total_size) {
         *pnum = 0;
         return 0;
-    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
-        nb_sectors = DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SIZE);
+    } else if (offset + bytes > total_size) {
+        bytes = total_size - offset;
     }

-    ret = find_allocation(bs, start, &data, &hole);
+    if (!mapping) {
+        *pnum = bytes;
+        *file = bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID |
+            (offset & BDRV_BLOCK_OFFSET_MASK);
+    }
+
+    ret = find_allocation(bs, offset, &data, &hole);
     if (ret == -ENXIO) {
         /* Trailing hole */
-        *pnum = nb_sectors;
+        *pnum = bytes;
         ret = BDRV_BLOCK_ZERO;
     } else if (ret < 0) {
         /* No info available, so pretend there are no holes */
-        *pnum = nb_sectors;
+        *pnum = bytes;
         ret = BDRV_BLOCK_DATA;
-    } else if (data == start) {
-        /* On a data extent, compute sectors to the end of the extent,
+    } else if (data == offset) {
+        /* On a data extent, compute bytes to the end of the extent,
          * possibly including a partial sector at EOF. */
-        *pnum = MIN(nb_sectors, DIV_ROUND_UP(hole - start, BDRV_SECTOR_SIZE));
+        *pnum = MIN(bytes, hole - offset);
         ret = BDRV_BLOCK_DATA;
     } else {
-        /* On a hole, compute sectors to the beginning of the next extent.  */
-        assert(hole == start);
-        *pnum = MIN(nb_sectors, (data - start) / BDRV_SECTOR_SIZE);
+        /* On a hole, compute bytes to the beginning of the next extent.  */
+        assert(hole == offset);
+        *pnum = MIN(bytes, data - offset);
         ret = BDRV_BLOCK_ZERO;
     }
     *file = bs;
-    return ret | BDRV_BLOCK_OFFSET_VALID | start;
+    return ret | BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);
 }

 static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,
@@ -2256,7 +2263,7 @@ BlockDriver bdrv_file = {
     .bdrv_close = raw_close,
     .bdrv_create = raw_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = raw_co_get_block_status,
+    .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,

     .bdrv_co_preadv         = raw_co_preadv,
-- 
2.9.4
