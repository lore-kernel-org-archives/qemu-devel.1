Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQMIw-0003gK-Nz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 19:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQMIv-0000B4-An
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 19:23:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 29 Jun 2017 01:23:15 +0200
Message-Id: <20170628232315.22777-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Add test for dataplane mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Depends on Stefan's "virtio: use ioeventfd in TCG and qtest mode" series
to work at all, and on "mirror: Fix inconsistent backing AioContext for
after mirroring" (in my block branch) so it does not fail.
---
 tests/qemu-iotests/106     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/106.out | 14 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 112 insertions(+)
 create mode 100755 tests/qemu-iotests/106
 create mode 100644 tests/qemu-iotests/106.out

diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
new file mode 100755
index 0000000..ad438b5
--- /dev/null
+++ b/tests/qemu-iotests/106
@@ -0,0 +1,97 @@
+#!/bin/bash
+#
+# Test case for mirroring with dataplane
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
+owner=mreitz@redhat.com
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+here=$PWD
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.overlay0"
+    _rm_test_img "$TEST_IMG.overlay1"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and qemu instance handling
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+IMG_SIZE=64K
+
+_make_test_img $IMG_SIZE
+TEST_IMG="$TEST_IMG.overlay0" _make_test_img -b "$TEST_IMG" $IMG_SIZE
+TEST_IMG="$TEST_IMG.overlay1" _make_test_img -b "$TEST_IMG" $IMG_SIZE
+
+# So that we actually have something to mirror and the job does not return
+# immediately (which may be bad because then we cannot know whether the
+# 'return' or the 'BLOCK_JOB_READY' comes first).
+$QEMU_IO -c 'write 0 64' "$TEST_IMG.overlay0" | _filter_qemu_io
+
+# We cannot use virtio-blk here because that does not actually set the attached
+# BB's AioContext in qtest mode
+_launch_qemu \
+    -object iothread,id=iothr \
+    -blockdev node-name=source,driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG.overlay0" \
+    -device virtio-scsi,id=scsi-bus,iothread=iothr \
+    -device scsi-hd,bus=scsi-bus.0,drive=source
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'drive-mirror',
+       'arguments': {
+           'job-id': 'mirror',
+           'device': 'source',
+           'target': '$TEST_IMG.overlay1',
+           'mode':   'existing',
+           'sync':   'top'
+       } }" \
+    'BLOCK_JOB_READY'
+
+# The backing BDS should be assigned the overlay's AioContext
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'block-job-complete',
+       'arguments': { 'device': 'mirror' } }" \
+    'BLOCK_JOB_COMPLETED'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+
+wait=yes _cleanup_qemu
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
new file mode 100644
index 0000000..d1b83f1
--- /dev/null
+++ b/tests/qemu-iotests/106.out
@@ -0,0 +1,14 @@
+QA output created by 106
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT
+wrote 64/64 bytes at offset 0
+64 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "mirror", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "mirror", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 613d596..8da3e2b 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -112,6 +112,7 @@
 103 rw auto quick
 104 rw auto
 105 rw auto quick
+106 rw auto backing
 107 rw auto quick
 108 rw auto quick
 109 rw auto
-- 
2.9.4
