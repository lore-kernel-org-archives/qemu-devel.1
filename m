Received: from eggs.gnu.org ([2001:4830:134:3::10]:47411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg5R-0001q1-Ow
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVg5Q-0006YK-Jw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:31:29 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 13 Jul 2017 18:30:26 +0300
Message-Id: <20170713153028.31065-3-el13635@mail.ntua.gr>
In-Reply-To: <20170713153028.31065-1-el13635@mail.ntua.gr>
References: <20170713153028.31065-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v6 2/4] block: remove unused bdrv_media_changed
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

This function is not used anywhere, so remove it.

Markus Armbruster adds:
The i82078 floppy device model used to call bdrv_media_changed() to
implement its media change bit when backed by a host floppy.  This
went away in 21fcf36 "fdc: simplify media change handling".
Probably broke host floppy media change.  Host floppy pass-through
was dropped in commit f709623.  bdrv_media_changed() has never been
used for anything else.  Remove it.
(Source is Message-ID: <87y3ruaypm.fsf@dusky.pond.sub.org>)

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                   | 14 --------------
 block/raw-format.c        |  6 ------
 include/block/block.h     |  1 -
 include/block/block_int.h |  1 -
 4 files changed, 22 deletions(-)

diff --git a/block.c b/block.c
index dd409bfb5b..77d0fcade0 100644
--- a/block.c
+++ b/block.c
@@ -4200,20 +4200,6 @@ bool bdrv_is_inserted(BlockDriverState *bs)
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
index 142649ed56..ab552c0954 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -372,11 +372,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
     return bdrv_truncate(bs->file, offset, prealloc, errp);
 }
 
-static int raw_media_changed(BlockDriverState *bs)
-{
-    return bdrv_media_changed(bs->file->bs);
-}
-
 static void raw_eject(BlockDriverState *bs, bool eject_flag)
 {
     bdrv_eject(bs->file->bs, eject_flag);
@@ -510,7 +505,6 @@ BlockDriver bdrv_raw = {
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
     .bdrv_probe_geometry  = &raw_probe_geometry,
-    .bdrv_media_changed   = &raw_media_changed,
     .bdrv_eject           = &raw_eject,
     .bdrv_lock_medium     = &raw_lock_medium,
     .bdrv_co_ioctl        = &raw_co_ioctl,
diff --git a/include/block/block.h b/include/block/block.h
index b3e2674845..7e0cec5242 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -441,7 +441,6 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
-int bdrv_media_changed(BlockDriverState *bs);
 void bdrv_lock_medium(BlockDriverState *bs, bool locked);
 void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 37388ccb18..afdebe7c52 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -249,7 +249,6 @@ struct BlockDriver {
 
     /* removable device specific */
     bool (*bdrv_is_inserted)(BlockDriverState *bs);
-    int (*bdrv_media_changed)(BlockDriverState *bs);
     void (*bdrv_eject)(BlockDriverState *bs, bool eject_flag);
     void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
 
-- 
2.11.0
