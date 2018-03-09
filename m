Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqe-0007KE-Mn
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqa-0000qy-Qf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:09 +0100
Message-Id: <20180309214611.19122-6-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-1-kwolf@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] vdi: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This adds the .bdrv_co_create driver callback to vdi, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  21 ++++++-
 block/vdi.c          | 169 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 148 insertions(+), 42 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1e2edbc063..2eba0eef7e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3680,6 +3680,25 @@
             'size':             'size' } }
 
 ##
+# @BlockdevCreateOptionsVdi:
+#
+# Driver specific image creation options for vdi.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @cluster-size     Cluster size in bytes (default: 1 MB)
+# @static           Whether to create a static (preallocated) image
+#                   (default: false)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsVdi',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size',
+            '*cluster-size':    'size',
+            '*static':          'bool' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3733,7 +3752,7 @@
       'sheepdog':       'BlockdevCreateOptionsSheepdog',
       'ssh':            'BlockdevCreateOptionsSsh',
       'throttle':       'BlockdevCreateNotSupported',
-      'vdi':            'BlockdevCreateNotSupported',
+      'vdi':            'BlockdevCreateOptionsVdi',
       'vhdx':           'BlockdevCreateNotSupported',
       'vmdk':           'BlockdevCreateNotSupported',
       'vpc':            'BlockdevCreateNotSupported',
diff --git a/block/vdi.c b/block/vdi.c
index 2b5ddd0666..c60ddc58c0 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -60,6 +60,9 @@
 #include "qemu/coroutine.h"
 #include "qemu/cutils.h"
 #include "qemu/uuid.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 
 /* Code configuration options. */
 
@@ -182,6 +185,8 @@ typedef struct {
     Error *migration_blocker;
 } BDRVVdiState;
 
+static QemuOptsList vdi_create_opts;
+
 static void vdi_header_to_cpu(VdiHeader *header)
 {
     le32_to_cpus(&header->signature);
@@ -716,67 +721,72 @@ nonallocating_write:
     return ret;
 }
 
-static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
-                                           Error **errp)
+static int coroutine_fn vdi_co_create(BlockdevCreateOptions *opts,
+                                      Error **errp)
 {
+    BlockdevCreateOptionsVdi *vdi_opts;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
+
     int ret = 0;
-    uint64_t bytes = 0;
     uint32_t blocks;
-    size_t block_size = DEFAULT_CLUSTER_SIZE;
     uint32_t image_type = VDI_TYPE_DYNAMIC;
     VdiHeader header;
     size_t i;
     size_t bmap_size;
     int64_t offset = 0;
-    Error *local_err = NULL;
-    BlockBackend *blk = NULL;
     uint32_t *bmap = NULL;
 
     logout("\n");
 
-    /* Read out options. */
-    bytes = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                     BDRV_SECTOR_SIZE);
-#if defined(CONFIG_VDI_BLOCK_SIZE)
-    /* TODO: Additional checks (SECTOR_SIZE * 2^n, ...). */
-    block_size = qemu_opt_get_size_del(opts,
-                                       BLOCK_OPT_CLUSTER_SIZE,
-                                       DEFAULT_CLUSTER_SIZE);
-#endif
-#if defined(CONFIG_VDI_STATIC_IMAGE)
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_STATIC, false)) {
-        image_type = VDI_TYPE_STATIC;
+    assert(opts->driver == BLOCKDEV_DRIVER_VDI);
+    vdi_opts = &opts->u.vdi;
+
+    /* Validate options and set default values */
+    if (!vdi_opts->has_cluster_size) {
+        vdi_opts->cluster_size = DEFAULT_CLUSTER_SIZE;
     }
-#endif
 
-    if (bytes > VDI_DISK_SIZE_MAX) {
-        ret = -ENOTSUP;
+    if (vdi_opts->size > VDI_DISK_SIZE_MAX) {
         error_setg(errp, "Unsupported VDI image size (size is 0x%" PRIx64
                           ", max supported is 0x%" PRIx64 ")",
-                          bytes, VDI_DISK_SIZE_MAX);
-        goto exit;
+                          vdi_opts->size, VDI_DISK_SIZE_MAX);
+        return -ENOTSUP;
     }
 
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        goto exit;
+#if !defined(CONFIG_VDI_BLOCK_SIZE)
+    if (vdi_opts->has_cluster_size) {
+        error_setg(errp, "Non-default cluster size not supported");
+        return -ENOTSUP;
+    }
+#endif
+#if !defined(CONFIG_VDI_STATIC_IMAGE)
+    if (vdi_opts->has_static) {
+        error_setg(errp, "Static images not supported");
+        return -ENOTSUP;
+    }
+#else
+    if (vdi_opts->q_static) {
+        image_type = VDI_TYPE_STATIC;
+    }
+#endif
+
+    /* Create BlockBackend to write to the image */
+    bs = bdrv_open_blockdev_ref(vdi_opts->file, errp);
+    if (bs == NULL) {
+        return -EIO;
     }
 
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
-        ret = -EIO;
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
         goto exit;
     }
