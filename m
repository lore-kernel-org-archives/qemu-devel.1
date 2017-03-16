Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRIB-0003P0-Mp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI6-00007m-7d
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coRI6-00007S-2F
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:50 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 16 Mar 2017 10:01:38 +0100
Message-Id: <20170316090141.13421-4-quintela@redhat.com>
In-Reply-To: <20170316090141.13421-1-quintela@redhat.com>
References: <20170316090141.13421-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] migration/block: Avoid invoking blk_drain
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
Cc: dgilbert@redhat.com, Lidong Chen <jemmy858585@gmail.com>

From: Lidong Chen <jemmy858585@gmail.com>

Increase bmds->cur_dirty after submit io, so reduce the frequency
involve into blk_drain, and improve the performance obviously
when block migration.

The performance test result of this patch:

During the block dirty save phase, this patch improve guest os IOPS
from 4.0K to 9.5K. and improve the migration speed from
505856 rsec/s to 855756 rsec/s.

Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
2.9.3
