Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQN-0000cl-1B
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQL-0007PI-Py
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 13:44:04 +0800
Message-Id: <20170915054404.19914-4-famz@redhat.com>
In-Reply-To: <20170915054404.19914-1-famz@redhat.com>
References: <20170915054404.19914-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] iotests: Add "quit during block migration"
 case 195
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/195     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/195.out | 19 +++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 117 insertions(+)
 create mode 100755 tests/qemu-iotests/195
 create mode 100644 tests/qemu-iotests/195.out

diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
new file mode 100755
index 0000000000..f732b56854
--- /dev/null
+++ b/tests/qemu-iotests/195
@@ -0,0 +1,97 @@
+#!/bin/bash
+#
+# Test quit during block migration (migrate -b) doesn't crash
+#
+# Copyright 2017 Red Hat, Inc.
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
+owner=famz@redhat.com
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
+    rm -f "${MIG_SOCKET}"
+    rm -f "${TEST_IMG}.dest"
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
+_supported_fmt qcow2 raw qed dmg quorum
+_supported_proto file
+_supported_os Linux
+
+size=64M
+_make_test_img $size
+TEST_IMG="${TEST_IMG}.dest" _make_test_img $size
+
+echo
+echo === Starting VMs ===
+echo
+
+qemu_comm_method="qmp"
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=$CACHEMODE,driver=$IMGFMT,id=disk
+src=$QEMU_HANDLE
+_send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_launch_qemu \
+    -drive file="${TEST_IMG}.dest",cache=$CACHEMODE,driver=$IMGFMT,id=disk \
+    -incoming "unix:${MIG_SOCKET}"
+dest=$QEMU_HANDLE
+_send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
+
+echo
+echo === Do block migration to destination ===
+echo
+
+reply="$(_send_qemu_cmd $src \
+    "{ 'execute': 'migrate',
+       'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
+    'return\|error')"
+echo "$reply"
+if echo "$reply" | grep "compiled without old-style" > /dev/null; then
+    _notrun "migrate -b support not compiled in"
+fi
+
+echo
+echo === Shut down and check image ===
+echo
+
+_send_qemu_cmd $src '{"execute":"quit"}' 'return'
+_cleanup_qemu
+
+_check_test_img
+TEST_IMG="${TEST_IMG}.dest" _check_test_img
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
new file mode 100644
index 0000000000..36b2fc5e83
--- /dev/null
+++ b/tests/qemu-iotests/195.out
@@ -0,0 +1,19 @@
+QA output created by 195
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=IMGFMT size=67108864
+
+=== Starting VMs ===
+
+{"return": {}}
+{"return": {}}
+
+=== Do block migration to destination ===
+
+{"return": {}}
+
+=== Shut down and check image ===
+
+{"return": {}}
+No errors were found on the image.
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 94e764865a..e7e8fcc722 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -189,3 +189,4 @@
 190 rw auto quick
 192 rw auto quick
 194 rw auto migration quick
+195 rw auto migration quick
-- 
2.13.5
