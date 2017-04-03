Received: from eggs.gnu.org ([2001:4830:134:3::10]:45968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv40N-0006do-UW
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv40L-0007Zl-Cb
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:55 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:54 +0200
Message-Id: <20170403153355.19722-15-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] iotests: Improve image-clear tests on
 non-aligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Eric Blake <eblake@redhat.com>

Tweak 097 and 176 to operate on an image that is not cluster-aligned,
to give further coverage of clearing out an entire image, including
the recent fix to eliminate the difference between fast path (97) and
slow (176) for qcow2.  Also tested on qcow (97 only, since qcow lacks
snapshots).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170331185356.2479-4-eblake@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/097     | 17 +++++++++-----
 tests/qemu-iotests/097.out | 55 ++++++++++++++++++++++++++++++++++++----------
 tests/qemu-iotests/176     | 17 +++++++++-----
 tests/qemu-iotests/176.out | 55 ++++++++++++++++++++++++++++++++++++----------
 4 files changed, 108 insertions(+), 36 deletions(-)

diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 1d28aff99d..e22670c8d0 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -66,13 +66,15 @@ echo
 echo "=== Test pass $i ==="
 echo
 
-TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
-_make_test_img -b "$TEST_IMG.itmd" 2100M
+len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
+TEST_IMG="$TEST_IMG.base" _make_test_img $len
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
+_make_test_img -b "$TEST_IMG.itmd" $len
 
-$QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
-$QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
-$QEMU_IO -c 'write -P 3 0x7fff0000 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 1 0x7ffd0000 192k" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -P 2 0x7ffe0000 128k" "$TEST_IMG.itmd" | _filter_qemu_io
+$QEMU_IO -c "write -P 3 0x7fff0000 64k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 4 $(($len - 512)) 512" "$TEST_IMG" | _filter_qemu_io
 
 if [ $i -lt 3 ]; then
     if [ $i == 0 ]; then
@@ -90,11 +92,13 @@ if [ $i -lt 3 ]; then
 
     # Bottom should be unchanged
     $QEMU_IO -c 'read -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c "read -P 0 $((len - 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
 
     # Intermediate should contain changes from top
     $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
     $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
     $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c "read -P 4 $((len - 512)) 512" "$TEST_IMG.itmd" | _filter_qemu_io
 
     # And in pass 0, the top image should be empty, whereas in both other passes
     # it should be unchanged (which is both checked by qemu-img map)
@@ -105,6 +109,7 @@ else
     $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.base" | _filter_qemu_io
     $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.base" | _filter_qemu_io
     $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c "read -P 4 $((len - 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
 
     # Both top and intermediate should be unchanged
 fi
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index 81fc2252a0..f6705a1cc7 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -2,104 +2,130 @@ QA output created by 097
 
 === Test pass 0 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 
 === Test pass 1 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 
 === Test pass 2 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 
 === Test pass 3 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -107,13 +133,18 @@ read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 *** done
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 9a70a8707c..950b28720e 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -69,14 +69,16 @@ echo
 echo "=== Test pass $i ==="
 echo
 
-TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
-_make_test_img -b "$TEST_IMG.itmd" 2100M
+len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
+TEST_IMG="$TEST_IMG.base" _make_test_img $len
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
+_make_test_img -b "$TEST_IMG.itmd" $len
 $QEMU_IMG snapshot -c snap "$TEST_IMG"
 
-$QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
-$QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
-$QEMU_IO -c 'write -P 3 0x7fff0000 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 1 0x7ffd0000 192k" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -P 2 0x7ffe0000 128k" "$TEST_IMG.itmd" | _filter_qemu_io
+$QEMU_IO -c "write -P 3 0x7fff0000 64k" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 4 $(($len - 512)) 512" "$TEST_IMG" | _filter_qemu_io
 
 if [ $i -lt 3 ]; then
     if [ $i == 0 ]; then
@@ -94,11 +96,13 @@ if [ $i -lt 3 ]; then
 
     # Bottom should be unchanged
     $QEMU_IO -c 'read -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c "read -P 0 $((len - 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
 
     # Intermediate should contain changes from top
     $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
     $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
     $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c "read -P 4 $((len - 512)) 512" "$TEST_IMG.itmd" | _filter_qemu_io
 
     # And in pass 0, the top image should be empty, whereas in both other passes
     # it should be unchanged (which is both checked by qemu-img map)
@@ -109,6 +113,7 @@ else
     $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.base" | _filter_qemu_io
     $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.base" | _filter_qemu_io
     $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c "read -P 4 $((len - 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
 
     # Both top and intermediate should be unchanged
 fi
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index fc6365309e..6271fa7d6f 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -2,104 +2,130 @@ QA output created by 176
 
 === Test pass 0 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 
 === Test pass 1 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 
 === Test pass 2 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 
 === Test pass 3 ===
 
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202010112
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202010112 backing_file=TEST_DIR/t.IMGFMT.itmd
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
 read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -107,13 +133,18 @@ read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 2202009600
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
 0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+0x83400000      0x200           TEST_DIR/t.IMGFMT.base
 Offset          Length          File
 0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
 0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+0x83400000      0x200           TEST_DIR/t.IMGFMT
 *** done
-- 
2.12.1
