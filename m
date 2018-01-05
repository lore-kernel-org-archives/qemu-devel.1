Received: from eggs.gnu.org ([2001:4830:134:3::10]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawL-0002ta-0a
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawJ-00004v-Ga
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:16 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:37 -0600
Message-Id: <20180105225753.30509-5-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 04/20] gluster: Switch to
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
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the gluster driver accordingly.

In want_zero mode, we continue to report fine-grained hole
information (the caller wants as much mapping detail as possible);
but when not in that mode, the caller prefers larger *pnum and
merely cares about what offsets are allocated at this layer, rather
than where the holes live.  Since holes still read as zeroes at
this layer (rather than deferring to a backing layer), we can take
the shortcut of skipping find_allocation(), and merely state that
all bytes are allocated.

We can also drop redundant bounds checks that are already
guaranteed by the block layer.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: drop redundant code
v4: tweak commit message [Fam], rebase to interface tweak
v3: no change
v2: tweak comments [Prasanna], add mapping, drop R-b
---
 block/gluster.c | 70 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 0f4265a3a4..6388ced82e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1349,68 +1349,66 @@ exit:
 }

 /*
- * Returns the allocation status of the specified sectors.
+ * Returns the allocation status of the specified offset.
  *
- * If 'sector_num' is beyond the end of the disk image the return value is 0
- * and 'pnum' is set to 0.
+ * The block layer guarantees 'offset' and 'bytes' are within bounds.
  *
- * 'pnum' is set to the number of sectors (including and immediately following
- * the specified sector) that are known to be in the same
+ * 'pnum' is set to the number of bytes (including and immediately following
+ * the specified offset) that are known to be in the same
  * allocated/unallocated state.
  *
- * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
- * beyond the end of the disk image it will be clamped.
+ * 'bytes' is the max value 'pnum' should be set to.
  *
- * (Based on raw_co_get_block_status() from file-posix.c.)
+ * (Based on raw_co_block_status() from file-posix.c.)
  */
-static int64_t coroutine_fn qemu_gluster_co_get_block_status(
-        BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file)
+static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
+                                                     bool want_zero,
+                                                     int64_t offset,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     int64_t *map,
+                                                     BlockDriverState **file)
 {
     BDRVGlusterState *s = bs->opaque;
-    off_t start, data = 0, hole = 0;
-    int64_t total_size;
+    off_t data = 0, hole = 0;
     int ret = -EINVAL;

     if (!s->fd) {
         return ret;
     }

-    start = sector_num * BDRV_SECTOR_SIZE;
-    total_size = bdrv_getlength(bs);
-    if (total_size < 0) {
-        return total_size;
-    } else if (start >= total_size) {
-        *pnum = 0;
-        return 0;
-    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
-        nb_sectors = DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SIZE);
+    if (!want_zero) {
+        *pnum = bytes;
+        *map = offset;
+        *file = bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }

-    ret = find_allocation(bs, start, &data, &hole);
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

+    *map = offset;
     *file = bs;

-    return ret | BDRV_BLOCK_OFFSET_VALID | start;
+    return ret | BDRV_BLOCK_OFFSET_VALID;
 }


@@ -1438,7 +1436,7 @@ static BlockDriver bdrv_gluster = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1466,7 +1464,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1494,7 +1492,7 @@ static BlockDriver bdrv_gluster_unix = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1528,7 +1526,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

-- 
2.14.3
