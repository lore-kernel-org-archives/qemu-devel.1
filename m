Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9tV7-00087m-Dt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9tUs-0006yP-2E
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  9 Oct 2018 18:00:04 +0300
Message-Id: <20181009150006.10712-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181009150006.10712-1-vsementsov@virtuozzo.com>
References: <20181009150006.10712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 1/3] qapi: add x-debug-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add a new command, returning block nodes (and their users) graph.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json           | 108 ++++++++++++++++++++++++
 include/block/block.h          |   1 +
 include/sysemu/block-backend.h |   2 +
 block.c                        | 146 +++++++++++++++++++++++++++++++++
 block/block-backend.c          |   5 ++
 blockdev.c                     |   5 ++
 6 files changed, 267 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cfb37f8c1d..1580bb95b8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1657,6 +1657,114 @@
 ##
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
 
+##
+# @BlockGraphNodeType:
+#
+# @block-backend: corresponds to BlockBackend
+#
+# @block-job: corresonds to BlockJob
+#
+# @block-driver: corresponds to BlockDriverState
+#
+# Since: 3.1
+##
+{ 'enum': 'BlockGraphNodeType',
+  'data': [ 'block-backend', 'block-job', 'block-driver' ] }
+
+##
+# @BlockGraphNode:
+#
+# @id: Block graph node identifier. This @id is generated only for
+#      x-debug-query-block-graph and does not relate to any other identifiers in
+#      Qemu.
+#
+# @type: Type of graph node. Can be one of block-backend, block-job or
+#        block-driver-state.
+#
+# @name: Human readable name of the node. Corresponds to node-name for
+#        block-driver-state nodes; is not guaranteed to be unique in the whole
+#        graph (with block-jobs and block-backends).
+#
+# Since: 3.1
+##
+{ 'struct': 'BlockGraphNode',
+  'data': { 'id': 'uint64', 'type': 'BlockGraphNodeType', 'name': 'str' } }
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
+# Block Graph edge description for x-debug-query-block-graph.
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
+#               child while it is still attached to this parent
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
+# @x-debug-query-block-graph:
+#
+# Get the block graph.
+#
+# Since: 3.1
+##
+{ 'command': 'x-debug-query-block-graph', 'returns': 'BlockGraph' }
+
 ##
 # @drive-mirror:
 #
diff --git a/include/block/block.h b/include/block/block.h
index b189cf422e..31158cced0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -445,6 +445,7 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
+BlockGraph *bdrv_get_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 830d873f24..32ca5c1b12 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -237,4 +237,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    int bytes, BdrvRequestFlags read_flags,
                                    BdrvRequestFlags write_flags);
 
+const BdrvChild *blk_root(BlockBackend *blk);
+
 #endif
diff --git a/block.c b/block.c
index 7710b399a3..90825f427f 100644
--- a/block.c
+++ b/block.c
@@ -4047,6 +4047,152 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
     return list;
 }
 
