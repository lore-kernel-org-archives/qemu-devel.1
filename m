Received: from eggs.gnu.org ([2001:4830:134:3::10]:60041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm6-00019Q-OP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceWm5-0007p7-GX
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:51:50 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 17 Feb 2017 02:51:25 +0200
Message-Id: <20170217005127.21010-2-nirsof@gmail.com>
In-Reply-To: <20170217005127.21010-1-nirsof@gmail.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-img: Add tests for raw image
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nirsof@gmail.com>

Add tests for creating raw image with and without the preallocation
option.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/175     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out | 18 ++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
new file mode 100755
index 0000000..ca56e82
--- /dev/null
+++ b/tests/qemu-iotests/175
@@ -0,0 +1,61 @@
+#!/bin/bash
+#
+# Test creating raw image preallocation mode
+#
+# Copyright (C) 2017 Nir Soffer <nirsof@gmail.com>
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
+_supported_proto file
+_supported_os Linux
+
+size=1m
+
+echo
+echo "== creating image with default preallocation =="
+_make_test_img $size | _filter_imgfmt
+stat -c "size=%s, blocks=%b" $TEST_IMG
+
+for mode in off full falloc; do
+    echo
+    echo "== creating image with preallocation $mode =="
+    IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
+    stat -c "size=%s, blocks=%b" $TEST_IMG
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
new file mode 100644
index 0000000..76c02c6
--- /dev/null
+++ b/tests/qemu-iotests/175.out
@@ -0,0 +1,18 @@
+QA output created by 175
+
+== creating image with default preallocation ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+size=1048576, blocks=0
+
+== creating image with preallocation off ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
+size=1048576, blocks=0
+
+== creating image with preallocation full ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
+size=1048576, blocks=2048
+
+== creating image with preallocation falloc ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=falloc
+size=1048576, blocks=2048
+ *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 985b9a6..1f4bf03 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -167,3 +167,4 @@
 172 auto
 173 rw auto
 174 auto
+175 auto quick
-- 
2.9.3
