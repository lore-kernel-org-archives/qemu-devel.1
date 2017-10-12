Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ik0-0004bE-J5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ijy-0007jM-Uq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:01:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 12 Oct 2017 13:59:00 -0500
Message-Id: <20171012185916.22776-5-eblake@redhat.com>
In-Reply-To: <20171012185916.22776-1-eblake@redhat.com>
References: <20171012185916.22776-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/20] gluster: Switch to
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

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

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: tweak commit message [Fam], rebase to interface tweak
v3: no change
v2: tweak comments [Prasanna], add mapping, drop R-b
---
 block/gluster.c | 67 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 0f4265a3a4..518f1984de 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1349,26 +1349,30 @@ exit:
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
+    off_t data = 0, hole = 0;
     int64_t total_size;
     int ret = -EINVAL;

@@ -1376,41 +1380,48 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
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
+    if (!want_zero) {
+        *pnum = bytes;
+        *map = offset;
+        *file = bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
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

+    *map = offset;
     *file = bs;

-    return ret | BDRV_BLOCK_OFFSET_VALID | start;
+    return ret | BDRV_BLOCK_OFFSET_VALID;
 }


@@ -1438,7 +1449,7 @@ static BlockDriver bdrv_gluster = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1466,7 +1477,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1494,7 +1505,7 @@ static BlockDriver bdrv_gluster_unix = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

@@ -1528,7 +1539,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
 #endif
-    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
+    .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
 };

-- 
2.13.6
