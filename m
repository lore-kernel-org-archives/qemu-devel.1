Received: from eggs.gnu.org ([2001:4830:134:3::10]:57899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhT6W-0007px-8d
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhT6V-0005O5-53
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:05:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 12:04:54 +0800
Message-Id: <20170815040454.4223-5-famz@redhat.com>
In-Reply-To: <20170815040454.4223-1-famz@redhat.com>
References: <20170815040454.4223-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 4/4] iotests: Add non-shared storage
 migration case 192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/192     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/192.out |  7 ++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/qemu-iotests/192
 create mode 100644 tests/qemu-iotests/192.out

diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
new file mode 100755
index 0000000000..b50a2c0c8e
--- /dev/null
+++ b/tests/qemu-iotests/192
@@ -0,0 +1,63 @@
+#!/bin/bash
+#
+# Test NBD export with -incoming (non-shared storage migration use case from
+# libvirt)
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
+owner=famz@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt generic
+_supported_proto file
+_supported_os Linux
+
+if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
+    _notrun "Requires a PC machine"
+fi
+
+size=64M
+_make_test_img $size
+
+{
+echo "nbd_server_start unix:$TEST_DIR/nbd"
+echo "nbd_server_add -w drive0"
+echo "q"
+} | $QEMU -nodefaults -display none -monitor stdio \
+    -drive format=$IMGFMT,file=$TEST_IMG,if=ide,id=drive0 \
+    -incoming defer 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/192.out b/tests/qemu-iotests/192.out
new file mode 100644
index 0000000000..1e0be4c4d7
--- /dev/null
+++ b/tests/qemu-iotests/192.out
@@ -0,0 +1,7 @@
+QA output created by 192
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) nbd_server_start unix:TEST_DIR/nbd
+(qemu) nbd_server_add -w drive0
+(qemu) q
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1848077932..afbdc427ea 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -186,3 +186,4 @@
 188 rw auto quick
 189 rw auto
 190 rw auto quick
+192 rw auto quick
-- 
2.13.4
