Received: from eggs.gnu.org ([2001:4830:134:3::10]:55433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUyBH-0000TM-En
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dUyBG-0002gF-Ig
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:38:35 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 11 Jul 2017 19:37:46 +0300
Message-Id: <20170711163748.17817-3-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-1-el13635@mail.ntua.gr>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v4 2/4] block: remove bdrv_media_changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

This function is not used anywhere, so remove it.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                   | 14 --------------
 block/raw-format.c        |  6 ------
 include/block/block.h     |  1 -
 include/block/block_int.h |  1 -
 4 files changed, 22 deletions(-)

diff --git a/block.c b/block.c
index 7f7530b6..5ca60f97 100644
--- a/block.c
+++ b/block.c
@@ -4213,20 +4213,6 @@ bool bdrv_is_inserted(BlockDriverState *bs)
 }
 
 /**
- * Return whether the media changed since the last call to this
- * function, or -ENOTSUP if we don't know.  Most drivers don't know.
- */
-int bdrv_media_changed(BlockDriverState *bs)
-{
-    BlockDriver *drv = bs->drv;
-
-    if (drv && drv->bdrv_media_changed) {
-        return drv->bdrv_media_changed(bs);
-    }
-    return -ENOTSUP;
-}
-
-/**
  * If eject_flag is TRUE, eject the media. Otherwise, close the tray
  */
 void bdrv_eject(BlockDriverState *bs, bool eject_flag)
diff --git a/block/raw-format.c b/block/raw-format.c
index 1ea8c2d7..df3bc5d5 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -346,11 +346,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     return bdrv_truncate(bs->file, offset, errp);
 }
 
-static int raw_media_changed(BlockDriverState *bs)
-{
-    return bdrv_media_changed(bs->file->bs);
-}
-
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
 {
     bdrv_eject(bs->file->bs, eject_flag);
@@ -483,7 +478,6 @@ BlockDriver bdrv_raw = {
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
     .bdrv_probe_geometry  = &raw_probe_geometry,
-    .bdrv_media_changed   = &raw_media_changed,
     .bdrv_eject           = &raw_eject,
     .bdrv_lock_medium     = &raw_lock_medium,
     .bdrv_co_ioctl        = &raw_co_ioctl,
diff --git a/include/block/block.h b/include/block/block.h
index afe1b615..3cb4cae7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -438,7 +438,6 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
-int bdrv_media_changed(BlockDriverState *bs);
 void bdrv_lock_medium(BlockDriverState *bs, bool locked);
 void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 75e93f72..3d9a8164 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -246,7 +246,6 @@ struct BlockDriver {
 
     /* removable device specific */
     bool (*bdrv_is_inserted)(BlockDriverState *bs);
-    int (*bdrv_media_changed)(BlockDriverState *bs);
     void (*bdrv_eject)(BlockDriverState *bs, bool eject_flag);
     void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
 
-- 
2.11.0
