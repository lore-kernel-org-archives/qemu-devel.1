Received: from eggs.gnu.org ([2001:4830:134:3::10]:60621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCE-0008B6-JR
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCA-0006g2-1F
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:50 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:01 +0300
Message-Id: <1509551048-129830-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 08/15] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

If COW areas of the newly allocated clusters are zeroes on the backing image,
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
 block/qcow2.h              |  6 +++++
 block/qcow2-cluster.c      |  3 ++-
 block/qcow2.c              | 67 ++++++++++++++++++++++++++++++++++++++++++++--
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  2 +-
 tests/qemu-iotests/060.out |  3 ++-
 tests/qemu-iotests/066     |  2 +-
 tests/qemu-iotests/066.out |  4 +--
 8 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 782a206..e312e48 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -377,6 +377,12 @@ typedef struct QCowL2Meta
     Qcow2COWRegion cow_end;
 
     /**
+     * Indicates that both COW areas are empty (nb_bytes == 0)
+     * or filled with zeroes and do not require any more copying
+     */
+    bool zero_cow;
+
+    /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
      * from @cow_start and @cow_end into one single write operation.
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fb10e26..e364116 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -783,7 +783,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->offset + start->nb_bytes <= end->offset);
     assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
-    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
+    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->zero_cow) {
         return 0;
     }
 
@@ -1383,6 +1383,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
             .offset     = nb_bytes,
             .nb_bytes   = avail_bytes - nb_bytes,
         },
+        .zero_cow = false,
     };
     qemu_co_queue_init(&(*m)->dependent_requests);
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
diff --git a/block/qcow2.c b/block/qcow2.c
index db759ce..827058d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1856,6 +1856,11 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
             continue;
         }
 
+        /* If both COW regions are zeroes already, skip this too */
+        if (m->zero_cow) {
+            continue;
+        }
+
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
@@ -1898,6 +1903,57 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
+static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    if (bs->encrypted) {
+        return false;
+    }
+
+    if (m->cow_start.nb_bytes != 0 &&
+        !is_zero(bs, m->offset + m->cow_start.offset, m->cow_start.nb_bytes))
+    {
+        return false;
+    }
+
+    if (m->cow_end.nb_bytes != 0 &&
+        !is_zero(bs, m->offset + m->cow_end.offset, m->cow_end.nb_bytes))
+    {
+        return false;
+    }
+
+    return true;
+}
+
+static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *m;
+
+    for (m = l2meta; m != NULL; m = m->next) {
+        int ret;
+
+        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
+            continue;
+        }
+
+        if (!is_zero_cow(bs, m)) {
+            continue;
+        }
+
+        /* instead of writing zero COW buffers,
+           efficiently zero out the whole clusters */
+        ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
+                                    m->nb_clusters * s->cluster_size,
+                                    BDRV_REQ_ALLOCATE);
+        if (ret < 0) {
+            continue;
+        }
+
+        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clusters);
+        m->zero_cow = true;
+    }
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1980,24 +2036,31 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE) {
+            handle_alloc_space(bs, l2meta);
+        }
+
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regions.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret = bdrv_co_pwritev(bs->file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
+                qemu_co_mutex_lock(&s->lock);
                 goto fail;
             }
         }
 
+        qemu_co_mutex_lock(&s->lock);
+
         while (l2meta != NULL) {
             QCowL2Meta *next;
 
diff --git a/block/trace-events b/block/trace-events
index 11c8d5f..c9fa596 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -61,6 +61,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
+qcow2_skip_cow(void* co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
 
 # block/qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
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
index 5ca3af4..736dc30 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -108,7 +108,8 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
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
