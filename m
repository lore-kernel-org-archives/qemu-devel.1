Received: from eggs.gnu.org ([2001:4830:134:3::10]:60377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj6-0006QO-PS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-00033L-Al
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18504 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002y4-Rq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:23 +0300
Message-Id: <20170628120530.31251-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 23/30] qmp: add persistent flag to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
Default is false.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 18 +++++++++++++++++-
 qapi/block-core.json |  8 +++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 64e03c0caf..125acabc07 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1973,6 +1973,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
+                               action->has_persistent, action->persistent,
                                &local_err);
 
     if (!local_err) {
@@ -2720,9 +2721,11 @@ out:
 
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
+                                bool has_persistent, bool persistent,
                                 Error **errp)
 {
     BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
 
     if (!name || name[0] == '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2745,7 +2748,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
index f85c2235c7..13f98ec146 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1561,10 +1561,16 @@
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
2.11.1
