Received: from eggs.gnu.org ([2001:4830:134:3::10]:45732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDs-0000zY-KH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDr-0003r8-OE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:49:12 +0100
Message-Id: <20170116204921.31578-9-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 16/25] block: Add 'base-directory' BDS option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

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
index 6b42216960..b4bd941696 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2367,6 +2367,14 @@
 #                 (default: false)
 # @detect-zeroes: #optional detect and optimize zero writes (Since 2.1)
 #                 (default: off)
+# @base-directory #optional May be specified for any node. Normally, whenever a
+#                 filename is specified which is supposed to be relative to this
+#                 node (such as relative backing filenames), the base directory
+#                 to be used is the directory the image file of this node is in,
+#                 which is simply prepended to the relative filename. Using this
+#                 option, the string which is prepended (i.e. the base
+#                 directory) can be overridden.
+#                 (Since 2.9)
 #
 # Remaining options are determined by the block driver.
 #
@@ -2375,6 +2383,7 @@
 { 'union': 'BlockdevOptions',
   'base': { 'driver': 'BlockdevDriver',
             '*node-name': 'str',
+            '*base-directory': 'str',
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
diff --git a/include/block/block_int.h b/include/block/block_int.h
index fb916a7890..30fc1def4a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -467,6 +467,8 @@ struct BlockDriverState {
     QDict *full_open_options;
     char exact_filename[PATH_MAX];
 
+    char *dirname;
+
     BdrvChild *backing;
     BdrvChild *file;
 
diff --git a/block.c b/block.c
index f3d4436c9e..a10ba111bc 100644
--- a/block.c
+++ b/block.c
@@ -984,6 +984,12 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "discard operation (ignore/off, unmap/on)",
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
@@ -1047,6 +1053,8 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
         goto fail_opts;
     }
 
+    bs->dirname = g_strdup(qemu_opt_get(opts, "base-directory"));
+
     bs->read_only = !(bs->open_flags & BDRV_O_RDWR);
 
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, bs->read_only)) {
@@ -2490,6 +2498,8 @@ static void bdrv_delete(BlockDriverState *bs)
 
     bdrv_close(bs);
 
+    g_free(bs->dirname);
+
     /* remove from list, if necessary */
     if (bs->node_name[0] != '\0') {
         QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
@@ -4097,6 +4107,10 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
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
2.11.0
