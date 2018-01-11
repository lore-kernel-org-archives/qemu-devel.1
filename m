Received: from eggs.gnu.org ([2001:4830:134:3::10]:57747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZium-0005T0-FN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiui-0000XA-Ug
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:19 +0100
Message-Id: <20180111195225.4226-5-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/10] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

All of the simple options are now passed to qcow2_create2() in a
BlockdevCreateOptions object. Still missing: node-name and the
encryption options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 148 insertions(+), 38 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b02bc39a01..09e567324d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2630,19 +2630,26 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     return meta_size + aligned_total_size;
 }
 
-static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
+static bool validate_cluster_size(size_t cluster_size, Error **errp)
 {
-    size_t cluster_size;
-    int cluster_bits;
-
-    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
-                                         DEFAULT_CLUSTER_SIZE);
-    cluster_bits = ctz32(cluster_size);
+    int cluster_bits = ctz32(cluster_size);
     if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
         (1 << cluster_bits) != cluster_size)
     {
         error_setg(errp, "Cluster size must be a power of two between %d and "
                    "%dk", 1 << MIN_CLUSTER_BITS, 1 << (MAX_CLUSTER_BITS - 10));
+        return false;
+    }
+    return true;
+}
+
+static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
+{
+    size_t cluster_size;
+
+    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
+                                         DEFAULT_CLUSTER_SIZE);
+    if (!validate_cluster_size(cluster_size, errp)) {
         return 0;
     }
     return cluster_size;
@@ -2690,12 +2697,11 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
-                         const char *backing_file, const char *backing_format,
-                         int flags, size_t cluster_size, PreallocMode prealloc,
-                         QemuOpts *opts, int version, int refcount_order,
-                         const char *encryptfmt, Error **errp)
+static int qcow2_create2(BlockDriverState *bs,
+                         BlockdevCreateOptions *create_options,
+                         QemuOpts *opts, const char *encryptfmt, Error **errp)
 {
+    BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
 
     /*
@@ -2712,10 +2718,88 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
      */
     BlockBackend *blk;
     QCowHeader *header;
+    size_t cluster_size;
+    int version;
+    int refcount_order;
     uint64_t* refcount_table;
     Error *local_err = NULL;
     int ret;
 
+    /* Validate options and set default values */
+    assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
+    qcow2_opts = &create_options->u.qcow2;
+
+    if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    if (qcow2_opts->has_compat) {
+        switch (qcow2_opts->compat) {
+        case BLOCKDEV_QCOW2_COMPAT_LEVEL_0_10:
+            version = 2;
+            break;
+        case BLOCKDEV_QCOW2_COMPAT_LEVEL_1_1:
+            version = 3;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        version = 3;
+    }
+
+    if (qcow2_opts->has_cluster_size) {
+        cluster_size = qcow2_opts->cluster_size;
+    } else {
+        cluster_size = DEFAULT_CLUSTER_SIZE;
+    }
+
+    if (!validate_cluster_size(cluster_size, errp)) {
+        return -EINVAL;
+    }
+
+    if (!qcow2_opts->has_preallocation) {
+        qcow2_opts->preallocation = PREALLOC_MODE_OFF;
+    }
+    if (qcow2_opts->backing_file &&
+        qcow2_opts->preallocation != PREALLOC_MODE_OFF)
+    {
+        error_setg(errp, "Backing file and preallocation cannot be used at "
+                   "the same time");
+        return -EINVAL;
+    }
+
+    if (!qcow2_opts->has_lazy_refcounts) {
+        qcow2_opts->lazy_refcounts = false;
+    }
+    if (version < 3 && qcow2_opts->lazy_refcounts) {
+        error_setg(errp, "Lazy refcounts only supported with compatibility "
+                   "level 1.1 and above (use compat=1.1 or greater)");
+        return -EINVAL;
+    }
+
+    if (!qcow2_opts->has_refcount_bits) {
+        qcow2_opts->refcount_bits = 16;
+    }
+    if (qcow2_opts->refcount_bits > 64 ||
+        !is_power_of_2(qcow2_opts->refcount_bits))
+    {
+        error_setg(errp, "Refcount width must be a power of two and may not "
+                   "exceed 64 bits");
+        return -EINVAL;
+    }
+    if (version < 3 && qcow2_opts->refcount_bits != 16) {
+        error_setg(errp, "Different refcount widths than 16 bits require "
+                   "compatibility level 1.1 or above (use compat=1.1 or "
+                   "greater)");
+        return -EINVAL;
+    }
+    refcount_order = ctz32(qcow2_opts->refcount_bits);
+
+
+    /* Create BlockBackend to write to the image */
     blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
@@ -2742,7 +2826,7 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
     /* We'll update this to correct value later */
     header->crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
 
-    if (flags & BLOCK_FLAG_LAZY_REFCOUNTS) {
+    if (qcow2_opts->lazy_refcounts) {
         header->compatible_features |=
             cpu_to_be64(QCOW2_COMPAT_LAZY_REFCOUNTS);
     }
@@ -2804,18 +2888,26 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
     }
 
     /* Okay, now that we have a valid image, let's give it the right size */
-    ret = blk_truncate(blk, total_size, PREALLOC_MODE_OFF, errp);
+    ret = blk_truncate(blk, qcow2_opts->size, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not resize image: ");
         goto out;
     }
 
     /* Want a backing file? There you go.*/
-    if (backing_file) {
-        ret = bdrv_change_backing_file(blk_bs(blk), backing_file, backing_format);
+    if (qcow2_opts->has_backing_file) {
+        const char *backing_format = NULL;
+
+        if (qcow2_opts->has_backing_fmt) {
+            backing_format = BlockdevDriver_str(qcow2_opts->backing_fmt);
+        }
+
+        ret = bdrv_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
+                                       backing_format);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not assign backing file '%s' "
-                             "with format '%s'", backing_file, backing_format);
+                             "with format '%s'", qcow2_opts->backing_file,
+                             backing_format);
             goto out;
         }
     }
