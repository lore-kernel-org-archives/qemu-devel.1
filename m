Received: from eggs.gnu.org ([2001:4830:134:3::10]:47421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4UQY-0006AZ-Ah
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4UQW-00032M-Fq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:41:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  6 Apr 2018 18:41:08 +0200
Message-Id: <20180406164108.26118-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Split 214 off of 122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Commit abd3622cc03cf41ed542126a540385f30a4c0175 added a case to 122
regarding how the qcow2 driver handles an incorrect compressed data
length value.  This does not really fit into 122, as that file is
supposed to contain qemu-img convert test cases, which this case is not.
So this patch splits it off into its own file; maybe we will even get
more qcow2-only compression tests in the future.

Also, that test case does not work with refcount_bits=1, so mark that
option as unsupported.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Kind of a v2 for "iotests: 122 needs at least two refcount bits now"
(fulfills the same purpose, but also splits the case into its own file
 so you can still run 122 with refcount_bits=1 [Eric]).

I was a bit lost what to do about the copyright text, since this test
case was written by Berto.  I figured I'd drop the "owner" variable (it
isn't used anyway), but I put "Red Hat" into the copyright line --
currently every test has copyright information, so I decided it'd be
difficult to leave that out, and I figured I simply cannot claim
copyright for Igalia.  So, here we go.
---
 tests/qemu-iotests/122     | 47 -----------------------
 tests/qemu-iotests/122.out | 33 ----------------
 tests/qemu-iotests/214     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 35 +++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 132 insertions(+), 80 deletions(-)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 6cf4fcb866..45b359c2ba 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -129,53 +129,6 @@ $QEMU_IO -c "read -P 0x44 1023k    1k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil
 $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
 
-echo
-echo "=== Corrupted size field in compressed cluster descriptor ==="
-echo
-# Create an empty image and fill half of it with compressed data.
-# The L2 entries of the two compressed clusters are located at
-# 0x800000 and 0x800008, their original values are 0x4008000000a00000
-# and 0x4008000000a00802 (5 sectors for compressed data each).
-_make_test_img 8M -o cluster_size=2M
-$QEMU_IO -c "write -c -P 0x11 0 2M" -c "write -c -P 0x11 2M 2M" "$TEST_IMG" \
-         2>&1 | _filter_qemu_io | _filter_testdir
-
-# Reduce size of compressed data to 4 sectors: this corrupts the image.
-poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
-$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-
-# 'qemu-img check' however doesn't see anything wrong because it
-# doesn't try to decompress the data and the refcounts are consistent.
-# TODO: update qemu-img so this can be detected.
-_check_test_img
-
-# Increase size of compressed data to the maximum (8192 sectors).
-# This makes QEMU read more data (8192 sectors instead of 5, host
-# addresses [0xa00000, 0xdfffff]), but the decompression algorithm
-# stops once we have enough to restore the uncompressed cluster, so
-# the rest of the data is ignored.
-poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
-# Do it also for the second compressed cluster (L2 entry at 0x800008).
-# In this case the compressed data would span 3 host clusters
-# (host addresses: [0xa00802, 0xe00801])
-poke_file "$TEST_IMG" $((0x800008)) "\x7f\xfe"
-
-# Here the image is too small so we're asking QEMU to read beyond the
-# end of the image.
-$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-# But if we grow the image we won't be reading beyond its end anymore.
-$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-
-# The refcount data is however wrong because due to the increased size
-# of the compressed data it now reaches the following host clusters.
-# This can be repaired by qemu-img check by increasing the refcount of
-# those clusters.
-# TODO: update qemu-img to correct the compressed cluster size instead.
-_check_test_img -r all
-$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
-
 echo
 echo "=== Full allocation with -S 0 ==="
 echo
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index a6b7fe007e..47d8656db8 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -99,39 +99,6 @@ read 1024/1024 bytes at offset 1047552
 read 1046528/1046528 bytes at offset 1048576
 1022 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
-=== Corrupted size field in compressed cluster descriptor ===
-
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
-wrote 2097152/2097152 bytes at offset 0
-2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 2097152/2097152 bytes at offset 2097152
-2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read failed: Input/output error
-No errors were found on the image.
-read 4194304/4194304 bytes at offset 0
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4194304/4194304 bytes at offset 4194304
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4194304/4194304 bytes at offset 0
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-ERROR cluster 6 refcount=1 reference=3
-ERROR cluster 7 refcount=1 reference=2
-Repairing cluster 6 refcount=1 reference=3
-Repairing cluster 7 refcount=1 reference=2
-Repairing OFLAG_COPIED data cluster: l2_entry=8000000000c00000 refcount=3
-Repairing OFLAG_COPIED data cluster: l2_entry=8000000000e00000 refcount=2
-The following inconsistencies were found and repaired:
-
-    0 leaked clusters
-    4 corruptions
-
-Double checking the fixed image now...
-No errors were found on the image.
-read 4194304/4194304 bytes at offset 0
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4194304/4194304 bytes at offset 4194304
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
 === Full allocation with -S 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
new file mode 100755
index 0000000000..3545855fdd
--- /dev/null
+++ b/tests/qemu-iotests/214
@@ -0,0 +1,96 @@
+#!/bin/bash
+#
+# Test qcow2 image compression
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
+seq=$(basename "$0")
+echo "QA output created by $seq"
+
+here=$PWD
+status=1	# failure is the default!
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
+# Repairing the corrupted image requires qemu-img check to store a
+# refcount up to 3, which requires at least two refcount bits.
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
+
+
+echo
+echo "=== Corrupted size field in compressed cluster descriptor ==="
+echo
+# Create an empty image and fill half of it with compressed data.
+# The L2 entries of the two compressed clusters are located at
+# 0x800000 and 0x800008, their original values are 0x4008000000a00000
+# and 0x4008000000a00802 (5 sectors for compressed data each).
+_make_test_img 8M -o cluster_size=2M
+$QEMU_IO -c "write -c -P 0x11 0 2M" -c "write -c -P 0x11 2M 2M" "$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+
+# Reduce size of compressed data to 4 sectors: this corrupts the image.
+poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
+$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+# 'qemu-img check' however doesn't see anything wrong because it
+# doesn't try to decompress the data and the refcounts are consistent.
+# TODO: update qemu-img so this can be detected.
+_check_test_img
+
+# Increase size of compressed data to the maximum (8192 sectors).
+# This makes QEMU read more data (8192 sectors instead of 5, host
+# addresses [0xa00000, 0xdfffff]), but the decompression algorithm
+# stops once we have enough to restore the uncompressed cluster, so
+# the rest of the data is ignored.
+poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
+# Do it also for the second compressed cluster (L2 entry at 0x800008).
+# In this case the compressed data would span 3 host clusters
+# (host addresses: [0xa00802, 0xe00801])
+poke_file "$TEST_IMG" $((0x800008)) "\x7f\xfe"
+
+# Here the image is too small so we're asking QEMU to read beyond the
+# end of the image.
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+# But if we grow the image we won't be reading beyond its end anymore.
+$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+# The refcount data is however wrong because due to the increased size
+# of the compressed data it now reaches the following host clusters.
+# This can be repaired by qemu-img check by increasing the refcount of
+# those clusters.
+# TODO: update qemu-img to correct the compressed cluster size instead.
+_check_test_img -r all
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
new file mode 100644
index 0000000000..0fcd8dc051
--- /dev/null
+++ b/tests/qemu-iotests/214.out
@@ -0,0 +1,35 @@
+QA output created by 214
+
+=== Corrupted size field in compressed cluster descriptor ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=8388608
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Input/output error
+No errors were found on the image.
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4194304/4194304 bytes at offset 4194304
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR cluster 6 refcount=1 reference=3
+ERROR cluster 7 refcount=1 reference=2
+Repairing cluster 6 refcount=1 reference=3
+Repairing cluster 7 refcount=1 reference=2
+Repairing OFLAG_COPIED data cluster: l2_entry=8000000000c00000 refcount=3
+Repairing OFLAG_COPIED data cluster: l2_entry=8000000000e00000 refcount=2
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    4 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 4194304
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 52a80f3f9e..3e2dcdfa33 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -212,3 +212,4 @@
 211 rw auto quick
 212 rw auto quick
 213 rw auto quick
+214 rw auto
-- 
2.14.3