+#define QAPI_LIST_ADD(list, element) do { \
+    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
+    _tmp->value = (element); \
+    _tmp->next = (list); \
+    (list) = _tmp; \
+} while (0)
+
+typedef struct BlockGraphConstructor {
+    BlockGraph *graph;
+    GHashTable *graph_nodes;
+} BlockGraphConstructor;
+
+static BlockGraphConstructor *dbg_graph_new(void)
+{
+    BlockGraphConstructor *gr = g_new(BlockGraphConstructor, 1);
+
+    gr->graph = g_new0(BlockGraph, 1);
+    gr->graph_nodes = g_hash_table_new(NULL, NULL);
+
+    return gr;
+}
+
+static BlockGraph *dbg_graph_finalize(BlockGraphConstructor *gr)
+{
+    BlockGraph *graph = gr->graph;
+
+    g_hash_table_destroy(gr->graph_nodes);
+    g_free(gr);
+
+    return graph;
+}
+
+static uintptr_t dbg_graph_node_num(BlockGraphConstructor *gr, void *node)
+{
+    uintptr_t ret = (uintptr_t)g_hash_table_lookup(gr->graph_nodes, node);
+
+    if (ret != 0) {
+        return ret;
+    }
+
+    /* Start counting from 1, not 0, because 0 interferes with not-found (NULL)
+     * answer of g_hash_table_lookup.
+     */
+    ret = g_hash_table_size(gr->graph_nodes) + 1;
+    g_hash_table_insert(gr->graph_nodes, node, (void *)ret);
+
+    return ret;
+}
+
+static void dbg_graph_add_node(BlockGraphConstructor *gr, void *node,
+                               BlockGraphNodeType type, const char *name)
+{
+    BlockGraphNode *n;
+
+    n = g_new0(BlockGraphNode, 1);
+
+    n->id = dbg_graph_node_num(gr, node);
+    n->type = type;
+    n->name = g_strdup(name);
+
+    QAPI_LIST_ADD(gr->graph->nodes, n);
+}
+
+static void dbg_graph_add_edge(BlockGraphConstructor *gr, void *parent,
+                               const BdrvChild *child)
+{
+    typedef struct {
+        unsigned int flag;
+        BlockPermission num;
+    } PermissionMap;
+
+    static const PermissionMap permissions[] = {
+        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
+        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
+        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
+        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
+        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
+        { 0, 0 }
+    };
+    const PermissionMap *p;
+    BlockGraphEdge *edge;
+
+    QEMU_BUILD_BUG_ON(1UL << (ARRAY_SIZE(permissions) - 1) != BLK_PERM_ALL + 1);
+
+    edge = g_new0(BlockGraphEdge, 1);
+
+    edge->parent = dbg_graph_node_num(gr, parent);
+    edge->child = dbg_graph_node_num(gr, child->bs);
+    edge->name = g_strdup(child->name);
+
+    for (p = permissions; p->flag; p++) {
+        if (p->flag & child->perm) {
+            QAPI_LIST_ADD(edge->perm, p->num);
+        }
+        if (p->flag & child->shared_perm) {
+            QAPI_LIST_ADD(edge->shared_perm, p->num);
+        }
+    }
+
+    QAPI_LIST_ADD(gr->graph->edges, edge);
+}
+
+
+BlockGraph *bdrv_get_block_graph(Error **errp)
+{
+    BlockBackend *blk;
+    BlockJob *job;
+    BlockDriverState *bs;
+    BdrvChild *child;
+    BlockGraphConstructor *gr = dbg_graph_new();
+
+    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
+        char *allocated_name = NULL;
+        const char *name = blk_name(blk);
+
+        if (!name) {
+            name = allocated_name = blk_get_attached_dev_id(blk);
+        }
+        dbg_graph_add_node(gr, blk, BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEND, name);
+        g_free(allocated_name);
+        if (blk_root(blk)) {
+            dbg_graph_add_edge(gr, blk, blk_root(blk));
+        }
+    }
+
+    for (job = block_job_next(NULL); job; job = block_job_next(job)) {
+        GSList *el;
+
+        dbg_graph_add_node(gr, job, BLOCK_GRAPH_NODE_TYPE_BLOCK_JOB,
+                           job->job.id);
+        for (el = job->nodes; el; el = el->next) {
+            dbg_graph_add_edge(gr, job, (BdrvChild *)el->data);
+        }
+    }
+
+    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
+        dbg_graph_add_node(gr, bs, BLOCK_GRAPH_NODE_TYPE_BLOCK_DRIVER,
+                           bs->node_name);
+        QLIST_FOREACH(child, &bs->children, next) {
+            dbg_graph_add_edge(gr, bs, child);
+        }
+    }
+
+    return dbg_graph_finalize(gr);
+}
+
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp)
diff --git a/block/block-backend.c b/block/block-backend.c
index dc0cd57724..0146908229 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2248,3 +2248,8 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                               blk_out->root, off_out,
                               bytes, read_flags, write_flags);
 }
+
+const BdrvChild *blk_root(BlockBackend *blk)
+{
+    return blk->root;
+}
diff --git a/blockdev.c b/blockdev.c
index a8755bd908..925db6cf92 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3538,6 +3538,11 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
     return bdrv_named_nodes_list(errp);
 }
 
+BlockGraph *qmp_x_debug_query_block_graph(Error **errp)
+{
+    return bdrv_get_block_graph(errp);
+}
+
 BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                              Error **errp)
 {
-- 
2.18.0