@@ -2829,8 +2921,8 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
     }
 
     /* And if we're supposed to preallocate metadata, do that now */
-    if (prealloc != PREALLOC_MODE_OFF) {
-        ret = preallocate(blk_bs(blk), 0, total_size);
+    if (qcow2_opts->preallocation != PREALLOC_MODE_OFF) {
+        ret = preallocate(blk_bs(blk), 0, qcow2_opts->size);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not preallocate metadata");
             goto out;
@@ -2868,8 +2960,10 @@ out:
 
 static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 {
+    BlockdevCreateOptions create_options;
     char *backing_file = NULL;
     char *backing_fmt = NULL;
+    BlockdevDriver backing_drv;
     char *buf = NULL;
     uint64_t size = 0;
     int flags = 0;
@@ -2877,7 +2971,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     PreallocMode prealloc;
     int version;
     uint64_t refcount_bits;
-    int refcount_order;
     char *encryptfmt = NULL;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
@@ -2888,6 +2981,13 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                     BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+    backing_drv = qapi_enum_parse(&BlockdevDriver_lookup, backing_fmt,
+                                  0, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto finish;
+    }
     encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
     if (encryptfmt) {
         if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
@@ -2925,20 +3025,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         flags |= BLOCK_FLAG_LAZY_REFCOUNTS;
     }
 
-    if (backing_file && prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Backing file and preallocation cannot be used at "
-                   "the same time");
-        ret = -EINVAL;
-        goto finish;
-    }
-
-    if (version < 3 && (flags & BLOCK_FLAG_LAZY_REFCOUNTS)) {
-        error_setg(errp, "Lazy refcounts only supported with compatibility "
-                   "level 1.1 and above (use compat=1.1 or greater)");
-        ret = -EINVAL;
-        goto finish;
-    }
-
     refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2946,10 +3032,10 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         goto finish;
     }
 
-    refcount_order = ctz32(refcount_bits);
 
     /* Create and open the file (protocol layer */
     if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
+        int refcount_order = ctz32(refcount_bits);
         int64_t prealloc_size =
             qcow2_calc_prealloc_size(size, cluster_size, refcount_order);
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
@@ -2970,9 +3056,33 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     /* Create the qcow2 image (format layer) */
-    ret = qcow2_create2(bs, size, backing_file, backing_fmt, flags,
-                        cluster_size, prealloc, opts, version, refcount_order,
-                        encryptfmt, errp);
+    create_options = (BlockdevCreateOptions) {
+        .driver         = BLOCKDEV_DRIVER_QCOW2,
+        .node           = & (BlockdevRef) {
+            .type               = QTYPE_QSTRING,
+            .u.reference        = bs->node_name,
+        },
+        .u.qcow2        = {
+            .size               = size,
+            .has_compat         = true,
+            .compat             = version == 2
+                                  ? BLOCKDEV_QCOW2_COMPAT_LEVEL_0_10
+                                  : BLOCKDEV_QCOW2_COMPAT_LEVEL_1_1,
+            .has_backing_file   = (backing_file != NULL),
+            .backing_file       = backing_file,
+            .has_backing_fmt    = (backing_fmt != NULL),
+            .backing_fmt        = backing_drv,
+            .has_cluster_size   = true,
+            .cluster_size       = cluster_size,
+            .has_preallocation  = true,
+            .preallocation      = prealloc,
+            .has_lazy_refcounts = true,
+            .lazy_refcounts     = (flags & BLOCK_FLAG_LAZY_REFCOUNTS),
+            .has_refcount_bits  = true,
+            .refcount_bits      = refcount_bits,
+        },
+    };
+    ret = qcow2_create2(bs, &create_options, opts, encryptfmt, errp);
     if (ret < 0) {
         goto finish;
     }
-- 
2.13.6
