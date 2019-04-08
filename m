Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23503C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B5D20879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B5D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDX94-0002oB-4e
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:29:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6I-00015g-Pl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6G-0006M6-5T
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:50308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX6D-0006ES-4J; Mon, 08 Apr 2019 12:26:23 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hDX69-0001tt-N0; Mon, 08 Apr 2019 19:26:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 19:26:17 +0300
Message-Id: <20190408162617.258535-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 2/2] block: avoid recursive block_status
 call if possible
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408162617.w_6nku17DQDfhcXUpuKgdlh6DzKAYyHolliap6aiMy4@z>

drv_co_block_status digs bs->file for additional, more accurate search
for hole inside region, reported as DATA by bs since 5daa74a6ebc.

This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
knows, where are holes and where is data. But every block_status
request calls lseek additionally. Assume a big disk, full of
data, in any iterative copying block job (or img convert) we'll call
lseek(HOLE) on every iteration, and each of these lseeks will have to
iterate through all metadata up to the end of file. It's obviously
ineffective behavior. And for many scenarios we don't need this lseek
at all.

However, lseek is needed when we have metadata-preallocated image.

So, let's detect metadata-preallocation case and don't dig qcow2's
protocol file in other cases.

The idea is to compare allocation size in POV of filesystem with
allocations size in POV of Qcow2 (by refcounts). If allocation in fs is
significantly lower, consider it as metadata-preallocation case.

102 iotest changed, as our detector can't detect shrinked file as
metadata-preallocation, which don't seem to be wrong, as with metadata
preallocation we always have valid file length.

Other two iotests tiny changed QMP output sequence, which should be
exactly because skipped lseek at mirror beginning.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h              |  4 ++++
 include/block/block.h      |  8 +++++++-
 block/io.c                 |  9 ++++++++-
 block/qcow2-refcount.c     | 32 ++++++++++++++++++++++++++++++++
 block/qcow2.c              | 11 +++++++++++
 tests/qemu-iotests/102     |  2 +-
 tests/qemu-iotests/102.out |  3 ++-
 tests/qemu-iotests/141.out |  2 +-
 tests/qemu-iotests/144.out |  2 +-
 9 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fdee297f33..b6135d8271 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -350,6 +350,9 @@ typedef struct BDRVQcow2State {
     int nb_compress_threads;
 
     BdrvChild *data_file;
+
+    bool metadata_preallocation_checked;
+    bool metadata_preallocation;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
@@ -643,6 +646,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 void *cb_opaque, Error **errp);
 int qcow2_shrink_reftable(BlockDriverState *bs);
 int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs);
 
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..1f2f08e4ee 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -156,10 +156,15 @@ typedef struct HDGeometry {
  * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
  *                 layer, set by block layer
  *
- * Internal flag:
+ * Internal flags:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
  *                 that the block layer recompute the answer from the returned
  *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
+ * BDRV_BLOCK_RECURSE: request that the block layer will recursively search for
+ *                     zeroes in file child of current block node inside
+ *                     returned region. Only valid together with both
+ *                     BDRV_BLOCK_DATA and BDRV_BLOCK_OFFSET_VALID. Should not
+ *                     appear with BDRV_BLOCK_ZERO.
  *
  * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
  * host offset within the returned BDS that is allocated for the
@@ -184,6 +189,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_RAW          0x08
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
+#define BDRV_BLOCK_RECURSE      0x40
 #define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
 
 typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
diff --git a/block/io.c b/block/io.c
index dfc153b8d8..8595d4b504 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2121,6 +2121,12 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
      */
     assert(*pnum && QEMU_IS_ALIGNED(*pnum, align) &&
            align > offset - aligned_offset);
+    if (ret & BDRV_BLOCK_RECURSE) {
+        assert(ret & BDRV_BLOCK_DATA);
+        assert(ret & BDRV_BLOCK_OFFSET_VALID);
+        assert(!(ret & BDRV_BLOCK_ZERO));
+    }
+
     *pnum -= offset - aligned_offset;
     if (*pnum > bytes) {
         *pnum = bytes;
@@ -2151,7 +2157,8 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         }
     }
 
-    if (want_zero && local_file && local_file != bs &&
+    if (want_zero && ret & BDRV_BLOCK_RECURSE &&
+        local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int64_t file_pnum;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e0fe322500..5786ba93e0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3422,3 +3422,35 @@ int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
                             "There are no references in the refcount table.");
     return -EIO;
 }
+
+int qcow2_detect_metadata_preallocation(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int64_t i, end_cluster, cluster_count = 0, threshold;
+    int64_t file_length, real_allocation, real_clusters;
+
+    file_length = bdrv_getlength(bs->file->bs);
+    if (file_length < 0) {
+        return file_length;
+    }
+
+    real_allocation = bdrv_get_allocated_file_size(bs->file->bs);
+    if (real_allocation < 0) {
+        return real_allocation;
+    }
+
+    real_clusters = real_allocation / s->cluster_size;
+    threshold = MAX(real_clusters * 10 / 9, real_clusters + 2);
+
+    end_cluster = size_to_clusters(s, file_length);
+    for (i = 0; i < end_cluster && cluster_count < threshold; i++) {
+        uint64_t refcount;
+        int ret = qcow2_get_refcount(bs, i, &refcount);
+        if (ret < 0) {
+            return ret;
+        }
+        cluster_count += !!refcount;
+    }
+
+    return cluster_count >= threshold;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index d507ee0686..e89e1c4fb1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1900,6 +1900,12 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     unsigned int bytes;
     int status = 0;
 
+    if (!s->metadata_preallocation_checked) {
+        ret = qcow2_detect_metadata_preallocation(bs);
+        s->metadata_preallocation = (ret == 1);
+        s->metadata_preallocation_checked = true;
+    }
+
     bytes = MIN(INT_MAX, count);
     qemu_co_mutex_lock(&s->lock);
     ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
@@ -1922,6 +1928,11 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
         status |= BDRV_BLOCK_DATA;
     }
+    if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
+        (status & BDRV_BLOCK_OFFSET_VALID))
+    {
+        status |= BDRV_BLOCK_RECURSE;
+    }
     return status;
 }
 
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index cedd2b25dc..125402db2b 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -56,7 +56,7 @@ $QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG resize -f raw --shrink "$TEST_IMG" $((5 * 64 * 1024))
 
 $QEMU_IO -c map "$TEST_IMG"
-$QEMU_IMG map "$TEST_IMG"
+$QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
 
 echo
 echo '=== Testing map on an image file truncated outside of qemu ==='
diff --git a/tests/qemu-iotests/102.out b/tests/qemu-iotests/102.out
index 4401b08fee..cd2fdc7f96 100644
--- a/tests/qemu-iotests/102.out
+++ b/tests/qemu-iotests/102.out
@@ -7,7 +7,8 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image resized.
 64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
-Offset          Length          Mapped to       File
+Offset          Length          File
+0               0x10000         TEST_DIR/t.IMGFMT
 
 === Testing map on an image file truncated outside of qemu ===
 
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 41c7291258..4d71d9dcae 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -42,9 +42,9 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block device is in use by block job: commit"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index 55299201e4..a9a8216bea 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -14,10 +14,10 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "virtio0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
-- 
2.18.0


