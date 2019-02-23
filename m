Received: from eggs.gnu.org ([209.51.188.92]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqU-0000Dx-AU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqS-0001ht-EI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:06:10 -0500
Message-Id: <20190223000614.13894-7-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-1-jsnow@redhat.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/10] block/dirty-bitmap: explicitly lock
 bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

Instead of implying a user_locked/busy status, make it explicit.
Now, bitmaps in use by migration, NBD or backup operations
are all treated the same way with the same code paths.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/dirty-bitmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 976831e765..d92a269753 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -50,7 +50,7 @@ struct BdrvDirtyBitmap {
     HBitmap *meta;              /* Meta dirty bitmap */
     bool qmp_locked;            /* Bitmap is locked, it can't be modified
                                    through QMP */
-    BdrvDirtyBitmap *successor; /* Anonymous child; implies user_locked state */
+    BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
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
@@ -267,8 +265,9 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     child->disabled = bitmap->disabled;
     bitmap->disabled = true;
 
-    /* Install the successor and freeze the parent */
+    /* Install the successor and lock the parent */
     bitmap->successor = child;
+    bitmap->qmp_locked = true;
     return 0;
 }
 
@@ -322,6 +321,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
+    bitmap->qmp_locked = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -351,6 +351,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
     }
 
     parent->disabled = successor->disabled;
+    parent->qmp_locked = false;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
-- 
2.17.2
