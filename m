Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVG-0003bp-Op
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVF-0003k0-Ga
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:41 -0500
Message-Id: <20170714121457.10322-5-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/20] gluster: Switch to
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
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the gluster driver accordingly.  In mapping
mode, note that the entire file is reported as allocated, so we can
take a shortcut and skip find_allocation().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: tweak comments [Prasanna], add mapping, drop R-b
---
 block/gluster.c | 62 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index bfa4df1..6223ebd 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1353,26 +1353,26 @@ exit:
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
  *
- * (Based on raw_co_get_block_status() from file-posix.c.)
+ * (Based on raw_co_block_status() from file-posix.c.)
  */
-static int64_t coroutine_fn qemu_gluster_co_get_block_status(
-        BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file)
+static int64_t coroutine_fn qemu_gluster_co_block_status(
+        BlockDriverState *bs, bool mapping, int64_t offset, int64_t bytes,
+        int64_t *pnum, BlockDriverState **file)
 {
     BDRVGlusterState *s = bs->opaque;
-    off_t start, data = 0, hole = 0;
+    off_t data = 0, hole = 0;
     int64_t total_size;
     int ret = -EINVAL;

@@ -1380,41 +1380,47 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
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


@@ -1442,7 +1448,7 @@ static BlockDriver bdrv_gluster = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1470,7 +1476,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1498,7 +1504,7 @@ static BlockDriver bdrv_gluster_unix = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1532,7 +1538,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

-- 
2.9.4
