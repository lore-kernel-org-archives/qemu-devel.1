Received: from eggs.gnu.org ([2001:4830:134:3::10]:41822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBi-0008VC-Fw
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBf-0001XA-94
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:46 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 31 Oct 2018 18:16:37 +0200
Message-Id: <288b08d95c39ce463c47cf77bb434abe51996163.1541002357.git.berto@igalia.com>
In-Reply-To: <cover.1541002357.git.berto@igalia.com>
References: <cover.1541002357.git.berto@igalia.com>
In-Reply-To: <cover.1541002357.git.berto@igalia.com>
References: <cover.1541002357.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] block: Update
 BlockDriverState.inherits_from on bdrv_set_backing_hd()
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

When a BlockDriverState's child is opened (be it a backing file, the
protocol layer, or any other) inherits_from is set to point to the
parent node. Children opened separately and then attached to a parent
don't have this pointer set.

bdrv_reopen_queue_child() uses this to determine whether a node's
children must also be reopened inheriting the options from the parent
or not. If inherits_from points to the parent then the child is
reopened and its options can be changed, like in this example:

   $ qemu-img create -f qcow2 hd0.qcow2 1M
   $ qemu-img create -f qcow2 hd1.qcow2 1M
   $ $QEMU -drive if=none,node-name=hd0,file=hd0.qcow2,\
                  backing.driver=qcow2,backing.file.filename=hd1.qcow2
   (qemu) qemu-io hd0 "reopen -o backing.l2-cache-size=2M"

If the child does not inherit from the parent then it does not get
reopened and its options cannot be changed:

   $ $QEMU -drive if=none,node-name=hd1,file=hd1.qcow2
           -drive if=none,node-name=hd0,file=hd0.qcow2,backing=hd1
   (qemu) qemu-io hd0 "reopen -o backing.l2-cache-size=2M"
   Cannot change the option 'backing.l2-cache-size'

If a disk image has a chain of backing files then all of them are also
connected through their inherits_from pointers (i.e. it's possible to
walk the chain in reverse order from base to top).

However this is broken if the intermediate nodes are removed using
e.g. block-stream because the inherits_from pointer from the base node
becomes NULL:

   $ qemu-img create -f qcow2 hd0.qcow2 1M
   $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
   $ qemu-img create -f qcow2 -b hd1.qcow2 hd2.qcow2
   $ $QEMU -drive if=none,file=hd2.qcow2
   (qemu) qemu-io none0 "reopen -o backing.l2-cache-size=2M"
   (qemu) block_stream none0 0 hd0.qcow2
   (qemu) qemu-io none0 "reopen -o backing.l2-cache-size=2M"
   Cannot change the option 'backing.l2-cache-size'

This patch updates the inherits_from pointer if the intermediate nodes
of a backing chain are removed using bdrv_set_backing_hd(), and adds a
test case for this scenario.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                    |  21 +++++++++
 tests/qemu-iotests/161     | 104 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/161.out |  23 ++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 149 insertions(+)
 create mode 100755 tests/qemu-iotests/161
 create mode 100644 tests/qemu-iotests/161.out

diff --git a/block.c b/block.c
index 08d64cdc61..b565ba805f 100644
--- a/block.c
+++ b/block.c
@@ -2228,6 +2228,18 @@ static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
     }
 }
 
+/* Return true if you can reach parent going through child->inherits_from
+ * recursively. If parent or child are NULL, return false */
+static bool bdrv_inherits_from_recursive(BlockDriverState *child,
+                                         BlockDriverState *parent)
+{
+    while (child && child != parent) {
+        child = child->inherits_from;
+    }
+
+    return child != NULL;
+}
+
 /*
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
@@ -2235,6 +2247,9 @@ static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp)
 {
+    bool update_inherits_from = bdrv_chain_contains(bs, backing_hd) &&
+        bdrv_inherits_from_recursive(backing_hd, bs);
+
     if (backing_hd) {
         bdrv_ref(backing_hd);
     }
@@ -2250,6 +2265,12 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
                                     errp);
+    /* If backing_hd was already part of bs's backing chain, and
+     * inherits_from pointed recursively to bs then let's update it to
+     * point directly to bs (else it will become NULL). */
+    if (update_inherits_from) {
+        backing_hd->inherits_from = bs;
+    }
     if (!bs->backing) {
         bdrv_unref(backing_hd);
     }
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
new file mode 100755
index 0000000000..8d0c6afb47
--- /dev/null
+++ b/tests/qemu-iotests/161
@@ -0,0 +1,104 @@
+#!/bin/bash
+#
+# Test reopening a backing image after block-stream
+#
+# Copyright (C) 2018 Igalia, S.L.
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
+owner=berto@igalia.com
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
+    rm -f "$TEST_IMG.base"
+    rm -f "$TEST_IMG.int"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+# Any format implementing BlockDriver.bdrv_change_backing_file
+_supported_fmt qcow2 qed
+_supported_proto file
+_supported_os Linux
+
+IMG_SIZE=1M
+
+# Create the images
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+
+# First test: reopen $TEST.IMG changing the detect-zeroes option on
+# its backing file ($TEST_IMG.int).
+echo
+echo "*** Change an option on the backing file"
+echo
+_launch_qemu -drive if=none,file="${TEST_IMG}"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line':
+                      'qemu-io none0 \"reopen -o backing.detect-zeroes=on\"' } }" \
+    "return"
+
+_cleanup_qemu
+
+# Second test: stream $TEST_IMG.base into $TEST_IMG.int and then
+# reopen $TEST.IMG changing the detect-zeroes option on its new
+# backing file ($TEST_IMG.base).
+echo
+echo "*** Stream and then change an option on the backing file"
+echo
+_launch_qemu -drive if=none,file="${TEST_IMG}"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-stream', \
+       'arguments': { 'device': 'none0',
+                      'base': '${TEST_IMG}.base' } }" \
+    'return'
+
+# Wait for block-stream to finish
+sleep 0.5
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line':
+                      'qemu-io none0 \"reopen -o backing.detect-zeroes=on\"' } }" \
+    "return"
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
new file mode 100644
index 0000000000..a3474717a2
--- /dev/null
+++ b/tests/qemu-iotests/161.out
@@ -0,0 +1,23 @@
+QA output created by 161
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+
+*** Change an option on the backing file
+
+{"return": {}}
+{"return": ""}
+
+*** Stream and then change an option on the backing file
+
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "stream"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
+{"return": ""}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 31f6e77dcb..aecbd46087 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -167,6 +167,7 @@
 158 rw auto quick
 159 rw auto quick
 160 rw auto quick
+161 rw auto quick
 162 auto quick
 163 rw auto
 165 rw auto quick
-- 
2.11.0
