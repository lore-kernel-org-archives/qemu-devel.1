Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD92CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614BA2064A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XvrBNViM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614BA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOURc-0006lY-Ez
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTa3-0000d9-KZ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZz-0005Vb-QL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZy-0005Hl-T4; Sat, 26 Oct 2019 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=HA5giM8eakcNQynVtHU8k6s2wWTx975YvaVn6Hw41AI=; 
 b=XvrBNViMoOOg2eeIxzCtNCXgNmm02SrPCh/HHmJXQuMwfdyAsW+xjpCDZDCAMYw2QS9iH5+fR1OJPthHKZBJXJwVPbAY4hcCN0Xrt/XrZ5/O2fE8b8fBZYV7As7BaOomNMWYNlakueWzrTDWlq3W8cW1WWtYB7kSlCFxuMIxsV2Cjcgqt8hgHiPJ0EdRQ//avsBLwmdBrUz8+OPAzFVn2FzC4hkzkIVXDDTLsdv3l/AzzQTcP08Eiu/XyLJon7KV520oGYSVUZDeQKXJ25EkTIdvkNsZylwUfD6+uG7reaMBJzrroRWYcKbbiynadDDj2WYsC+DXlTyn/volN2ydvA==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045o-LH; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001P8-5n; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 04/26] qcow2: Add get_l2_entry() and set_l2_entry()
Date: Sun, 27 Oct 2019 00:25:06 +0300
Message-Id: <ea950886ef12077a69ac5c9d1ddba84626fc03fb.1572125022.git.berto@igalia.com>
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

The size of an L2 entry is 64 bits, but if we want to have subclusters
we need extended L2 entries. This means that we have to access L2
tables and slices differently depending on whether an image has
extended L2 entries or not.

This patch replaces all l2_slice[] accesses with calls to
get_l2_entry() and set_l2_entry().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c  | 65 ++++++++++++++++++++++--------------------
 block/qcow2-refcount.c | 17 +++++------
 block/qcow2.h          | 12 ++++++++
 3 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ee6b46f917..581fa90ab1 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -379,12 +379,13 @@ fail:
  * cluster which may require a different handling)
  */
 static int count_contiguous_clusters(BlockDriverState *bs, int nb_clusters,
-        int cluster_size, uint64_t *l2_slice, uint64_t stop_flags)
+        int cluster_size, uint64_t *l2_slice, int l2_index, uint64_t stop_flags)
 {
+    BDRVQcow2State *s = bs->opaque;
     int i;
     QCow2ClusterType first_cluster_type;
     uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
-    uint64_t first_entry = be64_to_cpu(l2_slice[0]);
+    uint64_t first_entry = get_l2_entry(s, l2_slice, l2_index);
     uint64_t offset = first_entry & mask;
 
     first_cluster_type = qcow2_get_cluster_type(bs, first_entry);
@@ -397,7 +398,7 @@ static int count_contiguous_clusters(BlockDriverState *bs, int nb_clusters,
            first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = be64_to_cpu(l2_slice[i]) & mask;
+        uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index + i) & mask;
         if (offset + (uint64_t) i * cluster_size != l2_entry) {
             break;
         }
@@ -413,14 +414,16 @@ static int count_contiguous_clusters(BlockDriverState *bs, int nb_clusters,
 static int count_contiguous_clusters_unallocated(BlockDriverState *bs,
                                                  int nb_clusters,
                                                  uint64_t *l2_slice,
+                                                 int l2_index,
                                                  QCow2ClusterType wanted_type)
 {
+    BDRVQcow2State *s = bs->opaque;
     int i;
 
     assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t entry = be64_to_cpu(l2_slice[i]);
+        uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
         QCow2ClusterType type = qcow2_get_cluster_type(bs, entry);
 
         if (type != wanted_type) {
@@ -566,7 +569,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     /* find the cluster offset for the given disk offset */
 
     l2_index = offset_to_l2_slice_index(s, offset);
-    *cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+    *cluster_offset = get_l2_entry(s, l2_slice, l2_index);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -601,14 +604,14 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
         c = count_contiguous_clusters_unallocated(bs, nb_clusters,
-                                                  &l2_slice[l2_index], type);
+                                                  l2_slice, l2_index, type);
         *cluster_offset = 0;
         break;
     case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
         /* how many allocated clusters ? */
         c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
-                                      &l2_slice[l2_index], QCOW_OFLAG_ZERO);
+                                      l2_slice, l2_index, QCOW_OFLAG_ZERO);
         *cluster_offset &= L2E_OFFSET_MASK;
         if (offset_into_cluster(s, *cluster_offset)) {
             qcow2_signal_corruption(bs, true, -1, -1,
@@ -761,7 +764,7 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
 
     /* Compression can't overwrite anything. Fail if the cluster was already
      * allocated. */
-    cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+    cluster_offset = get_l2_entry(s, l2_slice, l2_index);
     if (cluster_offset & L2E_OFFSET_MASK) {
         qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
         return -EIO;
@@ -786,7 +789,7 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
 
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
-    l2_slice[l2_index] = cpu_to_be64(cluster_offset);
+    set_l2_entry(s, l2_slice, l2_index, cluster_offset);
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     *host_offset = cluster_offset & s->cluster_offset_mask;
@@ -978,12 +981,12 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
          * cluster the second one has to do RMW (which is done above by
          * perform_cow()), update l2 table with its cluster pointer and free
          * old cluster. This is what this loop does */
-        if (l2_slice[l2_index + i] != 0) {
-            old_cluster[j++] = l2_slice[l2_index + i];
+        if (get_l2_entry(s, l2_slice, l2_index + i) != 0) {
+            old_cluster[j++] = get_l2_entry(s, l2_slice, l2_index + i);
         }
 
-        l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
-                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
+        set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_COPIED |
+                     (cluster_offset + (i << s->cluster_bits)));
      }
 
 
@@ -997,8 +1000,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      */
     if (!m->keep_old_clusters && j != 0) {
         for (i = 0; i < j; i++) {
-            qcow2_free_any_clusters(bs, be64_to_cpu(old_cluster[i]), 1,
-                                    QCOW2_DISCARD_NEVER);
+            qcow2_free_any_clusters(bs, old_cluster[i], 1, QCOW2_DISCARD_NEVER);
         }
     }
 
@@ -1051,7 +1053,7 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
     if (keep_old) {
         int i;
         for (i = 0; i < nb_clusters; i++) {
-            l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
             if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
                 break;
             }
@@ -1062,7 +1064,7 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
     }
 
     /* Get the L2 entry from the first cluster */
-    l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    l2_entry = get_l2_entry(s, l2_slice, l2_index);
     type = qcow2_get_cluster_type(bs, l2_entry);
 
     if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
@@ -1072,7 +1074,7 @@ static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
     }
 
     /* Get the L2 entry from the last cluster */
-    l2_entry = be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
+    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
     type = qcow2_get_cluster_type(bs, l2_entry);
 
     if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
@@ -1139,12 +1141,12 @@ static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
                               uint64_t *l2_slice, int l2_index, bool want_cow)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index]);