-
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* We need enough blocks to store the given disk size,
        so always round up. */
-    blocks = DIV_ROUND_UP(bytes, block_size);
+    blocks = DIV_ROUND_UP(vdi_opts->size, vdi_opts->cluster_size);
 
     bmap_size = blocks * sizeof(uint32_t);
     bmap_size = ROUND_UP(bmap_size, SECTOR_SIZE);
@@ -790,8 +800,8 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     header.offset_bmap = 0x200;
     header.offset_data = 0x200 + bmap_size;
     header.sector_size = SECTOR_SIZE;
-    header.disk_size = bytes;
-    header.block_size = block_size;
+    header.disk_size = vdi_opts->size;
+    header.block_size = vdi_opts->cluster_size;
     header.blocks_in_image = blocks;
     if (image_type == VDI_TYPE_STATIC) {
         header.blocks_allocated = blocks;
@@ -805,7 +815,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     vdi_header_to_le(&header);
     ret = blk_pwrite(blk, offset, &header, sizeof(header), 0);
     if (ret < 0) {
-        error_setg(errp, "Error writing header to %s", filename);
+        error_setg(errp, "Error writing header");
         goto exit;
     }
     offset += sizeof(header);
@@ -826,27 +836,103 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         }
         ret = blk_pwrite(blk, offset, bmap, bmap_size, 0);
         if (ret < 0) {
-            error_setg(errp, "Error writing bmap to %s", filename);
+            error_setg(errp, "Error writing bmap");
             goto exit;
         }
         offset += bmap_size;
     }
 
     if (image_type == VDI_TYPE_STATIC) {
-        ret = blk_truncate(blk, offset + blocks * block_size,
+        ret = blk_truncate(blk, offset + blocks * vdi_opts->cluster_size,
                            PREALLOC_MODE_OFF, errp);
         if (ret < 0) {
-            error_prepend(errp, "Failed to statically allocate %s", filename);
+            error_prepend(errp, "Failed to statically allocate image");
             goto exit;
         }
     }
 
 exit:
     blk_unref(blk);
+    bdrv_unref(bs);
     g_free(bmap);
     return ret;
 }
 
+static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
+{
+    BlockdevCreateOptions *create_options = NULL;
+    QDict *qdict = NULL;
+    QObject *qobj;
+    Visitor *v;
+    BlockDriverState *bs = NULL;
+    Error *local_err = NULL;
+    int ret;
+
+    static const QDictRenames opt_renames[] = {
+        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
+        { NULL, NULL },
+    };
+
+    /* Parse options and convert legacy syntax */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
+
+    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Create and open the file (protocol layer) */
+    ret = bdrv_create_file(filename, opts, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs == NULL) {
+        ret = -EIO;
+        goto fail;
+    }
+
+    /* Now get the QAPI type BlockdevCreateOptions */
+    qdict_put_str(qdict, "driver", "vdi");
+    qdict_put_str(qdict, "file", bs->node_name);
+
+    qobj = qdict_crumple(qdict, errp);
+    QDECREF(qdict);
+    qdict = qobject_to_qdict(qobj);
+    if (qdict == NULL) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Silently round up size */
+    assert(create_options->driver == BLOCKDEV_DRIVER_VDI);
+    create_options->u.vdi.size =
+        ROUND_UP(create_options->u.vdi.size, BDRV_SECTOR_SIZE);
+
+    /* Create the vdi image (format layer) */
+    ret = vdi_co_create(create_options, errp);
+
+fail:
+    QDECREF(qdict);
+    bdrv_unref(bs);
+    qapi_free_BlockdevCreateOptions(create_options);
+    return ret;
+}
+
 static void vdi_close(BlockDriverState *bs)
 {
     BDRVVdiState *s = bs->opaque;
@@ -895,6 +981,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_close = vdi_close,
     .bdrv_reopen_prepare = vdi_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
+    .bdrv_co_create      = vdi_co_create,
     .bdrv_co_create_opts = vdi_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = vdi_co_block_status,
-- 
2.13.6
