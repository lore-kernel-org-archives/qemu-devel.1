Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B925D207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aLxAdRWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925D207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHkM-0008KP-RA
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXv-00044c-FP; Mon, 25 May 2020 14:09:55 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXo-0007pL-Uq; Mon, 25 May 2020 14:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=lc0SmDD2nR0N4tONgLyUW2dLkalKWUxcTiom3DEcZDk=; 
 b=aLxAdRWjwMdRrbuxch4AzbuEv7XDtSLPE/sn+Gpx1gS8z5BELwbZjSzrDFrtupvNnK+qDyAN4jjqZidxxKIIN/+WVwg7RYyP0edXRhQxBgvBYkFriVhi+mkk3l12Ajmjyus/vOIByHprtdo+dnUcqzRcCq9p2IsDN0AuFiMKdULzYAwumhy9nvIYXN2VDDrkFgHPNPewzYenafcOmFGbLsmX9/odF6XCWq7tLDnKAoC5klQIBzgl8c/R/kCfKBFbUmX+/GcXp124eT0IfRe68CZ2k7d2aN4XFWh/v27COG+fRM/VRSX7gjl9iy0JFJQnqtttnrzLaDe/5WKzM6NrUg==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jdHXO-00088D-R5; Mon, 25 May 2020 20:09:22 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jdHX9-0002Mc-JT; Mon, 25 May 2020 20:09:07 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/32] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters in
 handle_copied()
Date: Mon, 25 May 2020 20:08:30 +0200
Message-Id: <34f171d849cfea17727f1c9883a413495a0c8f78.1590429901.git.berto@igalia.com>
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

When writing to a qcow2 file there are two functions that take a
virtual offset and return a host offset, possibly allocating new
clusters if necessary:

   - handle_copied() looks for normal data clusters that are already
     allocated and have a reference count of 1. In those clusters we
     can simply write the data and there is no need to perform any
     copy-on-write.

   - handle_alloc() looks for clusters that do need copy-on-write,
     either because they haven't been allocated yet, because their
     reference count is != 1 or because they are ZERO_ALLOC clusters.

The ZERO_ALLOC case is a bit special because those are clusters that
are already allocated and they could perfectly be dealt with in
handle_copied() (as long as copy-on-write is performed when required).

In fact, there is extra code specifically for them in handle_alloc()
that tries to reuse the existing allocation if possible and frees them
otherwise.

This patch changes the handling of ZERO_ALLOC clusters so the
semantics of these two functions are now like this:

   - handle_copied() looks for clusters that are already allocated and
     which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
     reference count of 1).

   - handle_alloc() looks for clusters for which we need a new
     allocation (all other cases).

