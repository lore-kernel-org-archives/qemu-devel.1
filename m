Received: from eggs.gnu.org ([2001:4830:134:3::10]:51972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvh5-000506-0D
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvh4-0004B8-Ep
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:22 +0200
Message-Id: <20170525163225.29954-16-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/18] migration/block: reset dirty bitmap
 before reading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

Any data that is returned by read may be stale already, the bitmap
has to be cleared before issuing the read.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 9e9f031..8fe484e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -536,6 +536,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             } else {
                 nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
             }
+            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+
             blk = g_new(BlkMigBlock, 1);
             blk->buf = g_malloc(BLOCK_SIZE);
             blk->bmds = bmds;
@@ -568,7 +570,6 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
                 g_free(blk);
             }
 
-            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
             sector += nr_sectors;
             bmds->cur_dirty = sector;
 
-- 
1.8.3.1
