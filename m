Received: from eggs.gnu.org ([2001:4830:134:3::10]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eotZw-0002YI-RT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eotZt-00086Z-Ku
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:18:40 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Feb 2018 18:18:11 +0200
Message-Id: <20180222161811.26200-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] iotests: Test abnormally large size in
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

L2 entries for compressed clusters have a field that indicates the
number of sectors used to store the data in the image.

That's however not the size of the compressed data itself, just the
number of sectors where that data is located. The actual data size is
usually not a multiple of the sector size, and therefore cannot be
represented with this field.

The way it works is that QEMU reads all the specified sectors and
starts decompressing the data until there's enough to recover the
original uncompressed cluster. If there are any bytes left that
haven't been decompressed they are simply ignored.

One consequence of this is that even if the size field is larger than
it needs to be QEMU can handle it just fine: it will read more data
from disk but it will ignore the extra bytes.

This test creates an image with a compressed cluster that uses 5
sectors (2.5 KB), increases the size field to the maximum (8192
sectors, or 4 MB) and verifies that the data can be read without
problems.

This test is important because while the decompressed data takes
exactly one cluster, the maximum value allowed in the compressed size
field is twice the cluster size. So although QEMU won't produce images
with such large values we need to make sure that it can handle them.

Aditionally, this patch also tests that decreasing the size corrupts
the image since the original data can no longer be recovered.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/122     | 22 ++++++++++++++++++++++
 tests/qemu-iotests/122.out |  9 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c2ba..32717e906e 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -130,6 +130,28 @@ $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil
 
 
 echo
+echo "=== Corrupted size field in compressed cluster descriptor ==="
+echo
+# Create an empty image, fill it with data and compress it
+# The L2 entry of the first compressed cluster is located at 0x800000
+# The original value is 0x4008000000a00000 (5 sectors for compressed data)
+_make_test_img 4M
+$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IMG convert -c -O qcow2 -o cluster_size=2M "$TEST_IMG" "$TEST_IMG".1
+
+# Reduce size of compressed data to 4 sectors: this corrupts the image
+poke_file "$TEST_IMG".1 $((0x800000)) "\x40\x06"
+$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Increase size of compressed data to the maximum (8192 sectors)
+# This makes QEMU read more data (8192 sectors instead of 5), but the
+# decompression algorithm stops once we have enough to restore the
+# uncompressed cluster, so the rest of the data is ignored
+poke_file "$TEST_IMG".1 $((0x800000)) "\x7f\xfe"
+$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
+
+
+echo
 echo "=== Full allocation with -S 0 ==="
 echo
 
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 47d8656db8..aba7325c55 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -99,6 +99,15 @@ read 1024/1024 bytes at offset 1047552
 read 1046528/1046528 bytes at offset 1048576
 1022 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Corrupted size field in compressed cluster descriptor ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Input/output error
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 === Full allocation with -S 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.11.0
