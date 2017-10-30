Received: from eggs.gnu.org ([2001:4830:134:3::10]:43205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D08-0006LC-He
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006bW-G8
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:32:58 +0300
Message-Id: <20171030163309.75770-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 03/14] block/dirty-bitmap: add
 bdrv_dirty_bitmap_release_successor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

To just release successor and unfreeze bitmap without any additional
work.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 93d4336505..a9e2a92e4f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -20,6 +20,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *bitmap,
                                            Error **errp);
+void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 981f99d362..7578863aa1 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -431,6 +431,20 @@ void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
     bitmap->disabled = false;
 }
 
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *parent)
+{
+    qemu_mutex_lock(parent->mutex);
+
+    if (parent->successor) {
+        bdrv_release_dirty_bitmap_locked(bs, parent->successor);
+        parent->successor = NULL;
+    }
+
+    qemu_mutex_unlock(parent->mutex);
+}
+
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bm;
-- 
2.11.1
