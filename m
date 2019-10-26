Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB1CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C0B20863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q8Gy7jYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C0B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTrn-0005E6-5L
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTa3-0000d8-Ki
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZz-0005Vk-Pt
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZy-0005Hi-Sy; Sat, 26 Oct 2019 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=HiOXQuXiCq1mp/4lDudFhp0ZZl9M+OAw5peBQeaptW4=; 
 b=q8Gy7jYv7RaWTJfiwaxmA4mvXW7KOMEF6TGaJc/rAxxx0wJwTmdlQ7OCT2dTLRIvUbPrfnhO0mj5+CcpPfPjPjTxGnCSoE9qHsfelq1JxvXdol04yRKAwaOnOOajMyfQaHFGLEsqISy4XVSMwb8fIfz/fO6vNpHsJY9X/WYtW0PS6yDPxA/grL6tnf+W1+2/LQZUQagJ+7c0RoTJwolq1FKK/gUAXr1AsqcELcofTF/87ilbMXRoVb6QewMgebNlHvq2ABxhZYZtoQgp7ieMND/uCv2U8SAca4GuMjPomrcCixS39qvuoeG9JxhpT6wnZBpf29jBjf2Brn2Npk9qvw==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045m-Lm; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001P6-4P; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 03/26] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters
 in handle_copied()
Date: Sun, 27 Oct 2019 00:25:05 +0300
Message-Id: <fe73f28b44ecaea8a0104e11078f38f563da5925.1572125022.git.berto@igalia.com>
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

One importante difference after this change is that clusters found in
handle_copied() may now require copy-on-write, but this will be anyway
necessary once we add support for subclusters.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 177 +++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 81 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index aa1010a515..ee6b46f917 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1021,7 +1021,8 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
 
 /*
  * For a given write request, create a new QCowL2Meta structure and
- * add it to @m.
+ * add it to @m. If the write request does not need copy-on-write or
+ * changes to the L2 metadata then this function does nothing.
  *
  * @host_offset points to the beginning of the first cluster.
  *
@@ -1034,15 +1035,51 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
  */
 static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
                               uint64_t guest_offset, uint64_t bytes,
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
+    /* Get the L2 entry from the first cluster */
+    l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    type = qcow2_get_cluster_type(bs, l2_entry);
+
+    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
+        cow_start_from = cow_start_to;
+    } else {
+        cow_start_from = 0;
+    }
+
+    /* Get the L2 entry from the last cluster */
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
@@ -1068,18 +1105,18 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
 }
 
-/* Returns true if writing to a cluster requires COW */
+/* Returns true if the cluster is unallocated or has refcount > 1 */
 static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
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
@@ -1087,20 +1124,34 @@ static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
 }
 
 /*
- * Returns the number of contiguous clusters that can be used for an allocating
- * write, but require COW to be performed (this includes yet unallocated space,
- * which must copy from the backing file)
+ * Returns the number of contiguous clusters that can be written to
+ * using one single write request, starting from @l2_index.
+ * At most @nb_clusters are checked.
+ *
+ * If @want_cow is true this counts clusters that are either
+ * unallocated, or allocated but with refcount > 1.
+ *
+ * If @want_cow is false this counts clusters that are already
+ * allocated and can be written to using their current locations
+ * (including QCOW2_CLUSTER_ZERO_ALLOC).
  */
 static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
-    uint64_t *l2_slice, int l2_index)
+                              uint64_t *l2_slice, int l2_index, bool want_cow)
 {
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
     int i;
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
-        if (!cluster_needs_cow(bs, l2_entry)) {
+        l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+        if (cluster_needs_cow(bs, l2_entry) != want_cow) {
             break;
         }
+        if (!want_cow && expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
+            break;
+        }
+        expected_offset += s->cluster_size;
     }
 
     assert(i <= nb_clusters);
@@ -1228,18 +1279,17 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     cluster_offset = be64_to_cpu(l2_slice[l2_index]);
 
-    /* Check how many clusters are already allocated and don't need COW */
-    if (qcow2_get_cluster_type(bs, cluster_offset) == QCOW2_CLUSTER_NORMAL
-        && (cluster_offset & QCOW_OFLAG_COPIED))
-    {
+    if (!cluster_needs_cow(bs, cluster_offset)) {
         /* If a specific host_offset is required, check it */
         bool offset_matches =
             (cluster_offset & L2E_OFFSET_MASK) == *host_offset;
 
         if (offset_into_cluster(s, cluster_offset & L2E_OFFSET_MASK)) {
-            qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset "
+            qcow2_signal_corruption(bs, true, -1, -1, "%s cluster offset "
                                     "%#llx unaligned (guest offset: %#" PRIx64
-                                    ")", cluster_offset & L2E_OFFSET_MASK,
+                                    ")", cluster_offset & QCOW_OFLAG_ZERO ?
+                                    "Preallocated zero" : "Data",
+                                    cluster_offset & L2E_OFFSET_MASK,
                                     guest_offset);
             ret = -EIO;
             goto out;
@@ -1252,15 +1302,17 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
         }
 
         /* We keep all QCOW_OFLAG_COPIED clusters */
-        keep_clusters =
-            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      &l2_slice[l2_index],
-                                      QCOW_OFLAG_COPIED | QCOW_OFLAG_ZERO);
+        keep_clusters = count_cow_clusters(bs, nb_clusters, l2_slice,
+                                           l2_index, false);
         assert(keep_clusters <= nb_clusters);
 
         *bytes = MIN(*bytes,
                  keep_clusters * s->cluster_size
                  - offset_into_cluster(s, guest_offset));
+        assert(*bytes != 0);
+
+        calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK, guest_offset,
+                          *bytes, l2_slice, m, true);
 
         ret = 1;
     } else {
@@ -1361,12 +1413,10 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
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
@@ -1392,67 +1442,31 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         return ret;
     }
 
-    entry = be64_to_cpu(l2_slice[l2_index]);
-    nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index);
+    nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index, true);
 
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
+    /* Allocate, if necessary at a given offset in the image file */
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
@@ -1475,13 +1489,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
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


