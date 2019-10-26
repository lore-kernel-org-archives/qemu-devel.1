Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F383120863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iqIGEnx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F383120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOThI-0001kw-WE
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZk-00006g-8k
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZi-0005MN-Fo
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:20 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZg-0005F3-93; Sat, 26 Oct 2019 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=zXbiawb2wVzz4PzqvAHfUoPvdjpMzsH+nV0DpWXuaaE=; 
 b=iqIGEnx500H+03i6OvdXkoxTxyOpsg9L3Kuhojj7Hlsx7VgHpq/vS5ET67S8paLAovL2ZKErYkrxRD2OnfmqQobLOJJN9dolJ5VhYT6iT2dSG1+6CeaZ3nV4/dU3FZwX/WewIIGMm1tVdHwmhPsl1y+4oGJpD0T1mFy0iAM4At3f1avswymH1NqSJhtkr+XuSI2lQKmN7Ov3aGy6HWvh+jq3sHCO/ZoXI3C+IiIk6i8GinimFh7r72QPYI22InbR7usKIppuiM1C6x8NmUnHADEfwd0xRZeQ66Ca8SJXS83LBGvsxEDyvcOk+9a9nqzvFBzL+Dq81/vPpjJENHW12w==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045z-QJ; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001PR-Jy; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 13/26] qcow2: Add subcluster support to
 calculate_l2_meta()
Date: Sun, 27 Oct 2019 00:25:15 +0300
Message-Id: <4cf84e3126dc87486b19514c211d46941cdff243.1572125022.git.berto@igalia.com>
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

If an image has subclusters then there are more copy-on-write
scenarios that we need to consider. Let's say we have a write request
from the middle of subcluster #3 until the end of the cluster:

   - If the cluster is new, then subclusters #0 to #3 from the old
     cluster must be copied into the new one.

   - If the cluster is new but the old cluster was unallocated, then
     only subcluster #3 needs copy-on-write. #0 to #2 are marked as
     unallocated in the bitmap of the new L2 entry.

   - If we are overwriting an old cluster and subcluster #3 is
     unallocated or has the all-zeroes bit set then we need
     copy-on-write on subcluster #3.

   - If we are overwriting an old cluster and subcluster #3 was
     allocated then there is no need to copy-on-write.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 136 +++++++++++++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 28 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1f509bda15..990bc070af 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1034,14 +1034,16 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
  * If @keep_old is true it means that the clusters were already
  * allocated and will be overwritten. If false then the clusters are
  * new and we have to decrease the reference count of the old ones.
+ *
+ * Returns 1 on success, -errno on failure.
  */
-static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
-                              uint64_t guest_offset, uint64_t bytes,
-                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
+static int calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
+                             uint64_t guest_offset, uint64_t bytes,
+                             uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
 {
     BDRVQcow2State *s = bs->opaque;
-    int l2_index = offset_to_l2_slice_index(s, guest_offset);
-    uint64_t l2_entry;
+    int sc_index, l2_index = offset_to_l2_slice_index(s, guest_offset);
+    uint64_t l2_entry, l2_bitmap;
     unsigned cow_start_from, cow_end_to;
     unsigned cow_start_to = offset_into_cluster(s, guest_offset);
     unsigned cow_end_from = cow_start_to + bytes;
@@ -1049,38 +1051,108 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
     QCowL2Meta *old_m = *m;
     QCow2ClusterType type;
 
-    /* Return if there's no COW (all clusters are normal and we keep them) */
+    /* Return if there's no COW (all subclusters are normal and we are
+     * keeping the clusters) */
     if (keep_old) {
+        unsigned first_sc = cow_start_to / s->subcluster_size;
+        unsigned last_sc = (cow_end_from - 1) / s->subcluster_size;
         int i;
-        for (i = 0; i < nb_clusters; i++) {
-            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
-            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
+        for (i = first_sc; i <= last_sc; i++) {
+            unsigned c = i / s->subclusters_per_cluster;
+            unsigned sc = i % s->subclusters_per_cluster;
+            l2_entry = get_l2_entry(s, l2_slice, l2_index + c);
+            l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + c);
+            type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc);
+            if (type == QCOW2_CLUSTER_INVALID) {
+                l2_index += c; /* Point to the invalid entry */
+                goto fail;
+            }
+            if (type != QCOW2_CLUSTER_NORMAL) {
                 break;
             }
         }
-        if (i == nb_clusters) {
-            return;
+        if (i == last_sc + 1) {
+            return 1;
         }
     }
 
     /* Get the L2 entry from the first cluster */
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
-    type = qcow2_get_cluster_type(bs, l2_entry);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
 
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_start_from = cow_start_to;
+    if (type == QCOW2_CLUSTER_INVALID) {
+        goto fail;
+    }
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_CLUSTER_NORMAL:
+        case QCOW2_CLUSTER_COMPRESSED:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
+            cow_start_from = 0;
+            break;
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_UNALLOCATED:
+            cow_start_from = sc_index << s->subcluster_bits;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        cow_start_from = 0;
+        switch (type) {
+        case QCOW2_CLUSTER_NORMAL:
+            cow_start_from = cow_start_to;
+            break;
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
+            cow_start_from = sc_index << s->subcluster_bits;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 
     /* Get the L2 entry from the last cluster */
-    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
-    type = qcow2_get_cluster_type(bs, l2_entry);
+    l2_index += nb_clusters - 1;
+    l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
 
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_end_to = cow_end_from;
+    if (type == QCOW2_CLUSTER_INVALID) {
+        goto fail;
+    }
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_CLUSTER_NORMAL:
+        case QCOW2_CLUSTER_COMPRESSED:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            break;
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_UNALLOCATED:
+            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+        switch (type) {
+        case QCOW2_CLUSTER_NORMAL:
+            cow_end_to = cow_end_from;
+            break;
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
+            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 
     *m = g_malloc0(sizeof(**m));
@@ -1105,6 +1177,18 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
 
     qemu_co_queue_init(&(*m)->dependent_requests);
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
+
+fail:
+    if (type == QCOW2_CLUSTER_INVALID) {
+        uint64_t l1_index = offset_to_l1_index(s, guest_offset);
+        uint64_t l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
+        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry found "
+                                " (L2 offset: %#" PRIx64 ", L2 index: %#x)",
+                                l2_offset, l2_index);
+        return -EIO;
+    }
+
+    return 1;
 }
 
 /* Returns true if the cluster is unallocated or has refcount > 1 */
@@ -1313,10 +1397,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
                  - offset_into_cluster(s, guest_offset));
         assert(*bytes != 0);
 
-        calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK, guest_offset,
-                          *bytes, l2_slice, m, true);
-
-        ret = 1;
+        ret = calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK,
+                                guest_offset, *bytes, l2_slice, m, true);
     } else {
         ret = 0;
     }
@@ -1491,10 +1573,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
     assert(*bytes != 0);
 
-    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2_slice,
-                      m, false);
-
-    ret = 1;
+    ret = calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
+                            l2_slice, m, false);
 
 out:
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-- 
2.20.1


