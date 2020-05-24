Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C7AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BB120826
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YJ2Ik3+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BB120826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs0W-00043f-Gy
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzZ-0001gN-Fy; Sun, 24 May 2020 10:52:45 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzX-0002kE-7X; Sun, 24 May 2020 10:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=FkRe2j8xgh8fITQ6IazREs9CCoGHVR/WNb0awBJK/Ko=; 
 b=YJ2Ik3+iNklfA4reOkNzcyqcNApcvUkQ1ONyLM3lNFMBP8WRyfHNh1sPyMbKjnBAdnjs0O2HvrneFuCXhr4D6BP6e+r31OEXcMrHBKF3iaJVS4GPbcWE5UYquEiHXYSXgSAFTsQNAG5axb0VulyeejvXsSbLOS2L0gl2y0G5BsbYkcPxgbE2JwodGLZP6WkNMakal2sI6tv9RAJ1ZnvGOd21UQko2NlTLJo+ZtuN7oiO1UOw7VRna2w9IgsBqPrUcFyEO/oXCJZKEDpy80XPSE1NloIttidSe2NySKXyGpyfqMuFZDpThea89yr10NApJoC+ltlOSSIuQ/SCo3dAaQ==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrz9-0007GH-7d; Sun, 24 May 2020 16:52:19 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005Ki-C8; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 23/32] qcow2: Add subcluster support to
 discard_in_l2_slice()
Date: Sun, 24 May 2020 16:51:43 +0200
Message-Id: <7f39a9000f6564f2e822a5c232e27b40f72b46f0.1590331741.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
References: <cover.1590331741.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:52:20
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

Two things need to be taken into account here:

1) With full_discard == true the L2 entry must be cleared completely.
   This also includes the L2 bitmap if the image has extended L2
   entries.

2) With full_discard == false we have to make the discarded cluster
   read back as zeroes. With normal L2 entries this is done with the
   QCOW_OFLAG_ZERO bit, whereas with extended L2 entries this is done
   with the individual 'all zeroes' bits for each subcluster.

   Note however that QCOW_OFLAG_ZERO is not supported in v2 qcow2
   images so, if there is a backing file, discard cannot guarantee
   that the image will read back as zeroes. If this is important for
   the caller it should forbid it as qcow2_co_pdiscard() does (see
   80f5c01183 for more details).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 51 +++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4e59bbd545..5e70b76c21 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1847,11 +1847,16 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t old_l2_entry;
-
-        old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+        uint64_t new_l2_entry = old_l2_entry;
+        uint64_t new_l2_bitmap = old_l2_bitmap;
+        QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
 
         /*
+         * If full_discard is true, the cluster should not read back as zeroes,
+         * but rather fall through to the backing file.
+         *
          * If full_discard is false, make sure that a discarded area reads back
          * as zeroes for v3 images (we cannot do it for v2 without actually
          * writing a zero-filled buffer). We can skip the operation if the
@@ -1860,40 +1865,28 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
          *
          * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
-         *
-         * If full_discard is true, the sector should not read back as zeroes,
-         * but rather fall through to the backing file.
          */
-        switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
-        case QCOW2_CLUSTER_UNALLOCATED:
-            if (full_discard || !bs->backing) {
-                continue;
+        if (full_discard) {
+            new_l2_entry = new_l2_bitmap = 0;
+        } else if (bs->backing || qcow2_cluster_is_allocated(type)) {
+            if (has_subclusters(s)) {
+                new_l2_entry = 0;
+                new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
+            } else {
+                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
             }
-            break;
+        }
 
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-            if (!full_discard) {
-                continue;
-            }
-            break;
-
-        case QCOW2_CLUSTER_ZERO_ALLOC:
-        case QCOW2_CLUSTER_NORMAL:
-        case QCOW2_CLUSTER_COMPRESSED:
-            break;
-
-        default:
-            abort();
+        if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
+            continue;
         }
 
         /* First remove L2 entries */
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
-        if (!full_discard && s->qcow_version >= 3) {
-            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
-        } else {
-            set_l2_entry(s, l2_slice, l2_index + i, 0);
+        set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
+        if (has_subclusters(s)) {
+            set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
-
         /* Then decrease the refcount */
         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
     }
-- 
2.20.1


