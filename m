Received: from eggs.gnu.org ([2001:4830:134:3::10]:35879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqe-0007KB-Mb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqZ-0000pi-Es
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:05 +0100
Message-Id: <20180309214611.19122-2-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-1-kwolf@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] parallels: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to parallels, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  18 ++++-
 block/parallels.c    | 199 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 168 insertions(+), 49 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 07039bfe9c..d38058eeab 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3481,6 +3481,22 @@
             'size':             'size' } }
 
 ##
+# @BlockdevCreateOptionsParallels:
+#
+# Driver specific image creation options for parallels.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @cluster-size     Cluster size in bytes (default: 1 MB)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsParallels',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size',
+            '*cluster-size':    'size' } }
+
+##
 # @BlockdevQcow2Version:
 #
 # @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
@@ -3664,7 +3680,7 @@
       'null-aio':       'BlockdevCreateNotSupported',
       'null-co':        'BlockdevCreateNotSupported',
       'nvme':           'BlockdevCreateNotSupported',
-      'parallels':      'BlockdevCreateNotSupported',
+      'parallels':      'BlockdevCreateOptionsParallels',
       'qcow2':          'BlockdevCreateOptionsQcow2',
       'qcow':           'BlockdevCreateNotSupported',
       'qed':            'BlockdevCreateNotSupported',
diff --git a/block/parallels.c b/block/parallels.c
index c13cb619e6..2da5e56a9d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -34,6 +34,9 @@
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
 #include "migration/blocker.h"
@@ -79,6 +82,25 @@ static QemuOptsList parallels_runtime_opts = {
     },
 };
 
+static QemuOptsList parallels_create_opts = {
+    .name = "parallels-create-opts",
+    .head = QTAILQ_HEAD_INITIALIZER(parallels_create_opts.head),
+    .desc = {
+        {
+            .name = BLOCK_OPT_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size",
+        },
+        {
+            .name = BLOCK_OPT_CLUSTER_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Parallels image cluster size",
+            .def_value_str = stringify(DEFAULT_CLUSTER_SIZE),
+        },
+        { /* end of list */ }
+    }
+};
+
 
 static int64_t bat2sect(BDRVParallelsState *s, uint32_t idx)
 {
@@ -480,46 +502,62 @@ out:
 }
 
 
-static int coroutine_fn parallels_co_create_opts(const char *filename,
-                                                 QemuOpts *opts,
-                                                 Error **errp)
+static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
+                                            Error **errp)
 {
+    BlockdevCreateOptionsParallels *parallels_opts;
+    BlockDriverState *bs;
+    BlockBackend *blk;
     int64_t total_size, cl_size;
-    uint8_t tmp[BDRV_SECTOR_SIZE];
-    Error *local_err = NULL;
-    BlockBackend *file;
     uint32_t bat_entries, bat_sectors;
     ParallelsHeader header;
+    uint8_t tmp[BDRV_SECTOR_SIZE];
     int ret;
 
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    cl_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
-                          DEFAULT_CLUSTER_SIZE), BDRV_SECTOR_SIZE);
+    assert(opts->driver == BLOCKDEV_DRIVER_PARALLELS);
+    parallels_opts = &opts->u.parallels;
+
+    /* Sanity checks */
+    total_size = parallels_opts->size;
+
+    if (parallels_opts->has_cluster_size) {
+        cl_size = parallels_opts->cluster_size;
+    } else {
+        cl_size = DEFAULT_CLUSTER_SIZE;
+    }
+
     if (total_size >= MAX_PARALLELS_IMAGE_FACTOR * cl_size) {
-        error_propagate(errp, local_err);
+        error_setg(errp, "Image size is too large for this cluster size");
         return -E2BIG;
     }
 
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        return ret;
+    if (!QEMU_IS_ALIGNED(total_size, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        return -EINVAL;
     }
 
-    file = blk_new_open(filename, NULL, NULL,
-                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                        &local_err);
-    if (file == NULL) {
-        error_propagate(errp, local_err);
+    if (!QEMU_IS_ALIGNED(cl_size, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "Cluster size must be a multiple of 512 bytes");
+        return -EINVAL;
+    }
+
+    /* Create BlockBackend to write to the image */
+    bs = bdrv_open_blockdev_ref(parallels_opts->file, errp);
+    if (bs == NULL) {
         return -EIO;
     }
 
-    blk_set_allow_write_beyond_eof(file, true);
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto out;
+    }
+    blk_set_allow_write_beyond_eof(blk, true);
 
-    ret = blk_truncate(file, 0, PREALLOC_MODE_OFF, errp);
+    /* Create image format */
+    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
-        goto exit;
+        goto out;
     }
 
     bat_entries = DIV_ROUND_UP(total_size, cl_size);
