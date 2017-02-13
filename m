Received: from eggs.gnu.org ([2001:4830:134:3::10]:59501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM7-0003SH-Qh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKM6-0006DL-3g
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:44 +0100
Message-Id: <1487006583-24350-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 22/41] block: Add
 BdrvChildRole.get_link_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

For meaningful error messages in the permission system, we want to allow
the parent of a BdrvChild to generate some kind of human-readable
identifier for the link represented by the BdrvChild.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   |  8 ++++++++
 block/block-backend.c     | 20 ++++++++++++++++++++
 include/block/block_int.h |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/block.c b/block.c
index fd06549..2116542 100644
--- a/block.c
+++ b/block.c
@@ -800,6 +800,13 @@ const BdrvChildRole child_format = {
     .drained_end     = bdrv_child_cb_drained_end,
 };
 
+static char *bdrv_backing_link_name(BdrvChild *c)
+{
+    BlockDriverState *parent = c->opaque;
+    return g_strdup_printf("backing file link from %s",
+                           bdrv_get_device_or_node_name(parent));
+}
+
 /*
  * Returns the options and flags that bs->backing should get, based on the
  * given options and flags for the parent BDS
@@ -825,6 +832,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
 }
 
 static const BdrvChildRole child_backing = {
+    .get_link_name   = bdrv_backing_link_name,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
diff --git a/block/block-backend.c b/block/block-backend.c
index 0c23add..a314284 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -80,6 +80,7 @@ static const AIOCBInfo block_backend_aiocb_info = {
 
 static void drive_info_del(DriveInfo *dinfo);
 static BlockBackend *bdrv_first_blk(BlockDriverState *bs);
+static char *blk_get_attached_dev_id(BlockBackend *blk);
 
 /* All BlockBackends */
 static QTAILQ_HEAD(, BlockBackend) block_backends =
@@ -102,6 +103,24 @@ static void blk_root_drained_end(BdrvChild *child);
 static void blk_root_change_media(BdrvChild *child, bool load);
 static void blk_root_resize(BdrvChild *child);
 
+static char *blk_root_get_link_name(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+    char *dev_id;
+
+    if (blk->name) {
+        return g_strdup(blk->name);
+    }
+
+    dev_id = blk_get_attached_dev_id(blk);
+    if (*dev_id) {
+        return dev_id;
+    } else {
+        g_free(dev_id);
+        return g_strdup("a block device");
+    }
+}
+
 static const char *blk_root_get_name(BdrvChild *child)
 {
     return blk_name(child->opaque);
@@ -113,6 +132,7 @@ static const BdrvChildRole child_root = {
     .change_media       = blk_root_change_media,
     .resize             = blk_root_resize,
     .get_name           = blk_root_get_name,
+    .get_link_name      = blk_root_get_link_name,
 
     .drained_begin      = blk_root_drained_begin,
     .drained_end        = blk_root_drained_end,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7558f99..a5557b1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -438,6 +438,10 @@ struct BdrvChildRole {
      * name), or NULL if the parent can't provide a better name. */
     const char* (*get_name)(BdrvChild *child);
 
+    /* Returns a malloced name that describes the link from the parent to the
+     * child. The caller is responsible for freeing the memory. */
+    char* (*get_link_name)(BdrvChild *child);
+
     /*
      * If this pair of functions is implemented, the parent doesn't issue new
      * requests after returning from .drained_begin() until .drained_end() is
-- 
1.8.3.1
