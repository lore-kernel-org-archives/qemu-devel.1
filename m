Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQa-0001pp-QF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQS-0005LS-C8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:16 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:29578 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQS-0005II-0M
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:51 +0300
Message-Id: <20170613140358.81651-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 23/30] qmp: add persistent flag to
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
index 2b397abf66..12ee9a3eda 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1982,6 +1982,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
+                               action->has_persistent, action->persistent,
                                &local_err);
 
     if (!local_err) {
@@ -2730,10 +2731,12 @@ out:
 
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
+                                bool has_persistent, bool persistent,
                                 Error **errp)
 {
     AioContext *aio_context;
     BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
 
     if (!name || name[0] == '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2759,7 +2762,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
+        goto out;
+    }
+
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
+    if (bitmap != NULL) {
+        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    }
 
  out:
     aio_context_release(aio_context);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea0b3e8b13..5d9ed0e208 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1560,10 +1560,16 @@
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
