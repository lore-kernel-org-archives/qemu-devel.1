Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C165C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE4420674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RA+ilQK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE4420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGuY-00072z-9J
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmb-0002oP-0q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmZ-0007V8-2x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmX-0005Yw-AL; Tue, 17 Mar 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=2/fHBs05oNAu/0EPAuhlH3K3uwbVq0B0b7Vdy8GVdcg=; 
 b=RA+ilQK/ZQiIIgZJe2YHEE49MVH27Aq4azrKyG3E9QPUl/H6DEeurSvMxbegEGC46X4gs12mBWe41DmVz2Py4eJWgZ0BTd4ZL+KNfPHb27j9pDiax1EqMlzCd4nhgCVSRfyK94l6t1PcM/pOIjb2DxImPDkX6BXqL32f/Jnyb5ilxbqY+qMkTbge9lmd4dUPbfRRbKW7+h41f2917D4UOJN/QhTYL4HSSnWMfBiZR/pBY6uNLasJa3FBFreSDMErc6BnWC88WC5lEr1NZaJBwXwOLXIfu83OO4i3xTPUvt+b37AnficyY9BBk6IEhxF54pju81hpU1sp5f2aJu1OIA==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015P-0t; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OP-DX; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/30] qcow2: Add l2_entry_size()
Date: Tue, 17 Mar 2020 19:16:08 +0100
Message-Id: <fd0f93353a218ff4518f34ebdbca05c2fc0f1085.1584468723.git.berto@igalia.com>
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

qcow2 images with subclusters have 128-bit L2 entries. The first 64
bits contain the same information as traditional images and the last
64 bits form a bitmap with the status of each individual subcluster.

Because of that we cannot assume that L2 entries are sizeof(uint64_t)
anymore. This function returns the proper value for the image.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  9 +++++++++
 block/qcow2-cluster.c  | 12 ++++++------
 block/qcow2-refcount.c | 14 ++++++++------
 block/qcow2.c          |  8 ++++----
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 06929072d2..1eb4b46807 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -80,6 +80,10 @@
 
 #define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
 
+/* Size of normal and extended L2 entries */
+#define L2E_SIZE_NORMAL   (sizeof(uint64_t))
+#define L2E_SIZE_EXTENDED (sizeof(uint64_t) * 2)
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
@@ -506,6 +510,11 @@ static inline bool has_subclusters(BDRVQcow2State *s)
     return false;
 }
 
