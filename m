Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba6-0000fO-2U
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba2-0001Nj-Sc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 10 Jul 2017 19:30:20 +0300
Message-Id: <20170710163029.129912-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-1-vsementsov@virtuozzo.com>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 07/16] block/dirty-bitmap: add
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
 block/dirty-bitmap.c         | 13 +++++++++++++
 include/block/dirty-bitmap.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 7b598c36bf..b5678d2d25 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -303,6 +303,19 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     return parent;
 }
 
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *parent)
+{
+    qemu_mutex_lock(parent->mutex);
+
+    if (parent->successor) {
+        bdrv_release_dirty_bitmap(bs, parent->successor);
+        parent->successor = NULL;
+    }
+
+    qemu_mutex_unlock(parent->mutex);
+}
 /**
  * Truncates _all_ bitmaps attached to a BDS.
  * Called with BQL taken.
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index d00a7a4b7c..fa2f670050 100644
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
-- 
2.11.1
