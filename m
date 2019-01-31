Received: from eggs.gnu.org ([209.51.188.92]:37470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0hw-0007sW-Hb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0hv-0007bC-2u
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:56 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:33 +0100
Message-Id: <20190131005945.20149-2-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] qapi: add x-debug-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add a new command, returning block nodes (and their users) graph.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181221170909.25584-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json           | 108 ++++++++++++++++++++++++
 include/block/block.h          |   1 +
 include/sysemu/block-backend.h |   2 +
 block.c                        | 148 +++++++++++++++++++++++++++++++++
 block/block-backend.c          |   5 ++
 blockdev.c                     |   5 ++
 6 files changed, 269 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be6c2..cde1b53708 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1665,6 +1665,114 @@
 ##
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ]=
 }
=20
+##
+# @XDbgBlockGraphNodeType:
+#
+# @block-backend: corresponds to BlockBackend
+#
+# @block-job: corresonds to BlockJob
+#
+# @block-driver: corresponds to BlockDriverState
+#
+# Since: 4.0
+##
+{ 'enum': 'XDbgBlockGraphNodeType',
+  'data': [ 'block-backend', 'block-job', 'block-driver' ] }
+
+##
+# @XDbgBlockGraphNode:
+#
+# @id: Block graph node identifier. This @id is generated only for
+#      x-debug-query-block-graph and does not relate to any other identi=
fiers in
+#      Qemu.
+#
+# @type: Type of graph node. Can be one of block-backend, block-job or
+#        block-driver-state.
+#
+# @name: Human readable name of the node. Corresponds to node-name for
+#        block-driver-state nodes; is not guaranteed to be unique in the=
 whole
+#        graph (with block-jobs and block-backends).
+#
+# Since: 4.0
+##
+{ 'struct': 'XDbgBlockGraphNode',
+  'data': { 'id': 'uint64', 'type': 'XDbgBlockGraphNodeType', 'name': 's=
tr' } }
+
+##
+# @BlockPermission:
+#
+# Enum of base block permissions.
+#
+# @consistent-read: A user that has the "permission" of consistent reads=
 is
+#                   guaranteed that their view of the contents of the bl=
ock
+#                   device is complete and self-consistent, representing=
 the
+#                   contents of a disk at a specific point.
+#                   For most block devices (including their backing file=
s) this
+#                   is true, but the property cannot be maintained in a =
few
+#                   situations like for intermediate nodes of a commit b=
lock
+#                   job.
+#
+# @write: This permission is required to change the visible disk content=
s.
+#
+# @write-unchanged: This permission (which is weaker than BLK_PERM_WRITE=
) is
+#                   both enough and required for writes to the block nod=
e when
+#                   the caller promises that the visible disk content do=
esn't
+#                   change.
+#                   As the BLK_PERM_WRITE permission is strictly stronge=
r,
+#                   either is sufficient to perform an unchanging write.
+#
+# @resize: This permission is required to change the size of a block nod=
e.
+#
+# @graph-mod: This permission is required to change the node that this
+#             BdrvChild points to.
+#
+# Since: 4.0
+##
+  { 'enum': 'BlockPermission',
+    'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
+              'graph-mod' ] }
+##
+# @XDbgBlockGraphEdge:
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
+# @shared-perm: permissions that can still be granted to other users of =
the
+#               child while it is still attached to this parent
+#
+# Since: 4.0
+##
+{ 'struct': 'XDbgBlockGraphEdge',
+  'data': { 'parent': 'uint64', 'child': 'uint64',
+            'name': 'str', 'perm': [ 'BlockPermission' ],
+            'shared-perm': [ 'BlockPermission' ] } }
+
+##
+# @XDbgBlockGraph:
+#
+# Block Graph - list of nodes and list of edges.
+#
+# Since: 4.0
+##
+{ 'struct': 'XDbgBlockGraph',
+  'data': { 'nodes': ['XDbgBlockGraphNode'], 'edges': ['XDbgBlockGraphEd=
ge'] } }
+
+##
+# @x-debug-query-block-graph:
+#
+# Get the block graph.
+#
+# Since: 4.0
+##
+{ 'command': 'x-debug-query-block-graph', 'returns': 'XDbgBlockGraph' }
+
 ##
 # @drive-mirror:
 #
diff --git a/include/block/block.h b/include/block/block.h
index f70a843b72..57233cf2c0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -448,6 +448,7 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag=
);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
+XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index c96bcdee14..c8f816a200 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -237,4 +237,6 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_=
in, int64_t off_in,
                                    int bytes, BdrvRequestFlags read_flag=
s,
                                    BdrvRequestFlags write_flags);
=20
+const BdrvChild *blk_root(BlockBackend *blk);
+
 #endif
diff --git a/block.c b/block.c
index 4f5ff2cc12..e795a7c5de 100644
--- a/block.c
+++ b/block.c
@@ -4119,6 +4119,154 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error =
**errp)
     return list;
 }