+static inline size_t l2_entry_size(BDRVQcow2State *s)
+{
+    return has_subclusters(s) ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
+}
+
 static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
                                     int idx)
 {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cd48ab0223..41a23c5305 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -208,7 +208,7 @@ static int l2_load(BlockDriverState *bs, uint64_t offset,
                    uint64_t l2_offset, uint64_t **l2_slice)
 {
     BDRVQcow2State *s = bs->opaque;
-    int start_of_slice = sizeof(uint64_t) *
+    int start_of_slice = l2_entry_size(s) *
         (offset_to_l2_index(s, offset) - offset_to_l2_slice_index(s, offset));
 
     return qcow2_cache_get(bs, s->l2_table_cache, l2_offset + start_of_slice,
@@ -281,7 +281,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index)
 
     /* allocate a new l2 entry */
 
-    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * sizeof(uint64_t));
+    l2_offset = qcow2_alloc_clusters(bs, s->l2_size * l2_entry_size(s));
     if (l2_offset < 0) {
         ret = l2_offset;
         goto fail;
@@ -305,7 +305,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index)
 
     /* allocate a new entry in the l2 cache */
 
-    slice_size2 = s->l2_slice_size * sizeof(uint64_t);
+    slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
     trace_qcow2_l2_allocate_get_empty(bs, l1_index);
@@ -369,7 +369,7 @@ fail:
     }
     s->l1_table[l1_index] = old_l2_offset;
     if (l2_offset > 0) {
-        qcow2_free_clusters(bs, l2_offset, s->l2_size * sizeof(uint64_t),
+        qcow2_free_clusters(bs, l2_offset, s->l2_size * l2_entry_size(s),
                             QCOW2_DISCARD_ALWAYS);
     }
     return ret;
@@ -718,7 +718,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
         /* Then decrease the refcount of the old table */
         if (l2_offset) {
-            qcow2_free_clusters(bs, l2_offset, s->l2_size * sizeof(uint64_t),
+            qcow2_free_clusters(bs, l2_offset, s->l2_size * l2_entry_size(s),
                                 QCOW2_DISCARD_OTHER);
         }
 
@@ -1919,7 +1919,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     int ret;
     int i, j;
 
-    slice_size2 = s->l2_slice_size * sizeof(uint64_t);
+    slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
     if (!is_active_l1) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 141e4fdcb1..3b89a97fd0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1254,7 +1254,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     l2_slice = NULL;
     l1_table = NULL;
     l1_size2 = l1_size * sizeof(uint64_t);
-    slice_size2 = s->l2_slice_size * sizeof(uint64_t);
+    slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
     s->cache_discards = true;
@@ -1605,7 +1605,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
     int i, l2_size, nb_csectors, ret;
 
     /* Read L2 table from disk */
-    l2_size = s->l2_size * sizeof(uint64_t);
+    l2_size = s->l2_size * l2_entry_size(s);
     l2_table = g_malloc(l2_size);
 
     ret = bdrv_pread(bs->file, l2_offset, l2_table, l2_size);
@@ -1680,15 +1680,16 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                             fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
                             offset);
                     if (fix & BDRV_FIX_ERRORS) {
+                        int idx = i * (l2_entry_size(s) / sizeof(uint64_t));
                         uint64_t l2e_offset =
-                            l2_offset + (uint64_t)i * sizeof(uint64_t);
+                            l2_offset + (uint64_t)i * l2_entry_size(s);
                         int ign = active ? QCOW2_OL_ACTIVE_L2 :
                                            QCOW2_OL_INACTIVE_L2;
 
                         l2_entry = QCOW_OFLAG_ZERO;
                         set_l2_entry(s, l2_table, i, l2_entry);
                         ret = qcow2_pre_write_overlap_check(bs, ign,
-                                l2e_offset, sizeof(uint64_t), false);
+                                l2e_offset, l2_entry_size(s), false);
                         if (ret < 0) {
                             fprintf(stderr, "ERROR: Overlap check failed\n");
                             res->check_errors++;
@@ -1698,7 +1699,8 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         }
 
                         ret = bdrv_pwrite_sync(bs->file, l2e_offset,
-                                               &l2_table[i], sizeof(uint64_t));
+                                               &l2_table[idx],
+                                               l2_entry_size(s));
                         if (ret < 0) {
                             fprintf(stderr, "ERROR: Failed to overwrite L2 "
                                     "table entry: %s\n", strerror(-ret));
@@ -1905,7 +1907,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
         }
 
         ret = bdrv_pread(bs->file, l2_offset, l2_table,
-                         s->l2_size * sizeof(uint64_t));
+                         s->l2_size * l2_entry_size(s));
         if (ret < 0) {
             fprintf(stderr, "ERROR: Could not read L2 table: %s\n",
                     strerror(-ret));
diff --git a/block/qcow2.c b/block/qcow2.c
index 239e0ad3d9..d3b8581aed 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -870,7 +870,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     uint64_t max_l2_entries = DIV_ROUND_UP(virtual_disk_size, s->cluster_size);
     /* An L2 table is always one cluster in size so the max cache size
      * should be a multiple of the cluster size. */
-    uint64_t max_l2_cache = ROUND_UP(max_l2_entries * sizeof(uint64_t),
+    uint64_t max_l2_cache = ROUND_UP(max_l2_entries * l2_entry_size(s),
                                      s->cluster_size);
 
     combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
@@ -1031,7 +1031,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
     }
 
-    r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
+    r->l2_slice_size = l2_cache_entry_size / l2_entry_size(s);
     r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
                                            l2_cache_entry_size);
     r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size,
@@ -1425,7 +1425,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         bs->encrypted = true;
     }
 
-    s->l2_bits = s->cluster_bits - 3; /* L2 is always one cluster */
+    s->l2_bits = s->cluster_bits - ctz32(l2_entry_size(s));
     s->l2_size = 1 << s->l2_bits;
     /* 2^(s->refcount_order - 3) is the refcount width in bytes */
     s->refcount_block_bits = s->cluster_bits - (s->refcount_order - 3);
@@ -4104,7 +4104,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
          *  preallocation. All that matters is that we will not have to allocate
          *  new refcount structures for them.) */
         nb_new_l2_tables = DIV_ROUND_UP(nb_new_data_clusters,
-                                        s->cluster_size / sizeof(uint64_t));
+                                        s->cluster_size / l2_entry_size(s));
         /* The cluster range may not be aligned to L2 boundaries, so add one L2
          * table for a potential head/tail */
         nb_new_l2_tables++;
-- 
2.20.1


