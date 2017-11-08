Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPEc-0004Kf-6e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPEY-0007F2-Td
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:13:34 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  8 Nov 2017 14:13:06 +0200
Message-Id: <0b1b95340ecdfbc6927e36adf2fd42ae6198747a.1510143008.git.berto@igalia.com>
In-Reply-To: <cover.1510143008.git.berto@igalia.com>
References: <cover.1510143008.git.berto@igalia.com>
In-Reply-To: <cover.1510143008.git.berto@igalia.com>
References: <cover.1510143008.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/1] qcow2: Check that corrupted images can be
 repaired in iotest 060
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We just fixed a few bugs that caused QEMU to crash when trying to
write to corrupted qcow2 images, and iotest 060 was expanded to test
all those scenarios.

In almost all cases the corrupted images can be repaired using
qemu-img, so this patch verifies that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/060     | 10 ++++++++
 tests/qemu-iotests/060.out | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 66a8fa4aea..fae08b03bf 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -248,6 +248,8 @@ echo
 _make_test_img 64M
 poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+# Repair the image
+_check_test_img -r all
 
 echo
 echo "=== Testing empty refcount table with valid L1 and L2 tables ==="
@@ -259,6 +261,8 @@ poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 # allocation with an explicit offset (using qcow2_alloc_clusters_at())
 # causing a refcount block to be allocated at offset 0
 $QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
+# Repair the image
+_check_test_img -r all
 
 echo
 echo "=== Testing empty refcount block ==="
@@ -266,6 +270,8 @@ echo
 _make_test_img 64M
 poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
+# Repair the image
+_check_test_img -r all
 
 echo
 echo "=== Testing empty refcount block with compressed write ==="
@@ -276,6 +282,8 @@ poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 # The previous write already allocated an L2 table, so now this new
 # write will try to allocate a compressed data cluster at offset 0.
 $QEMU_IO -c "write -c 0k 64k" "$TEST_IMG" | _filter_qemu_io
+# Repair the image
+_check_test_img -r all
 
 echo
 echo "=== Testing zero refcount table size ==="
@@ -283,6 +291,8 @@ echo
 _make_test_img 64M
 poke_file "$TEST_IMG" "56"                "\x00\x00\x00\x00"
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+# Repair the image
+_check_test_img -r all
 
 echo
 echo "=== Testing incorrect refcount table offset ==="
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index cfd78f87a9..62c22701b8 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -187,6 +187,18 @@ read failed: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with refcount table); further corruption events will be suppressed
 write failed: Input/output error
+ERROR cluster 0 refcount=0 reference=1
+ERROR cluster 1 refcount=0 reference=1
+ERROR cluster 3 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    3 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Testing empty refcount table with valid L1 and L2 tables ===
 
@@ -195,12 +207,40 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of refcount block at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+ERROR cluster 0 refcount=0 reference=1
+ERROR cluster 1 refcount=0 reference=1
+ERROR cluster 3 refcount=0 reference=1
+ERROR cluster 4 refcount=0 reference=1
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    5 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Testing empty refcount block ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+ERROR cluster 0 refcount=0 reference=1
+ERROR cluster 1 refcount=0 reference=1
+ERROR cluster 2 refcount=0 reference=1
+ERROR cluster 3 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    4 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Testing empty refcount block with compressed write ===
 
@@ -209,11 +249,35 @@ wrote 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preventing invalid allocation of compressed cluster at offset 0; further corruption events will be suppressed
 write failed: Input/output error
+ERROR cluster 0 refcount=0 reference=1
+ERROR cluster 1 refcount=0 reference=1
+ERROR cluster 2 refcount=0 reference=1
+ERROR cluster 3 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    4 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Testing zero refcount table size ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.IMGFMT: Image does not contain a reference count table
+ERROR cluster 0 refcount=0 reference=1
+ERROR cluster 3 refcount=0 reference=1
+Rebuilding refcount structure
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Testing incorrect refcount table offset ===
 
-- 
2.11.0
