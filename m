Received: from eggs.gnu.org ([2001:4830:134:3::10]:36266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSR-0002H5-Jm
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005Bf-NA
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:47 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:19970 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00058z-9c
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:28 +0300
Message-Id: <20170123121036.4823-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 16/24] qmp: add persistent flag to
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
---
 blockdev.c            | 18 +++++++++++++++++-
 docs/qmp-commands.txt |  3 +++
 qapi/block-core.json  |  7 ++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 245e1e1d17..40605faccc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1967,6 +1967,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     /* AIO context taken and released within qmp_block_dirty_bitmap_add */
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
+                               action->has_persistent, action->persistent,
                                &local_err);
 
     if (!local_err) {
@@ -2696,10 +2697,12 @@ out:
 
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
@@ -2725,7 +2728,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
index abf210a596..ef0245d0df 100644
--- a/docs/qmp-commands.txt
+++ b/docs/qmp-commands.txt
@@ -1015,6 +1015,9 @@ Arguments:
 - "node": device/node on which to create dirty bitmap (json-string)
 - "name": name of the new dirty bitmap (json-string)
 - "granularity": granularity to track writes with (int, optional)
+- "persistent": bitmap will be saved to the corresponding block device image
+                file on its close. For now only Qcow2 disks support persistent
+                bitmaps. (json-bool, optional, default false) (Since 2.9)
 
 Example:
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b42216960..b6a255395a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1231,10 +1231,15 @@
 # @granularity: #optional the bitmap granularity, default is 64k for
 #               block-dirty-bitmap-add
 #
+# @persistent: #optional the bitmap is persistent, i.e. it will be saved to the
+#              corresponding block device image file on its close. Default is
+#              false. (Since 2.9)
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
2.11.0
