Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZaM2-000446-B7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZaLy-0004Qp-6x
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:30 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:2749 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZaLx-0004Mx-Pd
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:26 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 12:40:11 +0300
Message-Id: <20170203094018.15493-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-1-vsementsov@virtuozzo.com>
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 17/24] qmp: add autoload parameter to
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
---
 blockdev.c           | 18 ++++++++++++++++--
 qapi/block-core.json |  6 +++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 40605faccc..e32ac69e4b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1968,6 +1968,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
     qmp_block_dirty_bitmap_add(action->node, action->name,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
+                               action->has_autoload, action->autoload,
                                &local_err);
 
     if (!local_err) {
@@ -2698,6 +2699,7 @@ out:
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 bool has_persistent, bool persistent,
+                                bool has_autoload, bool autoload,
                                 Error **errp)
 {
     AioContext *aio_context;
@@ -2731,6 +2733,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
@@ -2739,10 +2750,13 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
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
index 535df20212..09dcf4e6ae 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1564,11 +1564,15 @@
 #              Qcow2 disks support persistent bitmaps. Default is false.
 #              (Since 2.9)
 #
+# @autoload: #optional the bitmap will be automatically loaded when the image
+#            it is stored in is opened. This flag may only be specified for
+#            persistent bitmaps. Default is false. (Since 2.9)
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
2.11.0
