Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLb-0002nP-8l
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLW-0004MP-Vf
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Feb 2017 12:54:40 +0300
Message-Id: <1486979689-230770-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 08/17] block/dirty-bitmap: add
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c         | 10 ++++++++++
 include/block/dirty-bitmap.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index ab2c7f5..32aa6eb 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -274,6 +274,16 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     return parent;
 }
 
+void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
+                                         BdrvDirtyBitmap *parent)
+{
+    BdrvDirtyBitmap *successor = parent->successor;
+
+    if (successor) {
+        bdrv_release_dirty_bitmap(bs, successor);
+        parent->successor = NULL;
+    }
+}
 /**
  * Truncates _all_ bitmaps attached to a BDS.
  */
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 57b476c..20b3ec7 100644
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
1.8.3.1
