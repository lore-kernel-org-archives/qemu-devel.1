Received: from eggs.gnu.org ([2001:4830:134:3::10]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pId-0001yF-F6
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIc-0004Ry-Mo
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:39 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:42:05 +0200
Message-Id: <20170511144208.24075-16-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
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
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Any data that is returned by read may be stale already, the bitmap
has to be cleared before issuing the read.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: new

 migration/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index e4b3212ba7..79adab88cf 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -537,6 +537,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
             } else {
                 nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
             }
+            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
+
             blk = g_new(BlkMigBlock, 1);
             blk->buf = g_malloc(BLOCK_SIZE);
             blk->bmds = bmds;
@@ -569,7 +571,6 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
                 g_free(blk);
             }
 
-            bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
             sector += nr_sectors;
             bmds->cur_dirty = sector;
 
-- 
2.12.2
