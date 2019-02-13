Received: from eggs.gnu.org ([209.51.188.92]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu49d-0005gH-AK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu3ts-0005ZC-Iy
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:25:09 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:23:54 -0500
Message-Id: <20190213232356.21034-5-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-1-jsnow@redhat.com>
References: <20190213232356.21034-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] block/dirty-bitmap: explicitly lock
 bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Instead of implying a locked status, make it explicit.
Now, bitmaps in use by migration, NBD or backup operations
are all treated the same way with the same code paths.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/dirty-bitmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bb2e19e0d8..2042c62602 100644
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
