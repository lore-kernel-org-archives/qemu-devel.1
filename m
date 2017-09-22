Received: from eggs.gnu.org ([2001:4830:134:3::10]:40841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvPBR-0001mO-Qi
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dvPBO-0003pF-OE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:44:01 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 22 Sep 2017 17:43:53 +0300
Message-Id: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of uninitialized
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, vsementsov@virtuozzo.com

Without initialization to zero dirty_bitmap field may be not zero
for a bitmap which should not be stored and
qcow2_store_persistent_dirty_bitmaps will erroneously call
store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index e8d3bdbd6e..14f41d0427 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -602,7 +602,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
-        bm = g_new(Qcow2Bitmap, 1);
+        bm = g_new0(Qcow2Bitmap, 1);
         bm->table.offset = e->bitmap_table_offset;
         bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
-- 
2.11.1
