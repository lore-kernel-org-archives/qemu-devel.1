Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8E4206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Po7FEq3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8E4206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCR5-0000oZ-Lc
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQC4Y-00084M-RU; Wed, 07 Oct 2020 12:13:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:49535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQC4W-00040U-1q; Wed, 07 Oct 2020 12:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=SaVLv1MCCvjJEnd1v6sDBIjAvrIK/IZkqswk6U92goc=; 
 b=Po7FEq3fYVYTjURB6tcT7V+G7eb9Oct4B302GWqDzeZnh90twP92rkYxiNtYe6fA4dwPeW+6wLV3+4UgvxmSo2oos/5VPSoNAJsF5ppvg+BNYFEMdRupkThacKUPHEJeZTKfvyp/nxGitcglVUrwqR2kltiq3aEHRLW9z7SBXAaWAN19rFDi6OVwCQw1+SgINp5nlBxI5/rWQCIadHUvZJGFBLvEr+ypyGYczM3VtUXZrlwmJ9ohpy1b+99WI/xxCCOge4iwH09xbMQGjWy7pImKPeVc161s+FsJ8+J6/e40iKo8ytpc5N+DdZOM4JD7CD79ML0GnJw5FHW60sRpkw==;
Received: from [81.0.34.65] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kQC4P-0007iY-P5; Wed, 07 Oct 2020 18:13:37 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kQC4C-0001E3-PT; Wed, 07 Oct 2020 18:13:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qcow2: Document and enforce the QCowL2Meta invariants
Date: Wed,  7 Oct 2020 18:13:23 +0200
Message-Id: <20201007161323.4667-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 11:38:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QCowL2Meta structure is used to store information about a part of
a write request that touches clusters that need changes in their L2
entries. This happens with newly-allocated clusters or subclusters.

This structure has changed a bit since it was first created and its
current documentation is not quite up-to-date.

A write request can span a region consisting of a combination of
clusters of different types, and qcow2_alloc_host_offset() can
repeatedly call handle_copied() and handle_alloc() to add more
clusters to the mix as long as they all are contiguous on the image
file.

Because of this a write request has a list of QCowL2Meta structures,
one for each part of the request that needs changes in the L2
metadata.

Each one of them spans nb_clusters and has two copy-on-write regions
located immediately before and after the middle region touched by that
part of the write request. Even when those regions themselves are
empty their offsets must be correct because they are used to know the
location of the middle region.

This was not always the case but it is not a problem anymore
because the only two places where QCowL2Meta structures are created
(calculate_l2_meta() and qcow2_co_truncate()) ensure that the
copy-on-write regions are correctly defined, and so do assertions like
the ones in perform_cow().

The conditional initialization of the 'written_to' variable is
therefore unnecessary and is removed by this patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         | 19 +++++++++++--------
 block/qcow2-cluster.c |  5 +++--
 block/qcow2.c         | 19 +++++++++++++++----
 3 files changed, 29 insertions(+), 14 deletions(-)

v2: Fix mistakes on the commit messages [Eric]

diff --git a/block/qcow2.h b/block/qcow2.h
index 125ea9679b..2e0272a7b8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -435,17 +435,18 @@ typedef struct Qcow2COWRegion {
 
 /**
  * Describes an in-flight (part of a) write request that writes to clusters
- * that are not referenced in their L2 table yet.
+ * that need to have their L2 table entries updated (because they are
+ * newly allocated or need changes in their L2 bitmaps)
  */
 typedef struct QCowL2Meta
 {
-    /** Guest offset of the first newly allocated cluster */
+    /** Guest offset of the first updated cluster */
     uint64_t offset;
 
-    /** Host offset of the first newly allocated cluster */
+    /** Host offset of the first updated cluster */
     uint64_t alloc_offset;
 
-    /** Number of newly allocated clusters */
+    /** Number of updated clusters */
     int nb_clusters;
 
     /** Do not free the old clusters */
@@ -458,14 +459,16 @@ typedef struct QCowL2Meta
     CoQueue dependent_requests;
 
     /**
-     * The COW Region between the start of the first allocated cluster and the
-     * area the guest actually writes to.
+     * The COW Region immediately before the area the guest actually
+     * writes to. This (part of the) write request starts at
+     * cow_start.offset + cow_start.nb_bytes.
      */
     Qcow2COWRegion cow_start;
 
     /**
-     * The COW Region between the area the guest actually writes to and the
-     * end of the last allocated cluster.
+     * The COW Region immediately after the area the guest actually
+     * writes to. This (part of the) write request ends at cow_end.offset
+     * (which must always be set even when cow_end.nb_bytes is 0).
      */
     Qcow2COWRegion cow_end;
 
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index aa87d3e99b..485b4cb92e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1049,6 +1049,8 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
 
     assert(l2_index + m->nb_clusters <= s->l2_slice_size);
+    assert(m->cow_end.offset + m->cow_end.nb_bytes <=
+           m->nb_clusters << s->cluster_bits);
     for (i = 0; i < m->nb_clusters; i++) {
         uint64_t offset = cluster_offset + ((uint64_t)i << s->cluster_bits);
         /* if two concurrent writes happen to the same unallocated cluster
@@ -1070,8 +1072,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         if (has_subclusters(s) && !m->prealloc) {
             uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
             unsigned written_from = m->cow_start.offset;
-            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
-                m->nb_clusters << s->cluster_bits;
+            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes;
             int first_sc, last_sc;
             /* Narrow written_from and written_to down to the current cluster */
             written_from = MAX(written_from, i << s->cluster_bits);
diff --git a/block/qcow2.c b/block/qcow2.c
index b05512718c..e7b27fdf25 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2361,15 +2361,26 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
             continue;
         }
 
-        /* The data (middle) region must be immediately after the
-         * start region */
+        /*
+         * The write request should start immediately after the first
+         * COW region. This does not always happen because the area
+         * touched by the request can be larger than the one defined
+         * by @m (a single request can span an area consisting of a
+         * mix of previously unallocated and allocated clusters, that
+         * is why @l2meta is a list).
+         */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
+            /* In this case the request starts before this region */
+            assert(offset < l2meta_cow_start(m));
+            assert(m->cow_start.nb_bytes == 0);
             continue;
         }
 
-        /* The end region must be immediately after the data (middle)
-         * region */
+        /* The write request should end immediately before the second
+         * COW region (see above for why it does not always happen) */
         if (m->offset + m->cow_end.offset != offset + bytes) {
+            assert(offset + bytes > m->offset + m->cow_end.offset);
+            assert(m->cow_end.nb_bytes == 0);
             continue;
         }
 
-- 
2.20.1


