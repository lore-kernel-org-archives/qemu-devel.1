Received: from eggs.gnu.org ([2001:4830:134:3::10]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJh-0004NL-MD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJf-0004Jq-6c
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:33 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 18 Jan 2018 20:49:06 +0300
Message-Id: <1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
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
Use a backing image instead.

iotest 066:
cluster-alignment areas that were not really COWed are now detected
as zeroes, hence the initial write has to be exactly the same size for
the maps to match

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json       |  4 ++-
 block/qcow2.h              |  6 +++++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 block/trace-events         |  1 +
 tests/qemu-iotests/060     | 26 +++++++++++-------
 tests/qemu-iotests/060.out |  5 +++-
 tests/qemu-iotests/066     |  2 +-
 tests/qemu-iotests/066.out |  4 +--
 9 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a688..1579a77 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2546,6 +2546,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @cluster_alloc_space: an allocation of a cluster file space (since 2.12)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -2564,7 +2566,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'cluster_alloc_space'] }
 
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/qcow2.h b/block/qcow2.h
index 46c8cf4..e6e3a22 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -377,6 +377,12 @@ typedef struct QCowL2Meta
     Qcow2COWRegion cow_end;
 
     /**
+     * Indicates that COW regions are already handled and do not require
+     * any more processing.
+     */
+    bool skip_cow;
+
+    /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
      * from @cow_start and @cow_end into one single write operation.
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a3fec27..511ceb8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -791,7 +791,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->offset + start->nb_bytes <= end->offset);
     assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
-    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
+    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->skip_cow) {
         return 0;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 2ed21ff..087cb26 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1833,6 +1833,11 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
             continue;
         }
 
+        /* If COW regions are handled already, skip this too */
+        if (m->skip_cow) {
+            continue;
+        }
+
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
@@ -1875,6 +1880,52 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
+static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    return is_zero(bs, m->offset + m->cow_start.offset,
+                   m->cow_start.nb_bytes) &&
+           is_zero(bs, m->offset + m->cow_end.offset, m->cow_end.nb_bytes);
+}
+
+static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
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
+        if (bs->encrypted) {
+            continue;
+        }
+
+        if (!is_zero_cow(bs, m)) {
+            continue;
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        /* instead of writing zero COW buffers,
+           efficiently zero out the whole clusters */
+        ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
+                                    m->nb_clusters * s->cluster_size,
+                                    BDRV_REQ_ALLOCATE);
+        if (ret < 0) {
+            if (ret != -ENOTSUP && ret != -EAGAIN) {
+                return ret;
+            }
+            continue;
+        }
+
+        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clusters);
+        m->skip_cow = true;
+    }
+    return 0;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -1957,24 +2008,35 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
+        qemu_co_mutex_unlock(&s->lock);
+
+        if (bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE) {
+            ret = handle_alloc_space(bs, l2meta);
+            if (ret < 0) {
+                qemu_co_mutex_lock(&s->lock);
+                goto fail;
+            }
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
index 14797dd..92beff4 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -143,27 +143,33 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filter_qemu_io
 echo
 echo "=== Testing overlap while COW is in flight ==="
 echo
+BACKING_IMG=$TEST_IMG.base
+TEST_IMG=$BACKING_IMG _make_test_img 1G
+
+$QEMU_IO -c 'write 64k 64k' "$BACKING_IMG" | _filter_qemu_io
+
 # compat=0.10 is required in order to make the following discard actually
-# unallocate the sector rather than make it a zero sector - we want COW, after
-# all.
-IMGOPTS='compat=0.10' _make_test_img 1G
+# unallocate the sector rather than make it a zero sector as we would like
+# to reuse it for another guest offset
+IMGOPTS='compat=0.10' _make_test_img -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table after
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
-# Discard the first cluster. This cluster will soon enough be reallocated and
-# used for COW.
+# Discard the first cluster. This cluster will soon enough be reallocated
 $QEMU_IO -c 'discard 0k 64k' "$TEST_IMG" | _filter_qemu_io
 # Now, corrupt the image by marking the second L2 table cluster as free.
 poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
-# Start a write operation requiring COW on the image stopping it right before
-# doing the read; then, trigger the corruption prevention by writing anything to
-# any unallocated cluster, leading to an attempt to overwrite the second L2
+# Start a write operation requiring COW on the image;
+# this write will reuse the host offset released by a previous discard.
+# Stop it right before doing the read.
+# Then, trigger the corruption prevention by writing anything to
+# another unallocated cluster, leading to an attempt to overwrite the second L2
 # table. Finally, resume the COW write and see it fail (but not crash).
 echo "open -o file.driver=blkdebug $TEST_IMG
 break cow_read 0
-aio_write 0k 1k
+aio_write 64k 1k
 wait_break 0
-write 64k 64k
+write 128k 64k
 resume 0" | $QEMU_IO | _filter_qemu_io
 
 echo
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index c4cb7c6..15d95d5 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -97,7 +97,10 @@ read 512/512 bytes at offset 0
 
 === Testing overlap while COW is in flight ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1073741824
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
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
