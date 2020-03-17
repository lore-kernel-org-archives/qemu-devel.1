Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE0C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6968720714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TBul/Dsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6968720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH3J-0003XS-HV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmx-0003U7-IJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmv-00008k-1x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005yA-4H; Tue, 17 Mar 2020 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=/N5tR/EenqLcII0SrkA0hO9WogY+jGlaf4KeRI4XFi4=; 
 b=TBul/DslfCmx4VQNouxwZxLTeT8ahqYMUSOZlDG+HF5UuwWX4OvIOT/azJ9SKn9E2/2S4gc3I8LK0hWFiox4Cg9KdE95Yx0ldV3SJITpEaCpYqbP8L/poxJ278uIkqCWA0jSYMBbRSNJK3xN5LLadbwtFqcdTfHgMni5Sbjwas2U7JiZ82/rPT6QEJo1Gn9Vptu0yagUvYQuGWzx0KGxaU8v98qE8yaazdmrUQdIUi/UJH+odNMG1+vJQEJte1m4cM/otZcdYoISZGQprRwfiyMNyqUhuwWh94LjDPVBMcxVkYklvHuN530iF7m1DTnCwHaB7YFu+ZspPzIJ8G/spw==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-000151-2y; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006Of-M8; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/30] qcow2: Add subcluster support to zero_in_l2_slice()
Date: Tue, 17 Mar 2020 19:16:16 +0100
Message-Id: <f1d8c4bcf7c94e0cedbd96f1d7df9ea9905bddb3.1584468723.git.berto@igalia.com>
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

Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
image has subclusters. Instead, the individual 'all zeroes' bits must
be used.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 6f2643ba53..746006a117 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1897,7 +1897,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t old_offset;
+        uint64_t old_offset, l2_entry = 0;
         QCow2ClusterType cluster_type;
 
         old_offset = get_l2_entry(s, l2_slice, l2_index + i);
@@ -1914,12 +1914,18 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
-            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
         } else {
-            uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
-            set_l2_entry(s, l2_slice, l2_index + i, entry | QCOW_OFLAG_ZERO);
+            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
         }
+
+        if (has_subclusters(s)) {
+            set_l2_bitmap(s, l2_slice, l2_index + i, QCOW_L2_BITMAP_ALL_ZEROES);
+        } else {
+            l2_entry |= QCOW_OFLAG_ZERO;
+        }
+
+        set_l2_entry(s, l2_slice, l2_index + i, l2_entry);
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-- 
2.20.1


