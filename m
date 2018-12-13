Received: from eggs.gnu.org ([2001:4830:134:3::10]:42486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG9A-0002Pg-IP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG96-0001Jb-HI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:40 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:08 -0500
Message-Id: <20181213015013.15350-3-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-1-jsnow@redhat.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Especially outside of transactions, it is helpful to provide
all-or-nothing semantics for bitmap merges. This facilitates
the coalescing of multiple bitmaps into a single target for
the "checkpoint" interpretation when assembling bitmaps that
represent arbitrary points in time from component bitmaps.

This is an incompatible change from the preliminary version
of the API.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c           | 64 +++++++++++++++++++++++++++++---------------
 qapi/block-core.json | 22 +++++++--------
 2 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 1ba706df8b..0f740fd964 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2122,33 +2122,26 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
     }
 }
 
+void do_block_dirty_bitmap_merge(const char *node, const char *target,
+                                 strList *bitmaps, HBitmap **backup,
+                                 Error **errp);
+
 static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
                                              Error **errp)
 {
     BlockDirtyBitmapMerge *action;
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
-    BdrvDirtyBitmap *merge_source;
 
     if (action_check_completion_mode(common, errp) < 0) {
         return;
     }
 
     action = common->action->u.x_block_dirty_bitmap_merge.data;
-    state->bitmap = block_dirty_bitmap_lookup(action->node,
-                                              action->dst_name,
-                                              &state->bs,
-                                              errp);
-    if (!state->bitmap) {
-        return;
-    }
 
-    merge_source = bdrv_find_dirty_bitmap(state->bs, action->src_name);
-    if (!merge_source) {
-        return;
-    }
-
-    bdrv_merge_dirty_bitmap(state->bitmap, merge_source, &state->backup, errp);
+    do_block_dirty_bitmap_merge(action->node, action->target,
+                                action->bitmaps, &state->backup,
+                                errp);
 }
 
 static void abort_prepare(BlkActionState *common, Error **errp)
@@ -2980,24 +2973,51 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
-void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
-                                    const char *src_name, Error **errp)
+void do_block_dirty_bitmap_merge(const char *node, const char *target,
+                                 strList *bitmaps, HBitmap **backup,
+                                 Error **errp)
 {
     BlockDriverState *bs;
-    BdrvDirtyBitmap *dst, *src;
+    BdrvDirtyBitmap *dst, *src, *anon;
+    strList *lst;
+    Error *local_err = NULL;
 
-    dst = block_dirty_bitmap_lookup(node, dst_name, &bs, errp);
+    dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
     if (!dst) {
         return;
     }
 
-    src = bdrv_find_dirty_bitmap(bs, src_name);
-    if (!src) {
-        error_setg(errp, "Dirty bitmap '%s' not found", src_name);
+    anon = bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(dst),
+                                    NULL, errp);
+    if (!anon) {
         return;
     }
 
-    bdrv_merge_dirty_bitmap(dst, src, NULL, errp);
+    for (lst = bitmaps; lst; lst = lst->next) {
+        src = bdrv_find_dirty_bitmap(bs, lst->value);
+        if (!src) {
+            error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
+            goto out;
+        }
+
+        bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto out;
+        }
+    }
+
+    /* Merge into dst; dst is unchanged on failure. */
+    bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
+
+ out:
+    bdrv_release_dirty_bitmap(bs, anon);
+}
+
+void qmp_x_block_dirty_bitmap_merge(const char *node, const char *target,
+                                    strList *bitmaps, Error **errp)
+{
+    do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
 
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710836..320d74ef34 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1818,14 +1818,14 @@
 #
 # @node: name of device/node which the bitmap is tracking
 #
-# @dst_name: name of the destination dirty bitmap
+# @target: name of the destination dirty bitmap
 #
-# @src_name: name of the source dirty bitmap
+# @bitmaps: name(s) of the source dirty bitmap(s)
 #
 # Since: 3.0
 ##
 { 'struct': 'BlockDirtyBitmapMerge',
-  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
+  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
 
 ##
 # @block-dirty-bitmap-add:
@@ -1940,23 +1940,23 @@
 ##
 # @x-block-dirty-bitmap-merge:
 #
-# FIXME: Rename @src_name and @dst_name to src-name and dst-name.
-#
-# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
-# bitmap is unchanged. On error, @dst_name is unchanged.
+# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
+# The @bitmaps dirty bitmaps are unchanged.
+# On error, @target is unchanged.
 #
 # Returns: nothing on success
 #          If @node is not a valid block device, DeviceNotFound
-#          If @dst_name or @src_name is not found, GenericError
-#          If bitmaps has different sizes or granularities, GenericError
+#          If any bitmap in @bitmaps or @target is not found, GenericError
+#          If any of the bitmaps have different sizes or granularities,
+#              GenericError
 #
 # Since: 3.0
 #
 # Example:
 #
 # -> { "execute": "x-block-dirty-bitmap-merge",
-#      "arguments": { "node": "drive0", "dst_name": "bitmap0",
-#                     "src_name": "bitmap1" } }
+#      "arguments": { "node": "drive0", "target": "bitmap0",
+#                     "bitmaps": ["bitmap1"] } }
 # <- { "return": {} }
 #
 ##
-- 
2.17.2
