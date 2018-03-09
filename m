Received: from eggs.gnu.org ([2001:4830:134:3::10]:33473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkv-000136-Mb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKku-0006rs-46
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:57 +0100
Message-Id: <20180309161933.8168-21-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/56] qcow2: Use BlockdevRef in
 qcow2_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Instead of passing a separate BlockDriverState* into qcow2_co_create(),
make use of the BlockdevRef that is included in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h |  1 +
 block.c               | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 39 +++++++++++++++++++++++++--------------
 3 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b6db952a2..7805187b30 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -246,6 +246,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BlockDriverState* parent,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp);
+BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/block.c b/block.c
index 8f1c43d037..4fc65f7621 100644
--- a/block.c
+++ b/block.c
@@ -34,6 +34,8 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
@@ -2406,6 +2408,51 @@ BdrvChild *bdrv_open_child(const char *filename,
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
index 7679c28f57..b7df2d5cab 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2768,8 +2768,8 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
 }
 
 static int coroutine_fn
-qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
-                QemuOpts *opts, const char *encryptfmt, Error **errp)
+qcow2_co_create(BlockdevCreateOptions *create_options, QemuOpts *opts,
+                const char *encryptfmt, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
@@ -2786,7 +2786,8 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
      * 2 GB for 64k clusters, and we don't want to have a 2 GB initial file
      * size for any qcow2 image.
      */
-    BlockBackend *blk;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
     QCowHeader *header;
     size_t cluster_size;
     int version;
@@ -2795,10 +2796,15 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
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
@@ -2827,7 +2833,8 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
     }
 
     if (!validate_cluster_size(cluster_size, errp)) {
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_preallocation) {
@@ -2838,11 +2845,13 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
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
@@ -2851,7 +2860,8 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
     if (version < 3 && qcow2_opts->lazy_refcounts) {
         error_setg(errp, "Lazy refcounts only supported with compatibility "
                    "level 1.1 and above (use compat=1.1 or greater)");
-        return -EINVAL;
+        ret = -EINVAL;
+        goto out;
     }
 
     if (!qcow2_opts->has_refcount_bits) {
@@ -2862,13 +2872,15 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
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
 
@@ -3026,9 +3038,8 @@ qcow2_co_create(BlockDriverState *bs, BlockdevCreateOptions *create_options,
 
     ret = 0;
 out:
-    if (blk) {
-        blk_unref(blk);
-    }
+    blk_unref(blk);
+    bdrv_unref(bs);
     return ret;
 }
 
@@ -3157,7 +3168,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
             .refcount_bits      = refcount_bits,
         },
     };
-    ret = qcow2_co_create(bs, &create_options, opts, encryptfmt, errp);
+    ret = qcow2_co_create(&create_options, opts, encryptfmt, errp);
     if (ret < 0) {
         goto finish;
     }
-- 
2.13.6
