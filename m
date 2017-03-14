Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnhLD-0002Y9-0I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnhLC-0003uK-BH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:57:59 -0400
From: jemmy858585@gmail.com
Date: Tue, 14 Mar 2017 15:57:23 +0800
Message-Id: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
Subject: [Qemu-devel] [PATCH] migration/block: Avoid involve into blk_drain
 too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Lidong Chen <jemmy858585@gmail.com>

From: Lidong Chen <jemmy858585@gmail.com>

Increase bmds->cur_dirty after submit io, so reduce the frequency involve into blk_drain, and improve the performance obviously when block migration.

Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
---
 migration/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/block.c b/migration/block.c
index 6741228..f059cca 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -576,6 +576,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             }
 
             bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+            sector += nr_sectors;
+            bmds->cur_dirty = sector;
             break;
         }
         sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
-- 
1.8.3.1
