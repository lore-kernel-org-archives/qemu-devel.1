Received: from eggs.gnu.org ([2001:4830:134:3::10]:58442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T0-0006yT-CL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1Sv-0004jK-Sr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:25:58 +0200
Message-Id: <20180705102604.4986-7-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/12] block: Don't silently truncate node
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