One important difference after this change is that clusters found
in handle_copied() may now require copy-on-write, but this will be
necessary anyway once we add support for subclusters.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-cluster.c | 256 +++++++++++++++++++++++-------------------
 1 file changed, 141 insertions(+), 115 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 80f9787461..fce0be7a08 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1039,13 +1039,18 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
 
 /*
  * For a given write request, create a new QCowL2Meta structure, add
- * it to @m and the BDRVQcow2State.cluster_allocs list.
+ * it to @m and the BDRVQcow2State.cluster_allocs list. If the write
+ * request does not need copy-on-write or changes to the L2 metadata
+ * then this function does nothing.
  *
  * @host_cluster_offset points to the beginning of the first cluster.
  *
  * @guest_offset and @bytes indicate the offset and length of the
  * request.
  *
+ * @l2_slice contains the L2 entries of all clusters involved in this
+ * write request.
+ *
  * If @keep_old is true it means that the clusters were already
  * allocated and will be overwritten. If false then the clusters are
  * new and we have to decrease the reference count of the old ones.
@@ -1053,15 +1058,53 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
 static void calculate_l2_meta(BlockDriverState *bs,
                               uint64_t host_cluster_offset,
                               uint64_t guest_offset, unsigned bytes,
-                              QCowL2Meta **m, bool keep_old)
+                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
 {
     BDRVQcow2State *s = bs->opaque;
-    unsigned cow_start_from = 0;
+    int l2_index = offset_to_l2_slice_index(s, guest_offset);
+    uint64_t l2_entry;
+    unsigned cow_start_from, cow_end_to;
     unsigned cow_start_to = offset_into_cluster(s, guest_offset);
     unsigned cow_end_from = cow_start_to + bytes;
-    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
     unsigned nb_clusters = size_to_clusters(s, cow_end_from);
     QCowL2Meta *old_m = *m;
+    QCow2ClusterType type;
+
+    assert(nb_clusters <= s->l2_slice_size - l2_index);
+
+    /* Return if there's no COW (all clusters are normal and we keep them) */
+    if (keep_old) {
+        int i;
+        for (i = 0; i < nb_clusters; i++) {
+            l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
+                break;
+            }
+        }
+        if (i == nb_clusters) {
+            return;
+        }
+    }
+
+    /* Get the L2 entry of the first cluster */
+    l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    type = qcow2_get_cluster_type(bs, l2_entry);
+
+    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
+        cow_start_from = cow_start_to;
+    } else {
+        cow_start_from = 0;
+    }
+
+    /* Get the L2 entry of the last cluster */
+    l2_entry = be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
+    type = qcow2_get_cluster_type(bs, l2_entry);
+
+    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
+        cow_end_to = cow_end_from;
+    } else {
+        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+    }
 
     *m = g_malloc0(sizeof(**m));
     **m = (QCowL2Meta) {
@@ -1087,18 +1130,22 @@ static void calculate_l2_meta(BlockDriverState *bs,
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
 }
 
-/* Returns true if writing to a cluster requires COW */
-static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
+/*
+ * Returns true if writing to the cluster pointed to by @l2_entry
+ * requires a new allocation (that is, if the cluster is unallocated
+ * or has refcount > 1 and therefore cannot be written in-place).
+ */
+static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
 {
     switch (qcow2_get_cluster_type(bs, l2_entry)) {
     case QCOW2_CLUSTER_NORMAL:
+    case QCOW2_CLUSTER_ZERO_ALLOC:
         if (l2_entry & QCOW_OFLAG_COPIED) {
             return false;
         }
     case QCOW2_CLUSTER_UNALLOCATED:
     case QCOW2_CLUSTER_COMPRESSED:
     case QCOW2_CLUSTER_ZERO_PLAIN:
-    case QCOW2_CLUSTER_ZERO_ALLOC:
         return true;
     default:
         abort();
@@ -1106,20 +1153,38 @@ static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
 }
 
 /*
- * Returns the number of contiguous clusters that can be used for an allocating
- * write, but require COW to be performed (this includes yet unallocated space,
- * which must copy from the backing file)
+ * Returns the number of contiguous clusters that can be written to
+ * using one single write request, starting from @l2_index.
+ * At most @nb_clusters are checked.
+ *
+ * If @new_alloc is true this counts clusters that are either
+ * unallocated, or allocated but with refcount > 1 (so they need to be
+ * newly allocated and COWed).
+ *
+ * If @new_alloc is false this counts clusters that are already
+ * allocated and can be overwritten in-place (this includes clusters
+ * of type QCOW2_CLUSTER_ZERO_ALLOC).
  */
-static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
-    uint64_t *l2_slice, int l2_index)
+static int count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
+                                       uint64_t *l2_slice, int l2_index,
+                                       bool new_alloc)
 {
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
     int i;
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
-        if (!cluster_needs_cow(bs, l2_entry)) {
+        l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+        if (cluster_needs_new_alloc(bs, l2_entry) != new_alloc) {
             break;
         }
+        if (!new_alloc) {
+            if (expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
+                break;
+            }
+            expected_offset += s->cluster_size;
+        }
     }
 
     assert(i <= nb_clusters);
@@ -1190,10 +1255,10 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 }
 
 /*
- * Checks how many already allocated clusters that don't require a copy on
- * write there are at the given guest_offset (up to *bytes). If *host_offset is
- * not INV_OFFSET, only physically contiguous clusters beginning at this host
- * offset are counted.
+ * Checks how many already allocated clusters that don't require a new
+ * allocation there are at the given guest_offset (up to *bytes).
+ * If *host_offset is not INV_OFFSET, only physically contiguous clusters
+ * beginning at this host offset are counted.
  *
  * Note that guest_offset may not be cluster aligned. In this case, the
  * returned *host_offset points to exact byte referenced by guest_offset and
@@ -1202,12 +1267,12 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
  * Returns:
  *   0:     if no allocated clusters are available at the given offset.
  *          *bytes is normally unchanged. It is set to 0 if the cluster
- *          is allocated and doesn't need COW, but doesn't have the right
- *          physical offset.
+ *          is allocated and can be overwritten in-place but doesn't have
+ *          the right physical offset.
  *
- *   1:     if allocated clusters that don't require a COW are available at
- *          the requested offset. *bytes may have decreased and describes
- *          the length of the area that can be written to.
+ *   1:     if allocated clusters that can be overwritten in place are
+ *          available at the requested offset. *bytes may have decreased
+ *          and describes the length of the area that can be written to.
  *
  *  -errno: in error cases
  */
