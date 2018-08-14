Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYfX-0005p1-Hk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYfU-0002fa-Dn
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:43:20 +0300
Message-Id: <20180814124320.39481-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180814124320.39481-1-vsementsov@virtuozzo.com>
References: <20180814124320.39481-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] block: drop empty .bdrv_close handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

.bdrv_close handler is optional after previous commit, no needs to keep
empty functions more.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/blkreplay.c    | 5 -----
 block/commit.c       | 5 -----
 block/copy-on-read.c | 6 ------
 block/mirror.c       | 5 -----
 block/null.c         | 6 ------
 block/raw-format.c   | 5 -----
 6 files changed, 32 deletions(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index 766150ade6..b5d9efdeca 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -43,10 +43,6 @@ fail:
     return ret;
 }
 
-static void blkreplay_close(BlockDriverState *bs)
-{
-}
-
 static int64_t blkreplay_getlength(BlockDriverState *bs)
 {
     return bdrv_getlength(bs->file->bs);
@@ -135,7 +131,6 @@ static BlockDriver bdrv_blkreplay = {
     .instance_size          = 0,
 
     .bdrv_open              = blkreplay_open,
-    .bdrv_close             = blkreplay_close,
     .bdrv_child_perm        = bdrv_filter_default_perms,
     .bdrv_getlength         = blkreplay_getlength,
 
diff --git a/block/commit.c b/block/commit.c
index e1814d9693..eb414579bd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -239,10 +239,6 @@ static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
             bs->backing->bs->filename);
 }
 
-static void bdrv_commit_top_close(BlockDriverState *bs)
-{
-}
-
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildRole *role,
                                        BlockReopenQueue *reopen_queue,
@@ -260,7 +256,6 @@ static BlockDriver bdrv_commit_top = {
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
-    .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
 };
 
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index a19164f9eb..64dcc424b5 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -45,11 +45,6 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
 }
 
 
-static void cor_close(BlockDriverState *bs)
-{
-}
-
-
 #define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
                           | BLK_PERM_WRITE \
                           | BLK_PERM_RESIZE)
@@ -143,7 +138,6 @@ BlockDriver bdrv_copy_on_read = {
     .format_name                        = "copy-on-read",
 
     .bdrv_open                          = cor_open,
-    .bdrv_close                         = cor_close,
     .bdrv_child_perm                    = cor_child_perm,
 
     .bdrv_getlength                     = cor_getlength,
diff --git a/block/mirror.c b/block/mirror.c
index d2806812c8..e949aa1fc5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1424,10 +1424,6 @@ static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
             bs->backing->bs->filename);
 }
 
-static void bdrv_mirror_top_close(BlockDriverState *bs)
-{
-}
-
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildRole *role,
                                        BlockReopenQueue *reopen_queue,
@@ -1454,7 +1450,6 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_flush              = bdrv_mirror_top_flush,
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
-    .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
 };
 
diff --git a/block/null.c b/block/null.c
index 5d610fdfba..d442d3e901 100644
--- a/block/null.c
+++ b/block/null.c
@@ -97,10 +97,6 @@ static int null_file_open(BlockDriverState *bs, QDict *options, int flags,
     return ret;
 }
 
-static void null_close(BlockDriverState *bs)
-{
-}
-
 static int64_t null_getlength(BlockDriverState *bs)
 {
     BDRVNullState *s = bs->opaque;
@@ -263,7 +259,6 @@ static BlockDriver bdrv_null_co = {
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
-    .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,
 
     .bdrv_co_preadv         = null_co_preadv,
@@ -283,7 +278,6 @@ static BlockDriver bdrv_null_aio = {
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
-    .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,
 
     .bdrv_aio_preadv        = null_aio_preadv,
diff --git a/block/raw-format.c b/block/raw-format.c
index 2fd69cdb08..6f6dc99b2c 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -459,10 +459,6 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     return 0;
 }
 
-static void raw_close(BlockDriverState *bs)
-{
-}
-
 static int raw_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
     /* smallest possible positive score so that raw is used if and only if no
@@ -543,7 +539,6 @@ BlockDriver bdrv_raw = {
     .bdrv_reopen_commit   = &raw_reopen_commit,
     .bdrv_reopen_abort    = &raw_reopen_abort,
     .bdrv_open            = &raw_open,
-    .bdrv_close           = &raw_close,
     .bdrv_child_perm      = bdrv_filter_default_perms,
     .bdrv_co_create_opts  = &raw_co_create_opts,
     .bdrv_co_preadv       = &raw_co_preadv,
-- 
2.11.1
