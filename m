Received: from eggs.gnu.org ([2001:4830:134:3::10]:58205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAP-0004AN-Qd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edzAK-0006Vd-1S
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:03:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:02:00 +0100
Message-Id: <20180123140201.31163-29-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] iotests: Split 177 into two parts for
 compat=0.10
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

When originally written, test 177 explicitly took care to run
with compat=0.10.  Then I botched my own test in commit
81c219ac and f0a9c18f, by adding additional actions that require
v3 images.  Split out the new code into a new v3-only test, 204,
and revert 177 back to its original state other than a new comment.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20180117165420.15946-2-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/177     |  20 +++-----
 tests/qemu-iotests/177.out |  22 ++-------
 tests/qemu-iotests/204     | 119 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/204.out |  63 ++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 5 files changed, 193 insertions(+), 32 deletions(-)
 create mode 100755 tests/qemu-iotests/204
 create mode 100644 tests/qemu-iotests/204.out

diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 28990977f1..396986da89 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -2,7 +2,7 @@
 #
 # Test corner cases with unusual block geometries
 #
-# Copyright (C) 2016-2017 Red Hat, Inc.
+# Copyright (C) 2016-2018 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -37,13 +37,15 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
+# This test is runnable under compat=0.10; see test 204 for additional
+# tests specific to compat=1.1.
+
 _supported_fmt qcow2
 _supported_proto file
 
 CLUSTER_SIZE=1M
 size=128M
 options=driver=blkdebug,image.driver=qcow2
-nested_opts=image.file.driver=file,image.file.filename=$TEST_IMG
 
 echo
 echo "== setting up files =="
@@ -51,7 +53,7 @@ echo "== setting up files =="
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 $QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
 _make_test_img -b "$TEST_IMG.base"
-$QEMU_IO -c "write -P 22 0 110M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 22 0 $size" "$TEST_IMG" | _filter_qemu_io
 
 # Limited to 64k max-transfer
 echo
@@ -82,13 +84,6 @@ $QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
          -c "discard 80000001 30M" | _filter_qemu_io
 
 echo
-echo "== block status smaller than alignment =="
-limits=align=4k
-$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
-	 -c "alloc 1 1" -c "alloc 0x6dffff0 1000" -c "alloc 127m 5P" \
-	 -c map | _filter_qemu_io
-
-echo
 echo "== verify image content =="
 
 function verify_io()
@@ -110,13 +105,10 @@ function verify_io()
     echo read -P 0 32M 32M
     echo read -P 22 64M 13M
     echo read -P $discarded 77M 29M
-    echo read -P 22 106M 4M
-    echo read -P 11 110M 18M
+    echo read -P 22 106M 22M
 }
 
 verify_io | $QEMU_IO -r "$TEST_IMG" | _filter_qemu_io
-$QEMU_IMG map --image-opts "$options,$nested_opts,align=4k" \
-    | _filter_qemu_img_map
 
 _check_test_img
 
diff --git a/tests/qemu-iotests/177.out b/tests/qemu-iotests/177.out
index f788b55e20..e887542678 100644
--- a/tests/qemu-iotests/177.out
+++ b/tests/qemu-iotests/177.out
@@ -5,8 +5,8 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
-wrote 115343360/115343360 bytes at offset 0
-110 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == constrained alignment and max-transfer ==
 wrote 131072/131072 bytes at offset 1000
@@ -26,13 +26,6 @@ wrote 33554432/33554432 bytes at offset 33554432
 discard 31457280/31457280 bytes at offset 80000001
 30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-== block status smaller than alignment ==
