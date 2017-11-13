Received: from eggs.gnu.org ([2001:4830:134:3::10]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU6-0007Zx-OM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU3-0003AA-1c
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:12572 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eEHU2-000389-Ls
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Nov 2017 19:20:50 +0300
Message-Id: <20171113162053.58795-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171113162053.58795-1-vsementsov@virtuozzo.com>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] block/dirty-bitmap: add lock to
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
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

Like other setters here these functions should take a lock.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bd04e991b1..2a0bcd9e51 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -397,15 +397,19 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
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
