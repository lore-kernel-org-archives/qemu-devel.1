Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60769C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7E420706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2F7S/ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7E420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUVR-00088t-6K
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPF-0004mR-3y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUP6-0000fT-1g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6JLJl5beNXDL3oJiIgYhKZh+mibMI7ZXPkrJZXoGyI=;
 b=Y2F7S/armQIK1WEP9svH8WyLLXf0t8AP8chwJx5bYcJ82pZ03Iu0LiD1V65+oBn2ySpaU5
 Sp/DWgV893ZHL05i41AoDOayDxx5fN2xRg+ofKNfsOYrSemi9xOJNafjRwF8iOT+T/C4qD
 jX61IFeE/8x078Nl3z+LZMUCtoYlMTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-jhmICFV3NguO0EesTebg-w-1; Tue, 25 Aug 2020 04:34:01 -0400
X-MC-Unique: jhmICFV3NguO0EesTebg-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34EF510059B4;
 Tue, 25 Aug 2020 08:34:00 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A048F5F707;
 Tue, 25 Aug 2020 08:33:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/34] qcow2: Add subcluster support to calculate_l2_meta()
Date: Tue, 25 Aug 2020 10:32:57 +0200
Message-Id: <20200825083311.1098442-21-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <4292dd56e4446d386a2fe307311737a711c00708.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 167 +++++++++++++++++++++++++++++++++---------
 1 file changed, 133 insertions(+), 34 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5937937596..5e7ae0843d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -387,7 +387,6 @@ fail:
  * If the L2 entry is invalid return -errno and set @type to
  * QCOW2_SUBCLUSTER_INVALID.
  */
-G_GNUC_UNUSED
 static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
                                            uint64_t l2_entry,
                                            uint64_t l2_bitmap,
@@ -1111,56 +1110,148 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
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
+    int i;
+    bool skip_cow = keep_old;
 
     assert(nb_clusters <= s->l2_slice_size - l2_index);
 
-    /* Return if there's no COW (all clusters are normal and we keep them) */
-    if (keep_old) {
-        int i;
-        for (i = 0; i < nb_clusters; i++) {
-            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
-            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
-                break;
+    /* Check the type of all affected subclusters */
+    for (i = 0; i < nb_clusters; i++) {
+        l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+        if (skip_cow) {
+            unsigned write_from = MAX(cow_start_to, i << s->cluster_bits);
+            unsigned write_to = MIN(cow_end_from, (i + 1) << s->cluster_bits);
+            int first_sc = offset_to_sc_index(s, write_from);
+            int last_sc = offset_to_sc_index(s, write_to - 1);
+            int cnt = qcow2_get_subcluster_range_type(bs, l2_entry, l2_bitmap,
+                                                      first_sc, &type);
+            /* Is any of the subclusters of type != QCOW2_SUBCLUSTER_NORMAL ? */
+            if (type != QCOW2_SUBCLUSTER_NORMAL || first_sc + cnt <= last_sc) {
+                skip_cow = false;
             }
+        } else {
+            /* If we can't skip the cow we can still look for invalid entries */
+            type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, 0);
         }
-        if (i == nb_clusters) {
-            return;
+        if (type == QCOW2_SUBCLUSTER_INVALID) {
+            int l1_index = offset_to_l1_index(s, guest_offset);
+            uint64_t l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
+            qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster "
+                                    "entry found (L2 offset: %#" PRIx64
+                                    ", L2 index: %#x)",
+                                    l2_offset, l2_index + i);
+            return -EIO;
         }
     }
 
+    if (skip_cow) {
+        return 0;
+    }
+
     /* Get the L2 entry of the first cluster */
     l2_entry = get_l2_entry(s, l2_slice, l2_index);
-    type = qcow2_get_cluster_type(bs, l2_entry);
-
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_start_from = cow_start_to;
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            cow_start_from = 0;
+            break;
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            if (has_subclusters(s)) {
+                /* Skip all leading zero and unallocated subclusters */
+                uint32_t alloc_bitmap = l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC;
+                cow_start_from =
+                    MIN(sc_index, ctz32(alloc_bitmap)) << s->subcluster_bits;
+            } else {
+                cow_start_from = 0;
+            }
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
-
-    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
-        cow_end_to = cow_end_from;
+    l2_index += nb_clusters - 1;
+    l2_entry = get_l2_entry(s, l2_slice, l2_index);
+    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
+    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
+    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
+
+    if (!keep_old) {
+        switch (type) {
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            break;
+        case QCOW2_SUBCLUSTER_NORMAL:
+        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+            cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+            if (has_subclusters(s)) {
+                /* Skip all trailing zero and unallocated subclusters */
+                uint32_t alloc_bitmap = l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC;
+                cow_end_to -=
+                    MIN(s->subclusters_per_cluster - sc_index - 1,
+                        clz32(alloc_bitmap)) << s->subcluster_bits;
+            }
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
@@ -1185,6 +1276,8 @@ static void calculate_l2_meta(BlockDriverState *bs,
 
     qemu_co_queue_init(&(*m)->dependent_requests);
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
+
+    return 0;
 }
 
 /*
@@ -1273,8 +1366,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
         uint64_t start = guest_offset;
         uint64_t end = start + bytes;
-        uint64_t old_start = l2meta_cow_start(old_alloc);
-        uint64_t old_end = l2meta_cow_end(old_alloc);
+        uint64_t old_start = start_of_cluster(s, l2meta_cow_start(old_alloc));
+        uint64_t old_end = ROUND_UP(l2meta_cow_end(old_alloc), s->cluster_size);
 
         if (end <= old_start || start >= old_end) {
             /* No intersection */
@@ -1399,8 +1492,11 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
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
@@ -1576,8 +1672,11 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
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
2.26.2


