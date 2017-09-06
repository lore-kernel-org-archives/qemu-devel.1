Received: from eggs.gnu.org ([2001:4830:134:3::10]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavJ-0005fQ-QR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav9-0000v9-Or
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:36 +0200
Message-Id: <20170906140246.7326-5-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] block: add default implementations for
 bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

bdrv_co_get_block_status_from_file() and
bdrv_co_get_block_status_from_backing() set *file to bs->file and
bs->backing respectively, so that bdrv_co_get_block_status() can recurse
to them. Future block drivers won't have to duplicate code to implement
this.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 18 ++++++++++++++++++
 block/blkdebug.c          | 12 +-----------
 block/commit.c            | 12 +-----------
 block/io.c                | 26 ++++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 5 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ca4e7e5629..223801e4fb 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -964,6 +964,24 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
 
+/*
+ * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * their file.
+ */
+int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
+                                                        int64_t sector_num,
+                                                        int nb_sectors,
+                                                        int *pnum,
+                                                        BlockDriverState **file);
+/*
+ * Default implementation for drivers to pass bdrv_co_get_block_status() to
+ * their backing file.
+ */
+int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
+                                                           int64_t sector_num,
+                                                           int nb_sectors,
+                                                           int *pnum,
+                                                           BlockDriverState **file);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index f10e3e5638..46e53f2f09 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -628,16 +628,6 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
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
@@ -907,7 +897,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
+    .bdrv_co_get_block_status = bdrv_co_get_block_status_from_file,
 
     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/block/commit.c b/block/commit.c
index c7857c3321..898d91f653 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -244,16 +244,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
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
@@ -279,7 +269,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
diff --git a/block/io.c b/block/io.c
index 26003814eb..4378ae4c7d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1714,6 +1714,32 @@ typedef struct BdrvCoGetBlockStatusData {
     bool done;
 } BdrvCoGetBlockStatusData;
 
+int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
+                                                        int64_t sector_num,
+                                                        int nb_sectors,
+                                                        int *pnum,
+                                                        BlockDriverState **file)
+{
+    assert(bs->file && bs->file->bs);
+    *pnum = nb_sectors;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
+                                                           int64_t sector_num,
+                                                           int nb_sectors,
+                                                           int *pnum,
+                                                           BlockDriverState **file)
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
index 429751b9fe..6531652d73 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1059,16 +1059,6 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
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
@@ -1115,7 +1105,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_mirror_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
-- 
2.13.5
