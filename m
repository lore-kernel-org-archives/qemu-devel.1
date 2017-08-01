Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRd-0000D6-M8
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRc-0005Py-Ir
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:22 +0200
Message-Id: <20170801144632.3831-6-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] iotests: Add test of recent fix to
 'qemu-img measure'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The new test 190 ensures we don't regress back to an infinite loop when
measuring the size of a 2T+ qcow2 image.  I did not append to test 178,
because that test is also designed to run with format 'raw'; also, this
gives us some coverage of the measure command under the quick group.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/190     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/190.out | 11 +++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/qemu-iotests/190
 create mode 100644 tests/qemu-iotests/190.out

diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
new file mode 100755
index 0000000000..8f808fef5d
--- /dev/null
+++ b/tests/qemu-iotests/190
@@ -0,0 +1,59 @@
+#!/bin/bash
+#
+# qemu-img measure sub-command tests on huge qcow2 files
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
+owner=eblake@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.converted"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+# See 178 for more extensive tests across more formats
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo "== Huge file =="
+echo
+
+IMGOPTS='cluster_size=2M' _make_test_img 2T
+
+$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
+$QEMU_IMG measure -O qcow2 -o cluster_size=64k -f qcow2 "$TEST_IMG"
+$QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
new file mode 100644
index 0000000000..d001942002
--- /dev/null
+++ b/tests/qemu-iotests/190.out
@@ -0,0 +1,11 @@
+QA output created by 190
+== Huge file ==
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2199023255552
+required size: 2199023255552
+fully allocated size: 2199023255552
+required size: 335806464
+fully allocated size: 2199359062016
+required size: 18874368
+fully allocated size: 2199042129920
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 287f0ea27d..823811076d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -184,3 +184,4 @@
 186 rw auto
 188 rw auto quick
 189 rw auto
+190 rw auto quick
-- 
2.13.3
