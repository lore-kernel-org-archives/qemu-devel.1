Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4655020776
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PL8Pn8G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4655020776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHm7-0003VF-F8
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXw-00046a-8q; Mon, 25 May 2020 14:09:56 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXq-0007pC-6i; Mon, 25 May 2020 14:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=r9h4dLQSBF3SFB6+9xcKHSJ+KZ4mJEr2CS21yaFblV0=; 
 b=PL8Pn8G6tPQp+CyU10ypK9ZVDQBPnfjaSV/TlkInOgKggdGOJDREeXDs1zMRwidOhPUSmdMfN5WloZpMmi1W3MIKLs8x7BUa0GFi/Ptk7vt1AOhJv3Ib5EwG1iyp+w1Q8NT8G2bHs/v7poIGUyD2nRPUv5UsRDMa9cM9aHNUo9KLcnm6wGYrAiZ+HEdrJn3jnTIyZUiNrRtQU/tHVe99Hjv5XvfIumMMwR51qe0HiCjpxv3W3rYGyOaMlwfAWS1XL1i3NmWl5e0ER+zlEBxFGfO1/ct9q0DpaSlXG8/eOhgoWDQicA1AMMjYeWXGwYkaJULwuypjVFglfa9VRWrSGA==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jdHXO-00088U-MM; Mon, 25 May 2020 20:09:22 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jdHXA-0002NM-52; Mon, 25 May 2020 20:09:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 21/32] qcow2: Add subcluster support to
 qcow2_get_host_offset()
Date: Mon, 25 May 2020 20:08:46 +0200
Message-Id: <46add38625edc8ffec0056018d2cc512efda9a55.1590429901.git.berto@igalia.com>
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

The logic of this function remains pretty much the same, except that
it uses count_contiguous_subclusters(), which combines the logic of
count_contiguous_clusters() / count_contiguous_clusters_unallocated()
and checks individual subclusters.

qcow2_cluster_to_subcluster_type() is not necessary as a separate
function anymore so it's inlined into its caller.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  38 ++++-------
 block/qcow2-cluster.c | 150 ++++++++++++++++++++++--------------------
 2 files changed, 92 insertions(+), 96 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 84c06d9bba..32c68ead9a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -710,29 +710,6 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
     }
 }
 
