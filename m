Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEO-000849-J3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEN-0003Lv-Ph
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euMEN-0003Le-Lg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:54:59 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  9 Mar 2018 17:54:50 +0000
Message-Id: <20180309175453.41548-4-dgilbert@redhat.com>
In-Reply-To: <20180309175453.41548-1-dgilbert@redhat.com>
References: <20180309175453.41548-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] migration/block: reset dirty bitmap before
 read in bulk phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pl@kamp.de, peterx@redhat.com, quintela@redhat.com

From: Peter Lieven <pl@kamp.de>

Reset the dirty bitmap before reading to make sure we don't miss
any new data.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1520507908-16743-3-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 1f03946797..87bb35ce63 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -331,11 +331,10 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
      */
     qemu_mutex_lock_iothread();
     aio_context_acquire(blk_get_aio_context(bmds->blk));
-    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
-                                0, blk_mig_read_cb, blk);
-
     bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
                             nr_sectors * BDRV_SECTOR_SIZE);
+    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
+                                0, blk_mig_read_cb, blk);
     aio_context_release(blk_get_aio_context(bmds->blk));
     qemu_mutex_unlock_iothread();
 
-- 
2.14.3
