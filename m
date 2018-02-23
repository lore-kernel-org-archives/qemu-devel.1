Received: from eggs.gnu.org ([2001:4830:134:3::10]:52903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1epCol-0007i6-Oc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1epCoh-000887-Qx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:51:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 23 Feb 2018 14:50:47 +0200
Message-Id: <20180223125047.343-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2] iotests: Test abnormally large size in
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

Another effect of increasing the size field is that it can make it
include data from the following host cluster. In this case 'qemu-img
check' will detect that the refcounts are not correct, and we'll need
to rebuild them.

Additionally, this patch also tests that decreasing the size corrupts
the image since the original data can no longer be recovered. In this
case QEMU returns an error when trying to read the compressed data,
but 'qemu-img check' doesn't see anything wrong if the refcounts are
consistent.

One possible task for the future is to make 'qemu-img check' verify
the sizes of the compressed clusters, by trying to decompress the data
and checking that the size stored in the L2 entry is correct.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---

v2: We now have two scenarios where we make QEMU read data from the
    next host cluster and from beyond the end of the image. This
    version also runs qemu-img check on the corrupted image.

    If the size field is too small, reading fails but qemu-img check
    succeeds.

    If the size field is too large, reading succeeds but qemu-img
    check fails (this can be repaired, though).    

---
 tests/qemu-iotests/122     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 28 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c2ba..fd5f43acc3 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -130,6 +130,44 @@ $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil
 
 
 echo
+echo "=== Corrupted size field in compressed cluster descriptor ==="
+echo
+# Create an empty image, fill half of it with data and compress it.
+# The L2 entry of the first compressed cluster is located at 0x800000.
+# The original value is 0x4008000000a00000 (5 sectors for compressed data).
+TEST_IMG="$TEST_IMG".1 _make_test_img 8M
+$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IMG convert -c -O qcow2 -o cluster_size=2M "$TEST_IMG".1 "$TEST_IMG"
+
+# Reduce size of compressed data to 4 sectors: this corrupts the image.
+poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
+$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+# 'qemu-img check' however doesn't see anything wrong because it
+# doesn't try to decompress the data and the refcounts are consistent.
+_check_test_img
+
+# Increase size of compressed data to the maximum (8192 sectors).
+# This makes QEMU read more data (8192 sectors instead of 5), but the
+# decompression algorithm stops once we have enough to restore the
+# uncompressed cluster, so the rest of the data is ignored.
+poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
+
+# Here the image is too small so we're asking QEMU to read beyond the
+# end of the image.
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+# But if we grow the image we won't be reading beyond its end anymore.
+$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+# The refcount data is however wrong because due to the increased size
+# of the compressed data it now reaches the following host cluster.
+# This can be repaired by qemu-img check.
+_check_test_img -r all
+$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo
 echo "=== Full allocation with -S 0 ==="
 echo
 
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 47d8656db8..a32e178c6a 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -99,6 +99,34 @@ read 1024/1024 bytes at offset 1047552
 read 1046528/1046528 bytes at offset 1048576
 1022 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+=== Corrupted size field in compressed cluster descriptor ===
+
+Formatting 'TEST_DIR/t.IMGFMT.1', fmt=IMGFMT size=8388608
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read failed: Input/output error
+No errors were found on the image.
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4194304/4194304 bytes at offset 4194304
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+ERROR cluster 6 refcount=1 reference=2
+Repairing cluster 6 refcount=1 reference=2
+Repairing OFLAG_COPIED data cluster: l2_entry=8000000000c00000 refcount=2
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    2 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4194304/4194304 bytes at offset 4194304
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 === Full allocation with -S 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.11.0
