Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D1CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA6420863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qWUk+kvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA6420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUXq-00019h-Cm
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZj-00005k-PI
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZi-0005MT-Fo
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZg-0005Ez-9F; Sat, 26 Oct 2019 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=XEHEvrfcsTX6rTQlJxWyEBBrm+2ho4FOc5MlDoGNc74=; 
 b=qWUk+kvBkREm/977gysMGaD02BlQBPUaPBN3JT1v2rQP2o1y+7H6Ud5GwgIsX56Rr7f+B/sqxyQ/HQBC6/8N/AKm8RwY0MIU4lNefM5cwdA4Yu4bJ4M0LIoilB9NHBduac2FMzmc89SbHIyqHz0okNxAkuAzTCMYC4HEJwGgw0ZBxw7lstM04l00TLADGT6op3NkEaohpYqVxkvSMW0eHw+CrMOuA6Rbfy6j1UXlwbUJN5czqRlScyhC86rwpmTOXZTn8Hx9qdMWSPdINEvvNerTSsj/F3iosJtz+HNTgb8m/JrHLFE0rcSYh3y0IR+a16s+BbX9PmOPWUqIrYwRTQ==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045j-Jv; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001P2-12; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
Date: Sun, 27 Oct 2019 00:25:03 +0300
Message-Id: <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
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

handle_alloc() creates a QCowL2Meta structure in order to update the
image metadata and perform the necessary copy-on-write operations.

This patch moves that code to a separate function so it can be used
from other places.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 76 +++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8982b7b762..6c1dcdc781 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1019,6 +1019,55 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
                         QCOW2_DISCARD_NEVER);
 }
 
+/*
+ * For a given write request, create a new QCowL2Meta structure and
+ * add it to @m.
+ *
+ * @host_offset points to the beginning of the first cluster.
+ *
+ * @guest_offset and @bytes indicate the offset and length of the
+ * request.
+ *
+ * If @keep_old is true it means that the clusters were already
+ * allocated and will be overwritten. If false then the clusters are
+ * new and we have to decrease the reference count of the old ones.
+ */
+static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset,
+                              uint64_t guest_offset, uint64_t bytes,
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
+        .alloc_offset   = host_offset,
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
@@ -1417,35 +1466,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
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


