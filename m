Received: from eggs.gnu.org ([2001:4830:134:3::10]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTb-0004L2-BG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTa-0003jt-8G
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:55 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:16 +0200
Message-Id: <20180628000745.4477-3-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 02/31] block: Use children list in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

bdrv_refresh_filename() should invoke itself recursively on all
children, not just on file.

With that change, we can remove the manual invocations in blkverify,
quorum, commit, and mirror.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c           | 9 +++++----
 block/blkverify.c | 3 ---
 block/commit.c    | 1 -
 block/mirror.c    | 1 -
 block/quorum.c    | 1 -
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index e418c97423..52247062d5 100644
--- a/block.c
+++ b/block.c
@@ -5174,16 +5174,17 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
diff --git a/block/blkverify.c b/block/blkverify.c
index da97ee5927..4a18baaf20 100644
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
index e1814d9693..26db55d800 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -234,7 +234,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
 
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/mirror.c b/block/mirror.c
index 61bd9f3cf1..2f5ccae2b1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1421,7 +1421,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
          * bdrv_set_backing_hd */
         return;
     }
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/quorum.c b/block/quorum.c
index 9152da8c58..03388590f3 100644
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
