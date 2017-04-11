Received: from eggs.gnu.org ([2001:4830:134:3::10]:46416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR6-0005HI-AI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR4-0005px-E9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:07 -0500
Message-Id: <20170411011718.9152-3-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-1-eblake@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 02/13] iotests: Add test 179 to cover write
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
I wanted to prove that my patch to optimize write zeroes for
compat=0.10 images actually had an impact; for that, run:
./check -qcow2 -o compat=0.10 179

Writing the test to work correctly for both old and new qcow2
images is a bit tricky: 'qemu-img map' works for showing
whether a cluster is assigned an offset (in the preallocation
sense), but older images have to write literal zeroes where
newer images can set the zero flag.  Thankfully, 'qemu-io alloc'
hides the difference, by instead reporting whether a cluster's
content comes from the current layer (regardless of whether it
was due to a cluster allocation or a flag).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/179     | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/179.out | 22 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
new file mode 100755
index 0000000..338a45d
--- /dev/null
+++ b/tests/qemu-iotests/179
@@ -0,0 +1,78 @@
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
+echo
+echo '=== Testing write zeroes with unmap ==='
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 16M
+_make_test_img -b "$TEST_IMG.base"
+
+# Aligned writes should not allocate clusters, if unmap is requested
+# and there is no backing file.
+$QEMU_IO -c "write -z -u 1M 1M" "$TEST_IMG.base" | _filter_qemu_io
+
+# Unmap can even clear previously-allocated clusters.
+$QEMU_IO -c "write 3M 1M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z -u 3M 1M" "$TEST_IMG.base" | _filter_qemu_io
+
+# Up to now, the entire image should still be unallocated.
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# But not requesting unmap must result in allocation (whether a cluster
+# allocation in compat=0.10 or a flag allocation in compat=1.1).
+$QEMU_IO -c "write -z 5M 1M" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "alloc 5M $((1024*1024 / 512))" "$TEST_IMG.base" | _filter_qemu_io
+
+# Presence of a backing file overrides permission to unmap.  Again,
+# compat=0.10 images allocate, while compat=1.1 images set zero flag.
+$QEMU_IO -c "write -z -u 7M 1M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc 7M $((1024 * 1024 / 512))" "$TEST_IMG" | _filter_qemu_io
+
+# Final check that images are still sane.
+TEST_IMG="$TEST_IMG.base" _check_test_img
+_check_test_img
+
+# success, all done
+echo '*** done'
+status=0
diff --git a/tests/qemu-iotests/179.out b/tests/qemu-iotests/179.out
new file mode 100644
index 0000000..fc97b19
--- /dev/null
+++ b/tests/qemu-iotests/179.out
@@ -0,0 +1,22 @@
+QA output created by 179
+
+=== Testing write zeroes with unmap ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 16777216, "depth": 1, "zero": true, "data": false}]
+wrote 1048576/1048576 bytes at offset 5242880
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 sectors allocated at offset 5 MiB
+wrote 1048576/1048576 bytes at offset 7340032
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 sectors allocated at offset 7 MiB
+No errors were found on the image.
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 43142dd..cfc8823 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -169,3 +169,4 @@
 174 auto
 175 auto quick
 176 rw auto backing
+179 rw auto quick
-- 
2.9.3
