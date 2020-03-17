Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55818C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BA920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OOndXjn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BA920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH3M-0003fV-9A
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmu-0003Mn-57
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGms-0008UH-GF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:00 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGms-0005Ys-5E; Tue, 17 Mar 2020 14:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=woi6foyn/GnsQXxokCfj/612eLxPV2bZbIy780eGch4=; 
 b=OOndXjn7oDji51bTAsQqtUeSdocQYLxrCgRLxHXRY7rd0r6xQ5e50lIG6RHnHgsgyW1pmkSbjqzgkbaJrsQp9kWTD+67kVTdU24Z6tCL1OoJxeOfb1rfGwVVB6Wne8hqqry0mNc+ZE6mjrLYLMHOPOTsb2LvBtbm1Dx/YCHlrhzoywalGTVauet9cBU9DMCScqc+niaQFrRwz31Cd63to6+c1TdLU5B6pj33JrsRjWpCIWhPJgHIfy57UqphjXahd/PVUtisPpdX6Lm+Lxr7vaLL2ERk+8sTGwkxhPQ27wyi/vYYDxa6vkUYB9OC0tFc8/5ruQwkIW5UoLKffpwaxw==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015Q-0o; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OV-H0; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/30] qcow2: Add cluster type parameter to
 qcow2_get_host_offset()
Date: Tue, 17 Mar 2020 19:16:11 +0100
Message-Id: <348c0b057802b5b35eefe3dc7cc8ef2964024ed5.1584468723.git.berto@igalia.com>
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

This function returns an integer that can be either an error code or a
cluster type (a value from the QCow2ClusterType enum).

We are going to start using subcluster types instead of cluster types
in some functions so it's better to use the exact data types instead
of integers for clarity and in order to detect errors more easily.

This patch makes qcow2_get_host_offset() return 0 on success and
puts the returned cluster type in a separate parameter. There are no
semantic changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  3 ++-
 block/qcow2-cluster.c | 11 +++++++----
 block/qcow2.c         | 37 ++++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 52865787ee..6b7b286b91 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -859,7 +859,8 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
                           uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
 int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
-                          unsigned int *bytes, uint64_t *host_offset);
+                          unsigned int *bytes, uint64_t *host_offset,
+                          QCow2ClusterType *cluster_type);
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offset,
                                QCowL2Meta **m);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 41a23c5305..acfcf8ea4c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -514,13 +514,14 @@ static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
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
@@ -663,7 +664,9 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    return type;
+    *cluster_type = type;
+
+    return 0;
 
 fail:
     qcow2_cache_put(s->l2_table_cache, (void **)&l2_slice);
diff --git a/block/qcow2.c b/block/qcow2.c
index d3b8581aed..48e188152c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1971,6 +1971,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t host_offset;
     unsigned int bytes;
+    QCow2ClusterType type;
     int ret, status = 0;
 
     qemu_co_mutex_lock(&s->lock);
@@ -1982,7 +1983,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     }
 
     bytes = MIN(INT_MAX, count);
-    ret = qcow2_get_host_offset(bs, offset, &bytes, &host_offset);
+    ret = qcow2_get_host_offset(bs, offset, &bytes, &host_offset, &type);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         return ret;
@@ -1990,15 +1991,15 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
 
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
@@ -2207,6 +2208,7 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
     int ret = 0;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t host_offset = 0;
+    QCow2ClusterType type;
     AioTaskPool *aio = NULL;
 
     while (bytes != 0 && aio_task_pool_status(aio) == 0) {
@@ -2218,22 +2220,23 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
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
@@ -3716,6 +3719,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     if (head || tail) {
         uint64_t off;
         unsigned int nr;
+        QCow2ClusterType type;
 
         assert(head + bytes <= s->cluster_size);
 
@@ -3731,10 +3735,11 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
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
@@ -3792,16 +3797,18 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
 
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


