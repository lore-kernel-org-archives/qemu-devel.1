Received: from eggs.gnu.org ([209.51.188.92]:39224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gt-0001xw-6B
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9go-0007qS-25
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:47 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:34:03 +0200
Message-Id: <0bdcfe1afa7b1b60eda0258861d4239ef85b1788.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 12/13] block: Add an 'x-blockdev-reopen' QMP
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This command allows reopening an arbitrary BlockDriverState with a
new set of options. Some options (e.g node-name) cannot be changed
and some block drivers don't allow reopening, but otherwise this
command is modelled after 'blockdev-add' and the state of the reopened
BlockDriverState should generally be the same as if it had just been
added by 'blockdev-add' with the same set of options.

One notable exception is the 'backing' option: 'x-blockdev-reopen'
requires that it is always present unless the BlockDriverState in
question doesn't have a current or default backing file.

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
 blockdev.c           | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index a8fa8748a9..d8831db7e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4258,6 +4258,53 @@ fail:
     visit_free(v);
 }
 
+void qmp_x_blockdev_reopen(BlockdevOptions *options, Error **errp)
+{
+    BlockDriverState *bs;
+    AioContext *ctx;
+    QObject *obj;
+    Visitor *v = qobject_output_visitor_new(&obj);
+    Error *local_err = NULL;
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
+    /* Perform the reopen operation */
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+    bdrv_subtree_drained_begin(bs);
+    queue = bdrv_reopen_queue(NULL, bs, qdict, false);
+    bdrv_reopen_multiple(queue, errp);
+    bdrv_subtree_drained_end(bs);
+    aio_context_release(ctx);
+
+fail:
+    visit_free(v);
+}
+
 void qmp_blockdev_del(const char *node_name, Error **errp)
 {
     AioContext *aio_context;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be6c2..1cfaccd500 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3816,6 +3816,48 @@
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
 
 ##
+# @x-blockdev-reopen:
+#
+# Reopens a block device using the given set of options. Any option
+# not specified will be reset to its default value regardless of its
+# previous status. If an option cannot be changed or a particular
+# driver does not support reopening then the command will return an
+# error.
+#
+# The top-level @node-name option (from BlockdevOptions) must be
+# specified and is used to select the block device to be reopened.
+# Other @node-name options must be either omitted or set to the
+# current name of the appropriate node. This command won't change any
+# node name and any attempt to do it will result in an error.
+#
+# In the case of options that refer to child nodes, the behavior of
+# this command depends on the value:
+#
+#  1) A set of options (BlockdevOptions): the child is reopened with
+#     the specified set of options.
+#
+#  2) A reference to the current child: the child is reopened using
+#     its existing set of options.
+#
+#  3) A reference to a different node: the current child is replaced
+#     with the specified one.
+#
+#  4) NULL: the current child (if any) is detached.
+#
+# Options (1) and (2) are supported in all cases, but at the moment
+# only @backing allows replacing or detaching an existing child.
+#
+# Unlike with blockdev-add, the @backing option must always be present
+# unless the node being reopened does not have a backing file and its
+# image does not have a default backing file name as part of its
+# metadata.
+#
+# Since: 4.0
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
