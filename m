Received: from eggs.gnu.org ([2001:4830:134:3::10]:38645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhWYU-0002py-O9
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhWYQ-0006RM-PZ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:46:26 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 10:45:13 +0300
Message-Id: <20170815074513.9055-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

block-insert-node and its pair command block-remove-node provide runtime
insertion and removal of filter nodes.

block-insert-node takes a (parent, child) and (node, child) pair of
edges and unrefs the (parent, child) BdrvChild relationship and creates
a new (parent, node) child with the same BdrvChildRole.

This is a different approach than x-blockdev-change which uses the driver
methods bdrv_add_child() and bdrv_del_child(),

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                    |  192 ++++++++
 blockdev.c                 |   44 ++
 include/block/block.h      |    6 +
 qapi/block-core.json       |   60 +++
 tests/qemu-iotests/193     |  241 ++++++++++
 tests/qemu-iotests/193.out | 1116 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |    1 +
 7 files changed, 1660 insertions(+)
 create mode 100755 tests/qemu-iotests/193
 create mode 100644 tests/qemu-iotests/193.out

diff --git a/block.c b/block.c
index 81bd51b670..f874aabbfb 100644
--- a/block.c
+++ b/block.c
@@ -930,6 +930,9 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_STREAM,
                     parent->backing_blocker);
