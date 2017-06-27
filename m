Received: from eggs.gnu.org ([2001:4830:134:3::10]:60469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzG8-0003lV-L4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPzG7-0008Ng-Gn
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:47:00 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 28 Jun 2017 01:46:16 +0300
Message-Id: <20170627224616.18538-3-el13635@mail.ntua.gr>
In-Reply-To: <20170627224616.18538-1-el13635@mail.ntua.gr>
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 2/2] block: add default implementations for
 bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

bdrv_co_get_block_status_from_file() and
bdrv_co_get_block_status_from_backing() set *file to bs->file and
bs->backing respectively, so that bdrv_co_get_block_status() can recurse
to them. Future block drivers won't have to duplicate code to implement
this.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/blkdebug.c          | 12 +-----------
 block/commit.c            | 12 +-----------
 block/io.c                | 24 ++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 include/block/block_int.h | 16 ++++++++++++++++
 5 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index b25856c4..f1539db6 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -641,16 +641,6 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
-static int64_t coroutine_fn blkdebug_co_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-    BlockDriverState **file)
-{
-    *pnum = nb_sectors;
-    *file = bs->file->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-        (sector_num << BDRV_SECTOR_BITS);
-}
-
 static void blkdebug_close(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -925,7 +915,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
+    .bdrv_co_get_block_status = bdrv_co_get_block_status_from_file,
 
     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/block/commit.c b/block/commit.c
index 524bd549..5b04f832 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -247,16 +247,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
-static int64_t coroutine_fn bdrv_commit_top_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-    BlockDriverState **file)
-{
-    *pnum = nb_sectors;
-    *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
-}
-
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
     bdrv_refresh_filename(bs->backing->bs);
@@ -282,7 +272,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
diff --git a/block/io.c b/block/io.c
index c1b73226..aec520b4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1706,6 +1706,30 @@ typedef struct BdrvCoGetBlockStatusData {
     bool done;
 } BdrvCoGetBlockStatusData;
 
+int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
+                                                     int64_t sector_num,
+                                                     int nb_sectors, int *pnum,
+                                                     BlockDriverState **file)
+{
+    assert(bs->file && bs->file->bs);
+    *pnum = nb_sectors;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
+                                                     int64_t sector_num,
+                                                     int nb_sectors, int *pnum,
+                                                     BlockDriverState **file)
+{
+    assert(bs->backing && bs->backing->bs);
+    *pnum = nb_sectors;
+    *file = bs->backing->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
diff --git a/block/mirror.c b/block/mirror.c
index 61a862dc..e8bf5f40 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1052,16 +1052,6 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
     return bdrv_co_flush(bs->backing->bs);
 }
 
-static int64_t coroutine_fn bdrv_mirror_top_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-    BlockDriverState **file)
-{
-    *pnum = nb_sectors;
-    *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
-}
-
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1108,7 +1098,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_mirror_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa6021..a42c2a6f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -945,6 +945,22 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
 
+/*
+ * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * their file
+ * */
+int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
+                                                     int64_t sector_num,
+                                                     int nb_sectors, int *pnum,
+                                                     BlockDriverState **file);
+/*
+ * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * their backing file
+ * */
+int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
+                                                     int64_t sector_num,
+                                                     int nb_sectors, int *pnum,
+                                                     BlockDriverState **file);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
2.11.0
