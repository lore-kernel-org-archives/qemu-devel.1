Received: from eggs.gnu.org ([2001:4830:134:3::10]:35881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqe-0007KD-Mf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqZ-0000qF-Ku
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:08 +0100
Message-Id: <20180309214611.19122-5-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-1-kwolf@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] qed: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to qed, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  25 ++++++-
 block/qed.c          | 204 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 162 insertions(+), 67 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c81677c434..1e2edbc063 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3559,6 +3559,29 @@
             '*refcount-bits':   'int' } }
 
 ##
+# @BlockdevCreateOptionsQed:
+#
+# Driver specific image creation options for qed.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @backing-file     File name of the backing file if a backing file
+#                   should be used
+# @backing-fmt      Name of the block driver to use for the backing file
+# @cluster-size     Cluster size in bytes (default: 65536)
+# @table-size       L1/L2 table size (in clusters)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsQed',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size',
+            '*backing-file':    'str',
+            '*backing-fmt':     'BlockdevDriver',
+            '*cluster-size':    'size',
+            '*table-size':      'int' } }
+
+##
 # @BlockdevCreateOptionsRbd:
 #
 # Driver specific image creation options for rbd/Ceph.
@@ -3702,7 +3725,7 @@
       'parallels':      'BlockdevCreateOptionsParallels',
       'qcow':           'BlockdevCreateOptionsQcow',
       'qcow2':          'BlockdevCreateOptionsQcow2',
-      'qed':            'BlockdevCreateNotSupported',
+      'qed':            'BlockdevCreateOptionsQed',
       'quorum':         'BlockdevCreateNotSupported',
       'raw':            'BlockdevCreateNotSupported',
       'rbd':            'BlockdevCreateOptionsRbd',
diff --git a/block/qed.c b/block/qed.c
index 5e6a6bfaa0..46a84beeed 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -20,6 +20,11 @@
 #include "trace.h"
 #include "qed.h"
 #include "sysemu/block-backend.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
+
+static QemuOptsList qed_create_opts;
 
 static int bdrv_qed_probe(const uint8_t *buf, int buf_size,
                           const char *filename)
@@ -594,57 +599,95 @@ static void bdrv_qed_close(BlockDriverState *bs)
     qemu_vfree(s->l1_table);
 }
 
-static int qed_create(const char *filename, uint32_t cluster_size,
-                      uint64_t image_size, uint32_t table_size,
-                      const char *backing_file, const char *backing_fmt,
-                      QemuOpts *opts, Error **errp)
+static int coroutine_fn bdrv_qed_co_create(BlockdevCreateOptions *opts,
+                                           Error **errp)
 {
-    QEDHeader header = {
-        .magic = QED_MAGIC,
-        .cluster_size = cluster_size,
-        .table_size = table_size,
-        .header_size = 1,
-        .features = 0,
-        .compat_features = 0,
-        .l1_table_offset = cluster_size,
-        .image_size = image_size,
-    };
+    BlockdevCreateOptionsQed *qed_opts;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
+
+    QEDHeader header;
     QEDHeader le_header;
     uint8_t *l1_table = NULL;
-    size_t l1_size = header.cluster_size * header.table_size;
-    Error *local_err = NULL;
+    size_t l1_size;
     int ret = 0;
-    BlockBackend *blk;
 
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        return ret;
+    assert(opts->driver == BLOCKDEV_DRIVER_QED);
+    qed_opts = &opts->u.qed;
+
+    /* Validate options and set default values */
+    if (!qed_opts->has_cluster_size) {
+        qed_opts->cluster_size = QED_DEFAULT_CLUSTER_SIZE;
+    }
+    if (!qed_opts->has_table_size) {
+        qed_opts->table_size = QED_DEFAULT_TABLE_SIZE;
     }
 
-    blk = blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk == NULL) {
-        error_propagate(errp, local_err);
+    if (!qed_is_cluster_size_valid(qed_opts->cluster_size)) {
+        error_setg(errp, "QED cluster size must be within range [%u, %u] "
+                         "and power of 2",
+                   QED_MIN_CLUSTER_SIZE, QED_MAX_CLUSTER_SIZE);
+        return -EINVAL;
+    }
+    if (!qed_is_table_size_valid(qed_opts->table_size)) {
+        error_setg(errp, "QED table size must be within range [%u, %u] "
+                         "and power of 2",
+                   QED_MIN_TABLE_SIZE, QED_MAX_TABLE_SIZE);
+        return -EINVAL;
+    }
+    if (!qed_is_image_size_valid(qed_opts->size, qed_opts->cluster_size,
+                                 qed_opts->table_size))
+    {
+        error_setg(errp, "QED image size must be a non-zero multiple of "
+                         "cluster size and less than %" PRIu64 " bytes",
+                   qed_max_image_size(qed_opts->cluster_size,
+                                      qed_opts->table_size));
+        return -EINVAL;
+    }
+
+    /* Create BlockBackend to write to the image */
+    bs = bdrv_open_blockdev_ref(qed_opts->file, errp);
+    if (bs == NULL) {
         return -EIO;
     }
 
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto out;
+    }
     blk_set_allow_write_beyond_eof(blk, true);
 
