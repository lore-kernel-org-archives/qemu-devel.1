Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBi-0008VB-El
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gHtBf-0001Wy-52
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:17:46 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 31 Oct 2018 18:16:38 +0200
Message-Id: <20c30d82e69d80e17c3f5cb1b3578ca53d1c611e.1541002357.git.berto@igalia.com>
In-Reply-To: <cover.1541002357.git.berto@igalia.com>
References: <cover.1541002357.git.berto@igalia.com>
In-Reply-To: <cover.1541002357.git.berto@igalia.com>
References: <cover.1541002357.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/2] block: Update
 BlockDriverState.inherits_from on bdrv_drop_intermediate()
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

The previous patch fixed the inherits_from pointer after block-stream,
and this one does the same for block-commit.

When block-commit finishes and the 'top' node is not the topmost one
from the backing chain then all nodes above 'base' up to and including
'top' are removed from the chain.

The bdrv_drop_intermediate() call converts a chain like this one:

    base <- intermediate <- top <- active

into this one:

    base <- active

In a simple scenario each backing file from the first chain has the
inherits_from attribute pointing to its parent. This means that
reopening 'active' will recursively reopen all its children, whose
options can be changed in the process.

However after the 'block-commit' call base.inherits_from is NULL and
the chain is broken, so 'base' does not inherit from 'active' and will
not be reopened automatically:

   $ qemu-img create -f qcow2 hd0.qcow2 1M
   $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
   $ qemu-img create -f qcow2 -b hd1.qcow2 hd2.qcow2
   $ $QEMU -drive if=none,file=hd2.qcow2

   { 'execute': 'block-commit',
     'arguments': {
       'device': 'none0',
       'top': 'hd1.qcow2' } }

   { 'execute': 'human-monitor-command',
     'arguments': {
        'command-line':
          'qemu-io none0 "reopen -o backing.l2-cache-size=2M"' } }

   { "return": "Cannot change the option 'backing.l2-cache-size'\r\n"}

This patch updates base.inherits_from in this scenario, and adds a
test case.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                    | 16 ++++++++++++++++
 tests/qemu-iotests/161     | 35 ++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/161.out | 16 ++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index b565ba805f..f2db213f4c 100644
--- a/block.c
+++ b/block.c
@@ -3809,6 +3809,8 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str)
 {
+    BlockDriverState *explicit_top = top;
+    bool update_inherits_from;
     BdrvChild *c, *next;
     Error *local_err = NULL;
     int ret = -EIO;
@@ -3824,6 +3826,16 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         goto exit;
     }
 
+    /* If 'base' recursively inherits from 'top' then we should set
+     * base->inherits_from to top->inherits_from after 'top' and all
+     * other intermediate nodes have been dropped.
+     * If 'top' is an implicit node (e.g. "commit_top") we should skip
+     * it because no one inherits from it. We use explicit_top for that. */
+    while (explicit_top && explicit_top->implicit) {
+        explicit_top = backing_bs(explicit_top);
+    }
+    update_inherits_from = bdrv_inherits_from_recursive(base, explicit_top);
+
     /* success - we can delete the intermediate states, and link top->base */
     /* TODO Check graph modification op blockers (BLK_PERM_GRAPH_MOD) once
      * we've figured out how they should work. */
@@ -3859,6 +3871,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         bdrv_unref(top);
     }
 
+    if (update_inherits_from) {
+        base->inherits_from = explicit_top->inherits_from;
+    }
+
     ret = 0;
 exit:
     bdrv_unref(top);
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 8d0c6afb47..180df17ad6 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -1,6 +1,6 @@
 #!/bin/bash
 #
-# Test reopening a backing image after block-stream
+# Test reopening a backing image after block-stream and block-commit
 #
 # Copyright (C) 2018 Igalia, S.L.
 #
@@ -98,6 +98,39 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 _cleanup_qemu
 
+# Third test: commit $TEST_IMG.int into $TEST_IMG.base and then reopen
+# $TEST.IMG changing the detect-zeroes option on its new backing file
+# ($TEST_IMG.base).
+echo
+echo "*** Commit and then change an option on the backing file"
+echo
+# Create the images again
+TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
+TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+
+_launch_qemu -drive if=none,file="${TEST_IMG}"
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit', \
+       'arguments': { 'device': 'none0',
+                      'top': '${TEST_IMG}.int' } }" \
+    'return'
+
+# Wait for block-commit to finish
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
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index a3474717a2..39951993ee 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -20,4 +20,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
 {"return": ""}
+
+*** Commit and then change an option on the backing file
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
+{"return": ""}
 *** done
-- 
2.11.0
