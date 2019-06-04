Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C1AC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4E523CBC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4E523CBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYC8S-0002Op-N9
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:18:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC66-0000zS-Tj
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC61-0005S2-Ff
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5x-0005C5-Cj; Tue, 04 Jun 2019 12:15:30 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5k-0005Pq-Vi; Tue, 04 Jun 2019 19:15:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:14 +0300
Message-Id: <20190604161514.262241-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 12/12] block/qcow2: implement
 .bdrv_co_pwritev(_compressed)_part
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement and use new interface to get rid of hd_qiov.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  1 +
 include/qemu/iov.h    |  1 +
 block/qcow2-cluster.c |  9 ++++---
 block/qcow2.c         | 60 +++++++++++++++++++++----------------------
 util/iov.c            | 10 ++++++++
 5 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 567375e56c..ea3bdb0699 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -417,6 +417,7 @@ typedef struct QCowL2Meta
      * from @cow_start and @cow_end into one single write operation.
      */
     QEMUIOVector *data_qiov;
+    size_t data_qiov_offset;
 
     /** Pointer to next L2Meta of the same write request */
     struct QCowL2Meta *next;
diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 29957c8a72..bffc151282 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -206,6 +206,7 @@ void qemu_iovec_init_extended(
         void *tail_buf, size_t tail_len);
 void qemu_iovec_init_slice(QEMUIOVector *qiov, QEMUIOVector *source,
                            size_t offset, size_t len);
+int qemu_iovec_subvec_niov(QEMUIOVector *qiov, size_t offset, size_t len);
 void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
 void qemu_iovec_concat(QEMUIOVector *dst,
                        QEMUIOVector *src, size_t soffset, size_t sbytes);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1159d6ed2f..00b1a9ab8d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -830,7 +830,6 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
     assert(start->nb_bytes + end->nb_bytes <= UINT_MAX - data_bytes);
     assert(start->offset + start->nb_bytes <= end->offset);
-    assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
     if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->skip_cow) {
         return 0;
@@ -862,7 +861,11 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     /* The part of the buffer where the end region is located */
     end_buffer = start_buffer + buffer_size - end->nb_bytes;
 
-    qemu_iovec_init(&qiov, 2 + (m->data_qiov ? m->data_qiov->niov : 0));
+    qemu_iovec_init(&qiov, 2 + (m->data_qiov ?
+                                qemu_iovec_subvec_niov(m->data_qiov,
+                                                       m->data_qiov_offset,
+                                                       data_bytes)
+                                : 0));
 
     qemu_co_mutex_unlock(&s->lock);
     /* First we read the existing data from both COW regions. We
@@ -905,7 +908,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
         if (start->nb_bytes) {
             qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
         }
-        qemu_iovec_concat(&qiov, m->data_qiov, 0, data_bytes);
+        qemu_iovec_concat(&qiov, m->data_qiov, m->data_qiov_offset, data_bytes);
         if (end->nb_bytes) {
             qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index c389ef07b0..850117cfa2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2091,7 +2091,8 @@ fail:
 /* Check if it's possible to merge a write request with the writing of
  * the data from the COW regions */
 static bool merge_cow(uint64_t offset, unsigned bytes,
-                      QEMUIOVector *hd_qiov, QCowL2Meta *l2meta)
+                      QEMUIOVector *qiov, size_t qiov_offset,
+                      QCowL2Meta *l2meta)
 {
     QCowL2Meta *m;
 
@@ -2120,11 +2121,12 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
 
         /* Make sure that adding both COW regions to the QEMUIOVector
          * does not exceed IOV_MAX */
-        if (hd_qiov->niov > IOV_MAX - 2) {
+        if (qemu_iovec_subvec_niov(qiov, qiov_offset, bytes) > IOV_MAX - 2) {
             continue;
         }
 
-        m->data_qiov = hd_qiov;
+        m->data_qiov = qiov;
+        m->data_qiov_offset = qiov_offset;
         return true;
     }
 
@@ -2205,24 +2207,22 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     return 0;
 }
 
