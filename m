Received: from eggs.gnu.org ([2001:4830:134:3::10]:55788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cn-0007UU-4g
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cl-0004S8-PP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:42 -0500
Message-Id: <20170703221456.30817-2-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/15] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

bdrv_co_get_block_status_from_file() and
bdrv_co_get_block_status_from_backing() set *file to bs->file and
bs->backing respectively, so that bdrv_co_get_block_status() can recurse
to them. Future block drivers won't have to duplicate code to implement
this.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-Id: <20170629184320.7151-4-el13635@mail.ntua.gr>

---
v2: Including this patch from Manos, since it affects my later patches;
however, I anticipate that we will get a full v3 series from Manos
merged first
---
 include/block/block_int.h | 16 ++++++++++++++++
 block/blkdebug.c          | 12 +-----------
 block/commit.c            | 12 +-----------
 block/io.c                | 24 ++++++++++++++++++++++++
 block/mirror.c            | 12 +-----------
 5 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 226232d..724799c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -958,6 +958,22 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
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
diff --git a/block/blkdebug.c b/block/blkdebug.c
index b25856c..f1539db 100644
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
index 774a8a5..9e875a6 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -242,16 +242,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
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
@@ -277,7 +267,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
diff --git a/block/io.c b/block/io.c
index 53c01cf..8c67ba8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1689,6 +1689,30 @@ typedef struct BdrvCoGetBlockStatusData {
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
index 6f54dcc..4e883bc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1043,16 +1043,6 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
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
@@ -1099,7 +1089,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_mirror_top_get_block_status,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
-- 
2.9.4
