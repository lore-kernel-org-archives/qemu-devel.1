Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE21C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353442075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f6rZDOSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353442075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs5L-0006uG-Ax
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzy-0002wo-Rr; Sun, 24 May 2020 10:53:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzv-0002lO-Mu; Sun, 24 May 2020 10:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=BQBzFbT8wnqCHQe0uUvmfEGGkpi4ghjE06/p8atLNIQ=; 
 b=f6rZDOSz1F8YvQiWUJPkOH2/xoX65nMSYgmQF4c6g+NXWwrsYfRunfBofGIaF1Yp2HkWhRP+Yu0jipXxISBvlsG6DncQagHYRSjO+JtA/gSsqsM4GJ3InFCfziicEP8p4oyOxIpN3Uczru48fAEkckChg+K5L+nbGnsW/Q08z7Yb06bhSB/w/HP2ADestjs1oZCpfpta3hISxd+VjpgQiiJ2qyXwH4lYr/F17VbUFro+fXPN8jGeJL0nZJp87IBMQpAkzr8gbI5V9U40ZzAWR8l3C/D0gPzYYutXf1zJFcsk4P3vPXr48V1aJh7A24ahjQMezuwdRPe4MRuACeJf5g==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrzF-0007GK-GZ; Sun, 24 May 2020 16:52:25 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005Ks-HI; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 28/32] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
Date: Sun, 24 May 2020 16:51:48 +0200
Message-Id: <c332a185d86773a0ca3c9c0b1094691a4bd260e7.1590331741.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
References: <cover.1590331741.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:52:20
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

This works now at the subcluster level and pwrite_zeroes_alignment is
updated accordingly.

qcow2_cluster_zeroize() is turned into qcow2_subcluster_zeroize() with
the following changes:

   - The request can now be subcluster-aligned.

   - The cluster-aligned body of the request is still zeroized using
     zero_in_l2_slice() as before.

   - The subcluster-aligned head and tail of the request are zeroized
     with the new zero_l2_subclusters() function.

There is just one thing to take into account for a possible future
improvement: compressed clusters cannot be partially zeroized so
zero_l2_subclusters() on the head or the tail can return -ENOTSUP.
This makes the caller repeat the *complete* request and write actual
zeroes to disk. This is sub-optimal because

   1) if the head area was compressed we would still be able to use
      the fast path for the body and possibly the tail.

   2) if the tail area was compressed we are writing zeroes to the
      head and the body areas, which are already zeroized.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  4 +--
 block/qcow2-cluster.c | 80 +++++++++++++++++++++++++++++++++++++++----
 block/qcow2.c         | 27 ++++++++-------
 3 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 32c68ead9a..ece5f1cb5a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -898,8 +898,8 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
 int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, enum qcow2_discard_type type,
                           bool full_discard);
-int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, int flags);
+int qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                             uint64_t bytes, int flags);
 
 int qcow2_expand_zero_clusters(BlockDriverState *bs,
                                BlockDriverAmendStatusCB *status_cb,
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3639dc8057..b808d6ad95 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2014,12 +2014,58 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }
 
-int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, int flags)
+static int zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
+                               unsigned nb_subclusters)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *l2_slice;
+    uint64_t old_l2_bitmap, l2_bitmap;
+    int l2_index, ret, sc = offset_to_sc_index(s, offset);
+
+    /* For full clusters use zero_in_l2_slice() instead */
+    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
+    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
+
+    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
+    if (ret < 0) {
+        return ret;
+    }
+
+    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice, l2_index))) {
+    case QCOW2_CLUSTER_COMPRESSED:
+        ret = -ENOTSUP; /* We cannot partially zeroize compressed clusters */
+        goto out;
+    case QCOW2_CLUSTER_NORMAL:
+    case QCOW2_CLUSTER_UNALLOCATED:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+
+    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+
+    if (old_l2_bitmap != l2_bitmap) {
+        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+    }
+
+    ret = 0;
+out:
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
+
+    return ret;
+}
+
+int qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                             uint64_t bytes, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
+    unsigned head, tail;
     int64_t cleared;
     int ret;
 
