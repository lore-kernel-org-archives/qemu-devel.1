Received: from eggs.gnu.org ([2001:4830:134:3::10]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmX-0006eF-JN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmW-00013W-E9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:41 +0200
Message-Id: <1499447335-6125-87-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 086/100] qmp: add autoload parameter to
 block-dirty-bitmap-add
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

Optional. Default is false.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-25-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c           | 18 ++++++++++++++++--
 qapi/block-core.json |  6 +++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 2ef731b..b7c1449 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1984,6 +1984,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
+                               action->has_autoload, action->autoload,
                                &local_err);
 
     if (!local_err) {
@@ -2710,6 +2711,7 @@ out:
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 bool has_persistent, bool persistent,
+                                bool has_autoload, bool autoload,
                                 Error **errp)
 {
     BlockDriverState *bs;
@@ -2739,6 +2741,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     if (!has_persistent) {
         persistent = false;
     }
+    if (!has_autoload) {
+        autoload = false;
+    }
+
+    if (has_autoload && !persistent) {
+        error_setg(errp, "Autoload flag must be used only for persistent "
+                         "bitmaps");
+        return;
+    }
 
     if (persistent &&
         !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
@@ -2747,9 +2758,12 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
-    if (bitmap != NULL) {
-        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    if (bitmap == NULL) {
+        return;
     }
+
+    bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 907ac9d..fb69efe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1558,11 +1558,15 @@
 #              Qcow2 disks support persistent bitmaps. Default is false for
 #              block-dirty-bitmap-add. (Since: 2.10)
 #
+# @autoload: the bitmap will be automatically loaded when the image it is stored
+#            in is opened. This flag may only be specified for persistent
+#            bitmaps. Default is false for block-dirty-bitmap-add. (Since: 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool' } }
+            '*persistent': 'bool', '*autoload': 'bool' } }
 
 ##
 # @block-dirty-bitmap-add:
-- 
1.8.3.1
