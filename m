Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLZ-0000LR-O0
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLX-0007Rq-Tv
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:01 +0200
Message-Id: <1498234919-27316-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/61] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

When qemu is exited, all running jobs should be cancelled successfully.
This adds a test for this for all types of block jobs that currently
exist in qemu.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/185     | 206 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/185.out |  59 +++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 266 insertions(+)
 create mode 100755 tests/qemu-iotests/185
 create mode 100644 tests/qemu-iotests/185.out

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
new file mode 100755
index 0000000..0eda371
--- /dev/null
+++ b/tests/qemu-iotests/185
@@ -0,0 +1,206 @@
+#!/bin/bash
+#
+# Test exiting qemu while jobs are still running
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1 # failure is the default!
+
+MIG_SOCKET="${TEST_DIR}/migrate"
+
+_cleanup()
+{
+    rm -f "${TEST_IMG}.mid"
+    rm -f "${TEST_IMG}.copy"
+    _cleanup_test_img
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+size=64M
+TEST_IMG="${TEST_IMG}.base" _make_test_img $size
+
+echo
+echo === Starting VM ===
+echo
+
+qemu_comm_method="qmp"
+
+_launch_qemu \
+    -drive file="${TEST_IMG}.base",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+echo
+echo === Creating backing chain ===
+echo
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'blockdev-snapshot-sync',
+       'arguments': { 'device': 'disk',
+                      'snapshot-file': '$TEST_IMG.mid',
+                      'format': '$IMGFMT',
+                      'mode': 'absolute-paths' } }" \
+    "return"
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': { 'command-line':
+                      'qemu-io disk \"write 0 4M\"' } }" \
+    "return"
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'blockdev-snapshot-sync',
+       'arguments': { 'device': 'disk',
+                      'snapshot-file': '$TEST_IMG',
+                      'format': '$IMGFMT',
+                      'mode': 'absolute-paths' } }" \
+    "return"
+
+echo
+echo === Start commit job and exit qemu ===
+echo
+
+# Note that the reference output intentionally includes the 'offset' field in
+# BLOCK_JOB_CANCELLED events for all of the following block jobs. They are
+# predictable and any change in the offsets would hint at a bug in the job
+# throttling code.
+#
+# In order to achieve these predictable offsets, all of the following tests
+# use speed=65536. Each job will perform exactly one iteration before it has
+# to sleep at least for a second, which is plenty of time for the 'quit' QMP
+# command to be received (after receiving the command, the rest runs
+# synchronously, so jobs can arbitrarily continue or complete).
+#
+# The buffer size for commit and streaming is 512k (waiting for 8 seconds after
+# the first request), for active commit and mirror it's large enough to cover
+# the full 4M, and for backup it's the qcow2 cluster size, which we know is
+# 64k. As all of these are at least as large as the speed, we are sure that the
+# offset doesn't advance after the first iteration before qemu exits.
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'device': 'disk',
+                      'base':'$TEST_IMG.base',
+                      'top': '$TEST_IMG.mid',
+                      'speed': 65536 } }" \
+    "return"
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
+wait=1 _cleanup_qemu
+
+echo
+echo === Start active commit job and exit qemu ===
+echo
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-commit',
+       'arguments': { 'device': 'disk',
+                      'base':'$TEST_IMG.base',
+                      'speed': 65536 } }" \
+    "return"
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
+wait=1 _cleanup_qemu
+
+echo
+echo === Start mirror job and exit qemu ===
+echo
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'drive-mirror',
+       'arguments': { 'device': 'disk',
+                      'target': '$TEST_IMG.copy',
+                      'format': '$IMGFMT',
+                      'sync': 'full',
+                      'speed': 65536 } }" \
+    "return"
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
+wait=1 _cleanup_qemu
+
+echo
+echo === Start backup job and exit qemu ===
+echo
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'drive-backup',
+       'arguments': { 'device': 'disk',
+                      'target': '$TEST_IMG.copy',
+                      'format': '$IMGFMT',
+                      'sync': 'full',
+                      'speed': 65536 } }" \
+    "return"
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
+wait=1 _cleanup_qemu
+
+echo
+echo === Start streaming job and exit qemu ===
+echo
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+h=$QEMU_HANDLE
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'block-stream',
+       'arguments': { 'device': 'disk',
+                      'speed': 65536 } }" \
+    "return"
+
+_send_qemu_cmd $h "{ 'execute': 'quit' }" "return"
+wait=1 _cleanup_qemu
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
new file mode 100644
index 0000000..45bc7cb
--- /dev/null
+++ b/tests/qemu-iotests/185.out
@@ -0,0 +1,59 @@
+QA output created by 185
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+
+=== Starting VM ===
+
+{"return": {}}
+
+=== Creating backing chain ===
+
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"return": {}}
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": ""}
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"return": {}}
+
+=== Start commit job and exit qemu ===
+
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "commit"}}
+
+=== Start active commit job and exit qemu ===
+
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
+
+=== Start mirror job and exit qemu ===
+
+{"return": {}}
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
+
+=== Start backup job and exit qemu ===
+
+{"return": {}}
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
+
+=== Start streaming job and exit qemu ===
+
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 524288, "speed": 65536, "type": "stream"}}
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a6acaff..318ae74 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -175,3 +175,4 @@
 181 rw auto migration
 182 rw auto quick
 183 rw auto migration
+185 rw auto
-- 
1.8.3.1
