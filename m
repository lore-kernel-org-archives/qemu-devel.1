Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8662C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CC621D80
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ADxM9t4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CC621D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeJg-0003bu-AU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ3-0002dW-Gn; Tue, 08 Sep 2020 10:09:09 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ0-0004GP-2a; Tue, 08 Sep 2020 10:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=iURH801BBUb7sWphpIXEwbs0fpz4AS7JQPtbXPlcCuQ=; 
 b=ADxM9t4/x5czklqh4/H94oCMbyss7RRYmrzXMlZLQ8F6Wyt33eAGzeT2wD1KA18CsnJp+eHurnZPp3Mo4d6eZKAplszjsyhrXiGVmVGSLGArzR+vdTrL+SAE8dpSLsaMVnBkOfcVNVaebXxd/Ks/nQ0wBy02SkeHaHT5flqq76VOg4ZXTioPinHsr73+St5TpBh+VYeo5e2xQB8F5O5vHDuNylSyhRYz/+VcrrWVcSK17n4TR3oU3Tcqff7neevQiHpFIPvqv3x22FYPu64SgURnqItrHUZSbMbVDlpYDxH92t8F9WSUcoQLnzW/UQ7HGgkBRTmXgRGMouGwWuoGhw==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kFeIe-0007AN-3R; Tue, 08 Sep 2020 16:08:44 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kFeIR-0001zR-9q; Tue, 08 Sep 2020 16:08:31 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qcow2: Make qcow2_free_any_clusters() free only one
 cluster
Date: Tue,  8 Sep 2020 16:08:28 +0200
Message-Id: <77cea0f4616f921d37e971b3c5b18a2faa24b173.1599573989.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599573989.git.berto@igalia.com>
References: <cover.1599573989.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 10:08:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function takes an L2 entry and a number of clusters to free.
Although in principle it can free any type of cluster (using the L2
entry to determine its type) in practice the API is broken because
compressed clusters have a variable size and there is no way to free
more than one without having the L2 entry of each one of them.

The good news all callers are passing nb_clusters=1 so we can simply
get rid of that parameter.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h          | 4 ++--
 block/qcow2-cluster.c  | 6 +++---
 block/qcow2-refcount.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 065ec3df0b..bb6358121d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -855,8 +855,8 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, int size);
 void qcow2_free_clusters(BlockDriverState *bs,
                           int64_t offset, int64_t size,
                           enum qcow2_discard_type type);
-void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
-                             int nb_clusters, enum qcow2_discard_type type);
+void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
+                            enum qcow2_discard_type type);
 
 int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 996b3314f4..89c561e4c0 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1096,7 +1096,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      */
     if (!m->keep_old_clusters && j != 0) {
         for (i = 0; i < j; i++) {
-            qcow2_free_any_clusters(bs, old_cluster[i], 1, QCOW2_DISCARD_NEVER);
+            qcow2_free_any_cluster(bs, old_cluster[i], QCOW2_DISCARD_NEVER);
         }
     }
 
@@ -1911,7 +1911,7 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
         /* Then decrease the refcount */
-        qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
+        qcow2_free_any_cluster(bs, old_l2_entry, type);
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
@@ -2003,7 +2003,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (unmap) {
-            qcow2_free_any_clusters(bs, old_l2_entry, 1, QCOW2_DISCARD_REQUEST);
+            qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
         }
         set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
         if (has_subclusters(s)) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index aae52607eb..fc9bb2258f 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1156,8 +1156,8 @@ void qcow2_free_clusters(BlockDriverState *bs,
  * Free a cluster using its L2 entry (handles clusters of all types, e.g.
  * normal cluster, compressed cluster, etc.)
  */
-void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
-                             int nb_clusters, enum qcow2_discard_type type)
+void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
+                            enum qcow2_discard_type type)
 {
     BDRVQcow2State *s = bs->opaque;
     QCow2ClusterType ctype = qcow2_get_cluster_type(bs, l2_entry);
@@ -1168,7 +1168,7 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
              ctype == QCOW2_CLUSTER_ZERO_ALLOC))
         {
             bdrv_pdiscard(s->data_file, l2_entry & L2E_OFFSET_MASK,
-                          nb_clusters << s->cluster_bits);
+                          s->cluster_size);
         }
         return;
     }
@@ -1191,7 +1191,7 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
                                     l2_entry & L2E_OFFSET_MASK);
         } else {
             qcow2_free_clusters(bs, l2_entry & L2E_OFFSET_MASK,
-                                nb_clusters << s->cluster_bits, type);
+                                s->cluster_size, type);
         }
         break;
     case QCOW2_CLUSTER_ZERO_PLAIN:
-- 
2.20.1


