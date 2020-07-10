Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67929C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3F20657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oyoa3OcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvk8-0003Ag-Fy
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfM-000318-Tt; Fri, 10 Jul 2020 12:14:24 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jtvfI-0004vP-JX; Fri, 10 Jul 2020 12:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=quDPSlunrrCmsJvyut+Ssrzu4WgMw45eo+aNiowNwG0=; 
 b=oyoa3OcKSLHoct4uePi7DcS+JRfdv/P8acu/lGopmUwTnPa8mdLEpZpNJTEI2tkJWZakwq95PuRIK4xB/IPec2j7nJCz0Sp54rj/wcsKHVfRRlD2HTKvn/hJ7pI2ogyLcxHh1ORyH7yJN8muENoyzFcjHLscHq2CU8ctA3tsq6h8H6p4gi9VsF/1vkErapAPmsUucSIKDc4a/espgrhWnZ1biRPj6X3SwnRYh0pi9KxFYhbttTVIdWkymgg3tiZi2bRm0aXM+bV8vrVUX0Xn++kUo9wqFniR5ChsbbTF24J5a9SzoDCvPiOBJV7rY1XxMhb20wjKqlaJuQ2kDIz4Zg==;
Received: from [81.0.43.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jtvea-0003je-AM; Fri, 10 Jul 2020 18:13:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jtveK-0001QX-Td; Fri, 10 Jul 2020 18:13:20 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 11/34] qcow2: Add offset_into_subcluster() and
 size_to_subclusters()
Date: Fri, 10 Jul 2020 18:12:53 +0200
Message-Id: <3cc2390dcdef3d234d47c741b708bd8734490862.1594396418.git.berto@igalia.com>
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

Like offset_into_cluster() and size_to_clusters(), but for
subclusters.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 2503374677..4fe31adfd3 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -555,11 +555,21 @@ static inline int64_t offset_into_cluster(BDRVQcow2State *s, int64_t offset)
     return offset & (s->cluster_size - 1);
 }
 
+static inline int64_t offset_into_subcluster(BDRVQcow2State *s, int64_t offset)
+{
+    return offset & (s->subcluster_size - 1);
+}
+
 static inline uint64_t size_to_clusters(BDRVQcow2State *s, uint64_t size)
 {
     return (size + (s->cluster_size - 1)) >> s->cluster_bits;
 }
 
+static inline uint64_t size_to_subclusters(BDRVQcow2State *s, uint64_t size)
+{
+    return (size + (s->subcluster_size - 1)) >> s->subcluster_bits;
+}
+
 static inline int64_t size_to_l1(BDRVQcow2State *s, int64_t size)
 {
     int shift = s->cluster_bits + s->l2_bits;
-- 
2.20.1


