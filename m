Received: from eggs.gnu.org ([209.51.188.92]:49149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv6-0008Jh-MP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUv5-0002HQ-1x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:43 +0200
Message-Id: <20190430154244.30083-27-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/27] iotests: Check that images are in
 read-only mode after block-commit
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

From: Alberto Garcia <berto@igalia.com>

This tests the fix from the previous patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  35 +++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 151 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
new file mode 100755
index 0000000000..e4650ecf6b
--- /dev/null
+++ b/tests/qemu-iotests/249
@@ -0,0 +1,115 @@
+#!/usr/bin/env bash
+#
+# Test that a backing image is put back in read-only mode after
+# block-commit (both when it fails and when it succeeds).
+#
+# Copyright (C) 2019 Igalia, S.L.
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
+owner=3Dberto@igalia.com
+
+seq=3D"$(basename $0)"
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
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
+IMG_SIZE=3D1M
+
+# Create the images: base <- int <- active
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE | _filter_imgfmt
+TEST_IMG=3D"$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" | _filter_=
imgfmt
+_make_test_img -b "$TEST_IMG.int" | _filter_imgfmt
+
+# Launch QEMU with these two drives:
+# none0: base (read-only)
+# none1: base <- int <- active
+_launch_qemu -drive if=3Dnone,file=3D"${TEST_IMG}.base",node-name=3Dbase=
,read-only=3Don \
+             -drive if=3Dnone,file=3D"${TEST_IMG}",backing.node-name=3Di=
nt,backing.backing=3Dbase
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+echo
+echo '=3D=3D=3D Send a write command to a drive opened in read-only mode=
 (1)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}=
}" \
+    'return'
+
+echo
+echo '=3D=3D=3D Run block-commit on base using an invalid filter node na=
me'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'i=
nt',
+                     'filter-node-name': '1234'}}" \
+    'error'
+
+echo
+echo '=3D=3D=3D Send a write command to a drive opened in read-only mode=
 (2)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}=
}" \
+    'return'
+
+echo
+echo '=3D=3D=3D Run block-commit on base using the default filter node n=
ame'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-commit',
+       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'i=
nt'}}" \
+    'return'
+
+# Wait for block-commit to finish
+_send_qemu_cmd $QEMU_HANDLE '' \
+    '"status": "null"'
+
+echo
+echo '=3D=3D=3D Send a write command to a drive opened in read-only mode=
 (3)'
+echo
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}=
}" \
+    'return'
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
new file mode 100644
index 0000000000..1c93164e84
--- /dev/null
+++ b/tests/qemu-iotests/249.out
@@ -0,0 +1,35 @@
+QA output created by 249
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_=
file=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+{"return": {}}
+
+=3D=3D=3D Send a write command to a drive opened in read-only mode (1)
+
+{"return": "Block node is read-onlyrn"}
+
+=3D=3D=3D Run block-commit on base using an invalid filter node name
+
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"error": {"class": "GenericError", "desc": "Invalid node name"}}
+
+=3D=3D=3D Send a write command to a drive opened in read-only mode (2)
+
+{"return": "Block node is read-onlyrn"}
+
+=3D=3D=3D Run block-commit on base using the default filter node name
+
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 1048576, "of=
fset": 1048576, "speed": 0, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+
+=3D=3D=3D Send a write command to a drive opened in read-only mode (3)
+
+{"return": "Block node is read-onlyrn"}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..7ac9a5ea4a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+249 rw auto quick
--=20
2.20.1
