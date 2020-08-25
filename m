Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD062065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt7d99FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD062065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUaA-0002Kt-Ur
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPR-00054c-Dj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPA-0000fy-T7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POK1627KTH6bcgH86t074+LexWq35p1/PhByk7FiDnM=;
 b=Gt7d99FUT1A4myPpW+X0RON/WggZI5iiAOXW1qExI2llky82fM5tsSAzR99N0AROknYVcz
 iSkFyAzVQvhEnPABJevq1PGanUWfRNDbwEQOlZMxqevhQriQZbFZIbQbp4pYGB2NLkRswg
 7gsTdtvT5hnyYw3Wxg6txrrMp+KdEo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-avJGK8nfM5-jgVzPlDcKug-1; Tue, 25 Aug 2020 04:34:03 -0400
X-MC-Unique: avJGK8nfM5-jgVzPlDcKug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C02F18A2251;
 Tue, 25 Aug 2020 08:34:02 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 136547C676;
 Tue, 25 Aug 2020 08:34:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/34] qcow2: Add subcluster support to qcow2_get_host_offset()
Date: Tue, 25 Aug 2020 10:32:58 +0200
Message-Id: <20200825083311.1098442-22-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The logic of this function remains pretty much the same, except that
it uses count_contiguous_subclusters(), which combines the logic of
count_contiguous_clusters() / count_contiguous_clusters_unallocated()
and checks individual subclusters.

qcow2_cluster_to_subcluster_type() is not necessary as a separate
function anymore so it's inlined into its caller.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <d2193fd48653a350d80f0eca1c67b1d9053fb2f3.1594396418.git.berto@igalia.com>
[mreitz: Initialize expected_type to anything]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  38 ++++-------
 block/qcow2-cluster.c | 150 ++++++++++++++++++++++--------------------
 2 files changed, 92 insertions(+), 96 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 5df761edc3..4fad40b96b 100644
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
index 5e7ae0843d..08ecb4ca0c 100644
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
+    bool check_offset = false;
+    uint64_t expected_offset = 0;
+    QCow2SubclusterType expected_type = QCOW2_SUBCLUSTER_NORMAL, type;
 
-    first_cluster_type = qcow2_get_cluster_type(bs, first_entry);
-    if (first_cluster_type == QCOW2_CLUSTER_UNALLOCATED) {
-        return 0;
-    }
-
-    /* must be allocated */
-    assert(first_cluster_type == QCOW2_CLUSTER_NORMAL ||
-           first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
+    assert(*l2_index + nb_clusters <= s->l2_slice_size);
 
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
@@ -602,13 +602,13 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
 
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
 
@@ -629,7 +629,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
+    sc_index = offset_to_sc_index(s, offset);
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -637,9 +639,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -647,7 +649,9 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -656,23 +660,16 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -698,9 +695,18 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -713,7 +719,7 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    *subcluster_type = qcow2_cluster_to_subcluster_type(type);
+    *subcluster_type = type;
 
     return 0;
 
-- 
2.26.2


