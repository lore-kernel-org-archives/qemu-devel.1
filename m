Received: from eggs.gnu.org ([2001:4830:134:3::10]:57652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9h-0003Qj-O5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9g-0005po-Hu
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:36 +0100
Message-Id: <20180123140201.31163-5-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/29] tests/qemu-iotests: adding savevm/loadvm
 with postcopy flag test
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

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This patch implements a test case for the scenario that was failing
prior to the patch "migration/ram.c: do not set 'postcopy_running' in
POSTCOPY_INCOMING_END", commit acab30b85d.

This new test file 201 was derived from the test file 181 authored
by Kevin Wolf.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/201     | 120 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out |  23 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 144 insertions(+)
 create mode 100755 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
new file mode 100755
index 0000000000..11f640f5df
--- /dev/null
+++ b/tests/qemu-iotests/201
@@ -0,0 +1,120 @@
+#!/bin/bash
+#
+# Test savevm and loadvm after live migration with postcopy flag
+#
+# Copyright (C) 2017, IBM Corporation.
+#
+# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
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
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+MIG_SOCKET="${TEST_DIR}/migrate"
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_cleanup()
+{
+    rm -f "${MIG_SOCKET}"
+    _cleanup_test_img
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+# Internal snapshots are (currently) impossible with refcount_bits=1
+# This was taken from test 080
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
+
+size=64M
+_make_test_img $size
+
+echo
+echo === Starting VMs ===
+echo
+
+qemu_comm_method="monitor"
+
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    _launch_qemu \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk
+else
+    _launch_qemu \
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+fi
+src=$QEMU_HANDLE
+
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    _launch_qemu \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},id=disk \
+        -incoming "unix:${MIG_SOCKET}"
+else
+    _launch_qemu \
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
+        -incoming "unix:${MIG_SOCKET}"
+fi
+dest=$QEMU_HANDLE
+
+echo
+echo === Set \'migrate_set_capability postcopy-ram on\' and migrate ===
+echo
+
+silent=yes
+_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
+_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
+_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
+
+QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
+    _send_qemu_cmd $src "info migrate" "completed\|failed"
+silent=yes _send_qemu_cmd $src "" "(qemu)"
+
+echo
+echo === Check if migration was successful ===
+echo
+
+QEMU_COMM_TIMEOUT=1 silent=yes \
+    _send_qemu_cmd $src "info migrate" "completed"
+silent=yes _send_qemu_cmd $src "" "(qemu)"
+
+echo
+echo === On destination, execute savevm and loadvm ===
+echo
+
+silent=
+_send_qemu_cmd $dest 'savevm state1' "(qemu)"
+_send_qemu_cmd $dest 'loadvm state1' "(qemu)"
+
+echo
+echo === Shut down and check image ===
+echo
+
+_send_qemu_cmd $src 'quit' ""
+_send_qemu_cmd $dest 'quit' ""
+wait=1 _cleanup_qemu
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+status=0
diff --git a/tests/qemu-iotests/201.out b/tests/qemu-iotests/201.out
new file mode 100644
index 0000000000..9faf06f996
--- /dev/null
+++ b/tests/qemu-iotests/201.out
@@ -0,0 +1,23 @@
+QA output created by 201
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+
+=== Starting VMs ===
+
+
+=== Set 'migrate_set_capability postcopy-ram on' and migrate ===
+
+
+=== Check if migration was successful ===
+
+
+=== On destination, execute savevm and loadvm ===
+
+(qemu) savevm state1
+(qemu) loadvm state1
+
+=== Shut down and check image ===
+
+(qemu) quit
+(qemu) quit
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 93d96fb22f..c4703cd782 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -197,5 +197,6 @@
 197 rw auto quick
 198 rw auto
 200 rw auto
+201 rw auto migration
 202 rw auto quick
 203 rw auto
-- 
2.13.6
