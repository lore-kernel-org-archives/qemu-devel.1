Received: from eggs.gnu.org ([209.51.188.92]:42385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMVc-0004ur-FZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMVU-0001IZ-MV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:05:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Feb 2019 20:02:47 -0500
Message-Id: <20190212010248.11056-5-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-1-jsnow@redhat.com>
References: <20190212010248.11056-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] block/dirty-bitmap: explicitly lock
 bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Instead of implying a locked status, make it explicit.
Now, bitmaps in use by migration, NBD or backup operations
are all treated the same way with the same code paths.
---
 block/dirty-bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 1a433130ff..22c4a9e0fe 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -188,10 +188,8 @@ bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap)
     return bitmap->successor;
 }
 
-/* Both conditions disallow user-modification via QMP. */
 bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap) {
-    return bdrv_dirty_bitmap_has_successor(bitmap) ||
-           bdrv_dirty_bitmap_qmp_locked(bitmap);
+    return bdrv_dirty_bitmap_qmp_locked(bitmap);
 }
 
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
@@ -266,8 +264,9 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     child->disabled = bitmap->disabled;
     bitmap->disabled = true;
 
-    /* Install the successor and freeze the parent */
+    /* Install the successor and lock the parent */
     bitmap->successor = child;
+    bitmap->qmp_locked = true;
     return 0;
 }
 
@@ -321,6 +320,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
+    bitmap->qmp_locked = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -349,6 +349,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
     }
 
     parent->disabled = successor->disabled;
+    parent->qmp_locked = false;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
-- 
2.17.2
