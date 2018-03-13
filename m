Received: from eggs.gnu.org ([2001:4830:134:3::10]:60189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmdg-00020L-CN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmda-0004z6-DU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:19:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:18:00 +0100
Message-Id: <20180313161803.1814-39-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 38/41] vhdx: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This adds the .bdrv_co_create driver callback to vhdx, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  40 +++++++++-
 block/vhdx.c         | 216 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 203 insertions(+), 53 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d091817855..350094f46a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3842,6 +3842,44 @@
             '*static':          'bool' } }
 
 ##
+# @BlockdevVhdxSubformat:
+#
+# @dynamic: Growing image file
+# @fixed:   Preallocated fixed-size image file
+#
+# Since: 2.12
+##
+{ 'enum': 'BlockdevVhdxSubformat',
+  'data': [ 'dynamic', 'fixed' ] }
+
+##
+# @BlockdevCreateOptionsVhdx:
+#
+# Driver specific image creation options for vhdx.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @log-size         Log size in bytes, must be a multiple of 1 MB
+#                   (default: 1 MB)
+# @block-size       Block size in bytes, must be a multiple of 1 MB and not
+#                   larger than 256 MB (default: automatically choose a block
+#                   size depending on the image size)
+# @subformat        vhdx subformat (default: dynamic)
+# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-standard,
+#                   but default.  Do not set to 'off' when using 'qemu-img
+#                   convert' with subformat=dynamic.
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsVhdx',
+  'data': { 'file':                 'BlockdevRef',
+            'size':                 'size',
+            '*log-size':            'size',
+            '*block-size':          'size',
+            '*subformat':           'BlockdevVhdxSubformat',
+            '*block-state-zero':    'bool' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3896,7 +3934,7 @@
       'ssh':            'BlockdevCreateOptionsSsh',
       'throttle':       'BlockdevCreateNotSupported',
       'vdi':            'BlockdevCreateOptionsVdi',
-      'vhdx':           'BlockdevCreateNotSupported',
+      'vhdx':           'BlockdevCreateOptionsVhdx',
       'vmdk':           'BlockdevCreateNotSupported',
       'vpc':            'BlockdevCreateNotSupported',
       'vvfat':          'BlockdevCreateNotSupported',
diff --git a/block/vhdx.c b/block/vhdx.c
index d82350d07c..f1b97f4b49 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -26,6 +26,9 @@
 #include "block/vhdx.h"
 #include "migration/blocker.h"
 #include "qemu/uuid.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 
 /* Options for VHDX creation */
 
@@ -39,6 +42,8 @@ typedef enum VHDXImageType {
     VHDX_TYPE_DIFFERENCING,   /* Currently unsupported */
 } VHDXImageType;
 
+static QemuOptsList vhdx_create_opts;
+
 /* Several metadata and region table data entries are identified by
  * guids in  a MS-specific GUID format. */
 
@@ -1792,59 +1797,71 @@ exit:
  *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ -----------.
  *   1MB
  */
-static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts,
-                                            Error **errp)
+static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
+                                       Error **errp)
 {
+    BlockdevCreateOptionsVhdx *vhdx_opts;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
+
     int ret = 0;
-    uint64_t image_size = (uint64_t) 2 * GiB;
-    uint32_t log_size   = 1 * MiB;
-    uint32_t block_size = 0;
+    uint64_t image_size;
+    uint32_t log_size;
+    uint32_t block_size;
     uint64_t signature;
     uint64_t metadata_offset;
     bool use_zero_blocks = false;
 
     gunichar2 *creator = NULL;
     glong creator_items;
-    BlockBackend *blk;
-    char *type = NULL;
     VHDXImageType image_type;
-    Error *local_err = NULL;
 
-    image_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    log_size = qemu_opt_get_size_del(opts, VHDX_BLOCK_OPT_LOG_SIZE, 0);
-    block_size = qemu_opt_get_size_del(opts, VHDX_BLOCK_OPT_BLOCK_SIZE, 0);
-    type = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
-    use_zero_blocks = qemu_opt_get_bool_del(opts, VHDX_BLOCK_OPT_ZERO, true);
+    assert(opts->driver == BLOCKDEV_DRIVER_VHDX);
+    vhdx_opts = &opts->u.vhdx;
 
+    /* Validate options and set default values */
+    image_size = vhdx_opts->size;
     if (image_size > VHDX_MAX_IMAGE_SIZE) {
         error_setg_errno(errp, EINVAL, "Image size too large; max of 64TB");
-        ret = -EINVAL;
-        goto exit;
+        return -EINVAL;
     }
 
-    if (type == NULL) {
-        type = g_strdup("dynamic");
+    if (!vhdx_opts->has_log_size) {
+        log_size = DEFAULT_LOG_SIZE;
+    } else {
+        log_size = vhdx_opts->log_size;
+    }
+    if (log_size < MiB || (log_size % MiB) != 0) {
+        error_setg_errno(errp, EINVAL, "Log size must be a multiple of 1 MB");
+        return -EINVAL;
     }
 
-    if (!strcmp(type, "dynamic")) {
+    if (!vhdx_opts->has_block_state_zero) {
+        use_zero_blocks = true;
+    } else {
+        use_zero_blocks = vhdx_opts->block_state_zero;
+    }
+
+    if (!vhdx_opts->has_subformat) {
+        vhdx_opts->subformat = BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC;
+    }
+
+    switch (vhdx_opts->subformat) {
+    case BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC:
         image_type = VHDX_TYPE_DYNAMIC;
-    } else if (!strcmp(type, "fixed")) {
+        break;
+    case BLOCKDEV_VHDX_SUBFORMAT_FIXED:
         image_type = VHDX_TYPE_FIXED;
-    } else if (!strcmp(type, "differencing")) {
-        error_setg_errno(errp, ENOTSUP,
-                         "Differencing files not yet supported");
-        ret = -ENOTSUP;
-        goto exit;
-    } else {
-        error_setg(errp, "Invalid subformat '%s'", type);
-        ret = -EINVAL;
-        goto exit;
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     /* These are pretty arbitrary, and mainly designed to keep the BAT
      * size reasonable to load into RAM */
-    if (block_size == 0) {
+    if (vhdx_opts->has_block_size) {
+        block_size = vhdx_opts->block_size;
+    } else {
         if (image_size > 32 * TiB) {
             block_size = 64 * MiB;
         } else if (image_size > (uint64_t) 100 * GiB) {
@@ -1856,30 +1873,27 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts
         }
     }
 
-
-    /* make the log size close to what was specified, but must be
-     * min 1MB, and multiple of 1MB */
-    log_size = ROUND_UP(log_size, MiB);
-
-    block_size = ROUND_UP(block_size, MiB);
-    block_size = block_size > VHDX_BLOCK_SIZE_MAX ? VHDX_BLOCK_SIZE_MAX :
-                                                    block_size;
-
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        goto exit;
+    if (block_size < MiB || (block_size % MiB) != 0) {
+        error_setg_errno(errp, EINVAL, "Block size must be a multiple of 1 MB");
+        return -EINVAL;
+    }
+    if (block_size > VHDX_BLOCK_SIZE_MAX) {
+        error_setg_errno(errp, EINVAL, "Block size must not exceed %d",
+                         VHDX_BLOCK_SIZE_MAX);
+        return -EINVAL;
     }
 
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
-        ret = -EIO;
-        goto exit;
+    /* Create BlockBackend to write to the image */
+    bs = bdrv_open_blockdev_ref(vhdx_opts->file, errp);
+    if (bs == NULL) {
+        return -EIO;
     }
 
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto delete_and_exit;
+    }
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* Create (A) */
@@ -1931,12 +1945,109 @@ static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts
 
 delete_and_exit:
     blk_unref(blk);
-exit:
-    g_free(type);
+    bdrv_unref(bs);
     g_free(creator);
     return ret;
 }
 
+static int coroutine_fn vhdx_co_create_opts(const char *filename,
+                                            QemuOpts *opts,
+                                            Error **errp)
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
+        { VHDX_BLOCK_OPT_LOG_SIZE,      "log-size" },
+        { VHDX_BLOCK_OPT_BLOCK_SIZE,    "block-size" },
+        { VHDX_BLOCK_OPT_ZERO,          "block-state-zero" },
+        { NULL, NULL },
+    };
+
+    /* Parse options and convert legacy syntax */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vhdx_create_opts, true);
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
+    qdict_put_str(qdict, "driver", "vhdx");
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
+    /* Silently round up sizes:
+     * The image size is rounded to 512 bytes. Make the block and log size
+     * close to what was specified, but must be at least 1MB, and a multiple of
+     * 1 MB. Also respect VHDX_BLOCK_SIZE_MAX for block sizes. block_size = 0
+     * means auto, which is represented by a missing key in QAPI. */
+    assert(create_options->driver == BLOCKDEV_DRIVER_VHDX);
+    create_options->u.vhdx.size =
+        ROUND_UP(create_options->u.vhdx.size, BDRV_SECTOR_SIZE);
+
+    if (create_options->u.vhdx.has_log_size) {
+        create_options->u.vhdx.log_size =
+            ROUND_UP(create_options->u.vhdx.log_size, MiB);
+    }
+    if (create_options->u.vhdx.has_block_size) {
+        create_options->u.vhdx.block_size =
+            ROUND_UP(create_options->u.vhdx.block_size, MiB);
+
+        if (create_options->u.vhdx.block_size == 0) {
+            create_options->u.vhdx.has_block_size = false;
+        }
+        if (create_options->u.vhdx.block_size > VHDX_BLOCK_SIZE_MAX) {
+            create_options->u.vhdx.block_size = VHDX_BLOCK_SIZE_MAX;
+        }
+    }
+
+    /* Create the vhdx image (format layer) */
+    ret = vhdx_co_create(create_options, errp);
+
+fail:
+    QDECREF(qdict);
+    bdrv_unref(bs);
+    qapi_free_BlockdevCreateOptions(create_options);
+    return ret;
+}
+
 /* If opened r/w, the VHDX driver will automatically replay the log,
  * if one is present, inside the vhdx_open() call.
  *
@@ -2005,6 +2116,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_co_readv          = vhdx_co_readv,
     .bdrv_co_writev         = vhdx_co_writev,
+    .bdrv_co_create         = vhdx_co_create,
     .bdrv_co_create_opts    = vhdx_co_create_opts,
     .bdrv_get_info          = vhdx_get_info,
     .bdrv_co_check          = vhdx_co_check,
-- 
2.13.6
