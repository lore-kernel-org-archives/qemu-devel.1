Received: from eggs.gnu.org ([2001:4830:134:3::10]:44719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx1-0007Ib-Dc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLwy-0001au-To
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:20:25 +0300
Message-Id: <1534440027-10528-3-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] qapi: add x-query-block-nodes-relations
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

Add new command, returning list of block nodes graph edges.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  1 +
 block.c               | 57 +++++++++++++++++++++++++++++++++++++++++
 blockdev.c            |  5 ++++
 4 files changed, 134 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37afdc..ad7b62c49b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1630,6 +1630,77 @@
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ] }
 
 ##
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
+{ 'enum': 'BlockPermission',
+  'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
+            'graph-mod' ] }
+
+##
+# @BlockRelationInfo:
+#
+# Information about relation between block node and its parent.
+#
+# @parent: node name or some other parent name/description, if parent is not a
+#          block node.
+#
+# @parent-is-bds: parent is block node.
+#
+# @child: node name
+#
+# @name: name of the relation (examples are 'file' and 'backing')
+#
+# @perm: Granted permissions for the parent operating on the child.
+#
+# @shared-perm: Permissions that can still be granted to other users of the
+#               child while it is still attached this parent.
+#
+# Since: 3.1
+##
+{ 'struct': 'BlockRelationInfo',
+  'data': { 'parent': 'str', 'parent-is-bds': 'bool', 'child': 'str',
+            'name': 'str', 'perm': [ 'BlockPermission' ],
+            'shared-perm': [ 'BlockPermission' ] } }
+
+##
+# @x-query-block-nodes-relations:
+#
+# Get the block relations list.
+#
+# Returns: the list of BlockRelationInfo.
+#
+# Since: 3.1
+##
+{ 'command': 'x-query-block-nodes-relations', 'returns': [ 'BlockRelationInfo' ] }
+
+##
 # @drive-mirror:
 #
 # Start mirroring a block device's writes to a new destination. target
diff --git a/include/block/block.h b/include/block/block.h
index 4e0871aaf9..04136634c2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -448,6 +448,7 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag);
 const char *bdrv_get_format_name(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp);
+BlockRelationInfoList *bdrv_block_relations_list(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
diff --git a/block.c b/block.c
index 6161dbe3eb..776fc714af 100644
--- a/block.c
+++ b/block.c
@@ -4003,6 +4003,63 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
     return list;
 }
 
+BlockRelationInfoList *bdrv_block_relations_list(Error **errp)
+{
+    BlockRelationInfoList *list = NULL, *entry;
+    BlockDriverState *bs;
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
+        BdrvChild *child;
+
+        QLIST_FOREACH(child, &bs->parents, next_parent) {
+            entry = g_new0(BlockRelationInfoList, 1);
+            BlockRelationInfo *info = g_new0(BlockRelationInfo, 1);
+
+            info->parent_is_bds = child->role->parent_is_bds;
+            info->parent = child->role->parent_is_bds ?
+                               g_strdup(bdrv_get_node_name(child->opaque)) :
+                               bdrv_child_user_desc(child);
+            info->child = g_strdup(bs->node_name);
+            assert(bs == child->bs);
+            info->name = g_strdup(child->name);
+
+            for (p = permissions; p->flag; p++) {
+                BlockPermissionList *en;
+
+                if (p->flag & child->perm) {
+                    en = g_new(BlockPermissionList, 1);
+                    en->value = p->num;
+                    en->next = info->perm;
+                    info->perm = en;
+                }
+                if (p->flag & child->shared_perm) {
+                    en = g_new(BlockPermissionList, 1);
+                    en->value = p->num;
+                    en->next = info->shared_perm;
+                    info->shared_perm = en;
+                }
+            }
+
+            entry->value = info;
+            entry->next = list;
+            list = entry;
+        }
+    }
+
+    return list;
+}
+
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp)
diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..74bdc2e93e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3485,6 +3485,11 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
     return bdrv_named_nodes_list(errp);
 }
 
+BlockRelationInfoList *qmp_x_query_block_nodes_relations(Error **errp)
+{
+    return bdrv_block_relations_list(errp);
+}
+
 BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                              Error **errp)
 {
-- 
2.11.1
