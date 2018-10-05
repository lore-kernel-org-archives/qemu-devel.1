Received: from eggs.gnu.org ([2001:4830:134:3::10]:56786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zi3-0002rc-1s
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zi2-0007qx-6h
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:39:54 +0200
Message-Id: <20181005234023.8104-3-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 02/31] block: Use children list in
 bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

bdrv_refresh_filename() should invoke itself recursively on all
children, not just on file.

With that change, we can remove the manual invocations in blkverify,
quorum, commit, mirror, and blklogwrites.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c              | 9 +++++----
 block/blklogwrites.c | 3 ---
 block/blkverify.c    | 3 ---
 block/commit.c       | 1 -
 block/mirror.c       | 1 -
 block/quorum.c       | 1 -
 6 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index 8a7bc9308a..fd5e18081a 100644
--- a/block.c
+++ b/block.c
@@ -5224,16 +5224,17 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
 void bdrv_refresh_filename(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
+    BdrvChild *child;
     QDict *opts;
 
     if (!drv) {
         return;
     }
 
-    /* This BDS's file name will most probably depend on its file's name, so
-     * refresh that first */
-    if (bs->file) {
-        bdrv_refresh_filename(bs->file->bs);
+    /* This BDS's file name may depend on any of its children's file names, so
+     * refresh those first */
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_refresh_filename(child->bs);
     }
 
     if (drv->bdrv_refresh_filename) {
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ff98cd5533..8f1b589d54 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -285,9 +285,6 @@ static void blk_log_writes_refresh_filename(BlockDriverState *bs,
 {
     BDRVBlkLogWritesState *s = bs->opaque;
 
-    /* bs->file->bs has already been refreshed */
-    bdrv_refresh_filename(s->log_file->bs);
-
     if (bs->file->bs->full_open_options
         && s->log_file->bs->full_open_options)
     {
diff --git a/block/blkverify.c b/block/blkverify.c
index 89bf4386e3..035d77b64a 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -285,9 +285,6 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
-    /* bs->file->bs has already been refreshed */
-    bdrv_refresh_filename(s->test_file->bs);
-
     if (bs->file->bs->full_open_options
         && s->test_file->bs->full_open_options)
     {
diff --git a/block/commit.c b/block/commit.c
index a2da5740b0..dec1e89916 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -232,7 +232,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
 
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..9c9bea276d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1438,7 +1438,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
          * bdrv_set_backing_hd */
         return;
     }
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/quorum.c b/block/quorum.c
index eb526cc0f1..b14e9c6ec6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1080,7 +1080,6 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     int i;
 
     for (i = 0; i < s->num_children; i++) {
-        bdrv_refresh_filename(s->children[i]->bs);
         if (!s->children[i]->bs->full_open_options) {
             return;
         }
-- 
2.17.1
