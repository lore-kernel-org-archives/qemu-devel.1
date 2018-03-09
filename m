Received: from eggs.gnu.org ([2001:4830:134:3::10]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqh-0007N9-U0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqg-0000sV-Fr
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:11 +0100
Message-Id: <20180309214611.19122-8-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-1-kwolf@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] vpc: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to vpc, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  33 ++++++++++-
 block/vpc.c          | 152 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 147 insertions(+), 38 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3a65909c47..ca645a0067 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3734,6 +3734,37 @@
             '*block-state-zero':    'bool' } }
 
 ##
+# @BlockdevVpcSubformat:
+#
+# @dynamic: Growing image file
+# @fixed:   Preallocated fixed-size imge file
+#
+# Since: 2.12
+##
+{ 'enum': 'BlockdevVpcSubformat',
+  'data': [ 'dynamic', 'fixed' ] }
+
+##
+# @BlockdevCreateOptionsVpc:
+#
+# Driver specific image creation options for vpc (VHD).
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @subformat        vhdx subformat (default: dynamic)
+# @force-size       Force use of the exact byte size instead of rounding to the
+#                   next size that can be represented in CHS geometry
+#                   (default: false)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsVpc',
+  'data': { 'file':                 'BlockdevRef',
+            'size':                 'size',
+            '*subformat':           'BlockdevVpcSubformat',
+            '*force-size':          'bool' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3790,7 +3821,7 @@
       'vdi':            'BlockdevCreateOptionsVdi',
       'vhdx':           'BlockdevCreateOptionsVhdx',
       'vmdk':           'BlockdevCreateNotSupported',
-      'vpc':            'BlockdevCreateNotSupported',
+      'vpc':            'BlockdevCreateOptionsVpc',
       'vvfat':          'BlockdevCreateNotSupported',
       'vxhs':           'BlockdevCreateNotSupported'
   } }
diff --git a/block/vpc.c b/block/vpc.c
index b2e2b9ebd4..8824211713 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -32,6 +32,9 @@
 #include "migration/blocker.h"
 #include "qemu/bswap.h"
 #include "qemu/uuid.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 
 /**************************************************************/
 
@@ -166,6 +169,8 @@ static QemuOptsList vpc_runtime_opts = {
     }
 };
 
+static QemuOptsList vpc_create_opts;
+
 static uint32_t vpc_checksum(uint8_t* buf, size_t size)
 {
     uint32_t res = 0;
@@ -897,12 +902,15 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
     return ret;
 }
 
-static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
-                                           Error **errp)
+static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
+                                      Error **errp)
 {
+    BlockdevCreateOptionsVpc *vpc_opts;
+    BlockBackend *blk = NULL;
+    BlockDriverState *bs = NULL;
+
     uint8_t buf[1024];
     VHDFooter *footer = (VHDFooter *) buf;
-    char *disk_type_param;
     int i;
     uint16_t cyls = 0;
     uint8_t heads = 0;
@@ -911,45 +919,38 @@ static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
     int64_t total_size;
     int disk_type;
     int ret = -EIO;
-    bool force_size;
-    Error *local_err = NULL;
-    BlockBackend *blk = NULL;
 
-    /* Read out options */
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    disk_type_param = qemu_opt_get_del(opts, BLOCK_OPT_SUBFMT);
-    if (disk_type_param) {
-        if (!strcmp(disk_type_param, "dynamic")) {
-            disk_type = VHD_DYNAMIC;
-        } else if (!strcmp(disk_type_param, "fixed")) {
-            disk_type = VHD_FIXED;
-        } else {
-            error_setg(errp, "Invalid disk type, %s", disk_type_param);
-            ret = -EINVAL;
-            goto out;
-        }
-    } else {
+    assert(opts->driver == BLOCKDEV_DRIVER_VPC);
+    vpc_opts = &opts->u.vpc;
+
+    /* Validate options and set default values */
+    total_size = vpc_opts->size;
+
+    if (!vpc_opts->has_subformat) {
+        vpc_opts->subformat = BLOCKDEV_VPC_SUBFORMAT_DYNAMIC;
+    }
+    switch (vpc_opts->subformat) {
+    case BLOCKDEV_VPC_SUBFORMAT_DYNAMIC:
         disk_type = VHD_DYNAMIC;
+        break;
+    case BLOCKDEV_VPC_SUBFORMAT_FIXED:
+        disk_type = VHD_FIXED;
+        break;
+    default:
+        g_assert_not_reached();
     }
 
-    force_size = qemu_opt_get_bool_del(opts, VPC_OPT_FORCE_SIZE, false);
-
-    ret = bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        goto out;
+    /* Create BlockBackend to write to the image */
+    bs = bdrv_open_blockdev_ref(vpc_opts->file, errp);
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
         goto out;
     }
-
     blk_set_allow_write_beyond_eof(blk, true);
 
     /*
@@ -961,7 +962,7 @@ static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
      * we set the geometry to 65535 x 16 x 255 (CxHxS) sectors and use
      * the image size from the VHD footer to calculate total_sectors.
      */
-    if (force_size) {
+    if (vpc_opts->force_size) {
         /* This will force the use of total_size for sector count, below */
         cyls         = VHD_CHS_MAX_C;
         heads        = VHD_CHS_MAX_H;
@@ -990,7 +991,7 @@ static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
     memset(buf, 0, 1024);
 
     memcpy(footer->creator, "conectix", 8);
-    if (force_size) {
+    if (vpc_opts->force_size) {
         memcpy(footer->creator_app, "qem2", 4);
     } else {
         memcpy(footer->creator_app, "qemu", 4);
@@ -1032,10 +1033,86 @@ static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
 
 out:
     blk_unref(blk);
-    g_free(disk_type_param);
+    bdrv_unref(bs);
+    return ret;
+}
+
+static int coroutine_fn vpc_co_create_opts(const char *filename,
+                                           QemuOpts *opts, Error **errp)
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
+        { VPC_OPT_FORCE_SIZE,           "force-size" },
+        { NULL, NULL },
+    };
+
+    /* Parse options and convert legacy syntax */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vpc_create_opts, true);
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
+    qdict_put_str(qdict, "driver", "vpc");
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
+    assert(create_options->driver == BLOCKDEV_DRIVER_VPC);
+    create_options->u.vpc.size =
+        ROUND_UP(create_options->u.vpc.size, BDRV_SECTOR_SIZE);
+
+    /* Create the vpc image (format layer) */
+    ret = vpc_co_create(create_options, errp);
+
+fail:
+    QDECREF(qdict);
+    bdrv_unref(bs);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
+
 static int vpc_has_zero_init(BlockDriverState *bs)
 {
     BDRVVPCState *s = bs->opaque;
@@ -1096,6 +1173,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_close             = vpc_close,
     .bdrv_reopen_prepare    = vpc_reopen_prepare,
     .bdrv_child_perm        = bdrv_format_default_perms,
+    .bdrv_co_create         = vpc_co_create,
     .bdrv_co_create_opts    = vpc_co_create_opts,
 
     .bdrv_co_preadv             = vpc_co_preadv,
-- 
2.13.6
