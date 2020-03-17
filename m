Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2684C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66B520674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q+yZ8Ru3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGoJ-0004tN-PY
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmb-0002oj-EJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmZ-0007VA-1C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:41 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmX-0005Uy-AE; Tue, 17 Mar 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=WLtKXfd2LOoul3dgnoi9cY4JxZC/k5JqOQ2OW7I73Go=; 
 b=Q+yZ8Ru3Y7qnLZ5stN6SGF6mIvMqrqkKuwr3XJJ4SK6JbowcXZSYOsr7SUz1CuD8CnPqhJ9Q8/nGPtKZL5f7+nXjXGpzGvN9obJfv/cwhimX9dr3Ihz6aK+EdNZJB+eJmYZhbysjkyYSzFD/QblU/5AT9tDGhyXztj7qdHnRqjW3BKuzxCU2Ei0VeT8zR2jnaj204EuzDLoTQQqkMTkLhsHFBc3l2xItRYZKk298/4BfCHorUh/jebbUtGN0pgol2ZhjtTpPMeSiQgKP0sL33nLkJaiwJYjG0nBY/+ztCuWBA5QRdK2Y/qlP1pI4+bIv6xQg9fB9xVZqnPPcZU7l7A==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmC-00015Z-Vb; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006O7-42; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/30] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
Date: Tue, 17 Mar 2020 19:15:59 +0100
Message-Id: <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
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

qcow2_get_cluster_offset() takes an (unaligned) guest offset and
returns the (aligned) offset of the corresponding cluster in the qcow2
image.

In practice none of the callers need to know where the cluster starts
so this patch makes the function calculate and return the final host
offset directly. The function is also renamed accordingly.

There is a pre-existing exception with compressed clusters: in this
case the function returns the complete cluster descriptor (containing
the offset and size of the compressed data). This does not change with
this patch but it is now documented.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  4 ++--
 block/qcow2-cluster.c | 38 ++++++++++++++++++++++----------------
 block/qcow2.c         | 24 +++++++-----------------
 3 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 0942126232..f47ef6ca4e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -679,8 +679,8 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
-int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                             unsigned int *bytes, uint64_t *cluster_offset);
+int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
+                          unsigned int *bytes, uint64_t *host_offset);
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offset,
                                QCowL2Meta **m);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 17f1363279..95f04d12cc 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -496,10 +496,15 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
 
 
 /*
- * get_cluster_offset
+ * get_host_offset
  *
- * For a given offset of the virtual disk, find the cluster type and offset in
- * the qcow2 file. The offset is stored in *cluster_offset.
+ * For a given offset of the virtual disk find the equivalent host
+ * offset in the qcow2 file and store it in *host_offset. Neither
+ * offset needs to be aligned to a cluster boundary.
+ *
+ * If the cluster is unallocated then *host_offset will be 0.
+ * If the cluster is compressed then *host_offset will contain the
+ * complete compressed cluster descriptor.
  *
  * On entry, *bytes is the maximum number of contiguous bytes starting at
  * offset that we are interested in.
@@ -511,12 +516,12 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
  * Returns the cluster type (QCOW2_CLUSTER_*) on success, -errno in error
  * cases.
  */
-int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                             unsigned int *bytes, uint64_t *cluster_offset)
+int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
+                          unsigned int *bytes, uint64_t *host_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
-    uint64_t l1_index, l2_offset, *l2_slice;
+    uint64_t l1_index, l2_offset, *l2_slice, l2_entry;
     int c;
     unsigned int offset_in_cluster;
     uint64_t bytes_available, bytes_needed, nb_clusters;
@@ -537,7 +542,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         bytes_needed = bytes_available;
     }
 
-    *cluster_offset = 0;
+    *host_offset = 0;
 
     /* seek to the l2 offset in the l1 table */
 
@@ -570,7 +575,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
-    *cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+    l2_entry = be64_to_cpu(l2_slice[l2_index]);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -578,7 +583,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
      * true */
     assert(nb_clusters <= INT_MAX);
 
-    type = qcow2_get_cluster_type(bs, *cluster_offset);
+    type = qcow2_get_cluster_type(bs, l2_entry);
     if (s->qcow_version < 3 && (type == QCOW2_CLUSTER_ZERO_PLAIN ||
                                 type == QCOW2_CLUSTER_ZERO_ALLOC)) {
         qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
@@ -599,41 +604,42 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         }
         /* Compressed clusters can only be processed one by one */
         c = 1;
