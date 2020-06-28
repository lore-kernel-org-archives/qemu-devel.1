Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8255EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C42420720
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DqQEGSBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C42420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVS6-0005AN-HT
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6a-0007o6-4E; Sun, 28 Jun 2020 07:04:12 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6M-0000Xj-1i; Sun, 28 Jun 2020 07:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=eX0gs7cy4Um4G492fOBEncGdlWNFQIufd+lO6E+xWIQ=; 
 b=DqQEGSBv0Szz728/bnmdRhrd47/ztOVAmNxeW3lziyE1wZtEpA7eF7FwOrnxmM0x5rCcO0QA80zOSrOzx1r6GTNOYPq2oGVUPnwbS6z4ee6vDkFnqY5fjO7wgFh49G+tTeOMw+dpIiX2wrQ6DB5GtPGDRuKll63iUU+0ziuB1f7qXgBdLtnur0aiSDY5WNQo27VZd+nPiJJY0MJrZqY96Uvk8jtvE+wtHyk2Q0i28s2b7y2+tgPjnPTuXf+V0v2tv/pWJmCNE7UNHH2dPrFV+krqDiYYw1mRbsEP03dBM0BCLD8uCjwtUoRb9cAN2HQ/nAytU0i6tB7f1V4+hkziyw==;
Received: from 26.red-79-158-236.dynamicip.rima-tde.net ([79.158.236.26]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jpV5X-0002ge-WC; Sun, 28 Jun 2020 13:03:10 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jpV5I-00038h-0W; Sun, 28 Jun 2020 13:02:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 18/34] qcow2: Replace QCOW2_CLUSTER_* with
 QCOW2_SUBCLUSTER_*
Date: Sun, 28 Jun 2020 13:02:27 +0200
Message-Id: <58d560d48ff4a96f54fb419e17f1b0de1064f04e.1593342067.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593342067.git.berto@igalia.com>
References: <cover.1593342067.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 07:03:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to support extended L2 entries some functions of the qcow2
driver need to start dealing with subclusters instead of clusters.

qcow2_get_host_offset() is modified to return the subcluster type
instead of the cluster type, and all callers are updated to replace
all values of QCow2ClusterType with their QCow2SubclusterType
equivalents.

This patch only changes the data types, there are no semantic changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  2 +-
 block/qcow2-cluster.c | 10 +++----
 block/qcow2.c         | 70 ++++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 74f65793bd..5df761edc3 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -894,7 +894,7 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
 
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
                           unsigned int *bytes, uint64_t *host_offset,
-                          QCow2ClusterType *cluster_type);
+                          QCow2SubclusterType *subcluster_type);
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offset,
                                QCowL2Meta **m);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1e5681b0c6..ed7b92dbb2 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -564,15 +564,15 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
  * offset that we are interested in.
  *
  * On exit, *bytes is the number of bytes starting at offset that have the same
- * cluster type and (if applicable) are stored contiguously in the image file.
- * The cluster type is stored in *cluster_type.
- * Compressed clusters are always returned one by one.
+ * subcluster type and (if applicable) are stored contiguously in the image
+ * file. The subcluster type is stored in *subcluster_type.
+ * Compressed clusters are always processed one by one.
  *
  * Returns 0 on success, -errno in error cases.
  */
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
                           unsigned int *bytes, uint64_t *host_offset,
-                          QCow2ClusterType *cluster_type)
+                          QCow2SubclusterType *subcluster_type)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
@@ -713,7 +713,7 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    *cluster_type = type;
+    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
 
     return 0;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 89e17bdaba..2f7a2a7c7a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2033,7 +2033,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t host_offset;
     unsigned int bytes;
-    QCow2ClusterType type;
+    QCow2SubclusterType type;
     int ret, status = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -2053,15 +2053,16 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     *pnum = bytes;
 
