Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB66C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7961E206D3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WFDsGi6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7961E206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij00U-00079P-N8
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizZF-0003X7-F2
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizZC-00075W-Cz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:37 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:35034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizZB-0004l0-JQ; Sun, 22 Dec 2019 06:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=2WhpOWC666BhwTTPbASHMuPGmY1UVgCMvKZYd0QtBRI=; 
 b=WFDsGi6bW7d2kWE5O/tP6uNpCR0Amo0F4I8r43INFzd0iZLa366BYJEv4LF4H8ai+69s7C5bPLiEl85g5BUS3dW3Jm0bGjQXlwE6EaEqLQ/dYi7VBXgxuCWTY35bP3+OiKlEf55+dkE+kmW/1fAqT+Bs2eJn4wPZZiWky1R1SygiAsZi7G0SY+d+JSgcK79KgYuCd2sZr5ip/xYxagHXCwxGfFhLEgHlYPOXbx3itTmpU9qhCiJ4phU58U8FR0MBcTkW1pFY/C4lsNXN0hL/bDRFee09cAU/Isf3obgy0q44OtC8aIXTTUiuKJAVV5g7++DUYAn7R0EL6Z1CWJWnBA==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005dE-MR; Sun, 22 Dec 2019 12:37:52 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001Vq-J0; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 12/27] qcow2: Replace QCOW2_CLUSTER_* with
 QCOW2_SUBCLUSTER_*
Date: Sun, 22 Dec 2019 12:36:53 +0100
Message-Id: <ed8f4e6adb5390e31c217a6d6c21b77ef202437a.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to support extended L2 entries some functions of the qcow2
driver need to start dealing with subclusters instead of clusters.

qcow2_get_cluster_offset() is modified to return the subcluster
type instead of the cluster type, and all callers are updated to
replace all values of QCow2ClusterType with their QCow2SubclusterType
equivalents (as returned by qcow2_cluster_to_subcluster_type()).

This patch only changes the data types, there are no semantic changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 19 +++++-----
 block/qcow2.c         | 82 +++++++++++++++++++++++++------------------
 block/qcow2.h         |  3 +-
 3 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 851c7e6165..40c2e34a2a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -497,21 +497,22 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
 /*
  * get_cluster_offset
  *
- * For a given offset of the virtual disk, find the cluster type and offset in
- * the qcow2 file. The offset is stored in *cluster_offset.
+ * For a given offset of the virtual disk, find the cluster offset in
+ * the qcow2 file and store it in *cluster_offset.
  *
  * On entry, *bytes is the maximum number of contiguous bytes starting at
  * offset that we are interested in.
  *
  * On exit, *bytes is the number of bytes starting at offset that have the same
- * cluster type and (if applicable) are stored contiguously in the image file.
- * Compressed clusters are always returned one by one.
+ * subcluster type and (if applicable) are stored contiguously in the image
+ * file. The subcluster type is stored in *subcluster_type. Compressed clusters
+ * are always processed one by one.
  *
- * Returns the cluster type (QCOW2_CLUSTER_*) on success, -errno in error
- * cases.
+ * Returns 0 on success, -errno in error cases.
  */
 int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                             unsigned int *bytes, uint64_t *cluster_offset)
+                             unsigned int *bytes, uint64_t *cluster_offset,
+                             QCow2SubclusterType *subcluster_type)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
@@ -653,7 +654,9 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    return type;
+    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
+
+    return 0;
 
 fail:
     qcow2_cache_put(s->l2_table_cache, (void **)&l2_slice);
diff --git a/block/qcow2.c b/block/qcow2.c
index e7607d90d4..9277d680ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1964,6 +1964,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t cluster_offset;
     unsigned int bytes;
+    QCow2SubclusterType type;
     int ret, status = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -1975,7 +1976,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
 
     bytes = MIN(INT_MAX, count);
-    ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
+    ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset, &type);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
@@ -1983,15 +1984,16 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     *pnum = bytes;
 
-    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
-        !s->crypto) {
+    if ((type == QCOW2_SUBCLUSTER_NORMAL ||
+         type == QCOW2_SUBCLUSTER_ZERO_ALLOC) && !s->crypto) {
         *map = cluster_offset | offset_into_cluster(s, offset);
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
     }
-    if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
+    if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
+        type == QCOW2_SUBCLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
+    } else if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2094,7 +2096,7 @@ typedef struct Qcow2AioTask {
     AioTask task;
 
     BlockDriverState *bs;
-    QCow2ClusterType cluster_type; /* only for read */
+    QCow2SubclusterType subcluster_type; /* only for read */
     uint64_t file_cluster_offset;
     uint64_t offset;
     uint64_t bytes;
@@ -2107,7 +2109,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task);
 static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
                                        AioTaskPool *pool,
                                        AioTaskFunc func,
-                                       QCow2ClusterType cluster_type,
+                                       QCow2SubclusterType subcluster_type,
                                        uint64_t file_cluster_offset,
                                        uint64_t offset,
                                        uint64_t bytes,
