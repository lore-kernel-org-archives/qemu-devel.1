Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA189C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DA920776
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U/eXKayS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA920776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHqB-0002am-Mn
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXv-00043Q-01; Mon, 25 May 2020 14:09:55 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXq-0007ps-76; Mon, 25 May 2020 14:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=RVCbFs9i2wvpVbK9/MuPeRZS+QCNgjTqEUCxwaNf3JQ=; 
 b=U/eXKaySOgag2ZbwDTsxCqehgaAmUiuCnWt0EvSzcQhj8X5ziT1JfWPd9l0u40W3/2kRKZ/BFnXXteoGH3yvNqYddTWAGGxqqdLeI+tqzk31TQMB/JY4ip0HvN3Wv86X88j5Yb+Di7v1ZJ5UsESHJQgKysLZM3PMmITDQj4yIw52GWlBio59KXH3rrnHoWrXo2g25K1e3qwy0rT8UJHnl84ejgBe9MVXCd/QQ+PtNK3gWi2zm5I33eR7Ta08SWA37MFCAqDjxMNc5M54JulznobHnwbD8Mf0HlxU8/g8Go3fyFoYmLD+QRFiLBbLBjxhRypuAg2I5Mx/LYca3WCGow==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jdHXP-00088P-Ik; Mon, 25 May 2020 20:09:23 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jdHXA-0002N9-0N; Mon, 25 May 2020 20:09:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/32] qcow2: Add cluster type parameter to
 qcow2_get_host_offset()
Date: Mon, 25 May 2020 20:08:42 +0200
Message-Id: <101670d6282fcdb7c08d004921eebf1874a7a4c3.1590429901.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
References: <cover.1590429901.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 14:09:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This function returns an integer that can be either an error code or a
cluster type (a value from the QCow2ClusterType enum).

We are going to start using subcluster types instead of cluster types
in some functions so it's better to use the exact data types instead
of integers for clarity and in order to detect errors more easily.

This patch makes qcow2_get_host_offset() return 0 on success and
puts the returned cluster type in a separate parameter. There are no
semantic changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  3 ++-
 block/qcow2-cluster.c | 11 +++++++----
 block/qcow2.c         | 37 ++++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ba7614e406..9cd7cbd895 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -893,7 +893,8 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
-                          unsigned int *bytes, uint64_t *host_offset);
+                          unsigned int *bytes, uint64_t *host_offset,
+                          QCow2ClusterType *cluster_type);
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offset,
                                QCowL2Meta **m);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 32dc6e75e3..1e5681b0c6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -565,13 +565,14 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
  *
  * On exit, *bytes is the number of bytes starting at offset that have the same
  * cluster type and (if applicable) are stored contiguously in the image file.
+ * The cluster type is stored in *cluster_type.
  * Compressed clusters are always returned one by one.
  *
- * Returns the cluster type (QCOW2_CLUSTER_*) on success, -errno in error
- * cases.
+ * Returns 0 on success, -errno in error cases.
  */
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
-                          unsigned int *bytes, uint64_t *host_offset)
+                          unsigned int *bytes, uint64_t *host_offset,
+                          QCow2ClusterType *cluster_type)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
@@ -712,7 +713,9 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    return type;
+    *cluster_type = type;
+
+    return 0;
 
 fail:
     qcow2_cache_put(s->l2_table_cache, (void **)&l2_slice);
diff --git a/block/qcow2.c b/block/qcow2.c
index d4851e0e18..2806642f68 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2033,6 +2033,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t host_offset;
     unsigned int bytes;
+    QCow2ClusterType type;
     int ret, status = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -2044,7 +2045,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
 
     bytes = MIN(INT_MAX, count);
-    ret = qcow2_get_host_offset(bs, offset, &bytes, &host_offset);
+    ret = qcow2_get_host_offset(bs, offset, &bytes, &host_offset, &type);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
@@ -2052,15 +2053,15 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
     *pnum = bytes;
 
-    if ((ret == QCOW2_CLUSTER_NORMAL || ret == QCOW2_CLUSTER_ZERO_ALLOC) &&
+    if ((type == QCOW2_CLUSTER_NORMAL || type == QCOW2_CLUSTER_ZERO_ALLOC) &&
         !s->crypto) {
         *map = host_offset;
         *file = s->data_file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID;
     }
-    if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
+    if (type == QCOW2_CLUSTER_ZERO_PLAIN || type == QCOW2_CLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
-    } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
+    } else if (type != QCOW2_CLUSTER_UNALLOCATED) {
         status |= BDRV_BLOCK_DATA;
     }
     if (s->metadata_preallocation && (status & BDRV_BLOCK_DATA) &&
@@ -2269,6 +2270,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
     int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t host_offset = 0;
+    QCow2ClusterType type;
     AioTaskPool *aio = NULL;
 
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
@@ -2280,22 +2282,23 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         }
 
         qemu_co_mutex_lock(&s->lock);
-        ret = qcow2_get_host_offset(bs, offset, &cur_bytes, &host_offset);
+        ret = qcow2_get_host_offset(bs, offset, &cur_bytes,
+                                    &host_offset, &type);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
             goto out;
         }
 
-        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
-            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
-            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        if (type == QCOW2_CLUSTER_ZERO_PLAIN ||
+            type == QCOW2_CLUSTER_ZERO_ALLOC ||
+            (type == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
         {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
         } else {
             if (!aio && cur_bytes != bytes) {
                 aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
             }
-            ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, ret,
+            ret = qcow2_add_task(bs, aio, qcow2_co_preadv_task_entry, type,
                                  host_offset, offset, cur_bytes,
                                  qiov, qiov_offset, NULL);
             if (ret < 0) {
@@ -3841,6 +3844,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     if (head || tail) {
         uint64_t off;
         unsigned int nr;
+        QCow2ClusterType type;
 
         assert(head + bytes <= s->cluster_size);
 
@@ -3856,10 +3860,11 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
         bytes = s->cluster_size;
         nr = s->cluster_size;
-        ret = qcow2_get_host_offset(bs, offset, &nr, &off);
-        if (ret != QCOW2_CLUSTER_UNALLOCATED &&
-            ret != QCOW2_CLUSTER_ZERO_PLAIN &&
-            ret != QCOW2_CLUSTER_ZERO_ALLOC) {
+        ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
+        if (ret < 0 ||
+            (type != QCOW2_CLUSTER_UNALLOCATED &&
+             type != QCOW2_CLUSTER_ZERO_PLAIN &&
+             type != QCOW2_CLUSTER_ZERO_ALLOC)) {
             qemu_co_mutex_unlock(&s->lock);
             return -ENOTSUP;
         }
@@ -3923,16 +3928,18 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
     while (bytes != 0) {
         uint64_t copy_offset = 0;
+        QCow2ClusterType type;
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
         cur_write_flags = write_flags;
 
-        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes, &copy_offset);
+        ret = qcow2_get_host_offset(bs, src_offset, &cur_bytes,
+                                    &copy_offset, &type);
         if (ret < 0) {
             goto out;
         }
 
-        switch (ret) {
+        switch (type) {
         case QCOW2_CLUSTER_UNALLOCATED:
             if (bs->backing && bs->backing->bs) {
                 int64_t backing_length = bdrv_getlength(bs->backing->bs);
-- 
2.20.1


