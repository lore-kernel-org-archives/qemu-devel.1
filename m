Received: from eggs.gnu.org ([209.51.188.92]:36713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrd-0002il-Cs
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001kO-BJ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:41 +0300
Message-Id: <20190207102445.71998-14-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 13/17] migration/block: use
 qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 0e24e18d13..83c633fb3f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -83,7 +83,6 @@ typedef struct BlkMigBlock {
     BlkMigDevState *bmds;
     int64_t sector;
     int nr_sectors;
-    struct iovec iov;
     QEMUIOVector qiov;
     BlockAIOCB *aiocb;
 
@@ -314,9 +313,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     blk->sector = cur_sector;
     blk->nr_sectors = nr_sectors;
 
-    blk->iov.iov_base = blk->buf;
-    blk->iov.iov_len = nr_sectors * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&blk->qiov, &blk->iov, 1);
+    qemu_iovec_init_buf(&blk->qiov, blk->buf, nr_sectors * BDRV_SECTOR_SIZE);
 
     blk_mig_lock();
     block_mig_state.submitted++;
@@ -556,9 +553,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             blk->nr_sectors = nr_sectors;
 
             if (is_async) {
-                blk->iov.iov_base = blk->buf;
-                blk->iov.iov_len = nr_sectors * BDRV_SECTOR_SIZE;
-                qemu_iovec_init_external(&blk->qiov, &blk->iov, 1);
+                qemu_iovec_init_buf(&blk->qiov, blk->buf,
+                                    nr_sectors * BDRV_SECTOR_SIZE);
 
                 blk->aiocb = blk_aio_preadv(bmds->blk,
                                             sector * BDRV_SECTOR_SIZE,
-- 
2.18.0
