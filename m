Received: from eggs.gnu.org ([2001:4830:134:3::10]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBT-00045U-MX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBR-0007O3-Dt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:20:56 +0300
Message-Id: <20180326112056.8420-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180326112056.8420-1-vsementsov@virtuozzo.com>
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/7] blockdev: unify block-dirty-bitmap-clear
 command and transaction action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

 - use error messages from qmp command, as they are more descriptive
 - we need not check bs, as block_dirty_bitmap_lookup never returns
   bs = NULL on success (and if user set bs to be not NULL pointer),
   so, let's just assert it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 53 +++++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 54e1ba8f44..3f0979298e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2114,18 +2114,26 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     if (!state->bitmap) {
         return;
     }
+    assert(state->bs != NULL);
 
     if (bdrv_dirty_bitmap_frozen(state->bitmap)) {
-        error_setg(errp, "Cannot modify a frozen bitmap");
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be modified",
+                   action->name);
         return;
     } else if (bdrv_dirty_bitmap_qmp_locked(state->bitmap)) {
-        error_setg(errp, "Cannot modify a locked bitmap");
+        error_setg(errp,
+                   "Bitmap '%s' is currently locked and cannot be modified",
+                   action->name);
         return;
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
-        error_setg(errp, "Cannot clear a disabled bitmap");
+        error_setg(errp,
+                   "Bitmap '%s' is currently disabled and cannot be cleared",
+                   action->name);
         return;
     } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
-        error_setg(errp, "Cannot clear a readonly bitmap");
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared",
+                   action->name);
         return;
     }
 }
@@ -2878,35 +2886,16 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
 void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                                   Error **errp)
 {
-    BdrvDirtyBitmap *bitmap;
-    BlockDriverState *bs;
-
-    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap || !bs) {
-        return;
-    }
-
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be modified",
-                   name);
-        return;
-    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently locked and cannot be modified",
-                   name);
-        return;
-    } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently disabled and cannot be cleared",
-                   name);
-        return;
-    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
-        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
-        return;
-    }
+    BlockDirtyBitmap data = {
+        .node = (char *)node,
+        .name = (char *)name
+    };
+    TransactionAction action = {
+        .type = TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR,
+        .u.block_dirty_bitmap_clear.data = &data,
+    };
 
-    bdrv_clear_dirty_bitmap(bitmap);
+    blockdev_do_action(&action, errp);
 }
 
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
-- 
2.11.1