+    uint64_t l2_entry = get_l2_entry(s, l2_slice, l2_index);
     uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
     int i;
 
     for (i = 0; i < nb_clusters; i++) {
-        l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+        l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
         if (cluster_needs_cow(bs, l2_entry) != want_cow) {
             break;
         }
@@ -1277,7 +1279,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
         return ret;
     }
 
-    cluster_offset = be64_to_cpu(l2_slice[l2_index]);
+    cluster_offset = get_l2_entry(s, l2_slice, l2_index);
 
     if (!cluster_needs_cow(bs, cluster_offset)) {
         /* If a specific host_offset is required, check it */
@@ -1658,7 +1660,7 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     for (i = 0; i < nb_clusters; i++) {
         uint64_t old_l2_entry;
 
-        old_l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
+        old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
 
         /*
          * If full_discard is false, make sure that a discarded area reads back
@@ -1698,9 +1700,9 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         /* First remove L2 entries */
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (!full_discard && s->qcow_version >= 3) {
-            l2_slice[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
+            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
         } else {
-            l2_slice[l2_index + i] = cpu_to_be64(0);
+            set_l2_entry(s, l2_slice, l2_index + i, 0);
         }
 
         /* Then decrease the refcount */
@@ -1780,7 +1782,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         uint64_t old_offset;
         QCow2ClusterType cluster_type;
 
-        old_offset = be64_to_cpu(l2_slice[l2_index + i]);
+        old_offset = get_l2_entry(s, l2_slice, l2_index + i);
 
         /*
          * Minimize L2 changes if the cluster already reads back as
@@ -1794,10 +1796,11 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
-            l2_slice[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
+            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
         } else {
-            l2_slice[l2_index + i] |= cpu_to_be64(QCOW_OFLAG_ZERO);
+            uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
+            set_l2_entry(s, l2_slice, l2_index + i, entry | QCOW_OFLAG_ZERO);
         }
     }
 
@@ -1935,7 +1938,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             }
 
             for (j = 0; j < s->l2_slice_size; j++) {
-                uint64_t l2_entry = be64_to_cpu(l2_slice[j]);
+                uint64_t l2_entry = get_l2_entry(s, l2_slice, j);
                 int64_t offset = l2_entry & L2E_OFFSET_MASK;
                 QCow2ClusterType cluster_type =
                     qcow2_get_cluster_type(bs, l2_entry);
@@ -1949,7 +1952,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                     if (!bs->backing) {
                         /* not backed; therefore we can simply deallocate the
                          * cluster */
-                        l2_slice[j] = 0;
+                        set_l2_entry(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
                     }
@@ -2012,9 +2015,9 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 }
 
                 if (l2_refcount == 1) {
-                    l2_slice[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+                    set_l2_entry(s, l2_slice, j, offset | QCOW_OFLAG_COPIED);
                 } else {
-                    l2_slice[j] = cpu_to_be64(offset);
+                    set_l2_entry(s, l2_slice, j, offset);
                 }
                 l2_dirty = true;
             }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0d64bf5a5e..84fe02d388 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1309,7 +1309,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     uint64_t cluster_index;
                     uint64_t offset;
 
-                    entry = be64_to_cpu(l2_slice[j]);
+                    entry = get_l2_entry(s, l2_slice, j);
                     old_entry = entry;
                     entry &= ~QCOW_OFLAG_COPIED;
                     offset = entry & L2E_OFFSET_MASK;
@@ -1383,7 +1383,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                             qcow2_cache_set_dependency(bs, s->l2_table_cache,
                                                        s->refcount_block_cache);
                         }
-                        l2_slice[j] = cpu_to_be64(entry);
+                        set_l2_entry(s, l2_slice, j, entry);
                         qcow2_cache_entry_mark_dirty(s->l2_table_cache,
                                                      l2_slice);
                     }
