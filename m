Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlI-00015X-IE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlH-0006le-NA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:40 +0200
Message-Id: <20170711160814.20941-52-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 51/85] qmp: block-dirty-bitmap-remove: remove
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Remove persistent bitmap from the storage on block-dirty-bitmap-remove.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-30-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  3 ++-
 blockdev.c           | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
-- 
2.9.4
