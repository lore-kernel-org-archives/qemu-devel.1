Received: from eggs.gnu.org ([209.51.188.92]:46674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVs-0005mh-0y
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVj-0002Jt-Tn
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:07 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:06 +0100
Message-Id: <20190201192935.18394-3-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 02/31] block: Use children list in
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
index e93334d9fc..0e3d29d378 100644
--- a/block.c
+++ b/block.c
@@ -5475,16 +5475,17 @@ static bool append_open_options(QDict *d, BlockDr=
iverState *bs)
 void bdrv_refresh_filename(BlockDriverState *bs)
 {
     BlockDriver *drv =3D bs->drv;
+    BdrvChild *child;
     QDict *opts;
=20
     if (!drv) {
         return;
     }
=20
-    /* This BDS's file name will most probably depend on its file's name=
, so
-     * refresh that first */
-    if (bs->file) {
-        bdrv_refresh_filename(bs->file->bs);
+    /* This BDS's file name may depend on any of its children's file nam=
es, so
+     * refresh those first */
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_refresh_filename(child->bs);
     }
=20
     if (drv->bdrv_refresh_filename) {
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index d2e01bdb1d..36e3d0f822 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -285,9 +285,6 @@ static void blk_log_writes_refresh_filename(BlockDriv=
erState *bs,
 {
     BDRVBlkLogWritesState *s =3D bs->opaque;
=20
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
@@ -285,9 +285,6 @@ static void blkverify_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
 {
     BDRVBlkverifyState *s =3D bs->opaque;
=20
-    /* bs->file->bs has already been refreshed */
-    bdrv_refresh_filename(s->test_file->bs);
-
     if (bs->file->bs->full_open_options
         && s->test_file->bs->full_open_options)
     {
diff --git a/block/commit.c b/block/commit.c
index 53148e610b..093b1505de 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -232,7 +232,6 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockD=
riverState *bs,
=20
 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict=
 *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/mirror.c b/block/mirror.c
index b67b0120f8..031c1aeaeb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1438,7 +1438,6 @@ static void bdrv_mirror_top_refresh_filename(BlockD=
riverState *bs, QDict *opts)
          * bdrv_set_backing_hd */
         return;
     }
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
 }
diff --git a/block/quorum.c b/block/quorum.c
index 16b3c8067c..cf9d7c16c2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1073,7 +1073,6 @@ static void quorum_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        bdrv_refresh_filename(s->children[i]->bs);
         if (!s->children[i]->bs->full_open_options) {
             return;
         }
--=20
2.20.1
