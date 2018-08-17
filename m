Received: from eggs.gnu.org ([2001:4830:134:3::10]:50066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj7A-0004mi-Np
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj75-0006cA-W8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 21:04:38 +0300
Message-Id: <20180817180440.49687-1-vsementsov@virtuozzo.com>
In-Reply-To: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

Add a new command, returning block nodes graph.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |   1 +
 block.c               |  80 ++++++++++++++++++++++++++++++++++
 blockdev.c            |   5 +++
 4 files changed, 202 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37afdc..32398c9912 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1630,6 +1630,122 @@
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
 
 ##
+# @BlockGraphNodeType:
+#
+# @block: Actual block nodes, which may be queried by query-named-block-nodes.
+# @other: Not a block node. Examples: guest block device, block job.
+#
+# Since: 3.1
+##
+{ 'enum': 'BlockGraphNodeType',
+  'data': [ 'block', 'other' ] }
+
+##
+# @BlockGraphNodeTypeBlock:
+#
+# Since: 3.1
+##
+{ 'struct': 'BlockGraphNodeTypeBlock',
+  'data': { 'node-name': 'str' } }
+
+##
+# @BlockGraphNodeTypeOther:
+#
+# Since: 3.1
+##
+  { 'struct': 'BlockGraphNodeTypeOther',
+    'data': { 'description': 'str' } }
+
+##
+# @BlockGraphNode:
+#
+# @id: unique node identifier, equal to node RAM-pointer
+# @type: node type
+#
+# Since: 3.1
+##
+{ 'union': 'BlockGraphNode',
+  'base': { 'id': 'uint64', 'type': 'BlockGraphNodeType' },
+  'discriminator': 'type',
+  'data' : { 'block': 'BlockGraphNodeTypeBlock',
+             'other': 'BlockGraphNodeTypeOther' } }
+
+##
+# @BlockPermission:
+#
+# Enum of base block permissions.
+#
+# @consistent-read: A user that has the "permission" of consistent reads is
+#                   guaranteed that their view of the contents of the block
+#                   device is complete and self-consistent, representing the
+#                   contents of a disk at a specific point.
+#                   For most block devices (including their backing files) this
+#                   is true, but the property cannot be maintained in a few
+#                   situations like for intermediate nodes of a commit block
+#                   job.
+#
+# @write: This permission is required to change the visible disk contents.
+#
+# @write-unchanged: This permission (which is weaker than BLK_PERM_WRITE) is
+#                   both enough and required for writes to the block node when
+#                   the caller promises that the visible disk content doesn't
+#                   change.
+#                   As the BLK_PERM_WRITE permission is strictly stronger,
+#                   either is sufficient to perform an unchanging write.
+#
+# @resize: This permission is required to change the size of a block node.
+#
+# @graph-mod: This permission is required to change the node that this
+#             BdrvChild points to.
+#
+# Since: 3.1
+##
+  { 'enum': 'BlockPermission',
+    'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
+              'graph-mod' ] }
+##
+# @BlockGraphEdge:
+#
+# Block Graph edge description for x-query-block-graph.
+#
+# @parent: parent id
+#
+# @child: child id
+#
+# @name: name of the relation (examples are 'file' and 'backing')
+#
+# @perm: granted permissions for the parent operating on the child
+#
+# @shared-perm: permissions that can still be granted to other users of the
+#               child while it is still attached this parent
+#
+# Since: 3.1
+##
+{ 'struct': 'BlockGraphEdge',
+  'data': { 'parent': 'uint64', 'child': 'uint64',
+            'name': 'str', 'perm': [ 'BlockPermission' ],
+            'shared-perm': [ 'BlockPermission' ] } }
+
+##
+# @BlockGraph:
+#
+# Block Graph - list of nodes and list of edges.
+#
+# Since: 3.1
+##
+{ 'struct': 'BlockGraph',
+  'data': { 'nodes': ['BlockGraphNode'], 'edges': ['BlockGraphEdge'] } }
+
+##
+# @x-query-block-graph:
+#
+# Get the block graph.
+#
+# Since: 3.1
+##
+{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
+
+##
 # @drive-mirror:
 #
 # Start mirroring a block device's writes to a new destination. target
diff --git a/include/block/block.h b/include/block/block.h
index 4e0871aaf9..6f2ccad040 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -448,6 +448,7 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
+BlockGraph *bdrv_get_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
diff --git a/block.c b/block.c
index 6161dbe3eb..766354e79c 100644
--- a/block.c
+++ b/block.c
@@ -4003,6 +4003,86 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
     return list;
 }
 
+#define QAPI_LIST_ADD(list, element) do { \
+    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
+    _tmp->value = (element); \
+    _tmp->next = (list); \
+    list = _tmp; \
+} while (0)
+
+BlockGraph *bdrv_get_block_graph(Error **errp)
+{
+    BlockGraph *graph = g_new0(BlockGraph, 1);
+    BlockDriverState *bs;
+    BdrvChild *child;
+    BlockGraphNode *node;
+    BlockGraphEdge *edge;
+    struct {
+        unsigned int flag;
+        BlockPermission num;
+    } permissions[] = {
+        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
+        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
+        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
+        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
+        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
+        { 0, 0 }
+    }, *p;
+
+    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
+        QLIST_FOREACH(child, &bs->parents, next_parent) {
+            if (!child->role->parent_is_bds) {
+                BlockGraphNodeList *el;
+                bool add = true;
+
+                for (el = graph->nodes; el; el = el->next) {
+                    if (el->value->id == (uint64_t)child->opaque) {
+                        add = false;
+                        break;
+                    }
+                }
+
+                if (add) {
+                    node = g_new0(BlockGraphNode, 1);
+                    node->id = (uint64_t)child->opaque;
+                    node->type = BLOCK_GRAPH_NODE_TYPE_OTHER;
+                    node->u.other.description =
+                            g_strdup(bdrv_child_user_desc(child));
+                    QAPI_LIST_ADD(graph->nodes, node);
+                }
+            }
+
+            edge = g_new0(BlockGraphEdge, 1);
+
+            edge->parent = (uint64_t)child->opaque;
+            edge->child = (uint64_t)bs;
+            assert(bs == child->bs);
+            edge->name = g_strdup(child->name);
+
+            for (p = permissions; p->flag; p++) {
+                if (p->flag & child->perm) {
+                    QAPI_LIST_ADD(edge->perm, p->num);
+                }
+                if (p->flag & child->shared_perm) {
+                    QAPI_LIST_ADD(edge->shared_perm, p->num);
+                }
+            }
+
+            QAPI_LIST_ADD(graph->edges, edge);
+        }
+    }
+
+    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
+        node = g_new0(BlockGraphNode, 1);
+        node->id = (uint64_t)bs;
+        node->type = BLOCK_GRAPH_NODE_TYPE_BLOCK;
+        node->u.block.node_name = g_strdup(bdrv_get_node_name(bs));
+        QAPI_LIST_ADD(graph->nodes, node);
+    }
+
+    return graph;
+}
+
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp)
diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..099a27d7b8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3485,6 +3485,11 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
     return bdrv_named_nodes_list(errp);
 }
 
+BlockGraph *qmp_x_query_block_graph(Error **errp)
+{
+    return bdrv_get_block_graph(errp);
+}
+
 BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                              Error **errp)
 {
-- 
2.11.1