=20
+#define QAPI_LIST_ADD(list, element) do { \
+    typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \
+    _tmp->value =3D (element); \
+    _tmp->next =3D (list); \
+    (list) =3D _tmp; \
+} while (0)
+
+typedef struct XDbgBlockGraphConstructor {
+    XDbgBlockGraph *graph;
+    GHashTable *graph_nodes;
+} XDbgBlockGraphConstructor;
+
+static XDbgBlockGraphConstructor *xdbg_graph_new(void)
+{
+    XDbgBlockGraphConstructor *gr =3D g_new(XDbgBlockGraphConstructor, 1=
);
+
+    gr->graph =3D g_new0(XDbgBlockGraph, 1);
+    gr->graph_nodes =3D g_hash_table_new(NULL, NULL);
+
+    return gr;
+}
+
+static XDbgBlockGraph *xdbg_graph_finalize(XDbgBlockGraphConstructor *gr=
)
+{
+    XDbgBlockGraph *graph =3D gr->graph;
+
+    g_hash_table_destroy(gr->graph_nodes);
+    g_free(gr);
+
+    return graph;
+}
+
+static uintptr_t xdbg_graph_node_num(XDbgBlockGraphConstructor *gr, void=
 *node)
+{
+    uintptr_t ret =3D (uintptr_t)g_hash_table_lookup(gr->graph_nodes, no=
de);
+
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    /*
+     * Start counting from 1, not 0, because 0 interferes with not-found=
 (NULL)
+     * answer of g_hash_table_lookup.
+     */
+    ret =3D g_hash_table_size(gr->graph_nodes) + 1;
+    g_hash_table_insert(gr->graph_nodes, node, (void *)ret);
+
+    return ret;
+}
+
+static void xdbg_graph_add_node(XDbgBlockGraphConstructor *gr, void *nod=
e,
+                                XDbgBlockGraphNodeType type, const char =
*name)
+{
+    XDbgBlockGraphNode *n;
+
+    n =3D g_new0(XDbgBlockGraphNode, 1);
+
+    n->id =3D xdbg_graph_node_num(gr, node);
+    n->type =3D type;
+    n->name =3D g_strdup(name);
+
+    QAPI_LIST_ADD(gr->graph->nodes, n);
+}
+
+static void xdbg_graph_add_edge(XDbgBlockGraphConstructor *gr, void *par=
ent,
+                                const BdrvChild *child)
+{
+    typedef struct {
+        unsigned int flag;
+        BlockPermission num;
+    } PermissionMap;
+
+    static const PermissionMap permissions[] =3D {
+        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
+        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
+        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
+        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
+        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
+        { 0, 0 }
+    };
+    const PermissionMap *p;
+    XDbgBlockGraphEdge *edge;
+
+    QEMU_BUILD_BUG_ON(1UL << (ARRAY_SIZE(permissions) - 1) !=3D BLK_PERM=
_ALL + 1);
+
+    edge =3D g_new0(XDbgBlockGraphEdge, 1);
+
+    edge->parent =3D xdbg_graph_node_num(gr, parent);
+    edge->child =3D xdbg_graph_node_num(gr, child->bs);
+    edge->name =3D g_strdup(child->name);
+
+    for (p =3D permissions; p->flag; p++) {
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
+XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
+{
+    BlockBackend *blk;
+    BlockJob *job;
+    BlockDriverState *bs;
+    BdrvChild *child;
+    XDbgBlockGraphConstructor *gr =3D xdbg_graph_new();
+
+    for (blk =3D blk_all_next(NULL); blk; blk =3D blk_all_next(blk)) {
+        char *allocated_name =3D NULL;
+        const char *name =3D blk_name(blk);
+
+        if (!*name) {
+            name =3D allocated_name =3D blk_get_attached_dev_id(blk);
+        }
+        xdbg_graph_add_node(gr, blk, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_B=
ACKEND,
+                           name);
+        g_free(allocated_name);
+        if (blk_root(blk)) {
+            xdbg_graph_add_edge(gr, blk, blk_root(blk));
+        }
+    }
+
+    for (job =3D block_job_next(NULL); job; job =3D block_job_next(job))=
 {
+        GSList *el;
+
+        xdbg_graph_add_node(gr, job, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_J=
OB,
+                           job->job.id);
+        for (el =3D job->nodes; el; el =3D el->next) {
+            xdbg_graph_add_edge(gr, job, (BdrvChild *)el->data);
+        }
+    }
+
+    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
+        xdbg_graph_add_node(gr, bs, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_DR=
IVER,
+                           bs->node_name);
+        QLIST_FOREACH(child, &bs->children, next) {
+            xdbg_graph_add_edge(gr, bs, child);
+        }
+    }
+
+    return xdbg_graph_finalize(gr);
+}
+
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp)
diff --git a/block/block-backend.c b/block/block-backend.c
index 60d37a0c3d..cf05abd89d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2249,3 +2249,8 @@ int coroutine_fn blk_co_copy_range(BlockBackend *bl=
k_in, int64_t off_in,
                               blk_out->root, off_out,
                               bytes, read_flags, write_flags);
 }
+
+const BdrvChild *blk_root(BlockBackend *blk)
+{
+    return blk->root;
+}
diff --git a/blockdev.c b/blockdev.c
index a8fa8748a9..fb18e9c975 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3582,6 +3582,11 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(E=
rror **errp)
     return bdrv_named_nodes_list(errp);
 }
=20
+XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
+{
+    return bdrv_get_xdbg_block_graph(errp);
+}
+
 BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                              Error **errp)
 {
--=20
2.20.1
