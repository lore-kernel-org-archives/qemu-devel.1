Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01757C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ECB206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MqafXVFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ECB206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2Ny-00041M-TI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gd-0002Kr-Su; Wed, 10 Jun 2020 11:03:51 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2GX-0006vw-Ay; Wed, 10 Jun 2020 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=x44WykpORUb7jKPsPZokuc5MU7JgoaeSdWXwYoNGUz0=; 
 b=MqafXVFkNn/15r4J3crS1b1lYBI9YV/ykJbenJ0U1Ua+uAyKTfH7B/NmVGyQaNF+Je5jBv/ofRvQsxuS0vHsxOw4F2RQvVd7kr/0u6qtDaN+94u4sHH5+S0cpliWclolL33lwrJQAR6dqW5b5JtCrJxn5MhVLk0aJbDDZayqNZrqepGi79dsxVWzcwUKOlYILSzsHWRfWo+be8CApUFR8LchK2qbUGwaeuIP4wdTb+Bz7Vx+L8z6TZL1tJW74TauD2S8RKQcDn2Uy3zLlbxe5dtUQaxf68ndxwqrpkWZGMuN/a7rD1NsnnC48cats8RQ7dcJiLpKiXVm9hkzPyPVqw==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jj2GR-0007gi-7E; Wed, 10 Jun 2020 17:03:39 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jj2GB-0007Ma-Ox; Wed, 10 Jun 2020 17:03:23 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/34] qcow2: Split cluster_needs_cow() out of
 count_cow_clusters()
Date: Wed, 10 Jun 2020 17:02:42 +0200
Message-Id: <22bb483be1b70b26e9fb61faf3579195f2df99bf.1591801197.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
References: <cover.1591801197.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:03:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

We are going to need it in other places.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 61ad638bdc..80f9787461 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1087,6 +1087,24 @@ static void calculate_l2_meta(BlockDriverState *bs,
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
 }
 
+/* Returns true if writing to a cluster requires COW */
+static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
+{
+    switch (qcow2_get_cluster_type(bs, l2_entry)) {
+    case QCOW2_CLUSTER_NORMAL:
+        if (l2_entry & QCOW_OFLAG_COPIED) {
+            return false;
+        }
+    case QCOW2_CLUSTER_UNALLOCATED:
+    case QCOW2_CLUSTER_COMPRESSED:
+    case QCOW2_CLUSTER_ZERO_PLAIN:
+    case QCOW2_CLUSTER_ZERO_ALLOC:
+        return true;
+    default:
+        abort();
+    }
+}
+
 /*
  * Returns the number of contiguous clusters that can be used for an allocating
  * write, but require COW to be performed (this includes yet unallocated space,
@@ -1099,25 +1117,11 @@ static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
 
     for (i = 0; i < nb_clusters; i++) {
         uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
-        QCow2ClusterType cluster_type = qcow2_get_cluster_type(bs, l2_entry);
-
-        switch(cluster_type) {
-        case QCOW2_CLUSTER_NORMAL:
-            if (l2_entry & QCOW_OFLAG_COPIED) {
-                goto out;
-            }
+        if (!cluster_needs_cow(bs, l2_entry)) {
             break;
-        case QCOW2_CLUSTER_UNALLOCATED:
-        case QCOW2_CLUSTER_COMPRESSED:
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_ZERO_ALLOC:
-            break;
-        default:
-            abort();
         }
     }
 
-out:
     assert(i <= nb_clusters);
     return i;
 }
-- 
2.20.1


