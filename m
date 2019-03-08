Received: from eggs.gnu.org ([209.51.188.92]:44851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0000rH-8M
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7G-0006uC-HU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7F-0006mg-7M
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:13 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:47 -0500
Message-Id: <20190308202858.26636-7-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 06/17] block/dirty-bitmap: explicitly lock
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
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Instead of implying a user_locked/busy status, make it explicit.
Now, bitmaps in use by migration, NBD or backup operations
are all treated the same way with the same code paths.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 2e3192d86f..abc219814c 100644
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
 
@@ -323,6 +322,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->successor = NULL;
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
+    bitmap->qmp_locked = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
 
     return successor;
@@ -352,6 +352,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
     }
 
     parent->disabled = successor->disabled;
+    parent->qmp_locked = false;
     bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
-- 
2.17.2