@@ -1616,7 +1616,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
     /* Do the actual checks */
     for(i = 0; i < s->l2_size; i++) {
-        l2_entry = be64_to_cpu(l2_table[i]);
+        l2_entry = get_l2_entry(s, l2_table, i);
 
         switch (qcow2_get_cluster_type(bs, l2_entry)) {
         case QCOW2_CLUSTER_COMPRESSED:
@@ -1685,7 +1685,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                                            QCOW2_OL_INACTIVE_L2;
 
                         l2_entry = QCOW_OFLAG_ZERO;
-                        l2_table[i] = cpu_to_be64(l2_entry);
+                        set_l2_entry(s, l2_table, i, l2_entry);
                         ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, sizeof(uint64_t), false);
                         if (ret < 0) {
@@ -1913,7 +1913,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
         }
 
         for (j = 0; j < s->l2_size; j++) {
-            uint64_t l2_entry = be64_to_cpu(l2_table[j]);
+            uint64_t l2_entry = get_l2_entry(s, l2_table, j);
             uint64_t data_offset = l2_entry & L2E_OFFSET_MASK;
             QCow2ClusterType cluster_type = qcow2_get_cluster_type(bs, l2_entry);
 
@@ -1936,9 +1936,10 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                             "l2_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
                             repair ? "Repairing" : "ERROR", l2_entry, refcount);
                     if (repair) {
-                        l2_table[j] = cpu_to_be64(refcount == 1
-                                    ? l2_entry |  QCOW_OFLAG_COPIED
-                                    : l2_entry & ~QCOW_OFLAG_COPIED);
+                        set_l2_entry(s, l2_table, j,
+                                     refcount == 1 ?
+                                     l2_entry |  QCOW_OFLAG_COPIED :
+                                     l2_entry & ~QCOW_OFLAG_COPIED);
                         l2_dirty++;
                     }
                 }
diff --git a/block/qcow2.h b/block/qcow2.h
index 5cccd87162..940cd4c236 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -488,6 +488,18 @@ typedef enum QCow2MetadataOverlap {
 
 #define INV_OFFSET (-1ULL)
 
+static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
+                                    int idx)
+{
+    return be64_to_cpu(l2_slice[idx]);
+}
+
+static inline void set_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
+                                int idx, uint64_t entry)
+{
+    l2_slice[idx] = cpu_to_be64(entry);
+}
+
 static inline bool has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-- 
2.20.1


