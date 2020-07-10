Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C67C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F61206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AkeMTvIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F61206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvlx-0007An-FE
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfQ-000390-3m; Fri, 10 Jul 2020 12:14:28 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfJ-0004vx-FE; Fri, 10 Jul 2020 12:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=OWKv8itI14gMinFfoeWuhSr8+zShFcCCdZ5FAMbstjA=; 
 b=AkeMTvIuVc9o1Y5N5lqGpAa7bsPx47kOoFRYrX0THxtw85yPbrdlzA28NP3xeJlOzBR/e5FymniZ1enNiVdAOBCNyYqE1eXET5JOVHudHrN5neRcix0oPCSM2fnfBOURpYo6eOuIIQMpxR4Kdqt8IvIeHvEcWAU/af19q82JTiWQ8ymMk8LFd2P1pk9giBsgexKdAR41QZ0UuUSKtf+WidzN2vqnQTfcY5CJWNmHoqxmzREpW9kERIt8qc/zjEa8d3aSndZTmc8wCFJhrGQnh6Mg+hUEnRDTUpstj46Yz95PN5YD8jG5dDInRvFQBQ5NU6K1JhdDJpDj6hShYyK26w==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtvea-0003k2-KS; Fri, 10 Jul 2020 18:13:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveL-0001RG-F2; Fri, 10 Jul 2020 18:13:21 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 26/34] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
Date: Fri, 10 Jul 2020 18:13:08 +0200
Message-Id: <04455b3de5dfeb9d1cfe1fc7b02d7060a6e09710.1594396418.git.berto@igalia.com>
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

Compressed clusters always have the bitmap part of the extended L2
entry set to 0.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5bdbb65e7b..6b5d0698d0 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -862,6 +862,9 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
     set_l2_entry(s, l2_slice, l2_index, cluster_offset);
+    if (has_subclusters(s)) {
+        set_l2_bitmap(s, l2_slice, l2_index, 0);
+    }
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     *host_offset = cluster_offset & s->cluster_offset_mask;
-- 
2.20.1


