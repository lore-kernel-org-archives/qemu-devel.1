Received: from eggs.gnu.org ([2001:4830:134:3::10]:39953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgW-0000yF-23
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgU-0003Hj-9n
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:56 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 14 Dec 2018 18:15:08 -0500
Message-Id: <20181214231512.5295-4-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-1-jsnow@redhat.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/7] block: remove 'x' prefix from
 experimental bitmap APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

The 'x' prefix was added because I was uncertain of the direction we'd
take for the libvirt API. With the general approach solidified, I feel
comfortable committing to this API for 4.0.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c             | 22 +++++++++++-----------
 qapi/block-core.json   | 34 +++++++++++++++++-----------------
 qapi/transaction.json  | 12 ++++++------
 tests/qemu-iotests/223 |  4 ++--
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 0f740fd964..da87aae5cf 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1966,7 +1966,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
                                action->has_granularity, action->granularity,
                                action->has_persistent, action->persistent,
                                action->has_autoload, action->autoload,
-                               action->has_x_disabled, action->x_disabled,
+                               action->has_disabled, action->disabled,
                                &local_err);
 
     if (!local_err) {
@@ -2051,7 +2051,7 @@ static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.x_block_dirty_bitmap_enable.data;
+    action = common->action->u.block_dirty_bitmap_enable.data;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2092,7 +2092,7 @@ static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.x_block_dirty_bitmap_disable.data;
+    action = common->action->u.block_dirty_bitmap_disable.data;
     state->bitmap = block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2137,7 +2137,7 @@ static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
         return;
     }
 
-    action = common->action->u.x_block_dirty_bitmap_merge.data;
+    action = common->action->u.block_dirty_bitmap_merge.data;
 
     do_block_dirty_bitmap_merge(action->node, action->target,
                                 action->bitmaps, &state->backup,
@@ -2205,17 +2205,17 @@ static const BlkActionOps actions[] = {
         .commit = block_dirty_bitmap_free_backup,
         .abort = block_dirty_bitmap_restore,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] = {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_enable_prepare,
         .abort = block_dirty_bitmap_enable_abort,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_DISABLE] = {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_disable_prepare,
         .abort = block_dirty_bitmap_disable_abort,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_MERGE] = {
         .instance_size = sizeof(BlockDirtyBitmapState),
         .prepare = block_dirty_bitmap_merge_prepare,
         .commit = block_dirty_bitmap_free_backup,
@@ -2931,7 +2931,7 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     bdrv_clear_dirty_bitmap(bitmap, NULL);
 }
 
-void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
+void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
                                    Error **errp)
 {
     BlockDriverState *bs;
@@ -2952,7 +2952,7 @@ void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
     bdrv_enable_dirty_bitmap(bitmap);
 }
 
-void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
+void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
                                     Error **errp)
 {
     BlockDriverState *bs;
@@ -3014,8 +3014,8 @@ void do_block_dirty_bitmap_merge(const char *node, const char *target,
     bdrv_release_dirty_bitmap(bs, anon);
 }
 
-void qmp_x_block_dirty_bitmap_merge(const char *node, const char *target,
-                                    strList *bitmaps, Error **errp)
+void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
+                                  strList *bitmaps, Error **errp)
 {
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 320d74ef34..fde96fdb50 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1803,15 +1803,15 @@
 #            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
 #            open.
 #
-# @x-disabled: the bitmap is created in the disabled state, which means that
-#              it will not track drive changes. The bitmap may be enabled with
-#              x-block-dirty-bitmap-enable. Default is false. (Since: 3.0)
+# @disabled: the bitmap is created in the disabled state, which means that
+#            it will not track drive changes. The bitmap may be enabled with
+#            block-dirty-bitmap-enable. Default is false. (Since: 4.0)
 #
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool', '*x-disabled': 'bool' } }
+            '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bool' } }
 
 ##
 # @BlockDirtyBitmapMerge:
