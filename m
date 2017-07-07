Received: from eggs.gnu.org ([2001:4830:134:3::10]:43673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmh-0006px-M4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmg-0001Fx-QQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:46 +0200
Message-Id: <1499447335-6125-92-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 091/100] qmp: block-dirty-bitmap-remove: remove
 persistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Remove persistent bitmap from the storage on block-dirty-bitmap-remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-30-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c           | 10 ++++++++++
 qapi/block-core.json |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 988a60d..124c230 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2771,6 +2771,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
+    Error *local_err = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
@@ -2783,6 +2784,15 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
                    name);
         return;
     }
+
+    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     bdrv_dirty_bitmap_make_anon(bitmap);
     bdrv_release_dirty_bitmap(bs, bitmap);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9b5047d..4bf11e8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1593,7 +1593,8 @@
 # @block-dirty-bitmap-remove:
 #
 # Stop write tracking and remove the dirty bitmap that was created
-# with block-dirty-bitmap-add.
+# with block-dirty-bitmap-add. If the bitmap is persistent, remove it from its
+# storage too.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device or node, DeviceNotFound
-- 
1.8.3.1