+    /* Unblock filter node insertion */
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_EDGE_MODIFICATION,
+                    parent->backing_blocker);
     /*
      * We do backup in 3 ways:
      * 1. drive backup
@@ -5036,3 +5039,192 @@ BlockDriverState *bdrv_get_first_explicit(BlockDriverState *bs)
     }
     return bs;
 }
+
+
+static inline BdrvChild *bdrv_find_child(BlockDriverState *parent_bs,
+                                  const char *child_name)
+{
+    BdrvChild *child;
+    assert(child_name);
+
+    QLIST_FOREACH(child, &parent_bs->children, next) {
+        if (child->bs && !g_strcmp0(child->bs->node_name, child_name)) {
+            return child;
+        }
+    }
+
+    return NULL;
+}
+
+static int check_node_edge(const char *parent, const char *child, Error **errp)
+{
+    BlockDriverState *parent_bs, *child_bs;
+    parent_bs = bdrv_find_node(parent);
+    if (!parent_bs) {
+        error_setg(errp, "'%s' not a node name", parent);
+        return 1;
+    }
+    child_bs = bdrv_find_node(child);
+    if (!child_bs) {
+        error_setg(errp, "'%s' not a node name", child);
+        return 1;
+    }
+    if (!bdrv_find_child(parent_bs, child)) {
+        error_setg(errp, "'%s' not a child of '%s'", child, parent);
+        return 1;
+    }
+    if (bdrv_op_is_blocked(parent_bs, BLOCK_OP_TYPE_EDGE_MODIFICATION, errp) ||
+        bdrv_op_is_blocked(child_bs, BLOCK_OP_TYPE_EDGE_MODIFICATION, errp)) {
+        return 1;
+    }
+    return 0;
+}
+
+void bdrv_insert_node(const char *parent, const char *child,
+                      const char *node, Error **errp)
+{
+    BlockBackend *blk;
+    BlockDriverState *parent_bs, *node_bs, *child_bs;
+    BdrvChild *c;
+    const BdrvChildRole *role;
+
+    if (check_node_edge(node, child, errp)) {
+        return;
+    }
+    node_bs = bdrv_find_node(node);
+    child_bs = bdrv_find_node(child);
+    blk = blk_by_name(parent);
+    if (blk) {
+        /* insert 'node' as root bs of 'parent' device */
+        if (!blk_bs(blk)) {
+            error_setg(errp, "Device '%s' has no medium", parent);
+            return;
+        }
+        if (blk_bs(blk) != child_bs) {
+            error_setg(errp, "'%s' not a child of device '%s'", child, parent);
+            return;
+        }
+        bdrv_drained_begin(child_bs);
+        blk_remove_bs(blk);
+        blk_insert_bs(blk, node_bs, errp);
+        if (!blk_bs(blk)) {
+            blk_insert_bs(blk, child_bs, &error_abort);
+        }
+        bdrv_drained_end(child_bs);
+        return;
+    }
+
+    /* insert 'node' as child bs of 'parent' node */
+    if (check_node_edge(parent, child, errp)) {
+        return;
+    }
+    parent_bs = bdrv_find_node(parent);
+    c = bdrv_find_child(parent_bs, child);
+    role = c->role;
+    assert(role == &child_file || role == &child_backing);
+
+    bdrv_ref(node_bs);
+
+    bdrv_drained_begin(parent_bs);
+    bdrv_unref_child(parent_bs, c);
+    if (role == &child_file) {
+        parent_bs->file = bdrv_attach_child(parent_bs, node_bs, "file",
+                                            &child_file, errp);
+        if (!parent_bs->file) {
+            parent_bs->file = bdrv_attach_child(parent_bs, child_bs, "file",
+                                                &child_file, &error_abort);
+            goto out;
+        }
+    } else if (role == &child_backing) {
+        parent_bs->backing = bdrv_attach_child(parent_bs, node_bs, "backing",
+                                               &child_backing, errp);
+        if (!parent_bs->backing) {
+            parent_bs->backing = bdrv_attach_child(parent_bs, child_bs,
+                                                   "backing", &child_backing,
+                                                   &error_abort);
+            goto out;
+        }
+    }
+    bdrv_refresh_filename(parent_bs);
+    bdrv_refresh_limits(parent_bs, NULL);
+
+out:
+    bdrv_drained_end(parent_bs);
+}
+
+void bdrv_remove_node(const char *parent, const char *child,
+                      const char *node, Error **errp)
+{
+    BlockBackend *blk;
+    BlockDriverState *node_bs, *parent_bs, *child_bs;
+    BdrvChild *c;
+    const BdrvChildRole *role;
+
+    if (check_node_edge(node, child, errp)) {
+        return;
+    }
+    node_bs = bdrv_find_node(node);
+    child_bs = bdrv_find_node(child);
+    blk = blk_by_name(parent);
+    if (blk) {
+        /* remove 'node' as root bs of 'parent' device */
+        if (!blk_bs(blk)) {
+            error_setg(errp, "Device '%s' has no medium", parent);
+            return;
+        }
+        if (blk_bs(blk) != node_bs) {
+            error_setg(errp, "'%s' not a child of device '%s'", node, parent);
+            return;
+        }
+        bdrv_drained_begin(node_bs);
+        blk_remove_bs(blk);
+        blk_insert_bs(blk, child_bs, errp);
+        if (!blk_bs(blk)) {
+            blk_insert_bs(blk, node_bs, &error_abort);
+        }
+        bdrv_drained_end(node_bs);
+        return;
+    }
+
+    if (check_node_edge(parent, node, errp)) {
+        return;
+    }
+    parent_bs = bdrv_find_node(parent);
+    c = bdrv_find_child(node_bs, child);
+    role = c->role;
+    assert(role == &child_file || role == &child_backing);
+
+
+    bdrv_ref(child_bs);
+    bdrv_ref(node_bs);
+
+    bdrv_drained_begin(parent_bs);
+    bdrv_unref_child(parent_bs, bdrv_find_child(parent_bs, node));
+    if (role == &child_file) {
+        parent_bs->file = bdrv_attach_child(parent_bs, child_bs, "file",
+                &child_file, errp);
+        if (!parent_bs->file) {
+            parent_bs->file = bdrv_attach_child(parent_bs, node_bs, "file",
+                                                &child_file, &error_abort);
+            node_bs->file = bdrv_attach_child(node_bs, child_bs, "file",
+                                              &child_file, &error_abort);
+            goto out;
+        }
+    } else if (role == &child_backing) {
+        parent_bs->backing = bdrv_attach_child(parent_bs, child_bs, "backing",
+                                               &child_backing, errp);
+        if (!parent_bs->backing) {
+            parent_bs->backing = bdrv_attach_child(parent_bs, node_bs,
+                                                   "backing", &child_backing,
+                                                   &error_abort);
+            node_bs->backing = bdrv_attach_child(node_bs, child_bs, "backing",
+                                                 &child_backing, &error_abort);
+            goto out;
+        }
+    }
+    bdrv_refresh_filename(parent_bs);
+    bdrv_refresh_limits(parent_bs, NULL);
+    bdrv_unref(node_bs);
+out:
+    bdrv_drained_end(parent_bs);
+}
diff --git a/blockdev.c b/blockdev.c
index 8e2fc6e64c..5195ec1b61 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4238,3 +4238,47 @@ QemuOptsList qemu_drive_opts = {
         { /* end of list */ }
     },
 };
