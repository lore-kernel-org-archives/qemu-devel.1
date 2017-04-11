Received: from eggs.gnu.org ([2001:4830:134:3::10]:46485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR9-0005J8-8P
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR6-0005rZ-P4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:10 -0500
Message-Id: <20170411011718.9152-6-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-1-eblake@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 05/13] qcow2: Optimize write zero of
 unaligned tail cluster
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

We've already improved discards to operate efficiently on the tail
of an unaligned qcow2 image; it's time to make a similar improvement
to write zeroes.  The special case is only valid at the tail
cluster of a file, where we must recognize that any sectors beyond
the image end would implicitly read as zero, and therefore should
not penalize our logic for widening a partial cluster into writing
the whole cluster as zero.

Update test 154 to cover the new scenarios, using two images of
intentionally differing length.

While at it, fix the test to gracefully skip when run as
./check -qcow2 -o compat=0.10 154
since the older format lacks zero clusters already required earlier
in the test.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c              |   7 +++
 tests/qemu-iotests/154     | 111 ++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/154.out |  82 +++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5c1573c..8038793 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2449,6 +2449,10 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     BlockDriverState *file;
     int64_t res;

+    if (start + count > bs->total_sectors) {
+        count = bs->total_sectors - start;
+    }
+
     if (!count) {
         return true;
     }
@@ -2467,6 +2471,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     uint32_t tail = (offset + count) % s->cluster_size;

     trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, count);
+    if (offset + count == bs->total_sectors * BDRV_SECTOR_SIZE) {
+        tail = 0;
+    }

     if (head || tail) {
         int64_t cl_start = (offset - head) >> BDRV_SECTOR_BITS;
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 7ca7219..66128f5 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -2,7 +2,7 @@
 #
 # qcow2 specific bdrv_pwrite_zeroes tests with backing files (complements 034)
 #
-# Copyright (C) 2016 Red Hat, Inc.
+# Copyright (C) 2016-2017 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -42,7 +42,10 @@ _supported_proto file
 _supported_os Linux

 CLUSTER_SIZE=4k
-size=128M
+size=$((128 * 1024 * 1024))
+
+# This test requires zero clusters, added in v3 images
+_unsupported_imgopts compat=0.10

 echo
 echo == backing file contains zeros ==
@@ -299,6 +302,110 @@ $QEMU_IO -c "read -P 0 75k 1k" "$TEST_IMG" | _filter_qemu_io

 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map

+echo
+echo == unaligned image tail cluster, no allocation needed ==
+
+CLUSTER_SIZE=1024 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+
+# With no backing file, write to all or part of unallocated partial cluster
+
+# Backing file: 128m: ... | 00 --
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
+
+# Backing file: 128m: ... | -- 00
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
+
+# Backing file: 128m: ... | 00 00
+$QEMU_IO -c "write -z $size 1024" "$TEST_IMG.base" | _filter_qemu_io
+
+# No offset should be allocated, although the cluster itself is considered
+# allocated due to the zero flag
+$QEMU_IO -c "alloc $size 1024" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+# With backing file that reads as zero, write to all or part of entire cluster
+
+# Backing file: 128m: ... | 00 00
+# Active layer: 128m: ... | 00 00 00 00
+$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Backing file: 128m: ... | 00 00
+# Active layer: 128m: ... | 00 00 -- --
+$QEMU_IO -c "write -z $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
+
+# Backing file: 128m: ... | 00 00
+# Active layer: 128m: ... | -- -- 00 00
+$QEMU_IO -c "write -z $((size + 1024)) 1024" "$TEST_IMG" | _filter_qemu_io
+
+# Backing file: 128m: ... | 00 00
+# Active layer: 128m: ... | -- 00 00 --
+$QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
+
+# No offset should be allocated, although the cluster itself is considered
+# allocated due to the zero flag
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Preallocated cluster is not freed when unmap is not requested
+
+# Backing file: 128m: ... | XX -- => ... | XX 00
+$QEMU_IO -c "write $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
+
+# Backing file: 128m: ... | XX 00 => ... | 00 00
+$QEMU_IO -c "write -z $((size)) 1024" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG.base" | _filter_qemu_img_map
+
+echo
+echo == unaligned image tail cluster, allocation required ==
+
+CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+
+# Write beyond backing file must COW
+# Backing file: 128m: ... | XX --
+# Active layer: 128m: ... | -- -- 00 --
+
+$QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 512)) 1536" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+
+# Writes at boundaries of (partial) cluster must not lose mid-cluster data
+# Backing file: 128m: ... | -- XX
+# Active layer: 128m: ... | 00 -- -- 00
+
+$QEMU_IO -c "write -P 1 $((size + 512)) 512" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+
+# Partial write must not lose data
+# Backing file: 128m: ... | -- --
+# Active layer: 128m: ... | -- -- XX 00
+
+$QEMU_IO -c "write -P 1 $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index da9eabd..d6e76f4 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -282,4 +282,86 @@ read 1024/1024 bytes at offset 76800
 { "start": 69632, "length": 4096, "depth": 0, "zero": true, "data": false},
 { "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": 24576},
 { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data": false}]
+
+== unaligned image tail cluster, no allocation needed ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+1024/1024 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134218752, "depth": 0, "zero": true, "data": false}]
+wrote 2048/2048 bytes at offset 134217728
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+wrote 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 134218752
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 134218240
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134218752, "depth": 0, "zero": true, "data": false}]
+
+== unaligned image tail cluster, allocation required ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134218752
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1536/1536 bytes at offset 134218240
+1.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": 20480}]
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 134218752
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 134218752
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": 20480}]
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134218752
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134218752
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": 20480}]
 *** done
-- 
2.9.3
