Received: from eggs.gnu.org ([2001:4830:134:3::10]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hy-0001a9-Bv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hx-0008Og-D5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:22 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:01 -0500
Message-Id: <20180619014319.28272-36-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 035/113] migration/block: reset dirty bitmap
 before read in bulk phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Lieven <pl@kamp.de>

Reset the dirty bitmap before reading to make sure we don't miss
any new data.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1520507908-16743-3-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 86b124bc76bd7137d0fb20696c4e349571b8533d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/block.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 7147171bb7..7dc13352d8 100644
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
2.11.0