@@ -1822,7 +1822,7 @@
 #
 # @bitmaps: name(s) of the source dirty bitmap(s)
 #
-# Since: 3.0
+# Since: 4.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
   'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
@@ -1896,7 +1896,7 @@
   'data': 'BlockDirtyBitmap' }
 
 ##
-# @x-block-dirty-bitmap-enable:
+# @block-dirty-bitmap-enable:
 #
 # Enables a dirty bitmap so that it will begin tracking disk changes.
 #
@@ -1904,20 +1904,20 @@
 #          If @node is not a valid block device, DeviceNotFound
 #          If @name is not found, GenericError with an explanation
 #
-# Since: 3.0
+# Since: 4.0
 #
 # Example:
 #
-# -> { "execute": "x-block-dirty-bitmap-enable",
+# -> { "execute": "block-dirty-bitmap-enable",
 #      "arguments": { "node": "drive0", "name": "bitmap0" } }
 # <- { "return": {} }
 #
 ##
-  { 'command': 'x-block-dirty-bitmap-enable',
+  { 'command': 'block-dirty-bitmap-enable',
     'data': 'BlockDirtyBitmap' }
 
 ##
-# @x-block-dirty-bitmap-disable:
+# @block-dirty-bitmap-disable:
 #
 # Disables a dirty bitmap so that it will stop tracking disk changes.
 #
@@ -1925,20 +1925,20 @@
 #          If @node is not a valid block device, DeviceNotFound
 #          If @name is not found, GenericError with an explanation
 #
-# Since: 3.0
+# Since: 4.0
 #
 # Example:
 #
-# -> { "execute": "x-block-dirty-bitmap-disable",
+# -> { "execute": "block-dirty-bitmap-disable",
 #      "arguments": { "node": "drive0", "name": "bitmap0" } }
 # <- { "return": {} }
 #
 ##
-    { 'command': 'x-block-dirty-bitmap-disable',
+    { 'command': 'block-dirty-bitmap-disable',
       'data': 'BlockDirtyBitmap' }
 
 ##
-# @x-block-dirty-bitmap-merge:
+# @block-dirty-bitmap-merge:
 #
 # Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
 # The @bitmaps dirty bitmaps are unchanged.
@@ -1950,17 +1950,17 @@
 #          If any of the bitmaps have different sizes or granularities,
 #              GenericError
 #
-# Since: 3.0
+# Since: 4.0
 #
 # Example:
 #
-# -> { "execute": "x-block-dirty-bitmap-merge",
+# -> { "execute": "block-dirty-bitmap-merge",
 #      "arguments": { "node": "drive0", "target": "bitmap0",
 #                     "bitmaps": ["bitmap1"] } }
 # <- { "return": {} }
 #
 ##
-      { 'command': 'x-block-dirty-bitmap-merge',
+      { 'command': 'block-dirty-bitmap-merge',
         'data': 'BlockDirtyBitmapMerge' }
 
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 5875cdb16c..95edb78227 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -46,9 +46,9 @@
 # - @abort: since 1.6
 # - @block-dirty-bitmap-add: since 2.5
 # - @block-dirty-bitmap-clear: since 2.5
-# - @x-block-dirty-bitmap-enable: since 3.0
-# - @x-block-dirty-bitmap-disable: since 3.0
-# - @x-block-dirty-bitmap-merge: since 3.1
+# - @block-dirty-bitmap-enable: since 4.0
+# - @block-dirty-bitmap-disable: since 4.0
+# - @block-dirty-bitmap-merge: since 4.0
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -62,9 +62,9 @@
        'abort': 'Abort',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
        'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
-       'x-block-dirty-bitmap-enable': 'BlockDirtyBitmap',
-       'x-block-dirty-bitmap-disable': 'BlockDirtyBitmap',
-       'x-block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
+       'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
+       'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
+       'block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 397b865d34..5513dc6215 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -112,9 +112,9 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabilities"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
   "arguments":{"driver":"qcow2", "node-name":"n",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
-- 
2.17.2
