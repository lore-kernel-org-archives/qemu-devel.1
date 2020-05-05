Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD8C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD3C20735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hhaVeA+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD3C20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1oZ-00007V-R5
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xo-000713-Uy; Tue, 05 May 2020 13:39:48 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xd-0008Qq-Rx; Tue, 05 May 2020 13:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=CIikCPUTFA6bg+2ao1dAsQbyJ1omi1Z83b+QnpPzBiI=; 
 b=hhaVeA+D2cMG/rXNLe/ZlOkfQL5tZRbi2K7G2cNTXLtAVdnC2wN4SB61cBgqRKEMR778/0AkZCDe4hBKJbXSDfkgmQBotKVWguyIStcM+GINgvNqhL34vEv3c4TW0aXN/PgDroQFHso/nmN0noACgdqj8O3v2I3lUNWkCVshMYuqp4kXSQdUdpsc0FCt6l9Rm2JeQ0GBPo+aYaXDaF44vWjDAvcOQ4I46DiCEtXJyXK+76GaJQbKGLC8yJkAPP1Kgbz7nLrRJ4e2V7C9p12wiGDhHy4wMLO7m6Ru5PKtsKEJbUIw/u4dQWgbqDOJ4UzE0hDxzzM+DdqSQOsRvI+8Cw==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025S-CQ; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wd-000449-1X; Tue, 05 May 2020 19:38:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 19/31] qcow2: Add subcluster support to calculate_l2_meta()
Date: Tue,  5 May 2020 19:38:19 +0200
Message-Id: <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
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

If an image has subclusters then there are more copy-on-write
scenarios that we need to consider. Let's say we have a write request
from the middle of subcluster #3 until the end of the cluster:

1) If we are writing to a newly allocated cluster then we need
   copy-on-write. The previous contents of subclusters #0 to #3 must
   be copied to the new cluster. We can optimize this process by
   skipping all leading unallocated or zero subclusters (the status of
   those skipped subclusters will be reflected in the new L2 bitmap).

2) If we are overwriting an existing cluster:

   2.1) If subcluster #3 is unallocated or has the all-zeroes bit set
        then we need copy-on-write (on subcluster #3 only).

   2.2) If subcluster #3 was already allocated then there is no need
        for any copy-on-write. However we still need to update the L2
        bitmap to reflect possible changes in the allocation status of
        subclusters #4 to #31. Because of this, this function checks
        if all the overwritten subclusters are already allocated and
        in this case it returns without creating a new QCowL2Meta
        structure.

After all these changes l2meta_cow_start() and l2meta_cow_end()
are not necessarily cluster-aligned anymore. We need to update the
calculation of old_start and old_end in handle_dependencies() to
guarantee that no two requests try to write on the same cluster.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 174 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 146 insertions(+), 28 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5595ce1404..ffcb11edda 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1059,56 +1059,156 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
  * If @keep_old is true it means that the clusters were already
  * allocated and will be overwritten. If false then the clusters are
  * new and we have to decrease the reference count of the old ones.
+ *
+ * Returns 0 on success, -errno on failure.
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
+            return 0;
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
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            cow_start_from = 0;
+            break;
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
+            int i;
+            /* Skip all leading zero and unallocated subclusters */
+            for (i = 0; i < sc_index; i++) {
+                QCow2SubclusterType t;
+                t = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, i);
+                if (t == QCOW2_SUBCLUSTER_INVALID) {
+                    goto fail;
+                } else if (t == QCOW2_SUBCLUSTER_NORMAL) {
+                    break;
+                }
+            }
+            cow_start_from = i << s->subcluster_bits;
+            break;
+        }
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
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            break;
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
+            int i;
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            /* Skip all trailing zero and unallocated subclusters */
+            for (i = s->subclusters_per_cluster - 1; i > sc_index; i--) {
+                QCow2SubclusterType t;
+                t = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, i);
+                if (t == QCOW2_SUBCLUSTER_INVALID) {
+                    goto fail;
+                } else if (t == QCOW2_SUBCLUSTER_NORMAL) {
+                    break;
+                }
+                cow_end_to -= s->subcluster_size;
+            }
+            break;
+        }
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
@@ -1133,6 +1233,18 @@ static void calculate_l2_meta(BlockDriverState *bs,
 
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
+    return 0;
 }
 
 /*
@@ -1221,8 +1333,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
         uint64_t start = guest_offset;
         uint64_t end = start + bytes;
-        uint64_t old_start = l2meta_cow_start(old_alloc);
-        uint64_t old_end = l2meta_cow_end(old_alloc);
+        uint64_t old_start = start_of_cluster(s, l2meta_cow_start(old_alloc));
+        uint64_t old_end = ROUND_UP(l2meta_cow_end(old_alloc), s->cluster_size);
 
         if (end <= old_start || start >= old_end) {
             /* No intersection */
@@ -1347,8 +1459,11 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
                  - offset_into_cluster(s, guest_offset));
         assert(*bytes != 0);
 
-        calculate_l2_meta(bs, cluster_offset, guest_offset,
-                          *bytes, l2_slice, m, true);
+        ret = calculate_l2_meta(bs, cluster_offset, guest_offset,
+                                *bytes, l2_slice, m, true);
+        if (ret < 0) {
+            goto out;
+        }
 
         ret = 1;
     } else {
@@ -1524,8 +1639,11 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
     assert(*bytes != 0);
 
-    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2_slice,
-                      m, false);
+    ret = calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
+                            l2_slice, m, false);
+    if (ret < 0) {
+        goto out;
+    }
 
     ret = 1;
 
-- 
2.20.1


