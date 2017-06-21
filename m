Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf67-0007Wy-0w
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf66-0004kp-4j
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:03 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:24 +0200
Message-Id: <20170621125047.30294-3-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/25] block: Use children list in
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

bdrv_refresh_filename() should invoke itself recursively on all
children, not just on file.

With that change, we can remove the manual invocations in blkverify,
quorum, commit, and mirror.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c           | 9 +++++----
 block/blkverify.c | 3 ---
 block/commit.c    | 1 -
 block/mirror.c    | 1 -
 block/quorum.c    | 1 -
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index fa1d06d..2926f53 100644
--- a/block.c
+++ b/block.c
@@ -4788,16 +4788,17 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
index 06369f9..b2ed8cd 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -281,9 +281,6 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
-    /* bs->file->bs has already been refreshed */
-    bdrv_refresh_filename(s->test_file->bs);
-
     if (bs->file->bs->full_open_options
         && s->test_file->bs->full_open_options)
     {
diff --git a/block/commit.c b/block/commit.c
index 8c09c3d..7146e48 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -259,7 +259,6 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
 
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/mirror.c b/block/mirror.c
index db57bee..df6c8bb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1070,7 +1070,6 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/quorum.c b/block/quorum.c
index 1b2a8c3..f39b9e5 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1087,7 +1087,6 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     int i;
 
     for (i = 0; i < s->num_children; i++) {
-        bdrv_refresh_filename(s->children[i]->bs);
         if (!s->children[i]->bs->full_open_options) {
             return;
         }
-- 
2.9.4