-        *cluster_offset &= L2E_COMPRESSED_OFFSET_SIZE_MASK;
+        *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
         break;
     case QCOW2_CLUSTER_ZERO_PLAIN:
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
         c = count_contiguous_clusters_unallocated(bs, nb_clusters,
                                                   &l2_slice[l2_index], type);
-        *cluster_offset = 0;
+        *host_offset = 0;
         break;
     case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
         /* how many allocated clusters ? */
         c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
                                       &l2_slice[l2_index], QCOW_OFLAG_ZERO);
-        *cluster_offset &= L2E_OFFSET_MASK;
-        if (offset_into_cluster(s, *cluster_offset)) {
+        *host_offset = l2_entry & L2E_OFFSET_MASK;
+        if (offset_into_cluster(s, *host_offset)) {
             qcow2_signal_corruption(bs, true, -1, -1,
                                     "Cluster allocation offset %#"
                                     PRIx64 " unaligned (L2 offset: %#" PRIx64
-                                    ", L2 index: %#x)", *cluster_offset,
+                                    ", L2 index: %#x)", *host_offset,
                                     l2_offset, l2_index);
             ret = -EIO;
             goto fail;
         }
-        if (has_data_file(bs) && *cluster_offset != offset - offset_in_cluster)
+        if (has_data_file(bs) && *host_offset != offset - offset_in_cluster)
         {
             qcow2_signal_corruption(bs, true, -1, -1,
                                     "External data file host cluster offset %#"
                                     PRIx64 " does not match guest cluster "
                                     "offset: %#" PRIx64
-                                    ", L2 index: %#x)", *cluster_offset,
+                                    ", L2 index: %#x)", *host_offset,
                                     offset - offset_in_cluster, l2_index);
             ret = -EIO;
             goto fail;
         }
+        *host_offset += offset_in_cluster;
         break;
     default:
         abort();
diff --git a/block/qcow2.c b/block/qcow2.c
index a00b0c8e45..5b6ceaa2fa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1964,7 +1964,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
                                               BlockDriverState **file)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t cluster_offset;
+    uint64_t host_offset;
     unsigned int bytes;
     int ret, status = 0;
 
@@ -1977,7 +1977,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
 
     bytes = MIN(INT_MAX, count);
-    ret = qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
+    ret = qcow2_get_host_offset(bs, offset, &bytes, &host_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
@@ -1987,7 +1987,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
         !s->crypto) {
-        *map = cluster_offset | offset_into_cluster(s, offset);
+        *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
     }
@@ -2201,7 +2201,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
-    uint64_t cluster_offset = 0;
+    uint64_t host_offset = 0;
     AioTaskPool *aio = NULL;
 
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
@@ -2213,7 +2213,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         }
 
         qemu_co_mutex_lock(&s->lock);
-        ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
+        ret = qcow2_get_host_offset(bs, offset, &cur_bytes, &host_offset);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             goto out;
@@ -2225,15 +2225,6 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
-            /*
-             * For compressed clusters the variable cluster_offset
-             * does not actually store the offset but the full
-             * descriptor. We need to leave it unchanged because
-             * that's what qcow2_co_preadv_compressed() expects.
-             */
-            uint64_t host_offset = (ret == QCOW2_CLUSTER_COMPRESSED) ?
-                cluster_offset :
-                cluster_offset + offset_into_cluster(s, offset);
             if (!aio && cur_bytes != bytes) {
                 aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
             }
@@ -3735,7 +3726,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
         bytes = s->cluster_size;
         nr = s->cluster_size;
-        ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
+        ret = qcow2_get_host_offset(bs, offset, &nr, &off);
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
             ret != QCOW2_CLUSTER_ZERO_PLAIN &&
             ret != QCOW2_CLUSTER_ZERO_ALLOC) {
@@ -3800,7 +3791,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         cur_bytes = MIN(bytes, INT_MAX);
         cur_write_flags = write_flags;
 
-        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &copy_offset);
+        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes, &copy_offset);
         if (ret < 0) {
             goto out;
         }
@@ -3832,7 +3823,6 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
         case QCOW2_CLUSTER_NORMAL:
             child = s->data_file;
-            copy_offset += offset_into_cluster(s, src_offset);
             break;
 
         default:
-- 
2.20.1


