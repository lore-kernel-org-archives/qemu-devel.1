Received: from eggs.gnu.org ([2001:4830:134:3::10]:50049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD9-0006Ff-GB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPD8-0000mE-DI
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:28:51 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 15 Feb 2018 13:28:29 -0600
Message-Id: <20180215192829.9944-7-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
References: <20180215192829.9944-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] block: Drop last of the sector-based aio
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers with aio callbacks are using the
byte-based interfaces, we can remove the sector-based versions.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h |  6 ------
 block/io.c                | 23 ++++++-----------------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c882dc4232d..0f5b7accfa8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -134,15 +134,9 @@ struct BlockDriver {
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);

     /* aio */
-    BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
-    BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
diff --git a/block/io.c b/block/io.c
index 84a4caa72b7..04239f01eef 100644
--- a/block/io.c
+++ b/block/io.c
@@ -948,13 +948,8 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };

-        if (drv->bdrv_aio_preadv) {
-            acb = bs->drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
-                                           bdrv_co_io_em_complete, &co);
-        } else {
-            acb = bs->drv->bdrv_aio_readv(bs, sector_num, qiov, nb_sectors,
-                                          bdrv_co_io_em_complete, &co);
-        }
+        acb = bs->drv->bdrv_aio_preadv(bs, offset, bytes, qiov, flags,
+                                       bdrv_co_io_em_complete, &co);
         if (acb == NULL) {
             return -EIO;
         } else {
@@ -1008,16 +1003,10 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
             .coroutine = qemu_coroutine_self(),
         };

-        if (drv->bdrv_aio_pwritev) {
-            acb = bs->drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
-                                            flags & bs->supported_write_flags,
-                                            bdrv_co_io_em_complete, &co);
-            flags &= ~bs->supported_write_flags;
-        } else {
-            assert(!bs->supported_write_flags);
-            acb = bs->drv->bdrv_aio_writev(bs, sector_num, qiov, nb_sectors,
-                                           bdrv_co_io_em_complete, &co);
-        }
+        acb = bs->drv->bdrv_aio_pwritev(bs, offset, bytes, qiov,
+                                        flags & bs->supported_write_flags,
+                                        bdrv_co_io_em_complete, &co);
+        flags &= ~bs->supported_write_flags;
         if (acb == NULL) {
             ret = -EIO;
         } else {
-- 
2.14.3
