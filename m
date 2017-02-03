Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nc-CB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00082k-Oj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:46671 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-000808-CE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:54 +0300
Message-Id: <20170203154757.36140-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 15/18] qmp: add block-dirty-bitmap-load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

For loading dirty bitmap from nbd server. Or for underlying storages for
other formats.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c           | 28 ++++++++++++++++++++++++++++
 qapi/block-core.json | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 1bc3fe386a..2529943e7f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2790,6 +2790,34 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     aio_context_release(aio_context);
 }
 
+void qmp_block_dirty_bitmap_load(const char *node, const char *name,
+                                 Error **errp)
+{
+    AioContext *aio_context;
+    BlockDriverState *bs;
+
+    if (!node) {
+        error_setg(errp, "Node cannot be NULL");
+        return;
+    }
+    if (!name) {
+        error_setg(errp, "Bitmap name cannot be NULL");
+        return;
+    }
+    bs = bdrv_lookup_bs(node, node, NULL);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node);
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_load_dirty_bitmap(bs, name, errp);
+
+    aio_context_release(aio_context);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b258c45595..63777ea55b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1280,6 +1280,20 @@
   'data': 'BlockDirtyBitmap' }
 
 ##
+# @block-dirty-bitmap-load:
+#
+# Load a dirty bitmap from the storage (qcow2 file or nbd export)
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found, GenericError with an explanation
+#
+# Since: vz-7.4
+##
+  { 'command': 'block-dirty-bitmap-load',
+    'data': 'BlockDirtyBitmap' }
+
+##
 # @BlockDirtyBitmapSha256:
 #
 # SHA256 hash of dirty bitmap data
-- 
2.11.0
