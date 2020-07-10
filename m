Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674BC20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SSXzVs/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674BC20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvna-0002Aj-Ix
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfQ-0003AK-Fr; Fri, 10 Jul 2020 12:14:28 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfJ-0004w1-JP; Fri, 10 Jul 2020 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=oGG1Fgq5BJpPtfkJKz5xEU3qJSWeyhX0fR6sza+6YaA=; 
 b=SSXzVs/tccC33UfClrYYMoYt05LoE+3zJN+UZbv/9J7Cuv/uW2YsRXVSUjBeTHjCtXK66NxiQ03eyaxjF8eIFiTp0szuHb3hBh6FhBwLrotEoASfc2PkaJAzfTmtjL7/rTo+orJPH8jYb0droVw8b9zRFG1J7n+gX/OxD/PD0JMK7U4WNv5CFKlyydEO7K+qJ1YiQQ6xNhPSBedgxokuTpC05B85MMywGOUdxyWJiefahElBWJKzDN7A9CftHpM8rCvFlrzPSTKnzoY2ExFObpEI4k9Lr/PLF5Nklg/AJZYZUNlJFzLEZ4wO+DS7bxQNQuxLvCCGWNFD8Bwo6NACFg==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtvea-0003js-L4; Fri, 10 Jul 2020 18:13:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveL-0001R8-C1; Fri, 10 Jul 2020 18:13:21 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 23/34] qcow2: Add subcluster support to
 discard_in_l2_slice()
Date: Fri, 10 Jul 2020 18:13:05 +0200
Message-Id: <5ef8274e628aa3ab559bfac467abf488534f2b76.1594396418.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594396418.git.berto@igalia.com>
References: <cover.1594396418.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 12:13:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 52 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cb07fd00a1..ea025dc531 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1848,11 +1848,17 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t old_l2_entry;
-
-        old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+        uint64_t new_l2_entry = old_l2_entry;
+        uint64_t new_l2_bitmap = old_l2_bitmap;
+        QCow2ClusterType cluster_type =
+            qcow2_get_cluster_type(bs, old_l2_entry);
 
         /*
+         * If full_discard is true, the cluster should not read back as zeroes,
+         * but rather fall through to the backing file.
+         *
          * If full_discard is false, make sure that a discarded area reads back
          * as zeroes for v3 images (we cannot do it for v2 without actually
          * writing a zero-filled buffer). We can skip the operation if the
@@ -1861,40 +1867,28 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
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
+        } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
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