@@ -542,24 +580,107 @@ static int coroutine_fn parallels_co_create_opts(const char *filename,
     memset(tmp, 0, sizeof(tmp));
     memcpy(tmp, &header, sizeof(header));
 
-    ret = blk_pwrite(file, 0, tmp, BDRV_SECTOR_SIZE, 0);
+    ret = blk_pwrite(blk, 0, tmp, BDRV_SECTOR_SIZE, 0);
     if (ret < 0) {
         goto exit;
     }
-    ret = blk_pwrite_zeroes(file, BDRV_SECTOR_SIZE,
+    ret = blk_pwrite_zeroes(blk, BDRV_SECTOR_SIZE,
                             (bat_sectors - 1) << BDRV_SECTOR_BITS, 0);
     if (ret < 0) {
         goto exit;
     }
-    ret = 0;
 
-done:
-    blk_unref(file);
+    ret = 0;
+out:
+    blk_unref(blk);
+    bdrv_unref(bs);
     return ret;
 
 exit:
     error_setg_errno(errp, -ret, "Failed to create Parallels image");
-    goto done;
+    goto out;
+}
+
+static int coroutine_fn parallels_co_create_opts(const char *filename,
+                                                 QemuOpts *opts,
+                                                 Error **errp)
+{
+    BlockdevCreateOptions *create_options = NULL;
+    Error *local_err = NULL;
+    BlockDriverState *bs = NULL;
+    QDict *qdict = NULL;
+    QObject *qobj;
+    Visitor *v;
+    int ret;
+
+    static const QDictRenames opt_renames[] = {
+        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
+        { NULL, NULL },
+    };
+
+    /* Parse options and convert legacy syntax */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &parallels_create_opts,
+                                        true);
+
+    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
+        ret = -EINVAL;
+        goto done;
+    }
+
+    /* Create and open the file (protocol layer) */
+    ret = bdrv_create_file(filename, opts, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+        goto done;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs == NULL) {
+        ret = -EIO;
+        goto done;
+    }
+
+    /* Now get the QAPI type BlockdevCreateOptions */
+    qdict_put_str(qdict, "driver", "parallels");
+    qdict_put_str(qdict, "file", bs->node_name);
+
+    qobj = qdict_crumple(qdict, errp);
+    QDECREF(qdict);
+    qdict = qobject_to_qdict(qobj);
+    if (qdict == NULL) {
+        ret = -EINVAL;
+        goto done;
+    }
+
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto done;
+    }
+
+    /* Silently round up sizes */
+    create_options->u.parallels.size =
+        ROUND_UP(create_options->u.parallels.size, BDRV_SECTOR_SIZE);
+    create_options->u.parallels.cluster_size =
+        ROUND_UP(create_options->u.parallels.cluster_size, BDRV_SECTOR_SIZE);
+
+    /* Create the Parallels image (format layer) */
+    ret = parallels_co_create(create_options, errp);
+    if (ret < 0) {
+        goto done;
+    }
+    ret = 0;
+
+done:
+    QDECREF(qdict);
+    bdrv_unref(bs);
+    qapi_free_BlockdevCreateOptions(create_options);
+    return ret;
 }
 
 
@@ -771,25 +892,6 @@ static void parallels_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
-static QemuOptsList parallels_create_opts = {
-    .name = "parallels-create-opts",
-    .head = QTAILQ_HEAD_INITIALIZER(parallels_create_opts.head),
-    .desc = {
-        {
-            .name = BLOCK_OPT_SIZE,
-            .type = QEMU_OPT_SIZE,
-            .help = "Virtual disk size",
-        },
-        {
-            .name = BLOCK_OPT_CLUSTER_SIZE,
-            .type = QEMU_OPT_SIZE,
-            .help = "Parallels image cluster size",
-            .def_value_str = stringify(DEFAULT_CLUSTER_SIZE),
-        },
-        { /* end of list */ }
-    }
-};
-
 static BlockDriver bdrv_parallels = {
     .format_name	= "parallels",
     .instance_size	= sizeof(BDRVParallelsState),
@@ -803,6 +905,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
     .supports_backing = true,
+    .bdrv_co_create      = parallels_co_create,
     .bdrv_co_create_opts = parallels_co_create_opts,
     .bdrv_co_check  = parallels_co_check,
     .create_opts    = &parallels_create_opts,
-- 
2.13.6
