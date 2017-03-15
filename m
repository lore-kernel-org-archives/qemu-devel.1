Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnzl4-0007Gi-S2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnzl1-0007Uj-Qw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:37:54 -0400
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 15 Mar 2017 11:37:33 +0800
Message-Id: <1489549053-31728-1-git-send-email-jemmy858585@gmail.com>
Subject: [Qemu-devel] [PATCH v2] migration/block: Avoid invoking blk_drain
 too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <jemmy858585@gmail.com>

Increase bmds->cur_dirty after submit io, so reduce the frequency
involve into blk_drain, and improve the performance obviously
when block migration.

The performance test result of this patch:

During the block dirty save phase, this patch improve guest os IOPS
from 4.0K to 9.5K. and improve the migration speed from
505856 rsec/s to 855756 rsec/s.

Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
---
 migration/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/block.c b/migration/block.c
index 6741228..7734ff7 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -576,6 +576,9 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             }
 
             bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+            sector += nr_sectors;
+            bmds->cur_dirty = sector;
+
             break;
         }
         sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
-- 
1.8.3.1
