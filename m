Received: from eggs.gnu.org ([2001:4830:134:3::10]:45210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQjg-0006ux-Sz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evQjf-0006hc-KR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:55:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 12 Mar 2018 17:55:26 +0100
Message-Id: <20180312165528.8969-2-mreitz@redhat.com>
In-Reply-To: <20180312165528.8969-1-mreitz@redhat.com>
References: <20180312165528.8969-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] vdi: Pull option parsing from vdi_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

In preparation of QAPI-fying VDI image creation, we have to create a
BlockdevCreateOptionsVdi type which is received by a (future)
vdi_co_create().

vdi_co_create_opts() now converts the QemuOpts object into such a
BlockdevCreateOptionsVdi object.  The protocol-layer file is still
created in vdi_co_do_create() (and BlockdevCreateOptionsVdi.file is set
to an empty string), but that will be addressed by a follow-up patch.

Note that cluster-size is not part of the QAPI schema because it is not
supported by default.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 18 +++++++++++
 block/vdi.c          | 91 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 524d51567a..e7110c9a47 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3606,6 +3606,24 @@
   'data': { 'location':         'BlockdevOptionsSsh',
             'size':             'size' } }
 
+##
+# @BlockdevCreateOptionsVdi:
+#
+# Driver specific image creation options for VDI.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @static           Whether to create a statically (true) or
+#                   dynamically (false) allocated image
+#                   (default: false, i.e. dynamic)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsVdi',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size',
+            '*static':          'bool' } }
+
 ##
 # @BlockdevCreateNotSupported:
 #
diff --git a/block/vdi.c b/block/vdi.c
index 2b5ddd0666..0c8f8204ce 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -51,6 +51,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
@@ -140,6 +143,8 @@
 #define VDI_DISK_SIZE_MAX        ((uint64_t)VDI_BLOCKS_IN_IMAGE_MAX * \
                                   (uint64_t)DEFAULT_CLUSTER_SIZE)
 
+static QemuOptsList vdi_create_opts;
+
 typedef struct {
     char text[0x40];
     uint32_t signature;
@@ -716,13 +721,14 @@ nonallocating_write:
     return ret;
 }
 
-static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
-                                           Error **errp)
+static int coroutine_fn vdi_co_do_create(const char *filename,
+                                         QemuOpts *file_opts,
+                                         BlockdevCreateOptionsVdi *vdi_opts,
+                                         size_t block_size, Error **errp)
 {
     int ret = 0;
     uint64_t bytes = 0;
     uint32_t blocks;
-    size_t block_size = DEFAULT_CLUSTER_SIZE;
     uint32_t image_type = VDI_TYPE_DYNAMIC;
     VdiHeader header;
     size_t i;
@@ -735,18 +741,25 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     logout("\n");
 
     /* Read out options. */
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
+    bytes = vdi_opts->size;
+    if (vdi_opts->q_static) {
         image_type = VDI_TYPE_STATIC;
     }
+#ifndef CONFIG_VDI_STATIC_IMAGE
+    if (image_type == VDI_TYPE_STATIC) {
+        ret = -ENOTSUP;
+        error_setg(errp, "Statically allocated images cannot be created in "
+                   "this build");
+        goto exit;
+    }
+#endif
+#ifndef CONFIG_VDI_BLOCK_SIZE
+    if (block_size != DEFAULT_CLUSTER_SIZE) {
+        ret = -ENOTSUP;
+        error_setg(errp,
+                   "A non-default cluster size is not supported in this build");
+        goto exit;
+    }
 #endif
 
     if (bytes > VDI_DISK_SIZE_MAX) {
@@ -757,7 +770,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         goto exit;
     }
 
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, file_opts, &local_err);
     if (ret < 0) {
         error_propagate(errp, local_err);
         goto exit;
@@ -847,6 +860,56 @@ exit:
     return ret;
 }
 
+static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
+{
+    QDict *qdict = NULL;
+    BlockdevCreateOptionsVdi *create_options = NULL;
+    uint64_t block_size = DEFAULT_CLUSTER_SIZE;
+    Visitor *v;
+    Error *local_err = NULL;
+    int ret;
+
+    /* Since CONFIG_VDI_BLOCK_SIZE is disabled by default,
+     * cluster-size is not part of the QAPI schema; therefore we have
+     * to parse it before creating the QAPI object. */
+#if defined(CONFIG_VDI_BLOCK_SIZE)
+    block_size = qemu_opt_get_size_del(opts,
+                                       BLOCK_OPT_CLUSTER_SIZE,
+                                       DEFAULT_CLUSTER_SIZE);
+    if (block_size < BDRV_SECTOR_SIZE || block_size > UINT32_MAX ||
+        !is_power_of_2(block_size))
+    {
+        error_setg(errp, "Invalid cluster size");
+        ret = -EINVAL;
+        goto done;
+    }
+#endif
+
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
+
+    qdict_put_str(qdict, "file", ""); /* FIXME */
+
+    /* Get the QAPI object */
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    visit_type_BlockdevCreateOptionsVdi(v, NULL, &create_options, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto done;
+    }
+
+    create_options->size = ROUND_UP(create_options->size, BDRV_SECTOR_SIZE);
+
+    ret = vdi_co_do_create(filename, opts, create_options, block_size, errp);
+done:
+    QDECREF(qdict);
+    qapi_free_BlockdevCreateOptionsVdi(create_options);
+    return ret;
+}
+
 static void vdi_close(BlockDriverState *bs)
 {
     BDRVVdiState *s = bs->opaque;
-- 
2.14.3
