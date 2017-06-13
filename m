Received: from eggs.gnu.org ([2001:4830:134:3::10]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQV-0001hc-B4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQS-0005Kw-6J
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22875 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQR-0005Hh-RX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:52 +0300
Message-Id: <20170613140358.81651-25-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 24/30] qmp: add autoload parameter to
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

Optional. Default is false.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 18 ++++++++++++++++--
 qapi/block-core.json |  6 +++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 12ee9a3eda..d04432172a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1983,6 +1983,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
+                               action->has_autoload, action->autoload,
                                &local_err);
 
     if (!local_err) {
@@ -2732,6 +2733,7 @@ out:
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 bool has_persistent, bool persistent,
+                                bool has_autoload, bool autoload,
                                 Error **errp)
 {
     AioContext *aio_context;
@@ -2765,6 +2767,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
+        goto out;
+    }
 
     if (persistent &&
         !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
@@ -2773,10 +2784,13 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
-    if (bitmap != NULL) {
-        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    if (bitmap == NULL) {
+        goto out;
     }
 
+    bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
+
  out:
     aio_context_release(aio_context);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5d9ed0e208..9134a317e5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1565,11 +1565,15 @@
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
2.11.1
