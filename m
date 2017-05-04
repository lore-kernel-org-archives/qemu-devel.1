Received: from eggs.gnu.org ([2001:4830:134:3::10]:52637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677q-000365-61
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677n-0001LX-NN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 May 2017 22:07:52 -0500
Message-Id: <20170504030755.1001-8-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
References: <20170504030755.1001-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v12 07/10] iotests: Add test 179 to cover write
 zeroes with unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

No tests were covering write zeroes with unmap.  Additionally,
I needed to prove that my previous patches for correct status
reporting and write zeroes optimizations actually had an impact.

The test works for cluster_size between 8k and 2M (for smaller
sizes, it fails because our allocation patterns are not contiguous
with small clusters - in part, the largest consecutive allocation
we tend to get is often bounded by the size covered by one L2
table).

Note that testing for zero clusters is tricky: 'qemu-io map'
reports whether data comes from the current layer of the image
(useful for sniffing out which regions of the file have
QCOW_OFLAG_ZERO) - but doesn't show which clusters have mappings;
while 'qemu-img map' sees "zero":true for both unallocated and
zero clusters for any qcow2 with no backing layer (so less useful
at detecting true zero clusters), but reliably shows mappings.
So we have to rely on both queries side-by-side at each point of
the test.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v12: probe the map in more places, to make test easier to follow
v11: reserved for blkdebug half of v10
v10: drop any changes to v2 files, rewrite test to work with updates
earlier in the series, add a blkdebug probe
v9: new patch
---
 tests/qemu-iotests/179     | 132 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/179.out | 160 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 293 insertions(+)
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
new file mode 100755
index 0000000..124666f
--- /dev/null
+++ b/tests/qemu-iotests/179
@@ -0,0 +1,132 @@
+#!/bin/bash
+#
+# Test case for write zeroes with unmap
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+here="$PWD"
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
+_supported_os Linux
+
+# v2 images can't mark clusters as zero
+_unsupported_imgopts compat=0.10
+
+echo
+echo '=== Testing write zeroes with unmap ==='
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 64M
+_make_test_img -b "$TEST_IMG.base"
+
+# Offsets chosen at or near 2M boundaries so test works at any cluster size
+
+# Aligned writes to unallocated cluster should not allocate mapping, but must
+# mark cluster as zero, whether or not unmap was requested
+$QEMU_IO -c "write -z -u 2M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z 6M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# Unaligned writes need not allocate mapping if the cluster already reads
+# as zero, but must mark cluster as zero, whether or not unmap was requested
+$QEMU_IO -c "write -z -u 10485761 2097150" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z 14680065 2097150" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# Requesting unmap of normal data must deallocate; omitting unmap should
+# preserve the mapping
+$QEMU_IO -c "write 18M 14M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 20M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z 24M 6M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# Likewise when writing on already-mapped zero data
+$QEMU_IO -c "write -z -u 26M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z 28M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# Writing on unmapped zeroes does not allocate
+$QEMU_IO -c "write -z 32M 8M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 34M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z 36M 2M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# Writing zero overrides a backing file, regardless of backing cluster type
+$QEMU_IO -c "write -z 40M 8M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write 48M 8M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 42M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z 44M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 50M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z 52M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 58M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z 60M 2M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "map" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Final check that mappings are correct and images are still sane
+TEST_IMG="$TEST_IMG.base" _check_test_img
+_check_test_img
+
+echo
+echo '=== Testing cache optimization ==='
+echo
+
+BLKDBG_TEST_IMG="blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG.base"
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "l2_update"
+errno = "5"
+immediately = "on"
+once = "off"
+EOF
+
+# None of the following writes should trigger an L2 update, because the
+# cluster already reads as zero, and we don't have to change allocation
+$QEMU_IO -c "w -z -u 20M 2M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "w -z 20M 2M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "w -z 28M 2M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+
+# Proof that our blkdebug hook works
+$QEMU_IO -c "w -z -u 0M 2M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+
+# success, all done
+echo '*** done'
+status=0
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
new file mode 100644
index 0000000..d66b24e
--- /dev/null
+++ b/tests/qemu-iotests/179.out
@@ -0,0 +1,160 @@
+QA output created by 179
+
+=== Testing write zeroes with unmap ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 2097152/2097152 bytes at offset 2097152
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 6291456
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2 MiB (0x200000) bytes not allocated at offset 0 bytes (0x0)
+2 MiB (0x200000) bytes     allocated at offset 2 MiB (0x200000)
+2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
+2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
+56 MiB (0x3800000) bytes not allocated at offset 8 MiB (0x800000)
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
+wrote 2097150/2097150 bytes at offset 10485761
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097150/2097150 bytes at offset 14680065
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2 MiB (0x200000) bytes not allocated at offset 0 bytes (0x0)
+2 MiB (0x200000) bytes     allocated at offset 2 MiB (0x200000)
+2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
+2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
+2 MiB (0x200000) bytes not allocated at offset 8 MiB (0x800000)
+2 MiB (0x200000) bytes     allocated at offset 10 MiB (0xa00000)
+2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
+2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
+48 MiB (0x3000000) bytes not allocated at offset 16 MiB (0x1000000)
+[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": false}]
+wrote 14680064/14680064 bytes at offset 18874368
+14 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 20971520
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 6291456/6291456 bytes at offset 25165824
+6 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2 MiB (0x200000) bytes not allocated at offset 0 bytes (0x0)
+2 MiB (0x200000) bytes     allocated at offset 2 MiB (0x200000)
+2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
+2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
+2 MiB (0x200000) bytes not allocated at offset 8 MiB (0x800000)
+2 MiB (0x200000) bytes     allocated at offset 10 MiB (0xa00000)
+2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
+2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
+2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
+14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
+32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
+[{ "start": 0, "length": 18874368, "depth": 0, "zero": true, "data": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": true, "data": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 25165824, "length": 6291456, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 33554432, "length": 33554432, "depth": 0, "zero": true, "data": false}]
+wrote 2097152/2097152 bytes at offset 27262976
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 29360128
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2 MiB (0x200000) bytes not allocated at offset 0 bytes (0x0)
+2 MiB (0x200000) bytes     allocated at offset 2 MiB (0x200000)
+2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
+2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
+2 MiB (0x200000) bytes not allocated at offset 8 MiB (0x800000)
+2 MiB (0x200000) bytes     allocated at offset 10 MiB (0xa00000)
+2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
+2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
+2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
+14 MiB (0xe00000) bytes     allocated at offset 18 MiB (0x1200000)
+32 MiB (0x2000000) bytes not allocated at offset 32 MiB (0x2000000)
+[{ "start": 0, "length": 18874368, "depth": 0, "zero": true, "data": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": true, "data": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": true, "data": false},
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 33554432, "length": 33554432, "depth": 0, "zero": true, "data": false}]
+wrote 8388608/8388608 bytes at offset 33554432
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 35651584
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 37748736
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2 MiB (0x200000) bytes not allocated at offset 0 bytes (0x0)
+2 MiB (0x200000) bytes     allocated at offset 2 MiB (0x200000)
+2 MiB (0x200000) bytes not allocated at offset 4 MiB (0x400000)
+2 MiB (0x200000) bytes     allocated at offset 6 MiB (0x600000)
+2 MiB (0x200000) bytes not allocated at offset 8 MiB (0x800000)
+2 MiB (0x200000) bytes     allocated at offset 10 MiB (0xa00000)
+2 MiB (0x200000) bytes not allocated at offset 12 MiB (0xc00000)
+2 MiB (0x200000) bytes     allocated at offset 14 MiB (0xe00000)
+2 MiB (0x200000) bytes not allocated at offset 16 MiB (0x1000000)
+22 MiB (0x1600000) bytes     allocated at offset 18 MiB (0x1200000)
+24 MiB (0x1800000) bytes not allocated at offset 40 MiB (0x2800000)
+[{ "start": 0, "length": 18874368, "depth": 0, "zero": true, "data": false},
+{ "start": 18874368, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 0, "zero": true, "data": false},
+{ "start": 23068672, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 0, "zero": true, "data": false},
+{ "start": 29360128, "length": 2097152, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 33554432, "length": 33554432, "depth": 0, "zero": true, "data": false}]
+wrote 8388608/8388608 bytes at offset 41943040
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8388608/8388608 bytes at offset 50331648
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 44040192
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 46137344
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 52428800
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 54525952
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 60817408
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 62914560
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+42 MiB (0x2a00000) bytes not allocated at offset 0 bytes (0x0)
+4 MiB (0x400000) bytes     allocated at offset 42 MiB (0x2a00000)
+4 MiB (0x400000) bytes not allocated at offset 46 MiB (0x2e00000)
+4 MiB (0x400000) bytes     allocated at offset 50 MiB (0x3200000)
+4 MiB (0x400000) bytes not allocated at offset 54 MiB (0x3600000)
+4 MiB (0x400000) bytes     allocated at offset 58 MiB (0x3a00000)
+2 MiB (0x200000) bytes not allocated at offset 62 MiB (0x3e00000)
+[{ "start": 0, "length": 18874368, "depth": 1, "zero": true, "data": false},
+{ "start": 18874368, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 20971520, "length": 2097152, "depth": 1, "zero": true, "data": false},
+{ "start": 23068672, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 25165824, "length": 2097152, "depth": 1, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 27262976, "length": 2097152, "depth": 1, "zero": true, "data": false},
+{ "start": 29360128, "length": 2097152, "depth": 1, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 31457280, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 33554432, "length": 10485760, "depth": 1, "zero": true, "data": false},
+{ "start": 44040192, "length": 4194304, "depth": 0, "zero": true, "data": false},
+{ "start": 48234496, "length": 2097152, "depth": 1, "zero": true, "data": false},
+{ "start": 50331648, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 52428800, "length": 4194304, "depth": 0, "zero": true, "data": false},
+{ "start": 56623104, "length": 2097152, "depth": 1, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 58720256, "length": 2097152, "depth": 1, "zero": true, "data": false},
+{ "start": 60817408, "length": 4194304, "depth": 0, "zero": true, "data": false},
+{ "start": 65011712, "length": 2097152, "depth": 1, "zero": true, "data": false}]
+No errors were found on the image.
+No errors were found on the image.
+
+=== Testing cache optimization ===
+
+wrote 2097152/2097152 bytes at offset 20971520
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 20971520
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 29360128
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Failed to flush the L2 table cache: Input/output error
+Failed to flush the refcount block cache: Input/output error
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 9b9bb4c..395c72a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -170,4 +170,5 @@
 175 auto quick
 176 rw auto backing
 177 rw auto quick
+179 rw auto quick
 181 rw auto migration
-- 
2.9.3