@@ -2034,8 +2080,8 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
     }
 
     /* Caller must pass aligned values, except at image end */
-    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+    assert(offset_into_subcluster(s, offset) == 0);
+    assert(offset_into_subcluster(s, end_offset) == 0 ||
            end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
 
     /* The zero flag is only supported by version 3 and newer */
@@ -2043,11 +2089,26 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
         return -ENOTSUP;
     }
 
-    /* Each L2 slice is handled by its own loop iteration */
-    nb_clusters = size_to_clusters(s, bytes);
+    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
+    offset += head;
+
+    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
+        end_offset - MAX(offset, start_of_cluster(s, end_offset));
+    end_offset -= tail;
 
     s->cache_discards = true;
 
+    if (head) {
+        ret = zero_l2_subclusters(bs, offset - head,
+                                  size_to_subclusters(s, head));
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    /* Each L2 slice is handled by its own loop iteration */
+    nb_clusters = size_to_clusters(s, end_offset - offset);
+
     while (nb_clusters > 0) {
         cleared = zero_in_l2_slice(bs, offset, nb_clusters, flags);
         if (cleared < 0) {
@@ -2059,6 +2120,13 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
         offset += (cleared * s->cluster_size);
     }
 
+    if (tail) {
+        ret = zero_l2_subclusters(bs, end_offset, size_to_subclusters(s, tail));
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     ret = 0;
 fail:
     s->cache_discards = false;
diff --git a/block/qcow2.c b/block/qcow2.c
index 430b4e423a..40988fff55 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1903,7 +1903,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         /* Encryption works on a sector granularity */
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
-    bs->bl.pwrite_zeroes_alignment = s->cluster_size;
+    bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
 }
 
@@ -3840,8 +3840,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
-    uint32_t head = offset % s->cluster_size;
-    uint32_t tail = (offset + bytes) % s->cluster_size;
+    uint32_t head = offset_into_subcluster(s, offset);
+    uint32_t tail = ROUND_UP(offset + bytes, s->subcluster_size) -
+        (offset + bytes);
 
     trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, bytes);
     if (offset + bytes == bs->total_sectors * BDRV_SECTOR_SIZE) {
@@ -3853,20 +3854,19 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         unsigned int nr;
         QCow2SubclusterType type;
 
-        assert(head + bytes <= s->cluster_size);
+        assert(head + bytes + tail <= s->subcluster_size);
 
         /* check whether remainder of cluster already reads as zero */
         if (!(is_zero(bs, offset - head, head) &&
-              is_zero(bs, offset + bytes,
-                      tail ? s->cluster_size - tail : 0))) {
+              is_zero(bs, offset + bytes, tail))) {
             return -ENOTSUP;
         }
 
         qemu_co_mutex_lock(&s->lock);
         /* We can have new write after previous check */
-        offset = QEMU_ALIGN_DOWN(offset, s->cluster_size);
-        bytes = s->cluster_size;
-        nr = s->cluster_size;
+        offset -= head;
+        bytes = s->subcluster_size;
+        nr = s->subcluster_size;
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
             (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
@@ -3882,8 +3882,8 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
 
     trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, bytes);
 
-    /* Whatever is left can use real zero clusters */
-    ret = qcow2_cluster_zeroize(bs, offset, bytes, flags);
+    /* Whatever is left can use real zero subclusters */
+    ret = qcow2_subcluster_zeroize(bs, offset, bytes, flags);
     qemu_co_mutex_unlock(&s->lock);
 
     return ret;
@@ -4356,12 +4356,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
 
         /*
-         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
+         * Use zero clusters as much as we can. qcow2_subcluster_zeroize()
          * requires a cluster-aligned start. The end may be unaligned if it is
          * at the end of the image (which it is here).
          */
         if (offset > zero_start) {
-            ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
+            ret = qcow2_subcluster_zeroize(bs, zero_start, offset - zero_start,
+                                           0);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "Failed to zero out new clusters");
                 goto fail;
-- 
2.20.1


