Received: from eggs.gnu.org ([2001:4830:134:3::10]:51872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlO-0002mz-Uf
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlN-000790-OR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:51 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:8608 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ebQlN-00077Z-Dd
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:49 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Jan 2018 15:54:27 +0300
Message-Id: <20180116125427.18540-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180116125427.18540-1-vsementsov@virtuozzo.com>
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 6/6] qapi: add disabled parameter to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is needed, for example, to create a new bitmap and merge several
disabled bitmaps into a new one. Without this flag we will have to
put block-dirty-bitmap-add and block-dirty-bitmap-disable into one
transaction.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |  6 +++++-
 blockdev.c           | 10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9f9cfa0a44..de8041d11d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1597,11 +1597,15 @@
 #            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
 #            open.
 #
+# @disabled: bitmap is created in disabled state, which means that it will not
+#            track drive changes. The bitmap may be enabled with
+#            block-dirty-bitmap-enable. Default is false. (Since: 2.12)
+#
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool' } }
+            '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bool' } }
 
 ##
 # @BlockDirtyBitmapMerge:
diff --git a/blockdev.c b/blockdev.c
index 1650c31c87..444fccaab4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1983,6 +1983,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
                                action->has_autoload, action->autoload,
+                               action->has_disabled, action->disabled,
                                &local_err);
 
     if (!local_err) {
@@ -2788,6 +2789,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
                                 bool has_granularity, uint32_t granularity,
                                 bool has_persistent, bool persistent,
                                 bool has_autoload, bool autoload,
+                                bool has_disabled, bool disabled,
                                 Error **errp)
 {
     BlockDriverState *bs;
@@ -2822,6 +2824,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         warn_report("Autoload option is deprected and its value is ignored");
     }
 
+    if (!has_disabled) {
+        disabled = false;
+    }
+
     if (persistent &&
         !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
     {
@@ -2833,6 +2839,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         return;
     }
 
+    if (disabled) {
+        bdrv_disable_dirty_bitmap(bitmap);
+    }
+
     bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
 }
 
-- 
2.11.1
