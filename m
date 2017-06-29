Received: from eggs.gnu.org ([2001:4830:134:3::10]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQX-0002kh-DM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQeQW-0005Ta-Jy
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:44:29 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 29 Jun 2017 21:43:19 +0300
Message-Id: <20170629184320.7151-3-el13635@mail.ntua.gr>
In-Reply-To: <20170629184320.7151-1-el13635@mail.ntua.gr>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 2/3] block: use defaults of bdrv_* callbacks
 in raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that passing the call to bs->file is the default for some bdrv_*
callbacks, remove the duplicate implementations in block/raw-format.c

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/raw-format.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 1ea8c2d7..ff9b4359 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -312,11 +312,6 @@ static int64_t raw_getlength(BlockDriverState *bs)
     return s->size;
 }
 
-static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
-{
-    return bdrv_get_info(bs->file->bs, bdi);
-}
-
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     if (bs->probed) {
@@ -346,21 +341,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     return bdrv_truncate(bs->file, offset, errp);
 }
 
-static int raw_media_changed(BlockDriverState *bs)
-{
-    return bdrv_media_changed(bs->file->bs);
-}
-
-static void raw_eject(BlockDriverState *bs, bool eject_flag)
-{
-    bdrv_eject(bs->file->bs, eject_flag);
-}
-
-static void raw_lock_medium(BlockDriverState *bs, bool locked)
-{
-    bdrv_lock_medium(bs->file->bs, locked);
-}
-
 static int raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s = bs->opaque;
@@ -370,11 +350,6 @@ static int raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }
 
-static int raw_has_zero_init(BlockDriverState *bs)
-{
-    return bdrv_has_zero_init(bs->file->bs);
-}
-
 static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     return bdrv_create_file(filename, opts, errp);
@@ -479,16 +454,11 @@ BlockDriver bdrv_raw = {
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-    .bdrv_get_info        = &raw_get_info,
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
     .bdrv_probe_geometry  = &raw_probe_geometry,
-    .bdrv_media_changed   = &raw_media_changed,
-    .bdrv_eject           = &raw_eject,
-    .bdrv_lock_medium     = &raw_lock_medium,
     .bdrv_co_ioctl        = &raw_co_ioctl,
-    .create_opts          = &raw_create_opts,
-    .bdrv_has_zero_init   = &raw_has_zero_init
+    .create_opts          = &raw_create_opts
 };
 
 static void bdrv_raw_init(void)
-- 
2.11.0
