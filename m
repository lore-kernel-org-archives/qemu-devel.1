Received: from eggs.gnu.org ([2001:4830:134:3::10]:42766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2ST-0003Gk-M3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2SQ-0002JT-R8
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:29 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 14:51:42 +0000
Message-Id: <20170124145152.22980-8-berrange@redhat.com>
In-Reply-To: <20170124145152.22980-1-berrange@redhat.com>
References: <20170124145152.22980-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/17] iotests: fix 097 when run with qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The previous commit:

  commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
  Author: Eric Blake <eblake@redhat.com>
  Date:   Mon Dec 5 09:49:34 2016 -0600

    qcow2: Don't strand clusters near 2G intervals during commit

extended the 097 test case so that it did two passes, once
with an internal snapshot, once without.

qcow (v1) does not support internal snapshots, so this change
broke test 097 when run against qcow.

This splits 097 in two, creating a new 173 that tests the
internal snapshot codepath, effectively putting 097 back
to its content before the above commit.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/097     |  10 +---
 tests/qemu-iotests/097.out | 125 ++------------------------------------------
 tests/qemu-iotests/173     | 126 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/173.out | 119 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 5 files changed, 251 insertions(+), 130 deletions(-)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out

diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 4c33e80..1d28aff 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -56,26 +56,19 @@ _supported_os Linux
 #  3: Two-layer backing chain, commit to lower backing file
 #     (in this case, the top image will implicitly stay unchanged)
 #
-# Each pass is run twice, since qcow2 has different code paths for cleaning
-# an image depending on whether it has a snapshot.
-#
 # 020 already tests committing, so this only tests whether image chains are
 # working properly and that all images above the base are emptied; therefore,
 # no complicated patterns are necessary.  Check near the 2G mark, as qcow2
 # has been buggy at that boundary in the past.
 for i in 0 1 2 3; do
-for j in 0 1; do
 
 echo
-echo "=== Test pass $i.$j ==="
+echo "=== Test pass $i ==="
 echo
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
 TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
 _make_test_img -b "$TEST_IMG.itmd" 2100M
-if [ $j -eq 0 ]; then
-    $QEMU_IMG snapshot -c snap "$TEST_IMG"
-fi
 
 $QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
@@ -121,7 +114,6 @@ $QEMU_IMG map "$TEST_IMG.itmd" | _filter_qemu_img_map
 $QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
 
 done
-done
 
 
 # success, all done
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index 8106cc9..81fc225 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -1,6 +1,6 @@
 QA output created by 097
 
-=== Test pass 0.0 ===
+=== Test pass 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
@@ -29,66 +29,7 @@ Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 
-=== Test pass 0.1 ===
-
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 2147352576
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Image committed.
-read 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147287040
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147352576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-
-=== Test pass 1.0 ===
-
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 2147352576
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Image committed.
-read 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147287040
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147352576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
-0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
-
-=== Test pass 1.1 ===
+=== Test pass 1 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
@@ -118,7 +59,7 @@ Offset          Length          File
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 
-=== Test pass 2.0 ===
+=== Test pass 2 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
@@ -148,65 +89,7 @@ Offset          Length          File
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 
-=== Test pass 2.1 ===
-
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 2147352576
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Image committed.
-read 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147287040
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147352576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
-0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
-
-=== Test pass 3.0 ===
-
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 2147287040
-192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 2147352576
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Image committed.
-read 65536/65536 bytes at offset 2147287040
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147352576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 2147418112
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
-Offset          Length          File
-0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
-0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
-0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
-
-=== Test pass 3.1 ===
+=== Test pass 3 ===
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
 Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
new file mode 100755
index 0000000..9a70a87
--- /dev/null
+++ b/tests/qemu-iotests/173
@@ -0,0 +1,126 @@
+#!/bin/bash
+#
+# Commit changes into backing chains and empty the top image if the
+# backing image is not explicitly specified.
+#
+# Variant of 097, which includes snapshots to test different codepath
+# in qcow2
+#
+# Copyright (C) 2014 Red Hat, Inc.
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.itmd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+# Any format supporting backing files and bdrv_make_empty
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+
+# Four passes:
+#  0: Two-layer backing chain, commit to upper backing file (implicitly)
+#     (in this case, the top image will be emptied)
+#  1: Two-layer backing chain, commit to upper backing file (explicitly)
+#     (in this case, the top image will implicitly stay unchanged)
+#  2: Two-layer backing chain, commit to upper backing file (implicitly with -d)
+#     (in this case, the top image will explicitly stay unchanged)
+#  3: Two-layer backing chain, commit to lower backing file
+#     (in this case, the top image will implicitly stay unchanged)
+#
+# 020 already tests committing, so this only tests whether image chains are
+# working properly and that all images above the base are emptied; therefore,
+# no complicated patterns are necessary.  Check near the 2G mark, as qcow2
+# has been buggy at that boundary in the past.
+for i in 0 1 2 3; do
+
+echo
+echo "=== Test pass $i ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
+_make_test_img -b "$TEST_IMG.itmd" 2100M
+$QEMU_IMG snapshot -c snap "$TEST_IMG"
+
+$QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
+$QEMU_IO -c 'write -P 3 0x7fff0000 64k' "$TEST_IMG" | _filter_qemu_io
+
+if [ $i -lt 3 ]; then
+    if [ $i == 0 ]; then
+        # -b "$TEST_IMG.itmd" should be the default (that is, committing to the
+        # first backing file in the chain)
+        $QEMU_IMG commit "$TEST_IMG"
+    elif [ $i == 1 ]; then
+        # explicitly specify the commit target (this should imply -d)
+        $QEMU_IMG commit -b "$TEST_IMG.itmd" "$TEST_IMG"
+    else
+        # do not explicitly specify the commit target, but use -d to leave the
+        # top image unchanged
+        $QEMU_IMG commit -d "$TEST_IMG"
+    fi
+
+    # Bottom should be unchanged
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
+
+    # Intermediate should contain changes from top
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+
+    # And in pass 0, the top image should be empty, whereas in both other passes
+    # it should be unchanged (which is both checked by qemu-img map)
+else
+    $QEMU_IMG commit -b "$TEST_IMG.base" "$TEST_IMG"
+
+    # Bottom should contain all changes
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+
+    # Both top and intermediate should be unchanged
+fi
+
+$QEMU_IMG map "$TEST_IMG.base" | _filter_qemu_img_map
+$QEMU_IMG map "$TEST_IMG.itmd" | _filter_qemu_img_map
+$QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
+
+done
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/173.out b/tests/qemu-iotests/173.out
new file mode 100644
index 0000000..5d16a11
--- /dev/null
+++ b/tests/qemu-iotests/173.out
@@ -0,0 +1,119 @@
+QA output created by 173
+
+=== Test pass 0 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+
+=== Test pass 1 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 2 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 3 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 866c1a0..f5d7bc8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -165,3 +165,4 @@
 170 rw auto quick
 171 rw auto quick
 172 auto
+173 rw auto backing
-- 
2.9.3
