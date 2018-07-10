Received: from eggs.gnu.org ([2001:4830:134:3::10]:50314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCO-0001tc-QM
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCN-0007uq-Sw
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:20 +0800
Message-Id: <20180710063124.2263-7-famz@redhat.com>
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
References: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/10] block: Fix handling of image
 enlarging write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Two problems exist when a write request that enlarges the image (i.e.
write beyond EOF) finishes:

1) parent is not notified about size change;
2) dirty bitmap is not resized although we try to set the dirty bits;

Fix them just like how bdrv_co_truncate works.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 960e1492d0..10a475302a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -40,6 +40,7 @@
 
 static AioWait drain_all_aio_wait;
 
+static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
 
@@ -1599,13 +1600,16 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
     BlockDriverState *bs = child->bs;
 
     atomic_inc(&bs->write_gen);
-    bdrv_set_dirty(bs, offset, bytes);
 
     stat64_max(&bs->wr_highest_offset, offset + bytes);
 
-    if (ret == 0) {
-        bs->total_sectors = MAX(bs->total_sectors, end_sector);
+    if (ret == 0 &&
+        end_sector > bs->total_sectors) {
+        bs->total_sectors = end_sector;
+        bdrv_parent_cb_resize(bs);
+        bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
     }
+    bdrv_set_dirty(bs, offset, bytes);
 }
 
 /*
-- 
2.17.1
