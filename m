Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA4C-0004jE-HI
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA4B-0006aP-N4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA4B-0006a1-HI
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:43 +0800
Message-Id: <20170526075246.20265-20-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 19/22] migration/block: reset dirty bitmap
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
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Any data that is returned by read may be stale already, the bitmap
has to be cleared before issuing the read.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-16-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.4
