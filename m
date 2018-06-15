Received: from eggs.gnu.org ([2001:4830:134:3::10]:58846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbM-0005qZ-8b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbK-0003TU-Rf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:44 +0200
Message-Id: <20180615142108.27814-3-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/26] iotests: Add test 221 to catch qemu-img
 map regression
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

From: Eric Blake <eblake@redhat.com>

Although qemu-img creates aligned files (by rounding up), it
must also gracefully handle files that are not sector-aligned.
Test that the bug fixed in the previous patch does not recur.

It's a bit annoying that we can see the (implicit) hole past
the end of the file on to the next sector boundary, so if we
ever reach the point where we report a byte-accurate size rather
than our current behavior of always rounding up, this test will
probably need a slight modification.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/221     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/221.out | 16 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/qemu-iotests/221
 create mode 100644 tests/qemu-iotests/221.out

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
new file mode 100755
index 0000000000..41c4e4bdf8
--- /dev/null
+++ b/tests/qemu-iotests/221
@@ -0,0 +1,60 @@
+#!/bin/bash
+#
+# Test qemu-img vs. unaligned images
+#
+# Copyright (C) 2018 Red Hat, Inc.
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1 # failure is the default!
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
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Check mapping of unaligned raw image ==="
+echo
+
+_make_test_img 43009 # qemu-img create rounds size up
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+truncate --size=43009 "$TEST_IMG" # so we resize it and check again
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+$QEMU_IO -c 'w 43008 1' "$TEST_IMG" | _filter_qemu_io # writing also rounds up
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+truncate --size=43009 "$TEST_IMG" # so we resize it and check again
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
new file mode 100644
index 0000000000..a9c0190aad
--- /dev/null
+++ b/tests/qemu-iotests/221.out
@@ -0,0 +1,16 @@
+QA output created by 221
+
+=== Check mapping of unaligned raw image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=43009
+[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+wrote 1/1 bytes at offset 43008
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0914c922d7..937a3d0a4d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -218,3 +218,4 @@
 217 rw auto quick
 218 rw auto quick
 219 rw auto
+221 rw auto quick
-- 
2.13.6