@@ -1216,7 +1281,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
-    uint64_t cluster_offset;
+    uint64_t l2_entry, cluster_offset;
     uint64_t *l2_slice;
     uint64_t nb_clusters;
     unsigned int keep_clusters;
@@ -1237,7 +1302,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     l2_index = offset_to_l2_slice_index(s, guest_offset);
     nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
-    assert(nb_clusters <= INT_MAX);
+    /* Limit total byte count to BDRV_REQUEST_MAX_BYTES */
+    nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);
 
     /* Find L2 entry for the first involved cluster */
     ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
@@ -1245,41 +1311,39 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
         return ret;
     }
 
-    cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+    l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    cluster_offset = l2_entry & L2E_OFFSET_MASK;
+
+    if (!cluster_needs_new_alloc(bs, l2_entry)) {
+        if (offset_into_cluster(s, cluster_offset)) {
+            qcow2_signal_corruption(bs, true, -1, -1, "%s cluster offset "
+                                    "%#" PRIx64 " unaligned (guest offset: %#"
+                                    PRIx64 ")", l2_entry & QCOW_OFLAG_ZERO ?
+                                    "Preallocated zero" : "Data",
+                                    cluster_offset, guest_offset);
+            ret = -EIO;
+            goto out;
+        }
 
-    /* Check how many clusters are already allocated and don't need COW */
-    if (qcow2_get_cluster_type(bs, cluster_offset) == QCOW2_CLUSTER_NORMAL
-        && (cluster_offset & QCOW_OFLAG_COPIED))
-    {
         /* If a specific host_offset is required, check it */
-        bool offset_matches =
-            (cluster_offset & L2E_OFFSET_MASK) == *host_offset;
-
-        if (offset_into_cluster(s, cluster_offset & L2E_OFFSET_MASK)) {
-            qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset "
-                                    "%#llx unaligned (guest offset: %#" PRIx64
-                                    ")", cluster_offset & L2E_OFFSET_MASK,
-                                    guest_offset);
-            ret = -EIO;
-            goto out;
-        }
-
-        if (*host_offset != INV_OFFSET && !offset_matches) {
+        if (*host_offset != INV_OFFSET && cluster_offset != *host_offset) {
             *bytes = 0;
             ret = 0;
             goto out;
         }
 
         /* We keep all QCOW_OFLAG_COPIED clusters */
-        keep_clusters =
-            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      &l2_slice[l2_index],
-                                      QCOW_OFLAG_COPIED | QCOW_OFLAG_ZERO);
+        keep_clusters = count_single_write_clusters(bs, nb_clusters, l2_slice,
+                                                    l2_index, false);
         assert(keep_clusters <= nb_clusters);
 
         *bytes = MIN(*bytes,
                  keep_clusters * s->cluster_size
                  - offset_into_cluster(s, guest_offset));
+        assert(*bytes != 0);
+
+        calculate_l2_meta(bs, cluster_offset, guest_offset,
+                          *bytes, l2_slice, m, true);
 
         ret = 1;
     } else {
@@ -1293,8 +1357,7 @@ out:
     /* Only return a host offset if we actually made progress. Otherwise we
      * would make requirements for handle_alloc() that it can't fulfill */
     if (ret > 0) {
-        *host_offset = (cluster_offset & L2E_OFFSET_MASK)
-                     + offset_into_cluster(s, guest_offset);
+        *host_offset = cluster_offset + offset_into_cluster(s, guest_offset);
     }
 
     return ret;
@@ -1355,9 +1418,10 @@ static int do_alloc_cluster_offset(BlockDriverState *bs, uint64_t guest_offset,
 }
 
 /*
- * Allocates new clusters for an area that either is yet unallocated or needs a
- * copy on write. If *host_offset is not INV_OFFSET, clusters are only
- * allocated if the new allocation can match the specified host offset.
+ * Allocates new clusters for an area that is either still unallocated or
+ * cannot be overwritten in-place. If *host_offset is not INV_OFFSET,
+ * clusters are only allocated if the new allocation can match the specified
+ * host offset.
  *
  * Note that guest_offset may not be cluster aligned. In this case, the
  * returned *host_offset points to exact byte referenced by guest_offset and
@@ -1380,12 +1444,10 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
     uint64_t *l2_slice;
-    uint64_t entry;
     uint64_t nb_clusters;
     int ret;
-    bool keep_old_clusters = false;
 
-    uint64_t alloc_cluster_offset = INV_OFFSET;
+    uint64_t alloc_cluster_offset;
 
     trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_offset,
                              *bytes);
@@ -1400,10 +1462,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
 
     l2_index = offset_to_l2_slice_index(s, guest_offset);
     nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
-    assert(nb_clusters <= INT_MAX);
-
-    /* Limit total allocation byte count to INT_MAX */
-    nb_clusters = MIN(nb_clusters, INT_MAX >> s->cluster_bits);
+    /* Limit total allocation byte count to BDRV_REQUEST_MAX_BYTES */
+    nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);
 
     /* Find L2 entry for the first involved cluster */
     ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
