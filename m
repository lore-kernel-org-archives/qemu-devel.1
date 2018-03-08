Received: from eggs.gnu.org ([2001:4830:134:3::10]:40349)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ettZK-0004XY-Nv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ettZJ-00021U-1a
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:42 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44888 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ettZI-00020c-PF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:40 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 8 Mar 2018 12:18:28 +0100
From: Peter Lieven <pl@kamp.de>
Date: Thu,  8 Mar 2018 12:18:25 +0100
Message-Id: <1520507908-16743-3-git-send-email-pl@kamp.de>
In-Reply-To: <1520507908-16743-1-git-send-email-pl@kamp.de>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 2/5] migration/block: reset dirty bitmap before
 read in bulk phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

Reset the dirty bitmap before reading to make sure we don't miss
any new data.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 migration/block.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 1f03946..87bb35c 100644
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
2.7.4