-1/1 bytes allocated at offset 1 bytes
-16/1000 bytes allocated at offset 110 MiB
-0/1048576 bytes allocated at offset 127 MiB
-110 MiB (0x6e00000) bytes     allocated at offset 0 bytes (0x0)
-18 MiB (0x1200000) bytes not allocated at offset 110 MiB (0x6e00000)
-
 == verify image content ==
 read 1000/1000 bytes at offset 0
 1000 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -50,14 +43,7 @@ read 13631488/13631488 bytes at offset 67108864
 13 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 30408704/30408704 bytes at offset 80740352
 29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4194304/4194304 bytes at offset 111149056
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 18874368/18874368 bytes at offset 115343360
-18 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Offset          Length          File
-0               0x800000        TEST_DIR/t.IMGFMT
-0x900000        0x2400000       TEST_DIR/t.IMGFMT
-0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
-0x6a00000       0x400000        TEST_DIR/t.IMGFMT
+read 23068672/23068672 bytes at offset 111149056
+22 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
new file mode 100755
index 0000000000..feb69d2ada
--- /dev/null
+++ b/tests/qemu-iotests/204
@@ -0,0 +1,119 @@
+#!/bin/bash
+#
+# Test corner cases with unusual block geometries
+#
+# Copyright (C) 2016-2018 Red Hat, Inc.
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
+_supported_fmt qcow2
+_supported_proto file
+# This test assumes that discard leaves zero clusters; see test 177 for
+# other tests that also work in older images
+_unsupported_imgopts 'compat=0.10'
+
+CLUSTER_SIZE=1M
+size=128M
+options=driver=blkdebug,image.driver=qcow2
+nested_opts=image.file.driver=file,image.file.filename=$TEST_IMG
+
+echo
+echo "== setting up files =="
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+$QEMU_IO -c "write -P 11 0 $size" "$TEST_IMG.base" | _filter_qemu_io
+_make_test_img -b "$TEST_IMG.base"
+$QEMU_IO -c "write -P 22 0 110M" "$TEST_IMG" | _filter_qemu_io
+
+# Limited to 64k max-transfer
+echo
+echo "== constrained alignment and max-transfer =="
+limits=align=4k,max-transfer=64k
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -P 33 1000 128k" -c "read -P 33 1000 128k" | _filter_qemu_io
+
+echo
+echo "== write zero with constrained max-transfer =="
+limits=align=512,max-transfer=64k,opt-write-zero=$CLUSTER_SIZE
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -z 8003584 2093056" | _filter_qemu_io
+
+# non-power-of-2 write-zero/discard alignments
+echo
+echo "== non-power-of-2 write zeroes limits =="
+
+limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "write -z 32M 32M" | _filter_qemu_io
+
+echo
+echo "== non-power-of-2 discard limits =="
+
+limits=align=512,opt-write-zero=15M,max-write-zero=15M,opt-discard=15M,max-discard=15M
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+         -c "discard 80000001 30M" | _filter_qemu_io
+
+echo
+echo "== block status smaller than alignment =="
+limits=align=4k
+$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
+	 -c "alloc 1 1" -c "alloc 0x6dffff0 1000" -c "alloc 127m 5P" \
+	 -c map | _filter_qemu_io
+
+echo
+echo "== verify image content =="
+
+function verify_io()
+{
+    echo read -P 22 0 1000
+    echo read -P 33 1000 128k
+    echo read -P 22 132072 7871512
+    echo read -P 0 8003584 2093056
+    echo read -P 22 10096640 23457792
+    echo read -P 0 32M 32M
+    echo read -P 22 64M 13M
+    echo read -P 0 77M 29M
+    echo read -P 22 106M 4M
+    echo read -P 11 110M 18M
+}
+
+verify_io | $QEMU_IO -r "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --image-opts "$options,$nested_opts,align=4k" \
+    | _filter_qemu_img_map
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+status=0
diff --git a/tests/qemu-iotests/204.out b/tests/qemu-iotests/204.out
new file mode 100644
index 0000000000..f3a10fbe90
--- /dev/null
+++ b/tests/qemu-iotests/204.out
@@ -0,0 +1,63 @@
+QA output created by 204
+
+== setting up files ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 115343360/115343360 bytes at offset 0
+110 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== constrained alignment and max-transfer ==
+wrote 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== write zero with constrained max-transfer ==
+wrote 2093056/2093056 bytes at offset 8003584
+1.996 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== non-power-of-2 write zeroes limits ==
+wrote 33554432/33554432 bytes at offset 33554432
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== non-power-of-2 discard limits ==
+discard 31457280/31457280 bytes at offset 80000001
+30 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== block status smaller than alignment ==
+1/1 bytes allocated at offset 1 bytes
+16/1000 bytes allocated at offset 110 MiB
+0/1048576 bytes allocated at offset 127 MiB
+110 MiB (0x6e00000) bytes     allocated at offset 0 bytes (0x0)
+18 MiB (0x1200000) bytes not allocated at offset 110 MiB (0x6e00000)
+
+== verify image content ==
+read 1000/1000 bytes at offset 0
+1000 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 1000
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 7871512/7871512 bytes at offset 132072
+7.507 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2093056/2093056 bytes at offset 8003584
+1.996 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 23457792/23457792 bytes at offset 10096640
+22.371 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 33554432/33554432 bytes at offset 33554432
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 13631488/13631488 bytes at offset 67108864
+13 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 30408704/30408704 bytes at offset 80740352
+29 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 111149056
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 18874368/18874368 bytes at offset 115343360
+18 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x800000        TEST_DIR/t.IMGFMT
+0x900000        0x2400000       TEST_DIR/t.IMGFMT
+0x3c00000       0x1100000       TEST_DIR/t.IMGFMT
+0x6a00000       0x400000        TEST_DIR/t.IMGFMT
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c4703cd782..8fc4f62cca 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -200,3 +200,4 @@
 201 rw auto migration
 202 rw auto quick
 203 rw auto
+204 rw auto quick
-- 
2.13.6
