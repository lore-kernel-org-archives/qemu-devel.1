Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96781C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48960206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IVHMGRMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48960206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1ij-0006zR-9y
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xe-0006ue-RE; Tue, 05 May 2020 13:39:38 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xb-00089c-Lm; Tue, 05 May 2020 13:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=dt21YltqmDozOkNi/B5+nW8jw9yGE6PB+sp7M9EBbzU=; 
 b=IVHMGRMRcs7OsipiWN3MW3aMp01f5T6wlJKz1Kawn9cU2zRc3y4LLFIkz/FbvICVHFbLynqjM6PkLRgGdo97p7STtm+kA5r9jnBytWVZmy8hsHjsh4mwv0PMD901mmgJvvAPauDbDprqXqqX/1Q/qnZ5zvNB6DnP6mn1PN1BHHsE1S41DMhjpUllGNBibtUD+lB/6IMKv2CIDQ5Z2T32R+oHJTH42FXgcdpzR/dHbuVfVQP8AQ0I7b8MgQ5X6DvP79g0skIq5e+usmxKPSCBCMCVFT2+r2vc7CBp7WWHkT5hA6uYOIpB9sTPph2GG23tggWjOl7SkS6XeqHEBD/NnQ==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025T-91; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wd-00044B-2v; Tue, 05 May 2020 19:38:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/31] qcow2: Add subcluster support to
 qcow2_get_host_offset()
Date: Tue,  5 May 2020 19:38:20 +0200
Message-Id: <d4b41accb4c52f31dc7faa3b58084062ac4407f4.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The logic of this function remains pretty much the same, except that
it uses count_contiguous_subclusters(), which combines the logic of
count_contiguous_clusters() / count_contiguous_clusters_unallocated()
and checks individual subclusters.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h         |  38 +++++-------
 block/qcow2-cluster.c | 141 ++++++++++++++++++++----------------------
 2 files changed, 82 insertions(+), 97 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 1663b5359c..05e3ef0ece 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -692,29 +692,6 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
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
@@ -759,7 +736,20 @@ QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
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
index ffcb11edda..f500cbfb8e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -376,66 +376,58 @@ fail:
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
  */
-static int count_contiguous_clusters(BlockDriverState *bs, int nb_clusters,
-        int cluster_size, uint64_t *l2_slice, int l2_index, uint64_t stop_flags)
+static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
+                                        unsigned sc_index, uint64_t *l2_slice,
+                                        int l2_index)
 {
     BDRVQcow2State *s = bs->opaque;
-    int i;
-    QCow2ClusterType first_cluster_type;
-    uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
-    uint64_t first_entry = get_l2_entry(s, l2_slice, l2_index);
-    uint64_t offset = first_entry & mask;
-
-    first_cluster_type = qcow2_get_cluster_type(bs, first_entry);
-    if (first_cluster_type == QCOW2_CLUSTER_UNALLOCATED) {
-        return 0;
+    int i, j, count = 0;
+    uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
+    bool check_offset = true;
+    QCow2SubclusterType type =
+        qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
+
+    assert(type != QCOW2_SUBCLUSTER_INVALID); /* The caller should check this */
+    assert(l2_index + nb_clusters <= s->l2_size);
+
+    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
+        /* Compressed clusters are always processed one by one */
+        return s->subclusters_per_cluster - sc_index;
     }
 
-    /* must be allocated */
-    assert(first_cluster_type == QCOW2_CLUSTER_NORMAL ||
-           first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
-
-    for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index + i) & mask;
-        if (offset + (uint64_t) i * cluster_size != l2_entry) {
-            break;
-        }
+    if (type == QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN ||
+        type == QCOW2_SUBCLUSTER_ZERO_PLAIN) {
+        check_offset = false;
     }
 
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
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
-        QCow2ClusterType type = qcow2_get_cluster_type(bs, entry);
-
-        if (type != wanted_type) {
-            break;
+        l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+        if (check_offset && expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
+            return count;
+        }
+        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
+            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
+                return count;
+            }
+            count++;
         }
+        expected_offset += s->cluster_size;
     }
 
-    return i;
+    return count;
 }
 
 static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
@@ -524,12 +516,12 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -550,13 +542,13 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
 
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
 
@@ -577,7 +569,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
+    sc_index = offset_to_sc_index(s, offset);
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -585,9 +579,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -595,7 +589,13 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
     switch (type) {
-    case QCOW2_CLUSTER_COMPRESSED:
+    case QCOW2_SUBCLUSTER_INVALID:
+        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry found "
+                                " (L2 offset: %#" PRIx64 ", L2 index: %#x)",
+                                l2_offset, l2_index);
+        ret = -EIO;
+        goto fail;
+    case QCOW2_SUBCLUSTER_COMPRESSED:
         if (has_data_file(bs)) {
             qcow2_signal_corruption(bs, true, -1, -1, "Compressed cluster "
                                     "entry found in image with external data "
@@ -604,24 +604,17 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -647,9 +640,11 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
         abort();
     }
 
+    sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
+                                      l2_slice, l2_index);
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
-    bytes_available = (int64_t)c * s->cluster_size;
+    bytes_available = ((int64_t)sc + sc_index) << s->subcluster_bits;
 
 out:
     if (bytes_available > bytes_needed) {
@@ -662,7 +657,7 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
+    *subcluster_type = type;
 
     return 0;
 
-- 
2.20.1


