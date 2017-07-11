Received: from eggs.gnu.org ([2001:4830:134:3::10]:47395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmp-0002fT-QP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmo-0007ZX-JS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:19 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:13 +0200
Message-Id: <20170711160814.20941-85-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 84/85] iotests: Add preallocated resize test for
 raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-16-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/106     | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/106.out | 50 +++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 143 insertions(+)
 create mode 100755 tests/qemu-iotests/106
 create mode 100644 tests/qemu-iotests/106.out

diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
new file mode 100755
index 0000000..3264957
--- /dev/null
+++ b/tests/qemu-iotests/106
@@ -0,0 +1,92 @@
+#!/bin/bash
+#
+# Test preallocated resize of raw images
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
+owner=mreitz@redhat.com
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+here=$PWD
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment and filters
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+# in kB
+CREATION_SIZE=128
+GROWTH_SIZE=256
+
+echo '=== Testing image growth ==='
+
+for create_mode in off falloc full; do
+    for growth_mode in off falloc full; do
+        echo
+        echo "--- create_mode=$create_mode growth_mode=$growth_mode ---"
+
+        IMGOPTS="preallocation=$create_mode" _make_test_img ${CREATION_SIZE}K
+        $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
+
+        expected_size=0
+        if [ $create_mode != off ]; then
+            expected_size=$CREATION_SIZE
+        fi
+        if [ $growth_mode != off ]; then
+            expected_size=$((expected_size + $GROWTH_SIZE))
+        fi
+
+        actual_size=$($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep 'disk size')
+        actual_size=$(echo "$actual_size" | sed -e 's/^[^0-9]*\([0-9]\+\).*$/\1/')
+
+        # The actual size may exceed the expected size, depending on the file
+        # system. Therefore we just test that the actual size is at least what
+        # we expect.
+        if [ $actual_size -lt $expected_size ]; then
+            echo "ERROR: Image should have at least ${expected_size}K, but has ${actual_size}K"
+        fi
+    done
+done
+
+echo
+echo '=== Testing image shrinking ==='
+
+# None of this should work except for "off", because other modes cannot be used
+# for shrinking
+for growth_mode in falloc full off; do
+    echo
+    echo "--- growth_mode=$growth_mode ---"
+    $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" -${GROWTH_SIZE}K
+done
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
new file mode 100644
index 0000000..0a42312
--- /dev/null
+++ b/tests/qemu-iotests/106.out
@@ -0,0 +1,50 @@
+QA output created by 106
+=== Testing image growth ===
+
+--- create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=off
+Image resized.
+
+--- create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=off
+Image resized.
+
+--- create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=off
+Image resized.
+
+--- create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=falloc
+Image resized.
+
+--- create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=falloc
+Image resized.
+
+--- create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=falloc
+Image resized.
+
+--- create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=full
+Image resized.
+
+--- create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=full
+Image resized.
+
+--- create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072 preallocation=full
+Image resized.
+
+=== Testing image shrinking ===
+
+--- growth_mode=falloc ---
+qemu-img: Preallocation can only be used for growing images
+
+--- growth_mode=full ---
+qemu-img: Preallocation can only be used for growing images
+
+--- growth_mode=off ---
+Image resized.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 8f883f7..de14091 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -112,6 +112,7 @@
 103 rw auto quick
 104 rw auto
 105 rw auto quick
+106 rw auto quick
 107 rw auto quick
 108 rw auto quick
 109 rw auto
-- 
2.9.4
