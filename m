Received: from eggs.gnu.org ([2001:4830:134:3::10]:42738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYC-0006Vk-Vv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWYYB-0007BN-Jm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 20:08:32 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 20:08:22 -0500
Message-Id: <1a7a3d6e6d8af36cd5b47ed6ea93b5a9ededf81b.1485392617.git.jcody@redhat.com>
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
References: <cover.1485392617.git.jcody@redhat.com>
In-Reply-To: <cover.1485392617.git.jcody@redhat.com>
References: <cover.1485392617.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-iotest: test to lookup
 protocol-based image with relative backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This test uses NFS and block-stream to force a lookup of a backing
image that has a relative filename, but a full backing image name
with the protocol path intact.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/173     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/173.out | 12 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 110 insertions(+)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
new file mode 100755
index 0000000..bdaa092
--- /dev/null
+++ b/tests/qemu-iotests/173
@@ -0,0 +1,97 @@
+#!/bin/bash
+#
+# Test QAPI commands looking up protocol based images with relative
+# filename backing strings
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
+# creator
+owner=jcody@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    rm  -f "${QEMU_TEST_DIR}/image.base" "${QEMU_TEST_DIR}/image.snp1"
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto nfs
+_supported_os Linux
+
+size=100M
+
+BASE_IMG="${TEST_DIR}/image.base"
+TOP_IMG="${TEST_DIR}/image.snp1"
+
+TEST_IMG="${BASE_IMG}" _make_test_img $size
+
+TEST_IMG="${TOP_IMG}" _make_test_img $size
+
+echo
+echo === Running QEMU, using block-stream to find backing image ===
+echo
+
+qemu_comm_method="qmp"
+_launch_qemu -drive file="${BASE_IMG}",if=virtio,id=disk2
+h=$QEMU_HANDLE
+
+_send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" "return"
+
+_send_qemu_cmd $h "{ 'arguments': {
+                        'device': 'disk2',
+                        'format': '${IMGFMT}',
+                        'mode': 'existing',
+                        'snapshot-file': '${TOP_IMG}',
+                        'snapshot-node-name': 'snp1'
+                     },
+                     'execute': 'blockdev-snapshot-sync'
+                   }" "return"
+
+
+_send_qemu_cmd $h "{ 'arguments': {
+                        'backing-file': 'image.base',
+                        'device': 'disk2',
+                        'image-node-name': 'snp1'
+                     },
+                     'execute': 'change-backing-file'
+                   }" "return"
+
+_send_qemu_cmd $h "{ 'arguments': {
+                        'base': '${BASE_IMG}',
+                        'device': 'disk2'
+                      },
+                      'execute': 'block-stream'
+                   }" "BLOCK_JOB_COMPLETED"
+
+_cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/173.out b/tests/qemu-iotests/173.out
new file mode 100644
index 0000000..f477a00
--- /dev/null
+++ b/tests/qemu-iotests/173.out
@@ -0,0 +1,12 @@
+QA output created by 173
+Formatting 'TEST_DIR/image.base', fmt=IMGFMT size=104857600
+Formatting 'TEST_DIR/image.snp1', fmt=IMGFMT size=104857600
+
+=== Running QEMU, using block-stream to find backing image ===
+
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk2", "len": 104857600, "offset": 104857600, "speed": 0, "type": "stream"}}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 866c1a0..5a93ba9 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -165,3 +165,4 @@
 170 rw auto quick
 171 rw auto quick
 172 auto
+173 rw auto
-- 
2.9.3
