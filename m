Received: from eggs.gnu.org ([2001:4830:134:3::10]:55376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVaxZ-0004ee-TN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVaxY-00049D-W9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:01 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 13 Jul 2017 13:01:16 +0300
Message-Id: <20170713100117.11961-4-el13635@mail.ntua.gr>
In-Reply-To: <20170713100117.11961-1-el13635@mail.ntua.gr>
References: <20170713100117.11961-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v5 3/4] block: remove bdrv_truncate callback in
 blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Now that bdrv_truncate is passed to bs->file by default, remove the
callback from block/blkdebug.c and set is_filter to true.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/blkdebug.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c19ab28f07..91ffd1fe12 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -821,12 +821,6 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
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
@@ -909,6 +903,7 @@ static BlockDriver bdrv_blkdebug = {
     .format_name            = "blkdebug",
     .protocol_name          = "blkdebug",
     .instance_size          = sizeof(BDRVBlkdebugState),
+    .is_filter              = true,
 
     .bdrv_parse_filename    = blkdebug_parse_filename,
     .bdrv_file_open         = blkdebug_open,
@@ -917,7 +912,6 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_child_perm        = bdrv_filter_default_perms,
 
     .bdrv_getlength         = blkdebug_getlength,
-    .bdrv_truncate          = blkdebug_truncate,
     .bdrv_refresh_filename  = blkdebug_refresh_filename,
     .bdrv_refresh_limits    = blkdebug_refresh_limits,
 
-- 
2.11.0
