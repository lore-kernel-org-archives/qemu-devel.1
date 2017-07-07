Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmX-0006dv-8o
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmW-00013G-BT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:40 +0200
Message-Id: <1499447335-6125-86-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 085/100] qmp: add persistent flag to
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

Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
Default is false.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-24-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c           | 18 +++++++++++++++++-
 qapi/block-core.json |  8 +++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index edeb36b..2ef731b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1983,6 +1983,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
+                               action->has_persistent, action->persistent,
                                &local_err);
 
     if (!local_err) {
@@ -2708,9 +2709,11 @@ out:
 
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
+                                bool has_persistent, bool persistent,
                                 Error **errp)
 {
     BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
 
     if (!name || name[0] == '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2733,7 +2736,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         granularity = bdrv_get_default_bitmap_granularity(bs);
     }
 
-    bdrv_create_dirty_bitmap(bs, granularity, name, errp);
+    if (!has_persistent) {
+        persistent = false;
+    }
+
+    if (persistent &&
+        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
+    {
+        return;
+    }
+
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
+    if (bitmap != NULL) {
+        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    }
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9570963..907ac9d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1553,10 +1553,16 @@
 # @granularity: the bitmap granularity, default is 64k for
 #               block-dirty-bitmap-add
 #
+# @persistent: the bitmap is persistent, i.e. it will be saved to the
+#              corresponding block device image file on its close. For now only
+#              Qcow2 disks support persistent bitmaps. Default is false for
+#              block-dirty-bitmap-add. (Since: 2.10)
+#
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
-  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }
+  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
+            '*persistent': 'bool' } }
 
 ##
 # @block-dirty-bitmap-add:
-- 
1.8.3.1
