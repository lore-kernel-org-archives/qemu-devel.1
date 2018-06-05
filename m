Received: from eggs.gnu.org ([2001:4830:134:3::10]:40132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAu-00035N-Gw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAt-0005Qm-4Q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Jun 2018 14:59:01 -0400
Message-Id: <20180605185905.4583-2-jsnow@redhat.com>
In-Reply-To: <20180605185905.4583-1-jsnow@redhat.com>
References: <20180605185905.4583-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] block/dirty-bitmap: add lock to
 bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add locks and remove comments about BQL accordingly to
dirty_bitmap_mutex definition in block_int.h.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 967159479d..56234257f4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -442,18 +442,20 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
     }
 }
 
-/* Called with BQL taken.  */
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    bdrv_dirty_bitmap_lock(bitmap);
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = true;
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
-/* Called with BQL taken.  */
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    bdrv_dirty_bitmap_lock(bitmap);
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = false;
+    bdrv_dirty_bitmap_unlock(bitmap);
 }
 
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
-- 
2.14.3
