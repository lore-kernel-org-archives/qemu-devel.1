Received: from eggs.gnu.org ([2001:4830:134:3::10]:47455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmz-0002p1-5O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmu-0007cZ-CI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:29 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:14 +0200
Message-Id: <20170711160814.20941-86-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 85/85] iotests: Add preallocated growth test for
 qcow2
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
Message-id: 20170613202107.10125-17-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/125     | 130 +++++++++++++++
 tests/qemu-iotests/125.out | 386 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 517 insertions(+)
 create mode 100755 tests/qemu-iotests/125
 create mode 100644 tests/qemu-iotests/125.out

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
new file mode 100755
index 0000000..9424313
--- /dev/null
+++ b/tests/qemu-iotests/125
@@ -0,0 +1,130 @@
+#!/bin/bash
+#
+# Test preallocated growth of qcow2 images
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
+get_image_size_on_host()
+{
+    $QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep "disk size" \
+        | sed -e 's/^[^0-9]*\([0-9]\+\).*$/\1/'
+}
+
+# get standard environment and filters
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+if [ -z "$TEST_IMG_FILE" ]; then
+    TEST_IMG_FILE=$TEST_IMG
+fi
+
+# Generally, we create some image with or without existing preallocation and
+# then resize it. Then we write some data into the image and verify that its
+# size does not change if we have used preallocation.
+
+# With a cluster size of 512 B, one L2 table covers 64 * 512 B = 32 kB.
+# One cluster of the L1 table covers 64 * 32 kB = 2 MB.
+# There are multiple cases we want to test:
+# (1) Grow an image without having to allocate a new L2 table.
+# (2) Grow an image, having to allocate a new L2 table.
+# (3) Grow an image, having to grow the L1 table.
+# Therefore, we create an image that is 48 kB below 2 MB. Then:
+# (1) We resize it to 2 MB - 32 kB. (+ 16 kB)
+# (2) We resize it to 2 MB.         (+ 48 kB)
+# (3) We resize it to 2 MB + 32 kB. (+ 80 kB)
+
+# in B
+CREATION_SIZE=$((2 * 1024 * 1024 - 48 * 1024))
+
+# in kB
+for GROWTH_SIZE in 16 48 80; do
+    for create_mode in off metadata falloc full; do
+        for growth_mode in off metadata falloc full; do
+            echo "--- growth_size=$GROWTH_SIZE create_mode=$create_mode growth_mode=$growth_mode ---"
+
+            IMGOPTS="preallocation=$create_mode,cluster_size=512" _make_test_img ${CREATION_SIZE}
+            $QEMU_IMG resize -f "$IMGFMT" --preallocation=$growth_mode "$TEST_IMG" +${GROWTH_SIZE}K
+
+            host_size_0=$(get_image_size_on_host)
+            file_length_0=$(stat -c '%s' "$TEST_IMG_FILE")
+
+            $QEMU_IO -c "write 0 $CREATION_SIZE" "$TEST_IMG" | _filter_qemu_io
+
+            host_size_1=$(get_image_size_on_host)
+            file_length_1=$(stat -c '%s' "$TEST_IMG_FILE")
+
+            $QEMU_IO -c "write $CREATION_SIZE ${GROWTH_SIZE}K" "$TEST_IMG" | _filter_qemu_io
+
+            host_size_2=$(get_image_size_on_host)
+            file_length_2=$(stat -c '%s' "$TEST_IMG_FILE")
+
+            # Test creation preallocation: Compare #0 against #1
+            if [ $create_mode != off ]; then
+                # The image length should not have grown
+                if [ $file_length_1 -gt $file_length_0 ]; then
+                    echo "ERROR (create): Image length has grown from $file_length_0 to $file_length_1"
+                fi
+                if [ $create_mode != metadata ]; then
+                    # The host size should not have grown either
+                    if [ $host_size_1 -gt $host_size_0 ]; then
+                        echo "ERROR (create): Host size has grown from $host_size_0 to $host_size_1"
+                    fi
+                fi
+            fi
+
+            # Test resize preallocation: Compare #2 against #1
+            if [ $growth_mode != off ]; then
+                # The image length should not have grown
+                if [ $file_length_2 -gt $file_length_1 ]; then
+                    echo "ERROR (grow): Image length has grown from $file_length_1 to $file_length_2"
+                fi
+                if [ $create_mode != metadata ]; then
+                    # The host size should not have grown either
+                    if [ $host_size_2 -gt $host_size_1 ]; then
+                        echo "ERROR (grow): Host size has grown from $host_size_1 to $host_size_2"
+                    fi
+                fi
+            fi
+
+            echo
+        done
+    done
+done
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
new file mode 100644
index 0000000..3f4d6e3
--- /dev/null
+++ b/tests/qemu-iotests/125.out
@@ -0,0 +1,386 @@
+QA output created by 125
+--- growth_size=16 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=16 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 16384/16384 bytes at offset 2048000
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=48 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 49152/49152 bytes at offset 2048000
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=off growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=off growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=off growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=off growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=off
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=metadata growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=metadata growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=metadata growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=metadata growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=metadata
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=falloc growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=falloc growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=falloc growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=falloc growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=falloc
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=full growth_mode=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=full growth_mode=metadata ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=full growth_mode=falloc ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- growth_size=80 create_mode=full growth_mode=full ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2048000 preallocation=full
+Image resized.
+wrote 2048000/2048000 bytes at offset 0
+1.953 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 81920/81920 bytes at offset 2048000
+80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index de14091..2aba585 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -131,6 +131,7 @@
 122 rw auto
 123 rw auto quick
 124 rw auto backing
+125 rw auto
 126 rw auto backing
 128 rw auto quick
 129 rw auto quick
-- 
2.9.4
