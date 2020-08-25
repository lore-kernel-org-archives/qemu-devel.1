Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3294C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7BF2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X68WhzXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7BF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUdm-00023S-Vm
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPX-0005Bv-7s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPP-0000hn-6i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG6SkOayHtZafH5MCyV+bvGceoz5k9ttBs5EYi+2QfQ=;
 b=X68WhzXZXtYhqVzZAiOaMPGscDQZdlE4JRdVmnVxrW6ojY/siDpG/2X4ni8q25hUoeNhdG
 iVCyd/yIZzL0WL3th0+8SdQkcQwqod83rO5hujVKzxO4tfMm1F10/YW/mdaUptEOKt/W2D
 1IgXWF3QCqd8/4ssot/wGGWD+RnyNPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177--ywQron9OE2-V0-eHlvsTQ-1; Tue, 25 Aug 2020 04:34:19 -0400
X-MC-Unique: -ywQron9OE2-V0-eHlvsTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB731074641;
 Tue, 25 Aug 2020 08:34:18 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 865E61A92A;
 Tue, 25 Aug 2020 08:34:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 28/34] qcow2: Add subcluster support to qcow2_co_pwrite_zeroes()
Date: Tue, 25 Aug 2020 10:33:05 +0200
Message-Id: <20200825083311.1098442-29-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <17e05e2ee7e12f10dcf012da81e83ebe27eb3bef.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  4 +--
 block/qcow2-cluster.c | 81 +++++++++++++++++++++++++++++++++++++++----
 block/qcow2.c         | 33 +++++++++---------
 3 files changed, 94 insertions(+), 24 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4fad40b96b..4ef4ae4ab0 100644
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
index 1e84bd8e2e..9d349d61c6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2016,12 +2016,59 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
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
+    assert(offset_into_subcluster(s, offset) == 0);
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
 
@@ -2036,8 +2083,8 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
     }
 
     /* Caller must pass aligned values, except at image end */
-    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+    assert(offset_into_subcluster(s, offset) == 0);
+    assert(offset_into_subcluster(s, end_offset) == 0 ||
            end_offset >= bs->total_sectors << BDRV_SECTOR_BITS);
 
     /*
@@ -2052,11 +2099,26 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
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
@@ -2068,6 +2130,13 @@ int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
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
index 9990535c46..0cf0b0a9fb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1913,7 +1913,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         /* Encryption works on a sector granularity */
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
-    bs->bl.pwrite_zeroes_alignment = s->cluster_size;
+    bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
     bs->bl.pdiscard_alignment = s->cluster_size;
 }
 
@@ -3833,8 +3833,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
-    uint32_t head = offset % s->cluster_size;
-    uint32_t tail = (offset + bytes) % s->cluster_size;
+    uint32_t head = offset_into_subcluster(s, offset);
+    uint32_t tail = ROUND_UP(offset + bytes, s->subcluster_size) -
+        (offset + bytes);
 
     trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset, bytes);
     if (offset + bytes == bs->total_sectors * BDRV_SECTOR_SIZE) {
@@ -3846,20 +3847,19 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
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
@@ -3875,8 +3875,8 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
 
     trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, bytes);
 
-    /* Whatever is left can use real zero clusters */
-    ret = qcow2_cluster_zeroize(bs, offset, bytes, flags);
+    /* Whatever is left can use real zero subclusters */
+    ret = qcow2_subcluster_zeroize(bs, offset, bytes, flags);
     qemu_co_mutex_unlock(&s->lock);
 
     return ret;
@@ -4357,15 +4357,16 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
-        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->cluster_size);
+        uint64_t zero_start = QEMU_ALIGN_UP(old_length, s->subcluster_size);
 
         /*
-         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
-         * requires a cluster-aligned start. The end may be unaligned if it is
-         * at the end of the image (which it is here).
+         * Use zero clusters as much as we can. qcow2_subcluster_zeroize()
+         * requires a subcluster-aligned start. The end may be unaligned if
+         * it is at the end of the image (which it is here).
          */
         if (offset > zero_start) {
-            ret = qcow2_cluster_zeroize(bs, zero_start, offset - zero_start, 0);
+            ret = qcow2_subcluster_zeroize(bs, zero_start, offset - zero_start,
+                                           0);
             if (ret < 0) {
                 error_setg_errno(errp, -ret, "Failed to zero out new clusters");
                 goto fail;
-- 
2.26.2