-/*
- * For an image without extended L2 entries, return the
- * QCow2SubclusterType equivalent of a given QCow2ClusterType.
- */
-static inline
-QCow2SubclusterType qcow2_cluster_to_subcluster_type(QCow2ClusterType type)
-{
-    switch (type) {
-    case QCOW2_CLUSTER_COMPRESSED:
-        return QCOW2_SUBCLUSTER_COMPRESSED;
-    case QCOW2_CLUSTER_ZERO_PLAIN:
-        return QCOW2_SUBCLUSTER_ZERO_PLAIN;
-    case QCOW2_CLUSTER_ZERO_ALLOC:
-        return QCOW2_SUBCLUSTER_ZERO_ALLOC;
-    case QCOW2_CLUSTER_NORMAL:
-        return QCOW2_SUBCLUSTER_NORMAL;
-    case QCOW2_CLUSTER_UNALLOCATED:
-        return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * In an image without subsclusters @l2_bitmap is ignored and
  * @sc_index must be 0.
@@ -776,7 +753,20 @@ QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
             g_assert_not_reached();
         }
     } else {
-        return qcow2_cluster_to_subcluster_type(type);
+        switch (type) {
+        case QCOW2_CLUSTER_COMPRESSED:
+            return QCOW2_SUBCLUSTER_COMPRESSED;
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+            return QCOW2_SUBCLUSTER_ZERO_PLAIN;
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+            return QCOW2_SUBCLUSTER_ZERO_ALLOC;
+        case QCOW2_CLUSTER_NORMAL:
+            return QCOW2_SUBCLUSTER_NORMAL;
+        case QCOW2_CLUSTER_UNALLOCATED:
+            return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 59dd9bda29..2f3bd3a882 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -426,66 +426,66 @@ static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
 }
 
 /*
- * Checks how many clusters in a given L2 slice are contiguous in the image
- * file. As soon as one of the flags in the bitmask stop_flags changes compared
- * to the first cluster, the search is stopped and the cluster is not counted
- * as contiguous. (This allows it, for example, to stop at the first compressed
- * cluster which may require a different handling)
+ * Return the number of contiguous subclusters of the exact same type
+ * in a given L2 slice, starting from cluster @l2_index, subcluster
+ * @sc_index. Allocated subclusters are required to be contiguous in
+ * the image file.
+ * At most @nb_clusters are checked (note that this means clusters,
+ * not subclusters).
+ * Compressed clusters are always processed one by one but for the
+ * purpose of this count they are treated as if they were divided into
+ * subclusters of size s->subcluster_size.
+ * On failure return -errno and update @l2_index to point to the
+ * invalid entry.
  */
-static int count_contiguous_clusters(BlockDriverState *bs, int nb_clusters,
-        int cluster_size, uint64_t *l2_slice, int l2_index, uint64_t stop_flags)
+static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
+                                        unsigned sc_index, uint64_t *l2_slice,
+                                        unsigned *l2_index)
 {
     BDRVQcow2State *s = bs->opaque;
-    int i;
-    QCow2ClusterType first_cluster_type;
-    uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
-    uint64_t first_entry = get_l2_entry(s, l2_slice, l2_index);
-    uint64_t offset = first_entry & mask;
+    int i, count = 0;
+    bool check_offset;
+    uint64_t expected_offset;
+    QCow2SubclusterType expected_type, type;
 
-    first_cluster_type = qcow2_get_cluster_type(bs, first_entry);
-    if (first_cluster_type == QCOW2_CLUSTER_UNALLOCATED) {
-        return 0;
-    }
-
-    /* must be allocated */
-    assert(first_cluster_type == QCOW2_CLUSTER_NORMAL ||
-           first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
+    assert(*l2_index + nb_clusters <= s->l2_size);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index + i) & mask;
-        if (offset + (uint64_t) i * cluster_size != l2_entry) {
+        unsigned first_sc = (i == 0) ? sc_index : 0;
+        uint64_t l2_entry = get_l2_entry(s, l2_slice, *l2_index + i);
+        uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, *l2_index + i);
+        int ret = qcow2_get_subcluster_range_type(bs, l2_entry, l2_bitmap,
+                                                  first_sc, &type);
+        if (ret < 0) {
+            *l2_index += i; /* Point to the invalid entry */
+            return -EIO;
+        }
+        if (i == 0) {
+            if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
+                /* Compressed clusters are always processed one by one */
+                return ret;
+            }
+            expected_type = type;
+            expected_offset = l2_entry & L2E_OFFSET_MASK;
+            check_offset = (type == QCOW2_SUBCLUSTER_NORMAL ||
+                            type == QCOW2_SUBCLUSTER_ZERO_ALLOC ||
+                            type == QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC);
+        } else if (type != expected_type) {
             break;
+        } else if (check_offset) {
+            expected_offset += s->cluster_size;
+            if (expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
+                break;
+            }
         }
-    }
-
-        return i;
-}
-
-/*
- * Checks how many consecutive unallocated clusters in a given L2
- * slice have the same cluster type.
- */
-static int count_contiguous_clusters_unallocated(BlockDriverState *bs,
-                                                 int nb_clusters,
-                                                 uint64_t *l2_slice,
-                                                 int l2_index,
-                                                 QCow2ClusterType wanted_type)
-{
-    BDRVQcow2State *s = bs->opaque;
-    int i;
-
-    assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
-           wanted_type == QCOW2_CLUSTER_UNALLOCATED);
-    for (i = 0; i < nb_clusters; i++) {
-        uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
-        QCow2ClusterType type = qcow2_get_cluster_type(bs, entry);
-
-        if (type != wanted_type) {
+        count += ret;
+        /* Stop if there are type changes before the end of the cluster */
+        if (first_sc + ret < s->subclusters_per_cluster) {
             break;
         }
     }
 
-    return i;
+    return count;
 }
 
 static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
