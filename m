Received: from eggs.gnu.org ([2001:4830:134:3::10]:39405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYYwP-00017a-7i
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYYwO-00029U-B3
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:57:49 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Tue, 31 Jan 2017 15:57:03 +0200
Message-Id: <20170131135703.5638-3-nirsof@gmail.com>
In-Reply-To: <20170131135703.5638-1-nirsof@gmail.com>
References: <20170131135703.5638-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v4 2/2] qemu-io: Add regression tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Nir Soffer <nirsof@gmail.com>

From: Nir Soffer <nsoffer@redhat.com>

Add regression tests checking that qemu-io fail with non-zero exit code
when reading non-existing file or using the wrong format.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/173     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/173.out |  9 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 69 insertions(+)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
new file mode 100755
index 0000000..1d1fd6d
--- /dev/null
+++ b/tests/qemu-iotests/173
@@ -0,0 +1,59 @@
+#!/bin/bash
+#
+# Test that qemu-io fail with non-zero exit code
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
+owner=nirsof@gmail.com
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
+_supported_fmt raw
+
+
+size=256K
+_make_test_img $size
+
+echo
+echo "== reading wrong format should fail =="
+$QEMU_IO -f qcow2 -c "read 0 $size" "$TEST_IMG" 2>&1 | _filter_testdir
+test "${PIPESTATUS[0]}" -eq 1 || _fail "did not fail"
+
+echo
+echo "== reading missing file should fail =="
+$QEMU_IO -c "read 0 $size" "$TEST_DIR/missing" 2>&1 | _filter_testdir
+test "${PIPESTATUS[0]}" -eq 1 || _fail "did not fail"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/173.out b/tests/qemu-iotests/173.out
new file mode 100644
index 0000000..47012a3
--- /dev/null
+++ b/tests/qemu-iotests/173.out
@@ -0,0 +1,9 @@
+QA output created by 173
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=262144
+
+== reading wrong format should fail ==
+can't open device TEST_DIR/t.raw: Image is not in qcow2 format
+
+== reading missing file should fail ==
+can't open device TEST_DIR/missing: Could not open 'TEST_DIR/missing': No such file or directory
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 866c1a0..069a5f3 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -165,3 +165,4 @@
 170 rw auto quick
 171 rw auto quick
 172 auto
+173 auto
-- 
2.9.3
