Received: from eggs.gnu.org ([2001:4830:134:3::10]:41786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrIC-00007H-9E
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI9-00064G-70
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrI9-00062h-1Y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:29 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12CD837EEE
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:04 +0200
Message-Id: <20170605123908.18777-16-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/19] migration/block: reset dirty bitmap
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
Cc: famz@redhat.com

Any data that is returned by read may be stale already, the bitmap
has to be cleared before issuing the read.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 9e9f0316be..8fe484e8b4 100644
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
2.13.0