@@ -574,12 +574,12 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
                           QCow2SubclusterType *subcluster_type)
 {
     BDRVQcow2State *s = bs->opaque;
-    unsigned int l2_index;
-    uint64_t l1_index, l2_offset, *l2_slice, l2_entry;
-    int c;
+    unsigned int l2_index, sc_index;
+    uint64_t l1_index, l2_offset, *l2_slice, l2_entry, l2_bitmap;
+    int sc;
     unsigned int offset_in_cluster;
     uint64_t bytes_available, bytes_needed, nb_clusters;
-    QCow2ClusterType type;
+    QCow2SubclusterType type;
     int ret;
 
     offset_in_cluster = offset_into_cluster(s, offset);
@@ -600,13 +600,13 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
 
     l1_index = offset_to_l1_index(s, offset);
     if (l1_index >= s->l1_size) {
-        type = QCOW2_CLUSTER_UNALLOCATED;
+        type = QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
         goto out;
     }
 
     l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
     if (!l2_offset) {
-        type = QCOW2_CLUSTER_UNALLOCATED;
+        type = QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
         goto out;
     }
 
@@ -627,7 +627,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
+    sc_index = offset_to_sc_index(s, offset);
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -635,9 +637,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
      * true */
     assert(nb_clusters <= INT_MAX);
 
-    type = qcow2_get_cluster_type(bs, l2_entry);
-    if (s->qcow_version < 3 && (type == QCOW2_CLUSTER_ZERO_PLAIN ||
-                                type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
+    if (s->qcow_version < 3 && (type == QCOW2_SUBCLUSTER_ZERO_PLAIN ||
+                                type == QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
         qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
                                 " in pre-v3 image (L2 offset: %#" PRIx64
                                 ", L2 index: %#x)", l2_offset, l2_index);
@@ -645,7 +647,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
     switch (type) {
-    case QCOW2_CLUSTER_COMPRESSED:
+    case QCOW2_SUBCLUSTER_INVALID:
+        break; /* This is handled by count_contiguous_subclusters() below */
+    case QCOW2_SUBCLUSTER_COMPRESSED:
         if (has_data_file(bs)) {
             qcow2_signal_corruption(bs, true, -1, -1, "Compressed cluster "
                                     "entry found in image with external data "
@@ -654,24 +658,17 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
             ret = -EIO;
             goto fail;
         }
-        /* Compressed clusters can only be processed one by one */
-        c = 1;
         *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
         break;
-    case QCOW2_CLUSTER_ZERO_PLAIN:
-    case QCOW2_CLUSTER_UNALLOCATED:
-        /* how many empty clusters ? */
-        c = count_contiguous_clusters_unallocated(bs, nb_clusters,
-                                                  l2_slice, l2_index, type);
+    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
         *host_offset = 0;
         break;
-    case QCOW2_CLUSTER_ZERO_ALLOC:
-    case QCOW2_CLUSTER_NORMAL: {
+    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+    case QCOW2_SUBCLUSTER_NORMAL:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
         uint64_t host_cluster_offset = l2_entry & L2E_OFFSET_MASK;
         *host_offset = host_cluster_offset + offset_in_cluster;
-        /* how many allocated clusters ? */
-        c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      l2_slice, l2_index, QCOW_OFLAG_ZERO);
         if (offset_into_cluster(s, host_cluster_offset)) {
             qcow2_signal_corruption(bs, true, -1, -1,
                                     "Cluster allocation offset %#"
@@ -697,9 +694,18 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
         abort();
     }
 
+    sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
+                                      l2_slice, &l2_index);
+    if (sc < 0) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry found "
+                                " (L2 offset: %#" PRIx64 ", L2 index: %#x)",
+                                l2_offset, l2_index);
+        ret = -EIO;
+        goto fail;
+    }
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
-    bytes_available = (int64_t)c * s->cluster_size;
+    bytes_available = ((int64_t)sc + sc_index) << s->subcluster_bits;
 
 out:
     if (bytes_available > bytes_needed) {
@@ -712,7 +718,7 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
+    *subcluster_type = type;
 
     return 0;
 
-- 
2.20.1


