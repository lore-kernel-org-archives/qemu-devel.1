Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA50CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B16214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rOyGHSVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B16214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTkV-0007zm-SE
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZk-00006r-A9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZi-0005Ma-G4
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:20 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZg-0005F2-9D; Sat, 26 Oct 2019 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=N02rNnYxAWKgjBXR/pQJOdFYoHP99UpZ8ZnG2b9Blmc=; 
 b=rOyGHSVfmoHnG/5ICKiJc/ngCQUxzYtznptpkSz0StpM7KtLQDjgG/HNUDeg+th317VpujRybKlUmnv5+/dxGEZF1z7dJdET28f5SPhXJqraSOHmT1N0dAsOYjsfIQtDWPOYbdGt84KKq+trHevJ5WQhGPC9MKzSCYxll+3BmyRB+mk9MvRgqB21XER2/tyPVJmvkg7WuL92LbJDP+Zvxm6TGiVNCkDTMEv69N+/61DNN2AxarfZw1DseYRHxkRmsHMnNHQP1FcaHf8RI9XLT2N3pDOyp24WAJUs207ybZBVWISbY4/qAv4wkporEoHzGDibPVW5sHl5Zm4JybX/jA==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-000461-Rf; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001PT-LK; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 14/26] qcow2: Add subcluster support to
 qcow2_get_cluster_offset()
Date: Sun, 27 Oct 2019 00:25:16 +0300
Message-Id: <6932c2ddfe19a564cad7c54246290e166525fc46.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
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

The logic of this function remains pretty much the same, except that
it uses count_contiguous_subclusters(), which combines the logic of
count_contiguous_clusters() / count_contiguous_clusters_unallocated()
and checks individual subclusters.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 111 ++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 59 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 990bc070af..e67559152f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -372,66 +372,51 @@ fail:
 }
 
 /*
- * Checks how many clusters in a given L2 slice are contiguous in the image
- * file. As soon as one of the flags in the bitmask stop_flags changes compared
- * to the first cluster, the search is stopped and the cluster is not counted
- * as contiguous. (This allows it, for example, to stop at the first compressed
- * cluster which may require a different handling)
+ * Return the number of contiguous subclusters of the exact same type
+ * in a given L2 slice, starting from cluster @l2_index, subcluster
+ * @sc_index. At most @nb_clusters are checked. Allocated clusters are
+ * also required to be contiguous in the image file.
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
+    QCow2ClusterType type =
+        qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
+
+    assert(type != QCOW2_CLUSTER_INVALID); /* The caller should check this */
+
+    if (type == QCOW2_CLUSTER_COMPRESSED) {
+        return 1; /* Compressed clusters are always counted one by one */
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
+    if (type == QCOW2_CLUSTER_UNALLOCATED || type == QCOW2_CLUSTER_ZERO_PLAIN) {
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
+            goto out;
+        }
+        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
+            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
+                goto out;
+            }
+            count++;
         }
+        expected_offset += s->cluster_size;
     }
 
-    return i;
+out:
+    return count;
 }
 
 static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
@@ -514,8 +499,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
                              unsigned int *bytes, uint64_t *cluster_offset)
 {
     BDRVQcow2State *s = bs->opaque;
-    unsigned int l2_index;
-    uint64_t l1_index, l2_offset, *l2_slice;
+    unsigned int l2_index, sc_index;
+    uint64_t l1_index, l2_offset, *l2_slice, l2_bitmap;
     int c;
     unsigned int offset_in_cluster;
     uint64_t bytes_available, bytes_needed, nb_clusters;
@@ -569,7 +554,9 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
+    sc_index = offset_to_sc_index(s, offset);
     *cluster_offset = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -577,7 +564,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
      * true */
     assert(nb_clusters <= INT_MAX);
 
-    type = qcow2_get_cluster_type(bs, *cluster_offset);
+    type = qcow2_get_subcluster_type(bs, *cluster_offset, l2_bitmap, sc_index);
     if (s->qcow_version < 3 && (type == QCOW2_CLUSTER_ZERO_PLAIN ||
                                 type == QCOW2_CLUSTER_ZERO_ALLOC)) {
         qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
@@ -587,6 +574,13 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
     switch (type) {
+    case QCOW2_CLUSTER_INVALID:
+        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry found "
+                                " (L2 offset: %#" PRIx64 ", L2 index: %#x)",
+                                l2_offset, l2_index);
+        ret = -EIO;
+        goto fail;
+        break;
     case QCOW2_CLUSTER_COMPRESSED:
         if (has_data_file(bs)) {
             qcow2_signal_corruption(bs, true, -1, -1, "Compressed cluster "
@@ -602,16 +596,15 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         break;
     case QCOW2_CLUSTER_ZERO_PLAIN:
     case QCOW2_CLUSTER_UNALLOCATED:
-        /* how many empty clusters ? */
-        c = count_contiguous_clusters_unallocated(bs, nb_clusters,
-                                                  l2_slice, l2_index, type);
+        c = count_contiguous_subclusters(bs, nb_clusters, sc_index,
+                                         l2_slice, l2_index);
         *cluster_offset = 0;
         break;
     case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
-        /* how many allocated clusters ? */
-        c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      l2_slice, l2_index, QCOW_OFLAG_ZERO);
+    case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
+        c = count_contiguous_subclusters(bs, nb_clusters, sc_index,
+                                         l2_slice, l2_index);
         *cluster_offset &= L2E_OFFSET_MASK;
         if (offset_into_cluster(s, *cluster_offset)) {
             qcow2_signal_corruption(bs, true, -1, -1,
@@ -640,7 +633,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
-    bytes_available = (int64_t)c * s->cluster_size;
+    bytes_available = ((int64_t)c + sc_index) * s->subcluster_size;
 
 out:
     if (bytes_available > bytes_needed) {
-- 
2.20.1


