Received: from eggs.gnu.org ([2001:4830:134:3::10]:38229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBf-0003ar-MK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBd-0000O0-1E
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:58 +0200
Message-Id: <1494513181-7900-56-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 55/58] qcow2: Optimize write zero of unaligned
 tail cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We've already improved discards to operate efficiently on the tail
of an unaligned qcow2 image; it's time to make a similar improvement
to write zeroes.  The special case is only valid at the tail
cluster of a file, where we must recognize that any sectors beyond
the image end would implicitly read as zero, and therefore should
not penalize our logic for widening a partial cluster into writing
the whole cluster as zero.

However, note that for now, the special case of end-of-file is only
recognized if there is no backing file, or if the backing file has
the same length; that's because when the backing file is shorter
than the active layer, we don't have code in place to recognize
that reads of a sector unallocated at the top and beyond the backing
end-of-file are implicitly zero.  It's not much of a real loss,
because most people don't use images that aren't cluster-aligned,
or where the active layer is a different size than the backing
layer (especially where the difference falls within a single cluster).

Update test 154 to cover the new scenarios, using two images of
intentionally differing length.

While at it, fix the test to gracefully skip when run as
./check -qcow2 -o compat=0.10 154
since the older format lacks zero clusters already required earlier
in the test.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-11-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              |   7 ++
 tests/qemu-iotests/154     | 160 ++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/154.out | 128 ++++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3fa62b0..72b1650 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2451,6 +2451,10 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     BlockDriverState *file;
     int64_t res;
 
+    if (start + count > bs->total_sectors) {
+        count = bs->total_sectors - start;
+    }
+
     if (!count) {
         return true;
     }
@@ -2469,6 +2473,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     uint32_t tail = (offset + count) % s->cluster_size;
 
     trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, count);
+    if (offset + count == bs->total_sectors * BDRV_SECTOR_SIZE) {
+        tail = 0;
+    }
 
     if (head || tail) {
         int64_t cl_start = (offset - head) >> BDRV_SECTOR_BITS;
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 7ca7219..dd8a426 100755
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
@@ -299,6 +302,159 @@ $QEMU_IO -c "read -P 0 75k 1k" "$TEST_IMG" | _filter_qemu_io
 
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 
+echo
+echo == unaligned image tail cluster, no allocation needed ==
+
+# With no backing file, write to all or part of unallocated partial cluster
+# will mark the cluster as zero, but does not allocate.
+# Re-create the image each time to get back to unallocated clusters.
+
+# Write at the front: sector-wise, the request is: 128m... | 00 -- -- --
+_make_test_img $((size + 2048))
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at the back: sector-wise, the request is: 128m... | -- -- -- 00
+_make_test_img $((size + 2048))
+$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at middle: sector-wise, the request is: 128m... | -- 00 00 --
+_make_test_img $((size + 2048))
+$QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write entire cluster: sector-wise, the request is: 128m... | 00 00 00 00
+_make_test_img $((size + 2048))
+$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Repeat with backing file holding unallocated cluster.
+# TODO: Note that this forces an allocation, because we aren't yet able to
+# quickly detect that reads beyond EOF of the backing file are always zero
+CLUSTER_SIZE=2048 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+
+# Write at the front: sector-wise, the request is:
+# backing: 128m... | -- --
+# active:  128m... | 00 -- -- --
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at the back: sector-wise, the request is:
+# backing: 128m... | -- --
+# active:  128m... | -- -- -- 00
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at middle: sector-wise, the request is:
+# backing: 128m... | -- --
+# active:  128m... | -- 00 00 --
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write entire cluster: sector-wise, the request is:
+# backing: 128m... | -- --
+# active:  128m... | 00 00 00 00
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Repeat with backing file holding zero'd cluster
+# TODO: Note that this forces an allocation, because we aren't yet able to
+# quickly detect that reads beyond EOF of the backing file are always zero
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
+
+# Write at the front: sector-wise, the request is:
+# backing: 128m... | 00 00
+# active:  128m... | 00 -- -- --
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $size 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at the back: sector-wise, the request is:
+# backing: 128m... | 00 00
+# active:  128m... | -- -- -- 00
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write at middle: sector-wise, the request is:
+# backing: 128m... | 00 00
+# active:  128m... | -- 00 00 --
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Write entire cluster: sector-wise, the request is:
+# backing: 128m... | 00 00
+# active:  128m... | 00 00 00 00
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# A preallocated cluster maintains its allocation, whether it stays as
+# data due to a partial write:
+# Convert 128m... | XX XX => ... | XX 00
+_make_test_img $((size + 1024))
+$QEMU_IO -c "write -P 1 $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 512)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 512)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# or because it is the entire cluster and can use the zero flag:
+# Convert 128m... | XX XX => ... | 00 00
+$QEMU_IO -c "write -z $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "alloc $size 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $size 1024" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+echo
+echo == unaligned image tail cluster, allocation required ==
+
+# Write beyond backing file must COW
+# Backing file: 128m... | XX --
+# Active layer: 128m... | -- -- 00 --
+CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
+$QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0 $((size + 512)) 1536" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+
+# Writes at boundaries of (partial) cluster must not lose mid-cluster data
+# Backing file: 128m: ... | -- XX
+# Active layer: 128m: ... | 00 -- -- 00
+CLUSTER_SIZE=512 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))
+_make_test_img -b "$TEST_IMG.base" $((size + 2048))
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
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index d3b68e7..d8485ee 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -282,4 +282,132 @@ read 1024/1024 bytes at offset 76800
 { "start": 69632, "length": 4096, "depth": 0, "zero": true, "data": false},
 { "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data": false}]
+
+== unaligned image tail cluster, no allocation needed ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
+wrote 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
+wrote 1024/1024 bytes at offset 134218240
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776
+wrote 2048/2048 bytes at offset 134217728
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134219776, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134218752
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 1024/1024 bytes at offset 134218240
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 2048/2048 bytes at offset 134217728
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 512/512 bytes at offset 134219264
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 1024/1024 bytes at offset 134218240
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
+wrote 2048/2048 bytes at offset 134217728
+2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+2048/2048 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134218752
+wrote 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134217728
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 134218240
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+1024/1024 bytes allocated at offset 128 MiB
+[{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": false},
+{ "start": 134217728, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+wrote 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+1024/1024 bytes allocated at offset 128 MiB
+read 1024/1024 bytes at offset 134217728
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": false},
+{ "start": 134217728, "length": 1024, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
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
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
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
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 *** done
-- 
1.8.3.1