+
+void qmp_block_insert_node(const char *parent, const char *child,
+                           const char *node, Error **errp)
+{
+    BlockDriverState *bs = bdrv_find_node(node);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node);
+        return;
+    }
+    if (!bs->monitor_list.tqe_prev) {
+        error_setg(errp, "Node '%s' is not owned by the monitor",
+                   bs->node_name);
+        return;
+    }
+    if (!bs->drv->is_filter) {
+        error_setg(errp, "Block format '%s' used by node '%s' does not support"
+                   "insertion", bs->drv->format_name, bs->node_name);
+        return;
+    }
+
+    bdrv_insert_node(parent, child, node, errp);
+}
+
+void qmp_block_remove_node(const char *parent, const char *child,
+                           const char *node, Error **errp)
+{
+    BlockDriverState *bs = bdrv_find_node(node);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node);
+        return;
+    }
+    if (!bs->monitor_list.tqe_prev) {
+        error_setg(errp, "Node %s is not owned by the monitor",
+                   bs->node_name);
+        return;
+    }
+    if (!bs->drv->is_filter) {
+        error_setg(errp, "Block format '%s' used by node '%s' does not support"
+                   "removal", bs->drv->format_name, bs->node_name);
+        return;
+    }
+
+    bdrv_remove_node(parent, child, node, errp);
+}
diff --git a/include/block/block.h b/include/block/block.h
index 744b50e734..9e1120af1b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -191,6 +191,8 @@ typedef enum BlockOpType {
     BLOCK_OP_TYPE_RESIZE,
     BLOCK_OP_TYPE_STREAM,
     BLOCK_OP_TYPE_REPLACE,
+    BLOCK_OP_TYPE_EDGE_MODIFICATION, /* block user modification of graph edges
+                                        including this node */
     BLOCK_OP_TYPE_MAX,
 } BlockOpType;
 
@@ -627,4 +629,8 @@ void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                      uint32_t granularity, Error **errp);
 
+void bdrv_insert_node(const char *parent, const char *child,
+                      const char *node, Error **errp);
+void bdrv_remove_node(const char *parent, const char *child,
+                      const char *node, Error **errp);
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4d6ba1baef..16e19cb648 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3947,3 +3947,63 @@
   'data' : { 'parent': 'str',
              '*child': 'str',
              '*node': 'str' } }
