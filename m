Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB557C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1A920833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1A920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHOE-0005Qi-QD
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:29:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHMf-0004Xc-KH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHMd-0004Im-FP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:28:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:39442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHMW-0003VP-4O; Thu, 16 May 2019 10:28:02 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHMQ-0007KE-0x; Thu, 16 May 2019 17:27:54 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 16 May 2019 17:27:49 +0300
Message-Id: <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v14 1/1] qcow2: skip writing zero buffers to
 empty COW areas
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	Anton Nefedov <anton.nefedov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If COW areas of the newly allocated clusters are zeroes on the backing
image, efficient bdrv_write_zeroes(flags=BDRV_REQ_NO_FALLBACK) can be
used on the whole cluster instead of writing explicit zero buffers later
in perform_cow().

iotest 060:
write to the discarded cluster does not trigger COW anymore.
Use a backing image instead.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 +++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 93 +++++++++++++++++++++++++++++++++++++-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  7 ++-
 tests/qemu-iotests/060.out |  5 +-
 7 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..3e4042be7f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3215,6 +3215,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @cluster_alloc_space: an allocation of file space for a cluster (since 4.1)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3233,7 +3235,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'cluster_alloc_space'] }
 
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/qcow2.h b/block/qcow2.h
index e62508d1ce..07b18a733b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -398,6 +398,12 @@ typedef struct QCowL2Meta
      */
     Qcow2COWRegion cow_end;
 
+    /*
+     * Indicates that COW regions are already handled and do not require
+     * any more processing.
+     */
+    bool skip_cow;
+
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 974a4e8656..79d4651603 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -832,7 +832,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->offset + start->nb_bytes <= end->offset);
     assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
-    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
+    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->skip_cow) {
         return 0;
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 8e024007db..e6b1293ddf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2120,6 +2120,11 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
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
@@ -2145,6 +2150,80 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    int64_t nr;
+    return !bytes ||
+        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr == bytes);
+}
+
+static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    /*
+     * This check is designed for optimization shortcut so it must be
+     * efficient.
+     * Instead of is_zero(), use is_unallocated() as it is faster (but not
+     * as accurate and can result in false negatives).
+     */
+    return is_unallocated(bs, m->offset + m->cow_start.offset,
+                          m->cow_start.nb_bytes) &&
+           is_unallocated(bs, m->offset + m->cow_end.offset,
+                          m->cow_end.nb_bytes);
+}
+
+static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCowL2Meta *m;
+
+    if (!(s->data_file->bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK)) {
+        return 0;
+    }
+
+    if (bs->encrypted) {
+        return 0;
+    }
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
+        /*
+         * instead of writing zero COW buffers,
+         * efficiently zero out the whole clusters
+         */
+
+        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
+                                            m->nb_clusters * s->cluster_size,
+                                            true);
+        if (ret < 0) {
+            return ret;
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
+                                    m->nb_clusters * s->cluster_size,
+                                    BDRV_REQ_NO_FALLBACK);
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
@@ -2225,24 +2304,34 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             goto fail;
         }
 
+        qemu_co_mutex_unlock(&s->lock);
+
+        /* Try to efficiently initialize the physical space with zeroes */
+        ret = handle_alloc_space(bs, l2meta);
+        if (ret < 0) {
+            qemu_co_mutex_lock(&s->lock);
+            goto fail;
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
             ret = bdrv_co_pwritev(s->data_file,
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
         ret = qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
             goto fail;
diff --git a/block/trace-events b/block/trace-events
index 79ccd8d824..1e0653ce6d 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -68,6 +68,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
+qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
 
 # qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 89e911400c..b91d8321bb 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -150,10 +150,15 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filter_qemu_io
 echo
 echo "=== Testing overlap while COW is in flight ==="
 echo
+BACKING_IMG=$TEST_IMG.base
+TEST_IMG=$BACKING_IMG _make_test_img 1G
+
+$QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
+
 # compat=0.10 is required in order to make the following discard actually
 # unallocate the sector rather than make it a zero sector - we want COW, after
 # all.
-IMGOPTS='compat=0.10' _make_test_img 1G
+IMGOPTS='compat=0.10' _make_test_img -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table after
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index e42bf8c5a9..0f6b0658a1 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -97,7 +97,10 @@ read 512/512 bytes at offset 0
 
 === Testing overlap while COW is in flight ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1073741824
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824 backing_file=TEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
-- 
2.17.1


