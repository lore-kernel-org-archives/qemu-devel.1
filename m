Received: from eggs.gnu.org ([2001:4830:134:3::10]:49860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIyz-0000Yg-HA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIyx-00046s-V1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:18 +0100
Message-Id: <20180223192549.26666-6-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/36] qcow2: Use BlockdevRef in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Instead of passing a separate BlockDriverState* into qcow2_create2(),
make use of the BlockdevRef that is included in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 38 ++++++++++++++++++++++++--------------
 3 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 947e8876cd..54fe8b7a0e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -245,6 +245,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BlockDriverState* parent,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp);
+BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/block.c b/block.c
index 814e5a02da..c0e343d278 100644
--- a/block.c
+++ b/block.c
@@ -35,6 +35,8 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi-visit.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
@@ -2408,6 +2410,51 @@ BdrvChild *bdrv_open_child(const char *filename,
     return c;
 }
 
+/* TODO Future callers may need to specify parent/child_role in order for
+ * option inheritance to work. Existing callers use it for the root node. */
+BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
+{
+    BlockDriverState *bs = NULL;
+    Error *local_err = NULL;
+    QObject *obj = NULL;
+    QDict *qdict = NULL;
+    const char *reference = NULL;
+    Visitor *v = NULL;
+
+    if (ref->type == QTYPE_QSTRING) {
+        reference = ref->u.reference;
+    } else {
+        BlockdevOptions *options = &ref->u.definition;
+        assert(ref->type == QTYPE_QDICT);
+
+        v = qobject_output_visitor_new(&obj);
+        visit_type_BlockdevOptions(v, NULL, &options, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+        visit_complete(v, &obj);
+
+        qdict = qobject_to_qdict(obj);
+        qdict_flatten(qdict);
+
+        /* bdrv_open_inherit() defaults to the values in bdrv_flags (for
+         * compatibility with other callers) rather than what we want as the
+         * real defaults. Apply the defaults here instead. */
+        qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
+        qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
+        qdict_set_default_str(qdict, BDRV_OPT_READ_ONLY, "off");
+    }
+
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
+    obj = NULL;
+
+fail:
+    qobject_decref(obj);
+    visit_free(v);
+    return bs;
+}
+
 static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
                                                    int flags,
                                                    QDict *snapshot_options,
diff --git a/block/qcow2.c b/block/qcow2.c
index 22194180c6..b34924b0f0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2732,8 +2732,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(BlockDriverState *bs,
-                         BlockdevCreateOptions *create_options,
+static int qcow2_create2(BlockdevCreateOptions *create_options,
                          QemuOpts *opts, const char *encryptfmt, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
@@ -2751,7 +2750,8 @@ static int qcow2_create2(BlockDriverState *bs,
      * 2 GB for 64k clusters, and we don't want to have a 2 GB initial file
      * size for any qcow2 image.
      */
-    BlockBackend *blk;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
     QCowHeader *header;
     size_t cluster_size;
     int version;
@@ -2760,10 +2760,15 @@ static int qcow2_create2(BlockDriverState *bs,
     Error *local_err = NULL;
     int ret;
 
-    /* Validate options and set default values */
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
 
+    bs = bdrv_open_blockdev_ref(qcow2_opts->file, errp);
+    if (bs == NULL) {
+        return -EIO;
+    }
+
+    /* Validate options and set default values */
     if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
         error_setg(errp, "Image size must be a multiple of 512 bytes");
         ret = -EINVAL;
@@ -2792,7 +2797,8 @@ static int qcow2_create2(BlockDriverState *bs,
     }
 
     if (!validate_cluster_size(cluster_size, errp)) {
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_preallocation) {
@@ -2803,11 +2809,13 @@ static int qcow2_create2(BlockDriverState *bs,
     {
         error_setg(errp, "Backing file and preallocation cannot be used at "
                    "the same time");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
     if (qcow2_opts->has_backing_fmt && !qcow2_opts->has_backing_file) {
         error_setg(errp, "Backing format cannot be used without backing file");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_lazy_refcounts) {
@@ -2816,7 +2824,8 @@ static int qcow2_create2(BlockDriverState *bs,
     if (version < 3 && qcow2_opts->lazy_refcounts) {
         error_setg(errp, "Lazy refcounts only supported with compatibility "
                    "level 1.1 and above (use compat=1.1 or greater)");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_refcount_bits) {
@@ -2827,13 +2836,15 @@ static int qcow2_create2(BlockDriverState *bs,
     {
         error_setg(errp, "Refcount width must be a power of two and may not "
                    "exceed 64 bits");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
     if (version < 3 && qcow2_opts->refcount_bits != 16) {
         error_setg(errp, "Different refcount widths than 16 bits require "
                    "compatibility level 1.1 or above (use compat=1.1 or "
                    "greater)");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
     refcount_order = ctz32(qcow2_opts->refcount_bits);
 
@@ -2991,9 +3002,8 @@ static int qcow2_create2(BlockDriverState *bs,
 
     ret = 0;
 out:
-    if (blk) {
-        blk_unref(blk);
-    }
+    blk_unref(blk);
+    bdrv_unref(bs);
     return ret;
 }
 
@@ -3121,7 +3131,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
             .refcount_bits      = refcount_bits,
         },
     };
-    ret = qcow2_create2(bs, &create_options, opts, encryptfmt, errp);
+    ret = qcow2_create2(&create_options, opts, encryptfmt, errp);
     if (ret < 0) {
         goto finish;
     }
-- 
2.13.6