+    /* Prepare image format */
+    header = (QEDHeader) {
+        .magic = QED_MAGIC,
+        .cluster_size = qed_opts->cluster_size,
+        .table_size = qed_opts->table_size,
+        .header_size = 1,
+        .features = 0,
+        .compat_features = 0,
+        .l1_table_offset = qed_opts->cluster_size,
+        .image_size = qed_opts->size,
+    };
+
+    l1_size = header.cluster_size * header.table_size;
+
     /* File must start empty and grow, check truncate is supported */
     ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
 
-    if (backing_file) {
+    if (qed_opts->has_backing_file) {
         header.features |= QED_F_BACKING_FILE;
         header.backing_filename_offset = sizeof(le_header);
-        header.backing_filename_size = strlen(backing_file);
+        header.backing_filename_size = strlen(qed_opts->backing_file);
 
-        if (qed_fmt_is_raw(backing_fmt)) {
-            header.features |= QED_F_BACKING_FORMAT_NO_PROBE;
+        if (qed_opts->has_backing_fmt) {
+            const char *backing_fmt = BlockdevDriver_str(qed_opts->backing_fmt);
+            if (qed_fmt_is_raw(backing_fmt)) {
+                header.features |= QED_F_BACKING_FORMAT_NO_PROBE;
+            }
         }
     }
 
@@ -653,7 +696,7 @@ static int qed_create(const char *filename, uint32_t cluster_size,
     if (ret < 0) {
         goto out;
     }
-    ret = blk_pwrite(blk, sizeof(le_header), backing_file,
+    ret = blk_pwrite(blk, sizeof(le_header), qed_opts->backing_file,
                      header.backing_filename_size, 0);
     if (ret < 0) {
         goto out;
@@ -669,6 +712,7 @@ static int qed_create(const char *filename, uint32_t cluster_size,
 out:
     g_free(l1_table);
     blk_unref(blk);
+    bdrv_unref(bs);
     return ret;
 }
 
@@ -676,51 +720,78 @@ static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
                                                 QemuOpts *opts,
                                                 Error **errp)
 {
-    uint64_t image_size = 0;
-    uint32_t cluster_size = QED_DEFAULT_CLUSTER_SIZE;
-    uint32_t table_size = QED_DEFAULT_TABLE_SIZE;
-    char *backing_file = NULL;
-    char *backing_fmt = NULL;
+    BlockdevCreateOptions *create_options = NULL;
+    QDict *qdict = NULL;
+    QObject *qobj;
+    Visitor *v;
+    BlockDriverState *bs = NULL;
+    Error *local_err = NULL;
     int ret;
 
-    image_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
-    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    cluster_size = qemu_opt_get_size_del(opts,
-                                         BLOCK_OPT_CLUSTER_SIZE,
-                                         QED_DEFAULT_CLUSTER_SIZE);
-    table_size = qemu_opt_get_size_del(opts, BLOCK_OPT_TABLE_SIZE,
-                                       QED_DEFAULT_TABLE_SIZE);
-
-    if (!qed_is_cluster_size_valid(cluster_size)) {
-        error_setg(errp, "QED cluster size must be within range [%u, %u] "
-                         "and power of 2",
-                   QED_MIN_CLUSTER_SIZE, QED_MAX_CLUSTER_SIZE);
+    static const QDictRenames opt_renames[] = {
+        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
+        { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
+        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
+        { BLOCK_OPT_TABLE_SIZE,         "table-size" },
+        { NULL, NULL },
+    };
+
+    /* Parse options and convert legacy syntax */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &qed_create_opts, true);
+
+    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
         ret = -EINVAL;
-        goto finish;
+        goto fail;
     }
-    if (!qed_is_table_size_valid(table_size)) {
-        error_setg(errp, "QED table size must be within range [%u, %u] "
-                         "and power of 2",
-                   QED_MIN_TABLE_SIZE, QED_MAX_TABLE_SIZE);
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
+    qdict_put_str(qdict, "driver", "qed");
+    qdict_put_str(qdict, "file", bs->node_name);
+
+    qobj = qdict_crumple(qdict, errp);
+    QDECREF(qdict);
+    qdict = qobject_to_qdict(qobj);
+    if (qdict == NULL) {
         ret = -EINVAL;
-        goto finish;
+        goto fail;
     }
-    if (!qed_is_image_size_valid(image_size, cluster_size, table_size)) {
-        error_setg(errp, "QED image size must be a non-zero multiple of "
-                         "cluster size and less than %" PRIu64 " bytes",
-                   qed_max_image_size(cluster_size, table_size));
+
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
-        goto finish;
+        goto fail;
     }
 
-    ret = qed_create(filename, cluster_size, image_size, table_size,
-                     backing_file, backing_fmt, opts, errp);
+    /* Silently round up size */
+    assert(create_options->driver == BLOCKDEV_DRIVER_QED);
+    create_options->u.qed.size =
+        ROUND_UP(create_options->u.qed.size, BDRV_SECTOR_SIZE);
+
+    /* Create the qed image (format layer) */
+    ret = bdrv_qed_co_create(create_options, errp);
 
-finish:
-    g_free(backing_file);
-    g_free(backing_fmt);
+fail:
+    QDECREF(qdict);
+    bdrv_unref(bs);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
@@ -1602,6 +1673,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_close               = bdrv_qed_close,
     .bdrv_reopen_prepare      = bdrv_qed_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
+    .bdrv_co_create           = bdrv_qed_co_create,
     .bdrv_co_create_opts      = bdrv_qed_co_create_opts,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_block_status     = bdrv_qed_co_block_status,
-- 
2.13.6