@@ -2121,7 +2123,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
     *task = (Qcow2AioTask) {
         .task.func = func,
         .bs = bs,
-        .cluster_type = cluster_type,
+        .subcluster_type = subcluster_type,
         .qiov = qiov,
         .file_cluster_offset = file_cluster_offset,
         .offset = offset,
@@ -2132,7 +2134,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 
     trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
                          func == qcow2_co_preadv_task_entry ? "read" : "write",
-                         cluster_type, file_cluster_offset, offset, bytes,
+                         subcluster_type, file_cluster_offset, offset, bytes,
                          qiov, qiov_offset);
 
     if (!pool) {
@@ -2145,7 +2147,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
 }
 
 static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
-                                             QCow2ClusterType cluster_type,
+                                             QCow2SubclusterType subc_type,
                                              uint64_t file_cluster_offset,
                                              uint64_t offset, uint64_t bytes,
                                              QEMUIOVector *qiov,
@@ -2154,24 +2156,24 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster = offset_into_cluster(s, offset);
 
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
         return qcow2_co_preadv_compressed(bs, file_cluster_offset,
                                           offset, bytes, qiov, qiov_offset);
 
-    case QCOW2_CLUSTER_NORMAL:
+    case QCOW2_SUBCLUSTER_NORMAL:
         if ((file_cluster_offset & 511) != 0) {
             return -EIO;
         }
@@ -2199,8 +2201,9 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 
     assert(!t->l2meta);
 
-    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_offset,
-                                t->offset, t->bytes, t->qiov, t->qiov_offset);
+    return qcow2_co_preadv_task(t->bs, t->subcluster_type,
+                                t->file_cluster_offset, t->offset, t->bytes,
+                                t->qiov, t->qiov_offset);
 }
 
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
@@ -2212,6 +2215,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
     int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset = 0;
+    QCow2SubclusterType type;
     AioTaskPool *aio = NULL;
 
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
@@ -2223,22 +2227,23 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         }
 
         qemu_co_mutex_lock(&s->lock);
-        ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
+        ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes,
+                                       &cluster_offset, &type);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             goto out;
         }
 
-        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
-            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
-            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        if (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
+            type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+            (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
             if (!aio && cur_bytes != bytes) {
                 aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
             }
-            ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, ret,
+            ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, type,
                                  cluster_offset, offset, cur_bytes,
                                  qiov, qiov_offset, NULL);
             if (ret < 0) {
@@ -2469,7 +2474,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 {
     Qcow2AioTask *t = container_of(task, Qcow2AioTask, task);
 
-    assert(!t->cluster_type);
+    assert(!t->subcluster_type);
 
     return qcow2_co_pwritev_task(t->bs, t->file_cluster_offset,
                                  t->offset, t->bytes, t->qiov, t->qiov_offset,
@@ -3723,6 +3728,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     if (head || tail) {
         uint64_t off;
         unsigned int nr;
+        QCow2SubclusterType type;
 
         assert(head + bytes <= s->cluster_size);
 
@@ -3738,10 +3744,14 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
         bytes = s->cluster_size;
         nr = s->cluster_size;
-        ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
-        if (ret != QCOW2_CLUSTER_UNALLOCATED &&
-            ret != QCOW2_CLUSTER_ZERO_PLAIN &&
-            ret != QCOW2_CLUSTER_ZERO_ALLOC) {
+        ret = qcow2_get_cluster_offset(bs, offset, &nr, &off, &type);
+        if (ret < 0) {
+            qemu_co_mutex_unlock(&s->lock);
+            return -ENOTSUP;
+        }
+        if (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
+            type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
+            type != QCOW2_SUBCLUSTER_ZERO_ALLOC) {
             qemu_co_mutex_unlock(&s->lock);
             return -ENOTSUP;
         }
@@ -3799,17 +3809,19 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
     while (bytes != 0) {
         uint64_t copy_offset = 0;
+        QCow2SubclusterType type;
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
         cur_write_flags = write_flags;
 
-        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &copy_offset);
+        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes,
+                                       &copy_offset, &type);
         if (ret < 0) {
             goto out;
         }
 
-        switch (ret) {
-        case QCOW2_CLUSTER_UNALLOCATED:
+        switch (type) {
+        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
                 if (src_offset >= backing_length) {
@@ -3824,16 +3836,16 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
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
             copy_offset += offset_into_cluster(s, src_offset);
             if ((copy_offset & 511) != 0) {
diff --git a/block/qcow2.h b/block/qcow2.h
index 321ba9550f..37b7e25989 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -831,7 +831,8 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
 int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                             unsigned int *bytes, uint64_t *cluster_offset);
+                             unsigned int *bytes, uint64_t *cluster_offset,
+                             QCow2SubclusterType *subcluster_type);
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offset,
                                QCowL2Meta **m);
-- 
2.20.1


