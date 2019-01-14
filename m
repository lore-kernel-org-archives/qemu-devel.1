Received: from eggs.gnu.org ([209.51.188.92]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54R-0003jl-LU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54O-0005Jz-Pd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:49 -0600
Message-Id: <20190114162605.5330-5-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/20] block: remove 'x' prefix from
 experimental bitmap APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

The 'x' prefix was added because I was uncertain of the direction we'd
take for the libvirt API. With the general approach solidified, I feel
comfortable committing to this API for 4.0.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-5-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json   | 34 +++++++++++++++++-----------------
 qapi/transaction.json  | 12 ++++++------
 blockdev.c             | 22 +++++++++++-----------
 tests/qemu-iotests/223 |  4 ++--
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a153ea44203..91685be6c29 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1806,15 +1806,15 @@
 #            Currently, all dirty tracking bitmaps are loaded from Qcow2=
 on
 #            open.
 #
-# @x-disabled: the bitmap is created in the disabled state, which means =
that
-#              it will not track drive changes. The bitmap may be enable=
d with
-#              x-block-dirty-bitmap-enable. Default is false. (Since: 3.=
0)
+# @disabled: the bitmap is created in the disabled state, which means th=
at
+#            it will not track drive changes. The bitmap may be enabled =
with
+#            block-dirty-bitmap-enable. Default is false. (Since: 4.0)
 #
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
-            '*persistent': 'bool', '*autoload': 'bool', '*x-disabled': '=
bool' } }
+            '*persistent': 'bool', '*autoload': 'bool', '*disabled': 'bo=
ol' } }

 ##
 # @BlockDirtyBitmapMerge:
@@ -1825,7 +1825,7 @@
 #
 # @bitmaps: name(s) of the source dirty bitmap(s)
 #
-# Since: 3.0
+# Since: 4.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
   'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
@@ -1899,7 +1899,7 @@
   'data': 'BlockDirtyBitmap' }

 ##
-# @x-block-dirty-bitmap-enable:
+# @block-dirty-bitmap-enable:
 #
 # Enables a dirty bitmap so that it will begin tracking disk changes.
 #
@@ -1907,20 +1907,20 @@
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
@@ -1928,20 +1928,20 @@
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
@@ -1953,17 +1953,17 @@
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
index 5875cdb16c5..95edb782278 100644
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
diff --git a/blockdev.c b/blockdev.c
index f7bf48dfe71..a8fa8748a9c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1963,7 +1963,7 @@ static void block_dirty_bitmap_add_prepare(BlkActio=
nState *common,
                                action->has_granularity, action->granular=
ity,
                                action->has_persistent, action->persisten=
t,
                                action->has_autoload, action->autoload,
-                               action->has_x_disabled, action->x_disable=
d,
+                               action->has_disabled, action->disabled,
                                &local_err);

     if (!local_err) {
@@ -2048,7 +2048,7 @@ static void block_dirty_bitmap_enable_prepare(BlkAc=
tionState *common,
         return;
     }

-    action =3D common->action->u.x_block_dirty_bitmap_enable.data;
+    action =3D common->action->u.block_dirty_bitmap_enable.data;
     state->bitmap =3D block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2089,7 +2089,7 @@ static void block_dirty_bitmap_disable_prepare(BlkA=
ctionState *common,
         return;
     }

-    action =3D common->action->u.x_block_dirty_bitmap_disable.data;
+    action =3D common->action->u.block_dirty_bitmap_disable.data;
     state->bitmap =3D block_dirty_bitmap_lookup(action->node,
                                               action->name,
                                               NULL,
@@ -2136,7 +2136,7 @@ static void block_dirty_bitmap_merge_prepare(BlkAct=
ionState *common,
         return;
     }

-    action =3D common->action->u.x_block_dirty_bitmap_merge.data;
+    action =3D common->action->u.block_dirty_bitmap_merge.data;

     state->bitmap =3D do_block_dirty_bitmap_merge(action->node, action->=
target,
                                                 action->bitmaps, &state-=
>backup,
@@ -2204,17 +2204,17 @@ static const BlkActionOps actions[] =3D {
         .commit =3D block_dirty_bitmap_free_backup,
         .abort =3D block_dirty_bitmap_restore,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] =3D {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] =3D {
         .instance_size =3D sizeof(BlockDirtyBitmapState),
         .prepare =3D block_dirty_bitmap_enable_prepare,
         .abort =3D block_dirty_bitmap_enable_abort,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_DISABLE] =3D {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] =3D {
         .instance_size =3D sizeof(BlockDirtyBitmapState),
         .prepare =3D block_dirty_bitmap_disable_prepare,
         .abort =3D block_dirty_bitmap_disable_abort,
     },
-    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] =3D {
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_MERGE] =3D {
         .instance_size =3D sizeof(BlockDirtyBitmapState),
         .prepare =3D block_dirty_bitmap_merge_prepare,
         .commit =3D block_dirty_bitmap_free_backup,
@@ -2930,7 +2930,7 @@ void qmp_block_dirty_bitmap_clear(const char *node,=
 const char *name,
     bdrv_clear_dirty_bitmap(bitmap, NULL);
 }

-void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
+void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
                                    Error **errp)
 {
     BlockDriverState *bs;
@@ -2951,7 +2951,7 @@ void qmp_x_block_dirty_bitmap_enable(const char *no=
de, const char *name,
     bdrv_enable_dirty_bitmap(bitmap);
 }

-void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name=
,
+void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
                                     Error **errp)
 {
     BlockDriverState *bs;
@@ -3018,8 +3018,8 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge=
(const char *node,
     return dst;
 }

-void qmp_x_block_dirty_bitmap_merge(const char *node, const char *target=
,
-                                    strList *bitmaps, Error **errp)
+void qmp_block_dirty_bitmap_merge(const char *node, const char *target,
+                                  strList *bitmaps, Error **errp)
 {
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 397b865d347..5513dc62159 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -112,9 +112,9 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabili=
ties"}' "return"
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
--=20
2.20.1
