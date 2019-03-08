Received: from eggs.gnu.org ([209.51.188.92]:59476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5g-0008MZ-7p
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5b-0006Vh-2Y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:01 +0100
Message-Id: <20190308125823.32535-12-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/33] qemu-iotests: Test qcow2 preallocation
 modes
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/243     | 63 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/243.out | 26 ++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/qemu-iotests/243
 create mode 100644 tests/qemu-iotests/243.out

diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
new file mode 100755
index 0000000000..6a19919add
--- /dev/null
+++ b/tests/qemu-iotests/243
@@ -0,0 +1,63 @@
+#!/bin/bash
+#
+# Test qcow2 preallocation
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+owner=3Dkwolf@redhat.com
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+for mode in off metadata falloc full; do
+
+    echo
+    echo "=3D=3D=3D preallocation=3D$mode =3D=3D=3D"
+    echo
+
+    IMGOPTS=3D"preallocation=3D$mode" _make_test_img 64M
+
+    printf "File size: "
+    du -b $TEST_IMG | cut -f1
+
+    # Can't use precise numbers here because they differ between filesys=
tems
+    printf "Disk usage: "
+    [ $(du -B1 $TEST_IMG | cut -f1) -lt 1048576 ] && echo "low" || echo =
"high"
+
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
new file mode 100644
index 0000000000..e531753ad1
--- /dev/null
+++ b/tests/qemu-iotests/243.out
@@ -0,0 +1,26 @@
+QA output created by 243
+
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocati=
on=3Doff
+File size: 196616
+Disk usage: low
+
+=3D=3D=3D preallocation=3Dmetadata =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocati=
on=3Dmetadata
+File size: 67436544
+Disk usage: low
+
+=3D=3D=3D preallocation=3Dfalloc =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocati=
on=3Dfalloc
+File size: 67436544
+Disk usage: high
+
+=3D=3D=3D preallocation=3Dfull =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 preallocati=
on=3Dfull
+File size: 67436544
+Disk usage: high
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b5ca63cf72..03aa93dbf5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -241,3 +241,4 @@
 239 rw auto quick
 240 auto quick
 242 rw auto quick
+243 rw auto quick
--=20
2.20.1
