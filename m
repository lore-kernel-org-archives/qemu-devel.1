Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097F220657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b6IOfG+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097F220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvhm-0007S9-82
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvf1-00023n-2M; Fri, 10 Jul 2020 12:14:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvew-0004uw-OK; Fri, 10 Jul 2020 12:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=/yQAkav8k8jXe1E9CSu1YKeUgRZlXQ8ZbGUL+Lwq/rk=; 
 b=b6IOfG+jOqYO2UwmAaN0eLPFUONl0tc75qxHMqIivAIHukpsx6rzgC5LmqdNqhBWnNzVmPwIsJGYFNJ4CILPJkHSlhyEcqYYPjGGfI+aDdI+a8SARtLIbI/Q/xybkEoxwUDqK4CeluTBmmiHNuxgPjTIQFFJX9wY3gKHPKOqa694bxe+BQtJbw04PBa2tl/rtMVl25FWPk6RI186FUnyL62y2zfsFUtl/3HyBy7Mu4SuNstcMW86O0W+TQvU3Bvjo0Ci7pFAh88WLzpWUByeGGH5mjuO3FsYgTSc0R8kGMBrnzu3Ud78Y3+ZQH1+vf0uHpLegLUdfpKoxhw8aTqTlA==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtveZ-0003jT-2T; Fri, 10 Jul 2020 18:13:35 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveK-0001QE-L0; Fri, 10 Jul 2020 18:13:20 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 03/34] qcow2: Add calculate_l2_meta()
Date: Fri, 10 Jul 2020 18:12:45 +0200
Message-Id: <e5bc4a648dac31972bfa7a0e554be8064be78799.1594396418.git.berto@igalia.com>
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

handle_alloc() creates a QCowL2Meta structure in order to update the
image metadata and perform the necessary copy-on-write operations.

This patch moves that code to a separate function so it can be used
from other places.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 77 +++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 2d9ae6481c..360da3f6b2 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1038,6 +1038,56 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
     }
 }
 
+/*
+ * For a given write request, create a new QCowL2Meta structure, add
+ * it to @m and the BDRVQcow2State.cluster_allocs list.
+ *
+ * @host_cluster_offset points to the beginning of the first cluster.
+ *
+ * @guest_offset and @bytes indicate the offset and length of the
+ * request.
+ *
+ * If @keep_old is true it means that the clusters were already
+ * allocated and will be overwritten. If false then the clusters are
+ * new and we have to decrease the reference count of the old ones.
+ */
+static void calculate_l2_meta(BlockDriverState *bs,
+                              uint64_t host_cluster_offset,
+                              uint64_t guest_offset, unsigned bytes,
+                              QCowL2Meta **m, bool keep_old)
+{
+    BDRVQcow2State *s = bs->opaque;
+    unsigned cow_start_from = 0;
+    unsigned cow_start_to = offset_into_cluster(s, guest_offset);
+    unsigned cow_end_from = cow_start_to + bytes;
+    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
+    unsigned nb_clusters = size_to_clusters(s, cow_end_from);
+    QCowL2Meta *old_m = *m;
+
+    *m = g_malloc0(sizeof(**m));
+    **m = (QCowL2Meta) {
+        .next           = old_m,
+
+        .alloc_offset   = host_cluster_offset,
+        .offset         = start_of_cluster(s, guest_offset),
+        .nb_clusters    = nb_clusters,
+
+        .keep_old_clusters = keep_old,
+
+        .cow_start = {
+            .offset     = cow_start_from,
+            .nb_bytes   = cow_start_to - cow_start_from,
+        },
+        .cow_end = {
+            .offset     = cow_end_from,
+            .nb_bytes   = cow_end_to - cow_end_from,
+        },
+    };
+
+    qemu_co_queue_init(&(*m)->dependent_requests);
+    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
+}
+
 /*
  * Returns the number of contiguous clusters that can be used for an allocating
  * write, but require COW to be performed (this includes yet unallocated space,
@@ -1436,35 +1486,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t requested_bytes = *bytes + offset_into_cluster(s, guest_offset);
     int avail_bytes = nb_clusters << s->cluster_bits;
     int nb_bytes = MIN(requested_bytes, avail_bytes);
-    QCowL2Meta *old_m = *m;
-
-    *m = g_malloc0(sizeof(**m));
-
-    **m = (QCowL2Meta) {
-        .next           = old_m,
-
-        .alloc_offset   = alloc_cluster_offset,
-        .offset         = start_of_cluster(s, guest_offset),
-        .nb_clusters    = nb_clusters,
-
-        .keep_old_clusters  = keep_old_clusters,
-
-        .cow_start = {
-            .offset     = 0,
-            .nb_bytes   = offset_into_cluster(s, guest_offset),
-        },
-        .cow_end = {
-            .offset     = nb_bytes,
-            .nb_bytes   = avail_bytes - nb_bytes,
-        },
-    };
-    qemu_co_queue_init(&(*m)->dependent_requests);
-    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
 
     *host_offset = alloc_cluster_offset + offset_into_cluster(s, guest_offset);
     *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
     assert(*bytes != 0);
 
+    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
+                      m, keep_old_clusters);
+
     return 1;
 
 fail:
-- 
2.20.1


