Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B1C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA6E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FZcmKTHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA6E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH8k-0003jA-1M
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGn0-0003at-BD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmv-00009D-7B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:06 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-000650-9O; Tue, 17 Mar 2020 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=snU5YlWGDhrk8dD7MLwe4YRhknZ6d9pa8+zu7OhWw2g=; 
 b=FZcmKTHssrqx+j+Urw0N1CIWV32YMVWaik4Y5G8mueB6LST4mZq/BvfIOCnBYxi25KvEObsGrIzMvDc6X6ikj5SxS174+sNV0BMPmfBwfblxerhBZSvCzbrXiKz/ph+TsEAkePLkP5dLxMT5KOVFg5vqRXj2vOIE1qqtMZLPf+fJu3Eue+/pyWWQAZtf3RhDZrWoIpZnCxNCfV2+AG9Jfu2/SFUzl7a4Uubr8ZH6iXS4AU8d4p4r8/7tsX1yPxIg9oco6LUoO5gnvPTRPlZ89CaYeWYBS1bru3AVle+bkgE+so8UaO6xmQHjRnC3YV/Bb8R4iU+SwG24fOns9nSsqA==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-000153-30; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006Ob-KF; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/30] qcow2: Add subcluster support to calculate_l2_meta()
Date: Tue, 17 Mar 2020 19:16:14 +0100
Message-Id: <6f179204ed9ab6274a9d30b6aa9a63865a16035a.1584468723.git.berto@igalia.com>
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 140 +++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 30 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8cdf8a23b6..c6f3cc9237 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1061,56 +1061,128 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
  * If @keep_old is true it means that the clusters were already
  * allocated and will be overwritten. If false then the clusters are
  * new and we have to decrease the reference count of the old ones.
+ *
+ * Returns 1 on success, -errno on failure (in order to match the
+ * return value of handle_copied() and handle_alloc()).
  */
-static void calculate_l2_meta(BlockDriverState *bs,
-                              uint64_t host_cluster_offset,
-                              uint64_t guest_offset, unsigned bytes,
-                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
+static int calculate_l2_meta(BlockDriverState *bs, uint64_t host_cluster_offset,
+                             uint64_t guest_offset, unsigned bytes,
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
     unsigned nb_clusters = size_to_clusters(s, cow_end_from);
     QCowL2Meta *old_m = *m;
-    QCow2ClusterType type;
+    QCow2SubclusterType type;
 
     assert(nb_clusters <= s->l2_slice_size - l2_index);
 
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
+            if (type == QCOW2_SUBCLUSTER_INVALID) {
+                l2_index += c; /* Point to the invalid entry */
+                goto fail;
+            }
+            if (type != QCOW2_SUBCLUSTER_NORMAL) {
                 break;
             }
         }
-        if (i == nb_clusters) {
-            return;
+        if (i == last_sc + 1) {
+            return 1;
         }
     }
 
     /* Get the L2 entry of the first cluster */
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
-    type = qcow2_get_cluster_type(bs, l2_entry);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
 
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_start_from = cow_start_to;
+    if (type == QCOW2_SUBCLUSTER_INVALID) {
+        goto fail;
+    }
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            cow_start_from = 0;
+            break;
+        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+            cow_start_from = sc_index << s->subcluster_bits;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        cow_start_from = 0;
+        switch (type) {
+        case QCOW2_SUBCLUSTER_NORMAL:
+            cow_start_from = cow_start_to;
+            break;
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            cow_start_from = sc_index << s->subcluster_bits;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 
     /* Get the L2 entry of the last cluster */
-    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
-    type = qcow2_get_cluster_type(bs, l2_entry);
+    l2_index += nb_clusters - 1;
+    l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
 
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_end_to = cow_end_from;
+    if (type == QCOW2_SUBCLUSTER_INVALID) {
+        goto fail;
+    }
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            break;
+        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+        switch (type) {
+        case QCOW2_SUBCLUSTER_NORMAL:
+            cow_end_to = cow_end_from;
+            break;
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            cow_end_to = ROUND_UP(cow_end_from, s->subcluster_size);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 
     *m = g_malloc0(sizeof(**m));
@@ -1135,6 +1207,18 @@ static void calculate_l2_meta(BlockDriverState *bs,
 
     qemu_co_queue_init(&(*m)->dependent_requests);
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
+
+fail:
+    if (type == QCOW2_SUBCLUSTER_INVALID) {
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
 
 /*
@@ -1352,10 +1436,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
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
@@ -1530,10 +1612,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
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


