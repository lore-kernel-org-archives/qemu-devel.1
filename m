Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU6-0007Zy-Oa
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEHU3-0003BD-G8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:14368 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eEHU3-00038v-4b
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:21:15 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Nov 2017 19:20:51 +0300
Message-Id: <20171113162053.58795-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171113162053.58795-1-vsementsov@virtuozzo.com>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] qapi: add block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
 blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e348e6..487744c16b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1672,6 +1672,48 @@
   'data': 'BlockDirtyBitmap' }
 
 ##
+# @block-dirty-bitmap-enable:
+#
+# Enable dirty bitmap, so that it will continue tracking disk changes.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found, GenericError with an explanation
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-enable",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
+##
+  { 'command': 'block-dirty-bitmap-enable',
+    'data': 'BlockDirtyBitmap' }
+
+##
+# @block-dirty-bitmap-disable:
+#
+# Disable dirty bitmap, so that it will stop tracking disk changes.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found, GenericError with an explanation
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-disable",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
+##
+    { 'command': 'block-dirty-bitmap-disable',
+      'data': 'BlockDirtyBitmap' }
+
+##
 # @BlockDirtyBitmapSha256:
 #
 # SHA256 hash of dirty bitmap data
diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..fe1eb751f0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2827,6 +2827,48 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     bdrv_clear_dirty_bitmap(bitmap, NULL);
 }
 
+void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
+                                   Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be enabled",
+                   name);
+        return;
+    }
+
+    bdrv_enable_dirty_bitmap(bitmap);
+}
+
+void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
+                                    Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap || !bs) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be disabled",
+                   name);
+        return;
+    }
+
+    bdrv_disable_dirty_bitmap(bitmap);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
-- 
2.11.1