-static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                         uint64_t bytes, QEMUIOVector *qiov,
-                                         int flags)
+static coroutine_fn int qcow2_co_pwritev_part(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
     uint64_t cluster_offset;
-    QEMUIOVector hd_qiov;
+    QEMUIOVector encrypted_qiov;
     uint64_t bytes_done = 0;
     uint8_t *cluster_data = NULL;
     QCowL2Meta *l2meta = NULL;
 
     trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
 
-    qemu_iovec_init(&hd_qiov, qiov->niov);
-
     qemu_co_mutex_lock(&s->lock);
 
     while (bytes != 0) {
@@ -2255,9 +2255,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
         qemu_co_mutex_unlock(&s->lock);
 
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
-
         if (bs->encrypted) {
             assert(s->crypto);
             if (!cluster_data) {
@@ -2270,9 +2267,9 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                 }
             }
 
-            assert(hd_qiov.size <=
-                   QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-            qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
+            assert(cur_bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+            qemu_iovec_to_buf(qiov, qiov_offset + bytes_done,
+                              cluster_data, cur_bytes);
 
             if (qcow2_co_encrypt(bs, cluster_offset, offset,
                                  cluster_data, cur_bytes) < 0) {
@@ -2280,8 +2277,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                 goto out_unlocked;
             }
 
-            qemu_iovec_reset(&hd_qiov);
-            qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
+            qemu_iovec_init_buf(&encrypted_qiov, cluster_data, cur_bytes);
         }
 
         /* Try to efficiently initialize the physical space with zeroes */
@@ -2294,13 +2290,17 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
          * writing of the guest data together with that of the COW regions.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
-        if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
+        if (!merge_cow(offset, cur_bytes,
+                       bs->encrypted ? &encrypted_qiov : qiov,
+                       bs->encrypted ? 0 : qiov_offset + bytes_done, l2meta))
+        {
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
-            ret = bdrv_co_pwritev(s->data_file,
-                                  cluster_offset + offset_in_cluster,
-                                  cur_bytes, &hd_qiov, 0);
+            ret = bdrv_co_pwritev_part(
+                    s->data_file, cluster_offset + offset_in_cluster, cur_bytes,
+                    bs->encrypted ? &encrypted_qiov : qiov,
+                    bs->encrypted ? 0 : qiov_offset + bytes_done, 0);
             if (ret < 0) {
                 goto out_unlocked;
             }
@@ -2329,7 +2329,6 @@ out_locked:
 
     qemu_co_mutex_unlock(&s->lock);
 
-    qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
 
@@ -3993,8 +3992,9 @@ fail:
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                            uint64_t bytes, QEMUIOVector *qiov)
+qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret;
@@ -4031,7 +4031,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
     }
-    qemu_iovec_to_buf(qiov, 0, buf, bytes);
+    qemu_iovec_to_buf(qiov, qiov_offset, buf, bytes);
 
     out_buf = g_malloc(s->cluster_size);
 
@@ -4039,7 +4039,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
                                 buf, s->cluster_size);
     if (out_len == -ENOMEM) {
         /* could not compress: write normal cluster */
-        ret = qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
+        ret = qcow2_co_pwritev_part(bs, offset, bytes, qiov, qiov_offset, 0);
         if (ret < 0) {
             goto fail;
         }
@@ -4623,8 +4623,8 @@ static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
     BDRVQcow2State *s = bs->opaque;
 
     BLKDBG_EVENT(bs->file, BLKDBG_VMSTATE_SAVE);
-    return bs->drv->bdrv_co_pwritev(bs, qcow2_vm_state_offset(s) + pos,
-                                    qiov->size, qiov, 0);
+    return bs->drv->bdrv_co_pwritev_part(bs, qcow2_vm_state_offset(s) + pos,
+                                         qiov->size, qiov, 0, 0);
 }
 
 static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
@@ -5175,7 +5175,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_block_status = qcow2_co_block_status,
 
     .bdrv_co_preadv_part    = qcow2_co_preadv_part,
-    .bdrv_co_pwritev        = qcow2_co_pwritev,
+    .bdrv_co_pwritev_part   = qcow2_co_pwritev_part,
     .bdrv_co_flush_to_os    = qcow2_co_flush_to_os,
 
     .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
@@ -5183,7 +5183,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
     .bdrv_co_copy_range_to  = qcow2_co_copy_range_to,
     .bdrv_co_truncate       = qcow2_co_truncate,
-    .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
+    .bdrv_co_pwritev_compressed_part = qcow2_co_pwritev_compressed_part,
     .bdrv_make_empty        = qcow2_make_empty,
 
     .bdrv_snapshot_create   = qcow2_snapshot_create,
diff --git a/util/iov.c b/util/iov.c
index d988a533ce..0ed75e764c 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -401,6 +401,16 @@ static struct iovec *qiov_slice(QEMUIOVector *qiov,
     return iov;
 }
 
+int qemu_iovec_subvec_niov(QEMUIOVector *qiov, size_t offset, size_t len)
+{
+    size_t head, tail;
+    int niov;
+
+    qiov_slice(qiov, offset, len, &head, &tail, &niov);
+
+    return niov;
+}
+
 /*
  * Compile new iovec, combining @head_buf buffer, sub-qiov of @mid_qiov,
  * and @tail_buf buffer into new qiov.
-- 
2.18.0


