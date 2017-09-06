Received: from eggs.gnu.org ([2001:4830:134:3::10]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav8-0005TV-2F
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav2-0000qH-GI
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:35 +0200
Message-Id: <20170906140246.7326-4-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] block: remove bdrv_truncate callback in
 blkdebug
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

Now that bdrv_truncate is passed to bs->file by default, remove the
callback from block/blkdebug.c and set is_filter to true. is_filter also gives
access to other callbacks that are forwarded automatically to bs->file for
filters.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkdebug.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 8e385acf54..f10e3e5638 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -808,12 +808,6 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
 }
 
-static int blkdebug_truncate(BlockDriverState *bs, int64_t offset,
-                             PreallocMode prealloc, Error **errp)
-{
-    return bdrv_truncate(bs->file, offset, prealloc, errp);
-}
-
 static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -896,6 +890,7 @@ static BlockDriver bdrv_blkdebug = {
     .format_name            = "blkdebug",
     .protocol_name          = "blkdebug",
     .instance_size          = sizeof(BDRVBlkdebugState),
+    .is_filter              = true,
 
     .bdrv_parse_filename    = blkdebug_parse_filename,
     .bdrv_file_open         = blkdebug_open,
@@ -904,7 +899,6 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_child_perm        = bdrv_filter_default_perms,
 
     .bdrv_getlength         = blkdebug_getlength,
-    .bdrv_truncate          = blkdebug_truncate,
     .bdrv_refresh_filename  = blkdebug_refresh_filename,
     .bdrv_refresh_limits    = blkdebug_refresh_limits,
 
-- 
2.13.5
