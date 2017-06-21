Received: from eggs.gnu.org ([2001:4830:134:3::10]:34170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6q-0008BS-2y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6p-0005Ma-5E
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:38 +0200
Message-Id: <20170621125047.30294-17-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/25] block: Add 'base-directory' BDS option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Using this option, one can directly override what bdrv_dirname() will
return. This is useful if one uses e.g. qcow2 on top of quorum (with
only protocol BDSs under the quorum BDS) and wants to be able to use
relative backing filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json      |  9 +++++++++
 include/block/block_int.h |  2 ++
 block.c                   | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f85c223..4090c62 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2940,6 +2940,14 @@
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.
 #                 Requires read-only=true. (Since 2.10)
+# @base-directory May be specified for any node. Normally, whenever a filename
+#                 is specified which is supposed to be relative to this node
+#                 (such as relative backing filenames), the base directory to be
+#                 used is the directory the image file of this node is in, which
+#                 is simply prepended to the relative filename. Using this
+#                 option, the string which is prepended (i.e. the base
+#                 directory) can be overridden.
+#                 (Since 2.10)
 #
 # Remaining options are determined by the block driver.
 #
@@ -2948,6 +2956,7 @@
 { 'union': 'BlockdevOptions',
   'base': { 'driver': 'BlockdevDriver',
             '*node-name': 'str',
+            '*base-directory': 'str',
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 61e7d7a..8a7fc2d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -559,6 +559,8 @@ struct BlockDriverState {
     QDict *full_open_options;
     char exact_filename[PATH_MAX];
 
+    char *dirname;
+
     BdrvChild *backing;
     BdrvChild *file;
 
diff --git a/block.c b/block.c
index a5dd6bb..8e03cca 100644
--- a/block.c
+++ b/block.c
@@ -1233,6 +1233,12 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "always accept other writers (default: off)",
         },
+        {
+            .name = "base-directory",
+            .type = QEMU_OPT_STRING,
+            .help = "String to prepend to filenames relative to this BDS for "
+                    "making them absolute",
+        },
         { /* end of list */ }
     },
 };
@@ -1305,6 +1311,8 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     trace_bdrv_open_common(bs, filename ?: "", bs->open_flags,
                            drv->format_name);
 
+    bs->dirname = g_strdup(qemu_opt_get(opts, "base-directory"));
+
     bs->read_only = !(bs->open_flags & BDRV_O_RDWR);
 
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, bs->read_only)) {
@@ -3249,6 +3257,8 @@ static void bdrv_delete(BlockDriverState *bs)
 
     bdrv_close(bs);
 
+    g_free(bs->dirname);
+
     /* remove from list, if necessary */
     if (bs->node_name[0] != '\0') {
         QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
@@ -4931,6 +4941,10 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
 
+    if (bs->dirname) {
+        return g_strdup(bs->dirname);
+    }
+
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
         return NULL;
-- 
2.9.4
