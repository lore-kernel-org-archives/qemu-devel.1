Received: from eggs.gnu.org ([2001:4830:134:3::10]:39791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82YZ-0006AW-WF
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f82YU-0005kq-T7
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:44:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 16 Apr 2018 14:44:08 +0300
Message-Id: <20180416114414.18406-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180416114414.18406-1-vsementsov@virtuozzo.com>
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/7] block/dirty-bitmap: add lock to
 bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com

Functions write to BdrvDirtyBitmap field, so the should take the lock.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 967159479d..6c00288fd7 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -445,15 +445,19 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 /* Called with BQL taken.  */
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    bdrv_dirty_bitmap_lock(bitmap);
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = true;
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
 /* Called with BQL taken.  */
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    bdrv_dirty_bitmap_lock(bitmap);
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = false;
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
-- 
2.11.1
