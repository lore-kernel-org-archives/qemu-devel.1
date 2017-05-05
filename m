Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Sm7-0002ov-6y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Sm5-00016y-M8
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:15:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 May 2017 21:15:00 -0500
Message-Id: <20170505021500.19315-3-eblake@redhat.com>
In-Reply-To: <20170505021500.19315-1-eblake@redhat.com>
References: <20170505021500.19315-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] block: Exploit BDRV_BLOCK_EOF for
 larger zero blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

When we have a BSD with unallocated clusters, but asking the status
of its underlying bs->file or backing layer encounters an end-of-file
condition, we know that the rest of the unallocated area will read as
zeroes.  However, pre-patch, this required two separate calls to
bdrv_get_block_status(), as the first call stops at the point where
the underlying file ends.  Thanks to BDRV_BLOCK_EOF, we can now widen
the results of the primary status if the secondary status already
includes BDRV_BLOCK_ZERO.

In turn, this fixes a TODO mentioned in iotest 154, where we can now
see that all sectors in a partial cluster at the end of a file read
as zero when coupling the shorter backing file's status along with our
knowledge that the remaining sectors came from an unallocated cluster.

Also, note that the loop in bdrv_co_get_block_status_above() had an
inefficent exit: in cases where the active layer sets BDRV_BLOCK_ZERO
but does NOT set BDRV_BLOCK_ALLOCATED (namely, where we know we read
zeroes merely because our unallocated clusters lie beyond the backing
file's shorter length), we still ended up probing the backing layer
even though we already had a good answer.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c                 | 27 ++++++++++++++++++++++-----
 tests/qemu-iotests/154     |  4 ----
 tests/qemu-iotests/154.out | 12 ++++++------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/block/io.c b/block/io.c
index a7bc8bd..0ec9c75 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1819,10 +1819,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
              */
-            if (!file_pnum) {
-                /* !file_pnum indicates an offset at or beyond the EOF; it is
-                 * perfectly valid for the format block driver to point to such
-                 * offsets, so catch it and mark everything as zero */
+            if (ret2 & BDRV_BLOCK_EOF &&
+                (!file_pnum || ret2 & BDRV_BLOCK_ZERO)) {
+                /*
+                 * It is valid for the format block driver to read
+                 * beyond the end of the underlying file's current
+                 * size; such areas read as zero.
+                 */
                 ret |= BDRV_BLOCK_ZERO;
             } else {
                 /* Limit request to the range reported by the protocol driver */
@@ -1849,16 +1852,30 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
 {
     BlockDriverState *p;
     int64_t ret = 0;
+    bool first = true;

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
         ret = bdrv_co_get_block_status(p, sector_num, nb_sectors, pnum, file);
-        if (ret < 0 || ret & BDRV_BLOCK_ALLOCATED) {
+        if (ret < 0) {
+            break;
+        }
+        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+            /*
+             * Reading beyond the end of the file continues to read
+             * zeroes, but we can only widen the result to the
+             * unallocated length we learned from an earlier
+             * iteration.
+             */
+            *pnum = nb_sectors;
+        }
+        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
             break;
         }
         /* [sector_num, pnum] unallocated on this layer, which could be only
          * the first part of [sector_num, nb_sectors].  */
         nb_sectors = MIN(nb_sectors, *pnum);
+        first = false;
     }
     return ret;
 }
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 687b8f3..d4dae83 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -334,8 +334,6 @@ $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map

 # Repeat with backing file holding unallocated cluster.
-# TODO: Note that this forces an allocation, because we aren't yet able to
-# quickly detect that reads beyond EOF of the backing file are always zero
 CLUSTER_SIZE=2048 TEST_IMG="$TEST_IMG.base" _make_test_img $((size + 1024))

 # Write at the front: sector-wise, the request is:
@@ -371,8 +369,6 @@ $QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map

 # Repeat with backing file holding zero'd cluster
-# TODO: Note that this forces an allocation, because we aren't yet able to
-# quickly detect that reads beyond EOF of the backing file are always zero
 $QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io

 # Write at the front: sector-wise, the request is:
diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
index b86f074..9e7abf2 100644
--- a/tests/qemu-iotests/154.out
+++ b/tests/qemu-iotests/154.out
@@ -310,19 +310,19 @@ wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -336,19 +336,19 @@ wrote 512/512 bytes at offset 134217728
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 512/512 bytes at offset 134219264
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 1024/1024 bytes at offset 134218240
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 2048/2048 bytes allocated at offset 128 MiB
 [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
-{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 2048/2048 bytes at offset 134217728
 2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.9.3
