Received: from eggs.gnu.org ([2001:4830:134:3::10]:46747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYH-0000bj-DG
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYG-0002iO-5i
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:24 +0200
Message-Id: <20170929165347.29658-3-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 02/25] block: Use children list in
 bdrv_refresh_filename
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

bdrv_refresh_filename() should invoke itself recursively on all
children, not just on file.

With that change, we can remove the manual invocations in blkverify,
quorum, commit, and mirror.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c           | 9 +++++----
 block/blkverify.c | 3 ---
 block/commit.c    | 1 -
 block/mirror.c    | 1 -
 block/quorum.c    | 1 -
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 5c65fac672..5721168d1d 100644
--- a/block.c
+++ b/block.c
@@ -4877,16 +4877,17 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
index 06369f9eac..b2ed8cd70d 100644
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
index 8f0e83578a..1df8db5428 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -246,7 +246,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
 
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/mirror.c b/block/mirror.c
index 25e9354b4d..7aa873d86f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1078,7 +1078,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
          * bdrv_set_backing_hd */
         return;
     }
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/quorum.c b/block/quorum.c
index 272f9a5b77..2f1a628449 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1074,7 +1074,6 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     int i;
 
     for (i = 0; i < s->num_children; i++) {
-        bdrv_refresh_filename(s->children[i]->bs);
         if (!s->children[i]->bs->full_open_options) {
             return;
         }
-- 
2.13.6
