Received: from eggs.gnu.org ([2001:4830:134:3::10]:46421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVE-0003Zc-FB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVD-0003i5-6F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:39 -0500
Message-Id: <20170714121457.10322-3-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/20] block: Switch passthrough drivers to
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
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the generic helpers, and all passthrough clients
(blkdebug, commit, mirror) accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to master, retitle while merging blkdebug, commit, and mirror
---
 include/block/block_int.h | 26 ++++++++++++++------------
 block/io.c                | 30 ++++++++++++++++--------------
 block/blkdebug.c          | 19 ++++++++++---------
 block/commit.c            |  2 +-
 block/mirror.c            |  2 +-
 5 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index aeb2bf8..72b8b81 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -973,23 +973,25 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t *nperm, uint64_t *nshared);

 /*
- * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
  */
-int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
-                                                        int64_t sector_num,
-                                                        int nb_sectors,
-                                                        int *pnum,
-                                                        BlockDriverState **file);
+int64_t coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
+                                                    bool mapping,
+                                                    int64_t offset,
+                                                    int64_t bytes,
+                                                    int64_t *pnum,
+                                                    BlockDriverState **file);
 /*
- * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * Default implementation for drivers to pass bdrv_co_block_status() to
  * their backing file.
  */
-int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
-                                                           int64_t sector_num,
-                                                           int nb_sectors,
-                                                           int *pnum,
-                                                           BlockDriverState **file);
+int64_t coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
+                                                       bool mapping,
+                                                       int64_t offset,
+                                                       int64_t bytes,
+                                                       int64_t *pnum,
+                                                       BlockDriverState **file);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
diff --git a/block/io.c b/block/io.c
index 899a7b3..2e8ddd7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1684,30 +1684,32 @@ typedef struct BdrvCoBlockStatusData {
     bool done;
 } BdrvCoBlockStatusData;

-int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
-                                                        int64_t sector_num,
-                                                        int nb_sectors,
-                                                        int *pnum,
-                                                        BlockDriverState **file)
+int64_t coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
+                                                    bool mapping,
+                                                    int64_t offset,
+                                                    int64_t bytes,
+                                                    int64_t *pnum,
+                                                    BlockDriverState **file)
 {
     assert(bs->file && bs->file->bs);
-    *pnum = nb_sectors;
+    *pnum = bytes;
     *file = bs->file->bs;
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+        (offset & BDRV_BLOCK_OFFSET_MASK);
 }

-int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
-                                                           int64_t sector_num,
-                                                           int nb_sectors,
-                                                           int *pnum,
-                                                           BlockDriverState **file)
+int64_t coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
+                                                       bool mapping,
+                                                       int64_t offset,
+                                                       int64_t bytes,
+                                                       int64_t *pnum,
+                                                       BlockDriverState **file)
 {
     assert(bs->backing && bs->backing->bs);
-    *pnum = nb_sectors;
+    *pnum = bytes;
     *file = bs->backing->bs;
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+        (offset & BDRV_BLOCK_OFFSET_MASK);
 }

 /*
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 6b40a85..234c8fb9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -641,15 +641,16 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }

-static int64_t coroutine_fn blkdebug_co_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-    BlockDriverState **file)
+static int64_t coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
+                                                     bool mapping,
+                                                     int64_t offset,
+                                                     int64_t bytes,
+                                                     int64_t *pnum,
+                                                     BlockDriverState **file)
 {
-    assert(QEMU_IS_ALIGNED(sector_num | nb_sectors,
-                           DIV_ROUND_UP(bs->bl.request_alignment,
-                                        BDRV_SECTOR_SIZE)));
-    return bdrv_co_get_block_status_from_file(bs, sector_num, nb_sectors,
-                                              pnum, file);
+    assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+    return bdrv_co_block_status_from_file(bs, mapping, offset, bytes,
+                                          pnum, file);
 }

 static void blkdebug_close(BlockDriverState *bs)
@@ -921,7 +922,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
+    .bdrv_co_block_status   = blkdebug_co_block_status,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/block/commit.c b/block/commit.c
index f646c13..be90611 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -267,7 +267,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
diff --git a/block/mirror.c b/block/mirror.c
index 15b809e..d46dace 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1085,7 +1085,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
-- 
2.9.4
