Received: from eggs.gnu.org ([2001:4830:134:3::10]:50097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavB-0005Wu-ES
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav1-0000po-SO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:34 +0200
Message-Id: <20170906140246.7326-3-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] block: remove unused bdrv_media_changed
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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  1 -
 include/block/block_int.h |  1 -
 block.c                   | 14 --------------
 block/raw-format.c        |  6 ------
 4 files changed, 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index ab80195378..2ad18775af 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -441,7 +441,6 @@ int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
 int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
-int bdrv_media_changed(BlockDriverState *bs);
 void bdrv_lock_medium(BlockDriverState *bs, bool locked);
 void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 71183cc76e..ca4e7e5629 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -248,7 +248,6 @@ struct BlockDriver {
 
     /* removable device specific */
     bool (*bdrv_is_inserted)(BlockDriverState *bs);
-    int (*bdrv_media_changed)(BlockDriverState *bs);
     void (*bdrv_eject)(BlockDriverState *bs, bool eject_flag);
     void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
 
diff --git a/block.c b/block.c
index 175e8d35ff..6dd47e414e 100644
--- a/block.c
+++ b/block.c
@@ -4192,20 +4192,6 @@ bool bdrv_is_inserted(BlockDriverState *bs)
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
-- 
2.13.5
