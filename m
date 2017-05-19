Received: from eggs.gnu.org ([2001:4830:134:3::10]:48229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJX-0006k1-5D
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJT-0006mQ-6y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:15 -0400
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:10583
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJS-0006lF-PM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:11 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:30 +0300
Message-ID: <1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 03/13] qcow2: do not COW the empty areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

If COW area of the newly allocated cluster is zeroes, there is no reason
to write zero sectors in perform_cow() again now as whole clusters are
zeroed out in single chunks by handle_alloc_space().

Introduce QCowL2Meta field "reduced", since the existing fields
(offset and nb_bytes) still has to keep other write requests from
simultaneous writing in the area

iotest 060:
write to the discarded cluster does not trigger COW anymore.
so, break on write_aio event instead, will work for the test
(but write won't fail anymore, so update reference output)

iotest 066:
cluster-alignment areas that were not really COWed are now detected
as zeroes, hence the initial write has to be exactly the same size for
the maps to match

performance tests: ===

qemu-io,
  results in seconds to complete (less is better)
  random write 4k to empty image, no backing
    HDD
      64k cluster
        128M over 128M image:   160 -> 160 ( x1  )
        128M over   2G image:    86 ->  84 ( x1  )
        128M over   8G image:    40 ->  29 ( x1.4 )
      1M cluster
         32M over   8G image:    58 ->  23 ( x2.5 )

    SSD
      64k cluster
          2G over   2G image:    71 ->  38 (  x1.9 )
        512M over   8G image:    85 ->   8 ( x10.6 )
      1M cluster
        128M over  32G image:   314 ->   2 ( x157  )

  - improvement grows bigger the bigger the cluster size,
  - first data portions to the fresh image benefit the most
  (more chance to hit an unallocated cluster)
  - SSD improvement is close to the IO length reduction rate
  (e.g. writing only 4k instead of 64k) gives theoretical x16
  and practical x10 improvement)

fio tests over xfs, empty image (cluster 64k), no backing,

  first megabytes of random writes:
    randwrite 4k, size=8g:

      HDD (io_size=128m) :  730 ->  1050 IOPS ( x1.45)
      SSD (io_size=512m) : 1500 ->  7000 IOPS ( x4.7 )

  random writes io_size==image_size:
    randwrite 4k, size=2g io_size=2g:
                   HDD   : 200 IOPS (no difference)
                   SSD   : 7500 ->  9500 IOPS ( x1.3 )

  sequential write:
    seqwrite 4k, size=4g, iodepth=4
                   SSD   : 7000 -> 18000 IOPS ( x2.6 )

  - numbers are similar to qemu-io tests, slightly less improvement
  (damped by fs?)

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/qcow2-cluster.c      |  4 +++-
 block/qcow2.c              | 23 +++++++++++++++++++++++
 block/qcow2.h              |  4 ++++
 tests/qemu-iotests/060     |  2 +-
 tests/qemu-iotests/060.out |  3 ++-
 tests/qemu-iotests/066     |  2 +-
 tests/qemu-iotests/066.out |  4 ++--
 7 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 347d94b..cf18dee 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -758,7 +758,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m, Qcow2COWRegion *r)
     BDRVQcow2State *s = bs->opaque;
     int ret;
 
-    if (r->nb_bytes == 0) {
+    if (r->nb_bytes == 0 || r->reduced) {
         return 0;
     }
 
@@ -1267,10 +1267,12 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .cow_start = {
             .offset     = 0,
             .nb_bytes   = offset_into_cluster(s, guest_offset),
+            .reduced    = false,
         },
         .cow_end = {
             .offset     = nb_bytes,
             .nb_bytes   = avail_bytes - nb_bytes,
+            .reduced    = false,
         },
     };
     qemu_co_queue_init(&(*m)->dependent_requests);
diff --git a/block/qcow2.c b/block/qcow2.c
index b885dfc..b438f22 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -64,6 +64,9 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 
+static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
+                            uint32_t count);
+
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
     const QCowHeader *cow_header = (const void *)buf;
@@ -1575,6 +1578,25 @@ fail:
     return ret;
 }
 
+static void handle_cow_reduce(BlockDriverState *bs, QCowL2Meta *m)
+{
+    if (bs->encrypted) {
+        return;
+    }
+    if (!m->cow_start.reduced && m->cow_start.nb_bytes != 0 &&
+        is_zero_sectors(bs,
+                        (m->offset + m->cow_start.offset) >> BDRV_SECTOR_BITS,
+                        m->cow_start.nb_bytes >> BDRV_SECTOR_BITS)) {
+        m->cow_start.reduced = true;
+    }
+    if (!m->cow_end.reduced && m->cow_end.nb_bytes != 0 &&
+        is_zero_sectors(bs,
+                        (m->offset + m->cow_end.offset) >> BDRV_SECTOR_BITS,
+                        m->cow_end.nb_bytes >> BDRV_SECTOR_BITS)) {
+        m->cow_end.reduced = true;
+    }
+}
+
 static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -1598,6 +1620,7 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 
         file->total_sectors = MAX(file->total_sectors,
                                   (m->alloc_offset + bytes) / BDRV_SECTOR_SIZE);
+        handle_cow_reduce(bs, m);
     }
 }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc3..ba15c08 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -305,6 +305,10 @@ typedef struct Qcow2COWRegion {
 
     /** Number of bytes to copy */
     int         nb_bytes;
+
+    /** The region is filled with zeroes and does not require COW
+     */
+    bool        reduced;
 } Qcow2COWRegion;
 
 /**
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
index 9e8f5b9..ea29a32 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -107,7 +107,8 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
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
index 3d9da9b..093431e 100644
--- a/tests/qemu-iotests/066.out
+++ b/tests/qemu-iotests/066.out
@@ -19,8 +19,8 @@ Offset          Length          Mapped to       File
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
