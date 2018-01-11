Received: from eggs.gnu.org ([2001:4830:134:3::10]:57685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuk-0005RF-Lh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuj-0000XY-Bu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:20 +0100
Message-Id: <20180111195225.4226-6-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 05/10] qcow2: Use BlockdevRef in
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

Instead of passing a separate BlockDriverState* into qcow2_create2(),
make use of the BlockdevRef that is included in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 39 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 33 +++++++++++++++++++++------------
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 9b12774ddf..4b11f814a8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -258,6 +258,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BlockDriverState* parent,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp);
+BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/block.c b/block.c
index a8da4f2b25..c9b0e1d6d3 100644
--- a/block.c
+++ b/block.c
@@ -32,6 +32,8 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi-visit.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
@@ -2405,6 +2407,43 @@ BdrvChild *bdrv_open_child(const char *filename,
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
+    }
+
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
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
index 09e567324d..1a0f8f2e6d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2697,8 +2697,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(BlockDriverState *bs,
-                         BlockdevCreateOptions *create_options,
+static int qcow2_create2(BlockdevCreateOptions *create_options,
                          QemuOpts *opts, const char *encryptfmt, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
@@ -2716,7 +2715,8 @@ static int qcow2_create2(BlockDriverState *bs,
      * 2 GB for 64k clusters, and we don't want to have a 2 GB initial file
      * size for any qcow2 image.
      */
-    BlockBackend *blk;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
     QCowHeader *header;
     size_t cluster_size;
     int version;
@@ -2725,6 +2725,11 @@ static int qcow2_create2(BlockDriverState *bs,
     Error *local_err = NULL;
     int ret;
 
+    bs = bdrv_open_blockdev_ref(create_options->node, errp);
+    if (bs == NULL) {
+        return -EIO;
+    }
+
     /* Validate options and set default values */
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
@@ -2757,7 +2762,8 @@ static int qcow2_create2(BlockDriverState *bs,
     }
 
     if (!validate_cluster_size(cluster_size, errp)) {
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_preallocation) {
@@ -2768,7 +2774,8 @@ static int qcow2_create2(BlockDriverState *bs,
     {
         error_setg(errp, "Backing file and preallocation cannot be used at "
                    "the same time");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_lazy_refcounts) {
@@ -2777,7 +2784,8 @@ static int qcow2_create2(BlockDriverState *bs,
     if (version < 3 && qcow2_opts->lazy_refcounts) {
         error_setg(errp, "Lazy refcounts only supported with compatibility "
                    "level 1.1 and above (use compat=1.1 or greater)");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_refcount_bits) {
@@ -2788,13 +2796,15 @@ static int qcow2_create2(BlockDriverState *bs,
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
 
@@ -2952,9 +2962,8 @@ static int qcow2_create2(BlockDriverState *bs,
 
     ret = 0;
 out:
-    if (blk) {
-        blk_unref(blk);
-    }
+    blk_unref(blk);
+    bdrv_unref(bs);
     return ret;
 }
 
@@ -3082,7 +3091,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
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
