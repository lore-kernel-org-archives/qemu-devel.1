Received: from eggs.gnu.org ([2001:4830:134:3::10]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDANf-0005oo-6B
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dDANd-0000fZ-4f
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:01:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 May 2017 16:01:04 +0200
Message-Id: <1495548064-10926-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/183     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/183.out |  48 ++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 170 insertions(+)
 create mode 100755 tests/qemu-iotests/183
 create mode 100644 tests/qemu-iotests/183.out

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
new file mode 100755
index 0000000..0e1442c
--- /dev/null
+++ b/tests/qemu-iotests/183
@@ -0,0 +1,121 @@
+#!/bin/bash
+#
+# Test old-style block migration (migrate -b)
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
+status=1	# failure is the default!
+
+MIG_SOCKET="${TEST_DIR}/migrate"
+
+_cleanup()
+{
+    rm -f "${MIG_SOCKET}"
+    rm -f "${TEST_IMG}.dest"
+	_cleanup_test_img
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt generic
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
+qemu_comm_method="monitor"
+
+_launch_qemu \
+    -drive file="${TEST_IMG}",cache=${CACHEMODE},driver=$IMGFMT,id=disk
+src=$QEMU_HANDLE
+
+_launch_qemu \
+    -drive file="${TEST_IMG}.dest",cache=${CACHEMODE},driver=$IMGFMT,id=disk \
+    -incoming "unix:${MIG_SOCKET}"
+dest=$QEMU_HANDLE
+
+echo
+echo === Write something on the source ===
+echo
+
+_send_qemu_cmd $src 'qemu-io disk "write -P 0x55 0 64k"' "(qemu)"
+_send_qemu_cmd $src "" "ops/sec"
+silent=yes _timed_wait_for $src "(qemu)"
+_send_qemu_cmd $src 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
+_send_qemu_cmd $src "" "ops/sec"
+silent=yes _timed_wait_for $src "(qemu)"
+
+echo
+echo === Do block migration to destination ===
+echo
+
+_send_qemu_cmd $src "migrate -b unix:${MIG_SOCKET}" "(qemu)"
+_send_qemu_cmd $src "info migrate" "(qemu)" | sed -e "s/Completed [0-9]* %//g"
+_send_qemu_cmd $src "" "(qemu)" | grep "status"
+
+echo
+echo === Do some I/O on the destination ===
+echo
+
+# It is important that we use the BlockBackend of the guest device here instead
+# of the node name, which would create a new BlockBackend and not test whether
+# the guest has the necessary permissions to access the image now
+_send_qemu_cmd $dest "info status" "(qemu)"
+_send_qemu_cmd $dest 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)" |
+    sed -e "s/Completed [0-9]* %//g"
+_send_qemu_cmd $dest "" "ops/sec"
+silent=yes _timed_wait_for $dest "(qemu)"
+_send_qemu_cmd $dest 'qemu-io disk "write -P 0x66 1M 64k"' "(qemu)"
+_send_qemu_cmd $dest "" "ops/sec"
+silent=yes _timed_wait_for $dest "(qemu)"
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
+TEST_IMG="${TEST_IMG}.dest" _check_test_img
+
+$QEMU_IO -c 'write -P 0x66 1M 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG compare "$TEST_IMG.dest" "$TEST_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
new file mode 100644
index 0000000..5e05d2a
--- /dev/null
+++ b/tests/qemu-iotests/183.out
@@ -0,0 +1,48 @@
+QA output created by 183
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=IMGFMT size=67108864
+
+=== Starting VMs ===
+
+
+=== Write something on the source ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io disk "write -P 0x55 0 64k"
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk "read -P 0x55 0 64k"
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Do block migration to destination ===
+
+(qemu) migrate -b unix:TEST_DIR/migrate
+
+(qemu) info migrate
+Migration status: completed
+
+=== Do some I/O on the destination ===
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) Receiving block device images
+
+info status
+VM status: running
+(qemu) qemu-io disk "read -P 0x55 0 64k"
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) qemu-io disk "write -P 0x66 1M 64k"
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Shut down and check image ===
+
+(qemu) quit
+(qemu) quit
+No errors were found on the image.
+No errors were found on the image.
+wrote 65536/65536 bytes at offset 1048576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5c8ea0f..a6acaff 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -174,3 +174,4 @@
 179 rw auto quick
 181 rw auto migration
 182 rw auto quick
+183 rw auto migration
-- 
1.8.3.1