@@ -1411,67 +1471,32 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         return ret;
     }
 
-    entry = be64_to_cpu(l2_slice[l2_index]);
-    nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index);
+    nb_clusters = count_single_write_clusters(bs, nb_clusters,
+                                              l2_slice, l2_index, true);
 
     /* This function is only called when there were no non-COW clusters, so if
      * we can't find any unallocated or COW clusters either, something is
      * wrong with our code. */
     assert(nb_clusters > 0);
 
-    if (qcow2_get_cluster_type(bs, entry) == QCOW2_CLUSTER_ZERO_ALLOC &&
-        (entry & QCOW_OFLAG_COPIED) &&
-        (*host_offset == INV_OFFSET ||
-         start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
-    {
-        int preallocated_nb_clusters;
-
-        if (offset_into_cluster(s, entry & L2E_OFFSET_MASK)) {
-            qcow2_signal_corruption(bs, true, -1, -1, "Preallocated zero "
-                                    "cluster offset %#llx unaligned (guest "
-                                    "offset: %#" PRIx64 ")",
-                                    entry & L2E_OFFSET_MASK, guest_offset);
-            ret = -EIO;
-            goto fail;
-        }
-
-        /* Try to reuse preallocated zero clusters; contiguous normal clusters
-         * would be fine, too, but count_cow_clusters() above has limited
-         * nb_clusters already to a range of COW clusters */
-        preallocated_nb_clusters =
-            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      &l2_slice[l2_index], QCOW_OFLAG_COPIED);
-        assert(preallocated_nb_clusters > 0);
-
-        nb_clusters = preallocated_nb_clusters;
-        alloc_cluster_offset = entry & L2E_OFFSET_MASK;
-
-        /* We want to reuse these clusters, so qcow2_alloc_cluster_link_l2()
-         * should not free them. */
-        keep_old_clusters = true;
+    /* Allocate at a given offset in the image file */
+    alloc_cluster_offset = *host_offset == INV_OFFSET ? INV_OFFSET :
+        start_of_cluster(s, *host_offset);
+    ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
+                                  &nb_clusters);
+    if (ret < 0) {
+        goto out;
     }
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-
-    if (alloc_cluster_offset == INV_OFFSET) {
-        /* Allocate, if necessary at a given offset in the image file */
-        alloc_cluster_offset = *host_offset == INV_OFFSET ? INV_OFFSET :
-                               start_of_cluster(s, *host_offset);
-        ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
-                                      &nb_clusters);
-        if (ret < 0) {
-            goto fail;
-        }
-
-        /* Can't extend contiguous allocation */
-        if (nb_clusters == 0) {
-            *bytes = 0;
-            return 0;
-        }
-
-        assert(alloc_cluster_offset != INV_OFFSET);
+    /* Can't extend contiguous allocation */
+    if (nb_clusters == 0) {
+        *bytes = 0;
+        ret = 0;
+        goto out;
     }
 
+    assert(alloc_cluster_offset != INV_OFFSET);
+
     /*
      * Save info needed for meta data update.
      *
@@ -1494,13 +1519,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
     assert(*bytes != 0);
 
-    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
-                      m, keep_old_clusters);
+    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2_slice,
+                      m, false);
 
-    return 1;
+    ret = 1;
 
-fail:
-    if (*m && (*m)->nb_clusters > 0) {
+out:
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
+    if (ret < 0 && *m && (*m)->nb_clusters > 0) {
         QLIST_REMOVE(*m, next_in_flight);
     }
     return ret;
-- 
2.20.1


