Received: from eggs.gnu.org ([2001:4830:134:3::10]:46512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkQ-0005h2-9R
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkO-0005uM-VH
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:42 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  7 Mar 2017 20:54:20 -0600
Message-Id: <20170308025428.1037-3-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-1-eblake@redhat.com>
References: <20170308025428.1037-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear tests on
 non-aligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Tweak 097 and 176 to operate on an image that is not cluster-aligned,
to give further coverage of clearing out an entire image.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: new patch
---
 tests/qemu-iotests/097     |  7 ++++---
 tests/qemu-iotests/097.out | 24 ++++++++++++------------
 tests/qemu-iotests/176     |  7 ++++---
 tests/qemu-iotests/176.out | 24 ++++++++++++------------
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 1d28aff..2e3a886 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -66,9 +66,10 @@ echo
 echo "=== Test pass $i ==="
 echo

-TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
-_make_test_img -b "$TEST_IMG.itmd" 2100M
+len=$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster aligned
+TEST_IMG="$TEST_IMG.base" _make_test_img $len
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" $len
+_make_test_img -b "$TEST_IMG.itmd" $len

 $QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
 $QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index 81fc225..30a64ba 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -2,9 +2,9 @@ QA output created by 097

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
@@ -31,9 +31,9 @@ Offset          Length          File

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
@@ -61,9 +61,9 @@ Offset          Length          File

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
@@ -91,9 +91,9 @@ Offset          Length          File

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
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 9a70a87..39fc6fb 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -69,9 +69,10 @@ echo
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

 $QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index fc63653..db27b31 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -2,9 +2,9 @@ QA output created by 176

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
@@ -31,9 +31,9 @@ Offset          Length          File

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
@@ -61,9 +61,9 @@ Offset          Length          File

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
@@ -91,9 +91,9 @@ Offset          Length          File

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
-- 
2.9.3
