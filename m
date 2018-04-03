Received: from eggs.gnu.org ([2001:4830:134:3::10]:55436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot7-0006tN-9s
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot5-0006e0-P3
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:34:00 +0200
Message-Id: <20180403163400.6307-10-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] iotests: Test abnormally large size in
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

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

This test creates an image with two compressed clusters that use 5
sectors (2.5 KB) each, increases the size field to the maximum (8192
sectors, or 4 MB) and verifies that the data can be read without
problems.

This test is important because while the decompressed data takes
exactly one cluster, the maximum value allowed in the compressed size
field is twice the cluster size. So although QEMU won't produce images
with such large values we need to make sure that it can handle them.

Another effect of increasing the size field is that it can make
it include data from the following host cluster(s). In this case
'qemu-img check' will detect that the refcounts are not correct, and
we'll need to rebuild them.

Additionally, this patch also tests that decreasing the size corrupts
the image since the original data can no longer be recovered. In this
case QEMU returns an error when trying to read the compressed data,
but 'qemu-img check' doesn't see anything wrong if the refcounts are
consistent.

One possible task for the future is to make 'qemu-img check' verify
the sizes of the compressed clusters, by trying to decompress the data
and checking that the size stored in the L2 entry is correct.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180329120745.11154-1-berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c2ba..6cf4fcb866 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -130,6 +130,53 @@ $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fil
 
 
 echo
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
+echo
 echo "=== Full allocation with -S 0 ==="
 echo
 
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 47d8656db8..a6b7fe007e 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -99,6 +99,39 @@ read 1024/1024 bytes at offset 1047552
 read 1046528/1046528 bytes at offset 1048576
 1022 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
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
+
 === Full allocation with -S 0 ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.13.6
