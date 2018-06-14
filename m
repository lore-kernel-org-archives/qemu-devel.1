Received: from eggs.gnu.org ([2001:4830:134:3::10]:53121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000j5-U9
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVH-0003mt-Vp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:44 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:06 +0300
Message-Id: <4912b75d514ba7b01def0a79e7a40146d0a88fca.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 09/10] block: Add a 'x-blockdev-reopen' QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

This command allows reopening an arbitrary BlockDriverState with a new
set of options. Some options (e.g node-name) cannot be changed and
some block drivers don't allow reopening, but otherwise this command
is modelled after 'blockdev-add' and the state of the reopened
BlockDriverState should generally be the same as if it had just been
added by 'blockdev-add' with the same set of options.

One notable exception is that when the 'backing' option is omitted
then 'blockdev-add' opens the image's default backing file, whereas
'x-blockdev-reopen' simply keeps the current one.

This command allows reconfiguring the graph by using the appropriate
options to change the children of a node. At the moment it's possible
to change a backing file by setting the 'backing' option to the name
of the new node, but it should also be possible to add a similar
functionality to other block drivers (e.g. Quorum, blkverify).

Although the API is unlikely to change, this command is marked
experimental for the time being so there's room to see if the
semantics need changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 blockdev.c           | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 29 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 4862323012..1502747483 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4236,6 +4236,63 @@ fail:
     visit_free(v);
 }
 
+void qmp_x_blockdev_reopen(BlockdevOptions *options, Error **errp)
+{
+    BlockDriverState *bs;
+    QObject *obj;
+    Visitor *v = qobject_output_visitor_new(&obj);
+    Error *local_err = NULL;
+    int flags;
+    BlockReopenQueue *queue;
+    QDict *qdict;
+
+    /* Check for the selected node name */
+    if (!options->has_node_name) {
+        error_setg(errp, "Node name not specified");
+        goto fail;
+    }
+
+    bs = bdrv_find_node(options->node_name);
+    if (!bs) {
+        error_setg(errp, "Cannot find node named '%s'", options->node_name);
+        goto fail;
+    }
+
+    /* Put all options in a QDict and flatten it */
+    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    visit_complete(v, &obj);
+    qdict = qobject_to(QDict, obj);
+
+    qdict_flatten(qdict);
+
+    /* Set some default values */
+    qdict_put_bool(qdict, BDRV_OPT_CACHE_DIRECT,
+                   qdict_get_try_bool(qdict, BDRV_OPT_CACHE_DIRECT, false));
+    qdict_put_bool(qdict, BDRV_OPT_CACHE_NO_FLUSH,
+                   qdict_get_try_bool(qdict, BDRV_OPT_CACHE_NO_FLUSH, false));
+    qdict_put_bool(qdict, BDRV_OPT_READ_ONLY,
+                   qdict_get_try_bool(qdict, BDRV_OPT_READ_ONLY, false));
+
+    flags = 0;
+    if (!qdict_get_bool(qdict, BDRV_OPT_READ_ONLY)) {
+        flags |= (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);
+    }
+
+    /* Perform the reopen operation */
+    bdrv_subtree_drained_begin(bs);
+    queue = bdrv_reopen_queue(NULL, bs, qdict, flags, false);
+    bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, errp);
+    bdrv_subtree_drained_end(bs);
+
+fail:
+    visit_free(v);
+}
+
 void qmp_blockdev_del(const char *node_name, Error **errp)
 {
     AioContext *aio_context;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fff23fc82b..ee8bf7c0ea 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3651,6 +3651,35 @@
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
 
 ##
+# @x-blockdev-reopen:
+#
+# Reopens a block device using the given set of options. Any option
+# not specified will be reset to its default value regardless of its
+# previous status. If an option cannot be changed or a particular
+# driver does not support reopening the command will return an error.
+#
+# The top-level @node-name option (from BlockdevOptions) must be
+# specified and is used to select the block device to be reopened.
+# Other @node-name options must be either omitted or set to the
+# current name of the appropriate node. This command won't change any
+# node name and any attempt to do it will result in an error.
+#
+# The @backing option can always be omitted: any block device can be
+# reopened by specifying only its own options, without having to
+# include any of its backing files.
+#
+# Unlike blockdev-add, leaving out the @backing option will simply
+# keep the current backing file for that image and will not try to
+# open the default one. The way to replace a backing file is by
+# passing a reference to the new one in the @backing parameter.
+# If @backing is null then the current backing file will be removed.
+#
+# Since: 2.13
+##
+{ 'command': 'x-blockdev-reopen',
+  'data': 'BlockdevOptions', 'boxed': true }
+
+##
 # @blockdev-del:
 #
 # Deletes a block device that has been added using blockdev-add.
-- 
2.11.0
