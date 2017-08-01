Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1O-0000Xm-Oi
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1L-0002XL-8z
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:42 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  1 Aug 2017 17:19:10 +0300
Message-Id: <1501597152-25342-14-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 13/15] qcow2: allocate image space by-cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

If COW areas of the newly allocated clusters are zeroes on the backing image:
(even if preallocation feature is not used or it cannot detect if the image
already reads as zeroes, e.g. writing to a hole / preallocated zero cluster)
efficient bdrv_write_zeroes(flags=BDRV_REQ_ALLOCATE) can be used on the whole
cluster instead of writing explicit zero buffers later in perform_cow().

iotest 060:
write to the discarded cluster does not trigger COW anymore.
so, break on write_aio event instead, will work for the test
(but write won't fail anymore, so update reference output)

iotest 066:
cluster-alignment areas that were not really COWed are now detected
as zeroes, hence the initial write has to be exactly the same size for
the maps to match

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.c              | 22 +++++++++++++++++-----
 tests/qemu-iotests/060     |  2 +-
 tests/qemu-iotests/060.out |  3 ++-
 tests/qemu-iotests/066     |  2 +-
 tests/qemu-iotests/066.out |  4 ++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e49ad50..9c49d40 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2039,13 +2039,25 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     QCowL2Meta *m;
 
     for (m = l2meta; m != NULL; m = m->next) {
-        if (s->prealloc_size && handle_prealloc(bs, m)) {
-            if (check_zero_cow(bs, m)) {
-                trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset,
-                                     m->nb_clusters);
-                m->zero_cow = true;
+        bool preallocated_zeroes = s->prealloc_size && handle_prealloc(bs, m);
+
+        if (!check_zero_cow(bs, m)) {
+            continue;
+        }
+
+        if (!preallocated_zeroes &&
+            (m->cow_start.nb_bytes != 0 || m->cow_end.nb_bytes != 0))
+        {
+            if (bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
+                                      m->nb_clusters * s->cluster_size,
+                                      BDRV_REQ_ALLOCATE) != 0)
+            {
+                continue;
             }
         }
+
+        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clusters);
+        m->zero_cow = true;
     }
 }
 
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 8e95c45..3a0f096 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -160,7 +160,7 @@ poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
 # any unallocated cluster, leading to an attempt to overwrite the second L2
 # table. Finally, resume the COW write and see it fail (but not crash).
 echo "open -o file.driver=blkdebug $TEST_IMG
-break cow_read 0
+break write_aio 0
 aio_write 0k 1k
 wait_break 0
 write 64k 64k
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index a20e267..290ccec 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -114,7 +114,8 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
 blkdebug: Suspended request '0'
 write failed: Input/output error
 blkdebug: Resuming request '0'
-aio_write failed: No medium found
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing unallocated image header ===
 
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 8638217..3c216a1 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -71,7 +71,7 @@ echo
 _make_test_img $IMG_SIZE
 
 # Create data clusters (not aligned to an L2 table)
-$QEMU_IO -c 'write -P 42 1M 256k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -P 42 $(((1024 + 32) * 1024)) 192k" "$TEST_IMG" | _filter_qemu_io
 orig_map=$($QEMU_IMG map --output=json "$TEST_IMG")
 
 # Convert the data clusters to preallocated zero clusters
diff --git a/tests/qemu-iotests/066.out b/tests/qemu-iotests/066.out
index f94aa5c..81ef795 100644
--- a/tests/qemu-iotests/066.out
+++ b/tests/qemu-iotests/066.out
@@ -22,8 +22,8 @@ Offset          Length          Mapped to       File
 === Writing to preallocated zero clusters ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67109376
-wrote 262144/262144 bytes at offset 1048576
-256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 196608/196608 bytes at offset 1081344
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 262144/262144 bytes at offset 1048576
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 196608/196608 bytes at offset 1081344
-- 
2.7.4
