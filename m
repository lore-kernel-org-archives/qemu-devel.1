Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3CF21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZXS8Nrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3CF21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8kN-0006Fc-4c
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Uc-00012s-L2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ua-0004f7-Ep
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AdKmknnugHxI0CH7khxlUbe/K2/sscGCveI8C0uvRGw=;
 b=BZXS8NrhKq16zRN80dLNBhuZeLM2VjntT0Z8+57DDrPkLhaqpn9El1ADY7Fq2JyViL0vcH
 ukaUBTT1qowV4rtJvrvo+miUzal5cHVaRx73H4zQahA1eUaDD1J56e4sv+RB5hHzMoKIm6
 QVH8xtJ3QvYNcg1zDcgHyG2VOSq/mYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-pHoh_n4HMeqca-yE0Ym4MQ-1; Tue, 15 Sep 2020 06:47:17 -0400
X-MC-Unique: pHoh_n4HMeqca-yE0Ym4MQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87599802B72;
 Tue, 15 Sep 2020 10:47:16 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 051FC60BE2;
 Tue, 15 Sep 2020 10:47:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/22] qcow2: Convert qcow2_alloc_cluster_offset() into
 qcow2_alloc_host_offset()
Date: Tue, 15 Sep 2020 12:46:26 +0200
Message-Id: <20200915104627.699552-22-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

qcow2_alloc_cluster_offset() takes an (unaligned) guest offset and
returns the (aligned) offset of the corresponding cluster in the qcow2
image.

In practice none of the callers need to know where the cluster starts
so this patch makes the function calculate and return the final host
offset directly. The function is also renamed accordingly.

See 388e581615 for a similar change to qcow2_get_cluster_offset().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <9bfef50ec9200d752413be4fc2aeb22a28378817.1599833007.git.berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  6 +++---
 block/qcow2-cluster.c | 14 ++++++++++----
 block/qcow2.c         | 36 +++++++++++++-----------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index b73a4cf1f8..b71e444fca 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -901,9 +901,9 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
                           unsigned int *bytes, uint64_t *host_offset,
                           QCow2SubclusterType *subcluster_type);
-int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                               unsigned int *bytes, uint64_t *host_offset,
-                               QCowL2Meta **m);
+int qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
+                            unsigned int *bytes, uint64_t *host_offset,
+                            QCowL2Meta **m);
 int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                           uint64_t offset,
                                           int compressed_size,
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1a67b2d928..9acc6ce4ae 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1719,6 +1719,10 @@ out:
  * clusters (or subclusters) if necessary. The result can span a
  * combination of allocated and previously unallocated clusters.
  *
+ * Note that offset may not be cluster aligned. In this case, the returned
+ * *host_offset points to exact byte referenced by offset and therefore
+ * isn't cluster aligned as well.
+ *
  * On return, @host_offset is set to the beginning of the requested
  * area. This area is guaranteed to be contiguous on the qcow2 file
  * but it can be smaller than initially requested. In this case @bytes
@@ -1736,9 +1740,9 @@ out:
  *
  * Return 0 on success and -errno in error cases
  */
-int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
-                               unsigned int *bytes, uint64_t *host_offset,
-                               QCowL2Meta **m)
+int qcow2_alloc_host_offset(BlockDriverState *bs, uint64_t offset,
+                            unsigned int *bytes, uint64_t *host_offset,
+                            QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start, remaining;
@@ -1759,7 +1763,7 @@ again:
     while (true) {
 
         if (*host_offset == INV_OFFSET && cluster_offset != INV_OFFSET) {
-            *host_offset = start_of_cluster(s, cluster_offset);
+            *host_offset = cluster_offset;
         }
 
         assert(remaining >= cur_bytes);
@@ -1842,6 +1846,8 @@ again:
     *bytes -= remaining;
     assert(*bytes > 0);
     assert(*host_offset != INV_OFFSET);
+    assert(offset_into_cluster(s, *host_offset) ==
+           offset_into_cluster(s, offset));
 
     return 0;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index 1cb5daf39a..b05512718c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2559,7 +2559,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
     int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
-    uint64_t cluster_offset;
+    uint64_t host_offset;
     QCowL2Meta *l2meta = NULL;
     AioTaskPool *aio = NULL;
 
@@ -2580,16 +2580,13 @@ static coroutine_fn int qcow2_co_pwritev_part(
 
         qemu_co_mutex_lock(&s->lock);
 
-        ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
-                                         &cluster_offset, &l2meta);
+        ret = qcow2_alloc_host_offset(bs, offset, &cur_bytes,
+                                      &host_offset, &l2meta);
         if (ret < 0) {
             goto out_locked;
         }
 
-        assert(offset_into_cluster(s, cluster_offset) == 0);
-
-        ret = qcow2_pre_write_overlap_check(bs, 0,
-                                            cluster_offset + offset_in_cluster,
+        ret = qcow2_pre_write_overlap_check(bs, 0, host_offset,
                                             cur_bytes, true);
         if (ret < 0) {
             goto out_locked;
@@ -2601,7 +2598,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
             aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
         }
         ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_task_entry, 0,
-                             cluster_offset + offset_in_cluster, offset,
+                             host_offset, offset,
                              cur_bytes, qiov, qiov_offset, l2meta);
         l2meta = NULL; /* l2meta is consumed by qcow2_co_pwritev_task() */
         if (ret < 0) {
@@ -3129,13 +3126,12 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
 
     while (bytes) {
         cur_bytes = MIN(bytes, QEMU_ALIGN_DOWN(INT_MAX, s->cluster_size));
-        ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
-                                         &host_offset, &meta);
+        ret = qcow2_alloc_host_offset(bs, offset, &cur_bytes,
+                                      &host_offset, &meta);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Allocating clusters failed");
             goto out;
         }
-        host_offset += offset_into_cluster(s, offset);
 
         for (m = meta; m != NULL; m = m->next) {
             m->prealloc = true;
@@ -4043,10 +4039,9 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
                        BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of sectors in current iteration */
-    uint64_t cluster_offset;
+    uint64_t host_offset;
     QCowL2Meta *l2meta = NULL;
 
     assert(!bs->encrypted);
@@ -4057,31 +4052,26 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
 
         l2meta = NULL;
 
-        offset_in_cluster = offset_into_cluster(s, dst_offset);
         cur_bytes = MIN(bytes, INT_MAX);
 
         /* TODO:
          * If src->bs == dst->bs, we could simply copy by incrementing
          * the refcnt, without copying user data.
          * Or if src->bs == dst->bs->backing->bs, we could copy by discarding. */
-        ret = qcow2_alloc_cluster_offset(bs, dst_offset, &cur_bytes,
-                                         &cluster_offset, &l2meta);
+        ret = qcow2_alloc_host_offset(bs, dst_offset, &cur_bytes,
+                                      &host_offset, &l2meta);
         if (ret < 0) {
             goto fail;
         }
 
-        assert(offset_into_cluster(s, cluster_offset) == 0);
-
-        ret = qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes, true);
+        ret = qcow2_pre_write_overlap_check(bs, 0, host_offset, cur_bytes,
+                                            true);
         if (ret < 0) {
             goto fail;
         }
 
         qemu_co_mutex_unlock(&s->lock);
-        ret = bdrv_co_copy_range_to(src, src_offset,
-                                    s->data_file,
-                                    cluster_offset + offset_in_cluster,
+        ret = bdrv_co_copy_range_to(src, src_offset, s->data_file, host_offset,
                                     cur_bytes, read_flags, write_flags);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
-- 
2.26.2


