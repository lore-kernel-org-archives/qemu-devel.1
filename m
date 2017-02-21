Received: from eggs.gnu.org ([2001:4830:134:3::10]:43357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuy-0000kd-59
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuw-00088S-Tv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:28 +0100
Message-Id: <1487689130-30373-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 32/54] block: Add
 BdrvChildRole.get_parent_desc()
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

For meaningful error messages in the permission system, we need to get
some human-readable description of the parent of a BdrvChild.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   |  9 +++++++++
 block/block-backend.c     | 21 +++++++++++++++++++++
 include/block/block_int.h |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/block.c b/block.c
index 9f46698..19cf3b0 100644
--- a/block.c
+++ b/block.c
@@ -707,6 +707,12 @@ int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough)
     return 0;
 }
 
+static char *bdrv_child_get_parent_desc(BdrvChild *c)
+{
+    BlockDriverState *parent = c->opaque;
+    return g_strdup(bdrv_get_device_or_node_name(parent));
+}
+
 static void bdrv_child_cb_drained_begin(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -774,6 +780,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
 }
 
 const BdrvChildRole child_file = {
+    .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
@@ -794,6 +801,7 @@ static void bdrv_inherited_fmt_options(int *child_flags, QDict *child_options,
 }
 
 const BdrvChildRole child_format = {
+    .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
@@ -824,6 +832,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
 }
 
 const BdrvChildRole child_backing = {
+    .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
diff --git a/block/block-backend.c b/block/block-backend.c
index fcc42b5..38a3858 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -80,6 +80,7 @@ static const AIOCBInfo block_backend_aiocb_info = {
 
 static void drive_info_del(DriveInfo *dinfo);
 static BlockBackend *bdrv_first_blk(BlockDriverState *bs);
+static char *blk_get_attached_dev_id(BlockBackend *blk);
 
 /* All BlockBackends */
 static QTAILQ_HEAD(, BlockBackend) block_backends =
@@ -102,6 +103,25 @@ static void blk_root_drained_end(BdrvChild *child);
 static void blk_root_change_media(BdrvChild *child, bool load);
 static void blk_root_resize(BdrvChild *child);
 
+static char *blk_root_get_parent_desc(BdrvChild *child)
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
+        /* TODO Callback into the BB owner for something more detailed */
+        g_free(dev_id);
+        return g_strdup("a block device");
+    }
+}
+
 static const char *blk_root_get_name(BdrvChild *child)
 {
     return blk_name(child->opaque);
@@ -113,6 +133,7 @@ static const BdrvChildRole child_root = {
     .change_media       = blk_root_change_media,
     .resize             = blk_root_resize,
     .get_name           = blk_root_get_name,
+    .get_parent_desc    = blk_root_get_parent_desc,
 
     .drained_begin      = blk_root_drained_begin,
     .drained_end        = blk_root_drained_end,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e00d0f4..3177b9f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -452,6 +452,12 @@ struct BdrvChildRole {
      * name), or NULL if the parent can't provide a better name. */
     const char* (*get_name)(BdrvChild *child);
 
+    /* Returns a malloced string that describes the parent of the child for a
+     * human reader. This could be a node-name, BlockBackend name, qdev ID or
+     * QOM path of the device owning the BlockBackend, job type and ID etc. The
+     * caller is responsible for freeing the memory. */
+    char* (*get_parent_desc)(BdrvChild *child);
+
     /*
      * If this pair of functions is implemented, the parent doesn't issue new
      * requests after returning from .drained_begin() until .drained_end() is
-- 
1.8.3.1
