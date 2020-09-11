Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F83C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBF22226A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cjMHGRlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBF22226A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjmr-0006yH-0P
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGjka-0004OR-Lj; Fri, 11 Sep 2020 10:10:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGjkW-0000hA-Bo; Fri, 11 Sep 2020 10:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=8tUH1cre38QiqztWRmULDkd1dxIU2P18eyDpmVz0nYc=; 
 b=cjMHGRlH3VzLqU9oy9/rnF2nTPQubbKJHJI8xlUmDeJqTZwWf4ZL1nNUYJPiHZW1VNDXyNVOitVaeqt6qgT7bmjcU23v8eaHeABxPmn88SSB/jJKka/FQw16deEEv2M2cj3+//DYb0wii2+tWOrLiyyxa6/ytwqmYYsIiwyrUUaUkxz0v9LqfuC1ba3ads4TuIVs9LhcroFCoROcjpliBZ8D/teJE/elJbVZQu4F0CiFojArRXwWd2EAI6d3BbkkR890u37Bzb9lJukbBWtOtAnsktcIhm1ZXETVIL9fbgqCV/7GO6ahc8oaruBhHiafhUacPwWyV5aYY7o77XpelQ==;
Received: from [81.0.39.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kGjkS-0004om-00; Fri, 11 Sep 2020 16:09:56 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kGjkF-0000zw-3D; Fri, 11 Sep 2020 16:09:43 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qcow2: Convert qcow2_alloc_cluster_offset() into
 qcow2_alloc_host_offset()
Date: Fri, 11 Sep 2020 16:09:42 +0200
Message-Id: <9bfef50ec9200d752413be4fc2aeb22a28378817.1599833007.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599833007.git.berto@igalia.com>
References: <cover.1599833007.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 10:09:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_alloc_cluster_offset() takes an (unaligned) guest offset and
returns the (aligned) offset of the corresponding cluster in the qcow2
image.

In practice none of the callers need to know where the cluster starts
so this patch makes the function calculate and return the final host
offset directly. The function is also renamed accordingly.

See 388e581615 for a similar change to qcow2_get_cluster_offset().

Signed-off-by: Alberto Garcia <berto@igalia.com>
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
2.20.1


