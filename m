Received: from eggs.gnu.org ([2001:4830:134:3::10]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxya2-0002KZ-KZ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxya1-0004Ag-Qr
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:38 +0200
Message-Id: <20170929165347.29658-17-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS option
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

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
index 750bb0c77c..c57741f4c6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3137,6 +3137,14 @@
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
@@ -3145,6 +3153,7 @@
 { 'union': 'BlockdevOptions',
   'base': { 'driver': 'BlockdevDriver',
             '*node-name': 'str',
+            '*base-directory': 'str',
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3a71be3734..3c53a373e1 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -615,6 +615,8 @@ struct BlockDriverState {
     QDict *full_open_options;
     char exact_filename[PATH_MAX];
 
+    char *dirname;
+
     BdrvChild *backing;
     BdrvChild *file;
 
diff --git a/block.c b/block.c
index fd67b667b7..c055bcce5a 100644
--- a/block.c
+++ b/block.c
@@ -1250,6 +1250,12 @@ QemuOptsList bdrv_runtime_opts = {
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
@@ -1322,6 +1328,8 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     trace_bdrv_open_common(bs, filename ?: "", bs->open_flags,
                            drv->format_name);
 
+    bs->dirname = g_strdup(qemu_opt_get(opts, "base-directory"));
+
     bs->read_only = !(bs->open_flags & BDRV_O_RDWR);
 
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, bs->read_only)) {
@@ -3383,6 +3391,8 @@ static void bdrv_delete(BlockDriverState *bs)
 
     bdrv_close(bs);
 
+    g_free(bs->dirname);
+
     /* remove from list, if necessary */
     if (bs->node_name[0] != '\0') {
         QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
@@ -5032,6 +5042,10 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
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
2.13.6
