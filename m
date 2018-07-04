Received: from eggs.gnu.org ([2001:4830:134:3::10]:58797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fag1a-00036J-5i
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fag1Y-0002ll-VR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:32:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  4 Jul 2018 13:32:27 +0200
Message-Id: <20180704113227.23454-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Don't silently truncate node names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If the user passes a too long node name string, we silently truncate it
to fit into BlockDriverState.node_name, i.e. to 31 characters. Apart
from surprising the user when the node has a different name than
requested, this also bypasses the check for duplicate names, so that the
same name can be assigned to multiple nodes.

Fix this by just making too long node names an error.

Reported-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                       |  6 ++++++
 tests/qemu-iotests/051        | 15 +++++++++++++++
 tests/qemu-iotests/051.out    | 23 +++++++++++++++++++++++
 tests/qemu-iotests/051.pc.out | 23 +++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/block.c b/block.c
index 961ec97d26..ac8b3a3511 100644
--- a/block.c
+++ b/block.c
@@ -1156,6 +1156,12 @@ static void bdrv_assign_node_name(BlockDriverState *bs,
         goto out;
     }
 
+    /* Make sure that the node name isn't truncated */
+    if (strlen(node_name) >= sizeof(bs->node_name)) {
+        error_setg(errp, "Node name too long");
+        goto out;
+    }
+
     /* copy node name into the bs and insert it into the graph list */
     pstrcpy(bs->node_name, sizeof(bs->node_name), node_name);
     QTAILQ_INSERT_TAIL(&graph_bdrv_states, bs, node_list);
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index f617e25e24..ee9c820d0f 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -100,6 +100,21 @@ run_qemu -drive file="$TEST_IMG",driver=raw,format=qcow2
 run_qemu -drive file="$TEST_IMG",driver=qcow2,format=qcow2
 
 echo
+echo === Node names ===
+echo
+
+# Maximum length: 31 characters
+run_qemu -drive file="$TEST_IMG",node-name=x123456789012345678901234567890
+run_qemu -drive file="$TEST_IMG",node-name=x1234567890123456789012345678901
+
+# First character must be alphabetic
+# Following characters alphanumeric or -._
+run_qemu -drive file="$TEST_IMG",node-name=All-Types.of_all0wed_chars
+run_qemu -drive file="$TEST_IMG",node-name=123foo
+run_qemu -drive file="$TEST_IMG",node-name=_foo
+run_qemu -drive file="$TEST_IMG",node-name=foo#12
+
+echo
 echo === Device without drive ===
 echo
 
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index dd9846d1ce..b7273505c7 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -47,6 +47,29 @@ Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specify both 'driver' and 'format'
 
 
+=== Node names ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=x123456789012345678901234567890
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901: Node name too long
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=All-Types.of_all0wed_chars
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=123foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=123foo: Invalid node name
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=_foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=_foo: Invalid node name
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=foo#12
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node name
+
+
 === Device without drive ===
 
 Testing: -device VIRTIO_SCSI -device scsi-hd
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index b01f9a90d7..e9257fe318 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -47,6 +47,29 @@ Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specify both 'driver' and 'format'
 
 
+=== Node names ===
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=x123456789012345678901234567890
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901: Node name too long
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=All-Types.of_all0wed_chars
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) quit
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=123foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=123foo: Invalid node name
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=_foo
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=_foo: Invalid node name
+
+Testing: -drive file=TEST_DIR/t.qcow2,node-name=foo#12
+QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node name
+
+
 === Device without drive ===
 
 Testing: -device VIRTIO_SCSI -device scsi-hd
-- 
2.13.6