-    if ((type == QCOW2_CLUSTER_NORMAL || type == QCOW2_CLUSTER_ZERO_ALLOC) &&
-        !s->crypto) {
+    if ((type == QCOW2_SUBCLUSTER_NORMAL ||
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
         *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
     }
-    if (type == QCOW2_CLUSTER_ZERO_PLAIN || type == QCOW2_CLUSTER_ZERO_ALLOC) {
+    if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
+        type == QCOW2_SUBCLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (type != QCOW2_CLUSTER_UNALLOCATED) {
+    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2158,7 +2159,7 @@ typedef struct Qcow2AioTask {
     AioTask task;
 
     BlockDriverState *bs;
-    QCow2ClusterType cluster_type; /* only for read */
+    QCow2SubclusterType subcluster_type; /* only for read */
     uint64_t host_offset; /* or full descriptor in compressed clusters */
     uint64_t offset;
     uint64_t bytes;
@@ -2171,7 +2172,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task);
 static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
                                        AioTaskPool *pool,
                                        AioTaskFunc func,
-                                       QCow2ClusterType cluster_type,
+                                       QCow2SubclusterType subcluster_type,
                                        uint64_t host_offset,
                                        uint64_t offset,
                                        uint64_t bytes,
@@ -2185,7 +2186,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
     *task = (Qcow2AioTask) {
         .task.func = func,
         .bs = bs,
-        .cluster_type = cluster_type,
+        .subcluster_type = subcluster_type,
         .qiov = qiov,
         .host_offset = host_offset,
         .offset = offset,
@@ -2196,7 +2197,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
     trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
                          func == qcow2_co_preadv_task_entry ? "read" : "write",
-                         cluster_type, host_offset, offset, bytes,
+                         subcluster_type, host_offset, offset, bytes,
                          qiov, qiov_offset);
 
     if (!pool) {
@@ -2209,7 +2210,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 }
 
 static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
-                                             QCow2ClusterType cluster_type,
+                                             QCow2SubclusterType subc_type,
                                              uint64_t host_offset,
                                              uint64_t offset, uint64_t bytes,
                                              QEMUIOVector *qiov,
@@ -2217,24 +2218,24 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
 {
     BDRVQcow2State *s = bs->opaque;
 
-    switch (cluster_type) {
-    case QCOW2_CLUSTER_ZERO_PLAIN:
-    case QCOW2_CLUSTER_ZERO_ALLOC:
+    switch (subc_type) {
+    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
         /* Both zero types are handled in qcow2_co_preadv_part */
         g_assert_not_reached();
 
-    case QCOW2_CLUSTER_UNALLOCATED:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
         assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
 
         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
         return bdrv_co_preadv_part(bs->backing, offset, bytes,
                                    qiov, qiov_offset, 0);
 
-    case QCOW2_CLUSTER_COMPRESSED:
+    case QCOW2_SUBCLUSTER_COMPRESSED:
         return qcow2_co_preadv_compressed(bs, host_offset,
                                           offset, bytes, qiov, qiov_offset);
 
-    case QCOW2_CLUSTER_NORMAL:
+    case QCOW2_SUBCLUSTER_NORMAL:
         if (bs->encrypted) {
             return qcow2_co_preadv_encrypted(bs, host_offset,
                                              offset, bytes, qiov, qiov_offset);
@@ -2257,8 +2258,9 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 
     assert(!t->l2meta);
 
-    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->host_offset,
-                                t->offset, t->bytes, t->qiov, t->qiov_offset);
+    return qcow2_co_preadv_task(t->bs, t->subcluster_type,
+                                t->host_offset, t->offset, t->bytes,
+                                t->qiov, t->qiov_offset);
 }
 
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
@@ -2270,7 +2272,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
     int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t host_offset = 0;
-    QCow2ClusterType type;
+    QCow2SubclusterType type;
     AioTaskPool *aio = NULL;
 
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
@@ -2289,9 +2291,9 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
             goto out;
         }
 
-        if (type == QCOW2_CLUSTER_ZERO_PLAIN ||
-            type == QCOW2_CLUSTER_ZERO_ALLOC ||
-            (type == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
+            type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
@@ -2524,7 +2526,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 {
     Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
 
-    assert(!t->cluster_type);
+    assert(!t->subcluster_type);
 
     return qcow2_co_pwritev_task(t->bs, t->host_offset,
                                  t->offset, t->bytes, t->qiov, t->qiov_offset,
@@ -3844,7 +3846,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     if (head || tail) {
         uint64_t off;
         unsigned int nr;
-        QCow2ClusterType type;
+        QCow2SubclusterType type;
 
         assert(head + bytes <= s->cluster_size);
 
@@ -3862,9 +3864,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         nr = s->cluster_size;
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
-            (type != QCOW2_CLUSTER_UNALLOCATED &&
-             type != QCOW2_CLUSTER_ZERO_PLAIN &&
-             type != QCOW2_CLUSTER_ZERO_ALLOC)) {
+            (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+             type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
+             type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
             return -ENOTSUP;
         }
@@ -3928,7 +3930,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
     while (bytes != 0) {
         uint64_t copy_offset = 0;
-        QCow2ClusterType type;
+        QCow2SubclusterType type;
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
         cur_write_flags = write_flags;
@@ -3940,7 +3942,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         }
 
         switch (type) {
-        case QCOW2_CLUSTER_UNALLOCATED:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
@@ -3955,16 +3957,16 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
             }
             break;
 
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
             cur_write_flags |= BDRV_REQ_ZERO_WRITE;
             break;
 
-        case QCOW2_CLUSTER_COMPRESSED:
+        case QCOW2_SUBCLUSTER_COMPRESSED:
             ret = -ENOTSUP;
             goto out;
 
-        case QCOW2_CLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_NORMAL:
             child = s->data_file;
             break;
 
@@ -4493,7 +4495,7 @@ static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
 {
     Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
 
-    assert(!t->cluster_type && !t->l2meta);
+    assert(!t->subcluster_type && !t->l2meta);
 
     return qcow2_co_pwritev_compressed_task(t->bs, t->offset, t->bytes, t->qiov,
                                             t->qiov_offset);
-- 
2.20.1


