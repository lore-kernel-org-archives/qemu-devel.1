Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawJ-0002sL-Dc
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawF-0008Tx-BA
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:15 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:35 -0600
Message-Id: <20180105225753.30509-3-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 02/20] block: Switch passthrough drivers to
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
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the generic helpers, and all passthrough clients
(blkdebug, commit, mirror, throttle) accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: rebase to master
v4: rebase to interface tweak
v3: rebase to addition of throttle driver
v2: rebase to master, retitle while merging blkdebug, commit, and mirror
---
 include/block/block_int.h | 28 ++++++++++++++++------------
 block/io.c                | 36 ++++++++++++++++++++----------------
 block/blkdebug.c          | 20 +++++++++++---------
 block/commit.c            |  2 +-
 block/mirror.c            |  2 +-
 block/throttle.c          |  2 +-
 6 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c9777b55d..d4509a2711 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1034,23 +1034,27 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
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
+int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
+                                                bool want_zero,
+                                                int64_t offset,
+                                                int64_t bytes,
+                                                int64_t *pnum,
+                                                int64_t *map,
+                                                BlockDriverState **file);
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
+int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
+                                                   bool want_zero,
+                                                   int64_t offset,
+                                                   int64_t bytes,
+                                                   int64_t *pnum,
+                                                   int64_t *map,
+                                                   BlockDriverState **file);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
diff --git a/block/io.c b/block/io.c
index 9a697f3b20..087cb89b86 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1868,30 +1868,34 @@ typedef struct BdrvCoBlockStatusData {
     bool done;
 } BdrvCoBlockStatusData;

-int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverState *bs,
-                                                        int64_t sector_num,
-                                                        int nb_sectors,
-                                                        int *pnum,
-                                                        BlockDriverState **file)
+int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
+                                                bool want_zero,
+                                                int64_t offset,
+                                                int64_t bytes,
+                                                int64_t *pnum,
+                                                int64_t *map,
+                                                BlockDriverState **file)
 {
     assert(bs->file && bs->file->bs);
-    *pnum = nb_sectors;
+    *pnum = bytes;
+    *map = offset;
     *file = bs->file->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }

-int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
-                                                           int64_t sector_num,
-                                                           int nb_sectors,
-                                                           int *pnum,
-                                                           BlockDriverState **file)
+int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
+                                                   bool want_zero,
+                                                   int64_t offset,
+                                                   int64_t bytes,
+                                                   int64_t *pnum,
+                                                   int64_t *map,
+                                                   BlockDriverState **file)
 {
     assert(bs->backing && bs->backing->bs);
-    *pnum = nb_sectors;
+    *pnum = bytes;
+    *map = offset;
     *file = bs->backing->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }

 /*
diff --git a/block/blkdebug.c b/block/blkdebug.c
index e21669979d..82c30357f8 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -627,15 +627,17 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }

-static int64_t coroutine_fn blkdebug_co_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
-    BlockDriverState **file)
+static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
+                                                 bool want_zero,
+                                                 int64_t offset,
+                                                 int64_t bytes,
+                                                 int64_t *pnum,
+                                                 int64_t *map,
+                                                 BlockDriverState **file)
 {
-    assert(QEMU_IS_ALIGNED(sector_num | nb_sectors,
-                           DIV_ROUND_UP(bs->bl.request_alignment,
-                                        BDRV_SECTOR_SIZE)));
-    return bdrv_co_get_block_status_from_file(bs, sector_num, nb_sectors,
-                                              pnum, file);
+    assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+    return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
+                                          pnum, map, file);
 }

 static void blkdebug_close(BlockDriverState *bs)
@@ -907,7 +909,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
+    .bdrv_co_block_status   = blkdebug_co_block_status,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/block/commit.c b/block/commit.c
index bb6c904704..1943c9c3e1 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -265,7 +265,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
diff --git a/block/mirror.c b/block/mirror.c
index c9badc1203..f5bf620942 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1094,7 +1094,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
diff --git a/block/throttle.c b/block/throttle.c
index 833175ac77..d1324e7a9f 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -239,7 +239,7 @@ static BlockDriver bdrv_throttle = {
     .bdrv_reopen_prepare                =   throttle_reopen_prepare,
     .bdrv_reopen_commit                 =   throttle_reopen_commit,
     .bdrv_reopen_abort                  =   throttle_reopen_abort,
-    .bdrv_co_get_block_status           =   bdrv_co_get_block_status_from_file,
+    .bdrv_co_block_status               =   bdrv_co_block_status_from_file,

     .bdrv_co_drain_begin                =   throttle_co_drain_begin,
     .bdrv_co_drain_end                  =   throttle_co_drain_end,
-- 
2.14.3
