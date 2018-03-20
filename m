Received: from eggs.gnu.org ([2001:4830:134:3::10]:51492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBk-000071-5B
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBj-0000Pr-2a
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:21 +0100
Message-Id: <20180320173632.25480-2-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 01/12] vdi: Change 'static' create
 option to 'preallocation' in QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

What static=on really does is what we call metadata preallocation for
other block drivers. While we can still change the QMP interface, make
it more consistent by using 'preallocation' for VDI, too.

This doesn't implement any new functionality, so the only supported
preallocation modes are 'off' and 'metadata' for now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  6 ++----
 block/vdi.c          | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b0ad1a8b7..f6673f2b13 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3834,16 +3834,14 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
-# @static           Whether to create a statically (true) or
-#                   dynamically (false) allocated image
-#                   (default: false, i.e. dynamic)
+# @preallocation    Preallocation mode for the new image (default: off)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsVdi',
   'data': { 'file':             'BlockdevRef',
             'size':             'size',
-            '*static':          'bool' } }
+            '*preallocation':   'PreallocMode' } }
 
 ##
 # @BlockdevVhdxSubformat:
diff --git a/block/vdi.c b/block/vdi.c
index d939b034c4..73c059e69d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -728,7 +728,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
     int ret = 0;
     uint64_t bytes = 0;
     uint32_t blocks;
-    uint32_t image_type = VDI_TYPE_DYNAMIC;
+    uint32_t image_type;
     VdiHeader header;
     size_t i;
     size_t bmap_size;
@@ -744,9 +744,22 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
 
     /* Validate options and set default values */
     bytes = vdi_opts->size;
-    if (vdi_opts->q_static) {
+
+    if (!vdi_opts->has_preallocation) {
+        vdi_opts->preallocation = PREALLOC_MODE_OFF;
+    }
+    switch (vdi_opts->preallocation) {
+    case PREALLOC_MODE_OFF:
+        image_type = VDI_TYPE_DYNAMIC;
+        break;
+    case PREALLOC_MODE_METADATA:
         image_type = VDI_TYPE_STATIC;
+        break;
+    default:
+        error_setg(errp, "Preallocation mode not supported for vdi");
+        return -EINVAL;
     }
+
 #ifndef CONFIG_VDI_STATIC_IMAGE
     if (image_type == VDI_TYPE_STATIC) {
         ret = -ENOTSUP;
@@ -874,6 +887,7 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
     BlockdevCreateOptions *create_options = NULL;
     BlockDriverState *bs_file = NULL;
     uint64_t block_size = DEFAULT_CLUSTER_SIZE;
+    bool is_static = false;
     Visitor *v;
     Error *local_err = NULL;
     int ret;
@@ -895,6 +909,9 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
         goto done;
     }
 #endif
+    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_STATIC, false)) {
+        is_static = true;
+    }
 
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
 
@@ -913,6 +930,9 @@ static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
 
     qdict_put_str(qdict, "driver", "vdi");
     qdict_put_str(qdict, "file", bs_file->node_name);
+    if (is_static) {
+        qdict_put_str(qdict, "preallocation", "metadata");
+    }
 
     /* Get the QAPI object */
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
-- 
2.13.6