+
+##
+# @block-insert-node:
+#
+# Insert a filter node between a specific edge in the block driver state graph.
+# @parent:  the name of the parent node or device
+# @node:    the name of the node to insert under parent
+# @child:   the name of the child of both node and parent
+#
+# Example:
+# Insert and remove a throttle filter on top of a device chain, between the
+# device 'ide0-hd0' and node 'node-A'
+#
+# -> {'execute': 'object-add',
+#     "arguments": {
+#       "qom-type": "throttle-group",
+#       "id": "group0",
+#       "props" : { "limits": { "iops-total": 300 } }
+#     }
+#    }
+# <- { 'return': {} }
+# -> {'execute': 'blockdev-add',
+#       'arguments': {
+#           'driver': 'throttle',
+#           'node-name': 'throttle0',
+#           'throttle-group': 'group0',
+#           'file': 'node-A'
+#       }
+#    }
+# <- { 'return': {} }
+# -> { 'execute': 'block-insert-node',
+#       'arguments': { 'parent': 'ide0-hd0', 'child': 'node-A', 'node': 'throttle0' }
+#    }
+# <- { 'return': {} }
+# -> { 'execute': 'block-remove-node',
+#       'arguments': { 'parent': 'ide0-hd0', 'child': 'node-A', 'node': 'throttle0' }
+#    }
+# <- { 'return': {} }
+# -> { 'execute': 'blockdev-del',
+#       'arguments': { 'node-name': 'throttle0' }
+#    }
+# <- { 'return': {} }
+#
+##
+{ 'command': 'block-insert-node',
+  'data': { 'parent': 'str',
+             'child': 'str',
+             'node': 'str'} }
+##
+# @block-remove-node:
+#
+# Remove a filter node between two other nodes in the block driver state graph.
+# @parent:  the name of the parent node or device
+# @node:    the name of the node to remove from parent
+# @child:   the name of the child of node which will go under parent
+##
+{ 'command': 'block-remove-node',
+  'data': { 'parent': 'str',
+             'child': 'str',
+             'node': 'str'} }
diff --git a/tests/qemu-iotests/193 b/tests/qemu-iotests/193
new file mode 100755
index 0000000000..2936eba95e
--- /dev/null
+++ b/tests/qemu-iotests/193
@@ -0,0 +1,241 @@
+#!/bin/bash
+#
+# Test block-insert-node & block-remove-node commands
+#
+# Copyright (C) 2017 Manos Pitsidianakis
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner="Manos Pitsidianakis"
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -rf "$TEST_IMG".s
+    rm -rf "$TEST_IMG".e
+
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+function do_run_qemu()
+{
+    echo Testing: "$@" | _filter_imgfmt
+    $QEMU -nographic -qmp-pretty stdio -serial none "$@"
+    echo
+}
+
+function run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp\
+                          | _filter_qemu_io | _filter_generated_node_ids
+}
+
+_make_test_img 64M
+test_throttle=$($QEMU_IMG --help|grep throttle)
+[ "$test_throttle" = "" ] && _supported_fmt throttle
+
+echo
+echo "== inserting node =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+
+{ "execute": "blockdev-add",
+  "arguments": {
+    "node-name": "disk",
+    "driver": "$IMGFMT",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{ "execute": "device_add",
+   "arguments": { "driver": "virtio-blk", "drive": "disk",
+                  "id": "virtio0" } }
+{
+    "execute": "blockdev-snapshot-sync",
+    "arguments": {
+        "node-name": "disk",
+        "snapshot-file": "$TEST_IMG.s",
+        "format": "$IMGFMT",
+        "snapshot-node-name": "node-B"
+    }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "node-name": "throttle0",
+    "driver": "throttle",
+    "file": "disk"  }
+}
+
+{ "execute": "block-insert-node",
+    "arguments": {
+    "parent": "node-B",
+    "child": "disk",
+    "node": "throttle0" }
+}
+{ "execute": "query-block" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== inserting and removing node =="
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+
+{ "execute": "blockdev-add",
+  "arguments": {
+    "node-name": "disk",
+    "driver": "$IMGFMT",
+    "file": {
+      "driver": "file",
+      "filename": "$TEST_IMG"
+    }
+  }
+}
+{"execute": "blockdev-add",
+"arguments": {
+"node-name": "throttle0", "driver": "throttle", "file": "disk", "throttle-group": "foo", "limits" : { "iops-total": 100 } } }
+{ "execute": "device_add",
+   "arguments": { "driver": "virtio-blk", "drive": "throttle0",
+                  "id": "virtio0" } }
+{"execute": "blockdev-add",
+"arguments": {
+"node-name": "throttle1", "driver": "throttle", "file": "disk", "throttle-group": "bar", "limits" : { "iops-total": 200 } } }
+{"execute": "block-insert-node",
+	"arguments": {
+	"parent": "throttle0",
+	"child": "disk",
+	"node": "throttle1"}
+}
+{ "execute": "query-block" }
+{ "execute": "query-named-block-nodes" }
+{"execute": "block-remove-node",
+	"arguments": {
+	"parent": "throttle0",
+	"child": "disk",
+	"node": "throttle1"}
+}
+{"execute": "blockdev-del",
+    "arguments": { "node-name": "throttle1" }
+}
+{ "execute": "query-block" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== inserting node below BB =="
+
+run_qemu -drive file=$TEST_IMG,format=$IMGFMT,if=none,id=disk,node-name=disk0 <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "blockdev-add",
+  "arguments": {
+    "node-name": "throttle0",
+    "driver": "throttle",
+    "file": "disk0"  }
+}
+{ "execute": "block-insert-node",
+    "arguments": {
+    "parent": "disk",
+    "child": "disk0",
+    "node": "throttle0" }
+}
+{ "execute": "query-block" }
+{ "execute": "query-named-block-nodes" }
+{"execute": "block-remove-node",
+	"arguments": {
+	"parent": "disk",
+	"child": "disk0",
+	"node": "throttle0"}
+}
+{"execute": "blockdev-del",
+    "arguments": { "node-name": "throttle0" }
+}
+{ "execute": "query-block" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "quit" }
+EOF
+
+echo
+echo "== try insert with active block job =="
+
+# this should error because of the hidden mirror filter on top
+run_qemu -drive file=$TEST_IMG,format=$IMGFMT,if=none,id=disk,node-name=disk0 <<EOF
+{ "execute": "qmp_capabilities" }
+{
+    "execute": "blockdev-snapshot-sync",
+    "arguments": {
+        "node-name": "disk0",
+        "snapshot-file": "$TEST_IMG.s",
+        "format": "$IMGFMT",
+        "snapshot-node-name": "overlay0"
+    }
+}
+{
+    "execute": "drive-mirror",
+    "arguments": {
+        "device": "overlay0",
+        "job-id": "job0",
+        "target": "$TEST_IMG.e",
+        "sync": "full"
+    }
+}
+{
+    "execute": "query-block-jobs",
+    "arguments": {}
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+    "node-name": "throttle0",
+    "driver": "throttle",
+    "file": "overlay0"  }
+}
+{ "execute": "block-insert-node",
+    "arguments": {
+    "parent": "disk",
+    "child": "overlay0",
+    "node": "throttle0" }
+}
+{ "execute": "query-block" }
+{"execute": "blockdev-del",
+    "arguments": { "node-name": "throttle0" }
+}
+{ "execute": "quit" }
+EOF
+
+echo
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/193.out b/tests/qemu-iotests/193.out
new file mode 100644
index 0000000000..01a63c7ccb
--- /dev/null
+++ b/tests/qemu-iotests/193.out
@@ -0,0 +1,1116 @@
+QA output created by 192
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+== inserting node ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+Formatting 'TEST_DIR/t.qcow2.s', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "locked": false,
+            "removable": false,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "backing-image": {
+                        "virtual-size": 67108864,
+                        "filename": "TEST_DIR/t.qcow2",
+                        "format": "throttle",
+                        "actual-size": 200704
+                    },
+                    "backing-filename-format": "throttle",
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.s",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 200704,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "full-backing-filename": "TEST_DIR/t.qcow2",
+                    "backing-filename": "TEST_DIR/t.qcow2",
+                    "dirty-flag": false
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "node-B",
+                "backing_file_depth": 1,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "backing_file": "TEST_DIR/t.qcow2",
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2.s",
+                "encryption_key_missing": false
+            },
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "throttle",
+                "actual-size": 200704
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle0",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "backing-image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "format": "throttle",
+                    "actual-size": 200704
+                },
+                "backing-filename-format": "throttle",
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2.s",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "full-backing-filename": "TEST_DIR/t.qcow2",
+                "backing-filename": "TEST_DIR/t.qcow2",
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "node-B",
+            "backing_file_depth": 1,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "backing_file": "TEST_DIR/t.qcow2",
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.s",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2.s",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2.s",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "disk",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": true,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== inserting and removing node ==
+Testing:
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "locked": false,
+            "removable": false,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 67108864,
+                    "filename": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}}",
+                    "format": "throttle",
+                    "actual-size": 200704
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "throttle0",
+                "backing_file_depth": 0,
+                "drv": "throttle",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}}",
+                "encryption_key_missing": false
+            },
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "json:{\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+                "format": "throttle",
+                "actual-size": 200704
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle1",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "json:{\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}}",
+                "format": "throttle",
+                "actual-size": 200704
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle0",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"throttle-group\": \"bar\", \"driver\": \"throttle\", \"limits.iops-total\": 200, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}}",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "disk",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "",
+            "locked": false,
+            "removable": false,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 67108864,
+                    "filename": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+                    "format": "throttle",
+                    "actual-size": 200704
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "throttle0",
+                "backing_file_depth": 0,
+                "drv": "throttle",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+                "encryption_key_missing": false
+            },
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+                "format": "throttle",
+                "actual-size": 200704
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle0",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "json:{\"throttle-group\": \"foo\", \"driver\": \"throttle\", \"limits.iops-total\": 100, \"file\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}}",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "disk",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== inserting node below BB ==
+Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk,node-name=disk0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "disk",
+            "locked": false,
+            "removable": true,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "format": "throttle",
+                    "actual-size": 200704
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "throttle0",
+                "backing_file_depth": 0,
+                "drv": "throttle",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2",
+                "encryption_key_missing": false
+            },
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "throttle",
+                "actual-size": 200704
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "throttle0",
+            "backing_file_depth": 0,
+            "drv": "throttle",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "disk0",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "device": "disk",
+            "locked": false,
+            "removable": true,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 200704,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "dirty-flag": false
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "disk0",
+                "backing_file_depth": 0,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2",
+                "encryption_key_missing": false
+            },
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": [
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 67108864,
+                "filename": "TEST_DIR/t.qcow2",
+                "cluster-size": 65536,
+                "format": "qcow2",
+                "actual-size": 200704,
+                "format-specific": {
+                    "type": "qcow2",
+                    "data": {
+                        "compat": "1.1",
+                        "lazy-refcounts": false,
+                        "refcount-bits": 16,
+                        "corrupt": false
+                    }
+                },
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "disk0",
+            "backing_file_depth": 0,
+            "drv": "qcow2",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        },
+        {
+            "iops_rd": 0,
+            "detect_zeroes": "off",
+            "image": {
+                "virtual-size": 197120,
+                "filename": "TEST_DIR/t.qcow2",
+                "format": "file",
+                "actual-size": 200704,
+                "dirty-flag": false
+            },
+            "iops_wr": 0,
+            "ro": false,
+            "node-name": "NODE_NAME",
+            "backing_file_depth": 0,
+            "drv": "file",
+            "iops": 0,
+            "bps_wr": 0,
+            "write_threshold": 0,
+            "encrypted": false,
+            "bps": 0,
+            "bps_rd": 0,
+            "cache": {
+                "no-flush": false,
+                "direct": false,
+                "writeback": true
+            },
+            "file": "TEST_DIR/t.qcow2",
+            "encryption_key_missing": false
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+
+
+== try insert with active block job ==
+Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk,node-name=disk0
+{
+    QMP_VERSION
+}
+{
+    "return": {
+    }
+}
+Formatting 'TEST_DIR/t.qcow2.s', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{
+    "return": {
+    }
+}
+Formatting 'TEST_DIR/t.qcow2.e', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "BLOCK_JOB_READY",
+    "data": {
+        "device": "job0",
+        "len": 0,
+        "offset": 0,
+        "speed": 0,
+        "type": "mirror"
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "return": [
+        {
+            "io-status": "ok",
+            "device": "job0",
+            "busy": false,
+            "len": 0,
+            "offset": 0,
+            "paused": false,
+            "speed": 0,
+            "ready": true,
+            "type": "mirror"
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "error": {
+        "class": "GenericError",
+        "desc": "'overlay0' not a child of device 'disk'"
+    }
+}
+{
+    "return": [
+        {
+            "device": "disk",
+            "locked": false,
+            "removable": true,
+            "inserted": {
+                "iops_rd": 0,
+                "detect_zeroes": "off",
+                "image": {
+                    "backing-image": {
+                        "virtual-size": 67108864,
+                        "filename": "TEST_DIR/t.qcow2",
+                        "cluster-size": 65536,
+                        "format": "qcow2",
+                        "actual-size": 200704,
+                        "format-specific": {
+                            "type": "qcow2",
+                            "data": {
+                                "compat": "1.1",
+                                "lazy-refcounts": false,
+                                "refcount-bits": 16,
+                                "corrupt": false
+                            }
+                        },
+                        "dirty-flag": false
+                    },
+                    "backing-filename-format": "qcow2",
+                    "virtual-size": 67108864,
+                    "filename": "TEST_DIR/t.qcow2.s",
+                    "cluster-size": 65536,
+                    "format": "qcow2",
+                    "actual-size": 200704,
+                    "format-specific": {
+                        "type": "qcow2",
+                        "data": {
+                            "compat": "1.1",
+                            "lazy-refcounts": false,
+                            "refcount-bits": 16,
+                            "corrupt": false
+                        }
+                    },
+                    "full-backing-filename": "TEST_DIR/t.qcow2",
+                    "backing-filename": "TEST_DIR/t.qcow2",
+                    "dirty-flag": false
+                },
+                "iops_wr": 0,
+                "ro": false,
+                "node-name": "overlay0",
+                "backing_file_depth": 1,
+                "drv": "qcow2",
+                "iops": 0,
+                "bps_wr": 0,
+                "write_threshold": 0,
+                "backing_file": "TEST_DIR/t.qcow2",
+                "encrypted": false,
+                "bps": 0,
+                "bps_rd": 0,
+                "cache": {
+                    "no-flush": false,
+                    "direct": false,
+                    "writeback": true
+                },
+                "file": "TEST_DIR/t.qcow2.s",
+                "encryption_key_missing": false
+            },
+            "dirty-bitmaps": [
+                {
+                    "status": "active",
+                    "granularity": 65536,
+                    "count": 0
+                }
+            ],
+            "type": "unknown"
+        }
+    ]
+}
+{
+    "return": {
+    }
+}
+{
+    "return": {
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "SHUTDOWN",
+    "data": {
+        "guest": false
+    }
+}
+{
+    "timestamp": {
+        "seconds":  TIMESTAMP,
+        "microseconds":  TIMESTAMP
+    },
+    "event": "BLOCK_JOB_COMPLETED",
+    "data": {
+        "device": "job0",
+        "len": 0,
+        "offset": 0,
+        "speed": 0,
+        "type": "mirror"
+    }
+}
+
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1b4221f26d..9ad3d3d8cb 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -188,3 +188,4 @@
 189 rw auto
 190 rw auto quick
 191 rw auto quick
+193 rw auto quick
-- 
2.11.0
