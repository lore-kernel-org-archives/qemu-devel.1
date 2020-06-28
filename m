Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C6C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C3420771
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yqj+cmRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVBK-000790-VK
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6R-0007Ss-2s; Sun, 28 Jun 2020 07:04:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6J-0000XD-8n; Sun, 28 Jun 2020 07:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=mWxBfZCwA3fQQGqfzhuDYPXDU/mKIOsOcPZxQSXCu4Q=; 
 b=Yqj+cmRZDzWXwxWwMyC6bmzBbqH9gqmLWpjzSBa8nZ1IKl0rA7fxMRCvcCUlhkwBPB6/PzueHxD9raY/SpjPXR2CA5iAisVGIfqkteJdouHBnkUAAQcdwHSKblNpbNQ7g857+uKlCmhqee674v1PSOX/3PgZ3SB4rgUUgYXwoNvzstobZsHcN3wEmCJ2y5VYPTpJcNciNHP9MNFS6OvHELw+IsPcQDzgVzE86QGUv6h5/uV7p7GC5bDlLqr/1ekOLCQBiM2+jJYm6nOp/7n7BUV1x2hken3hQJTYQKjGndb/JC71ZofrEhUnKhqPZsLBT7jkG+JFsGSEhD6/bu6TNg==;
Received: from 26.red-79-158-236.dynamicip.rima-tde.net ([79.158.236.26]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jpV5Y-0002gX-3f; Sun, 28 Jun 2020 13:03:09 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jpV5H-00038T-Pg; Sun, 28 Jun 2020 13:02:51 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/34] qcow2: Add offset_into_subcluster() and
 size_to_subclusters()
Date: Sun, 28 Jun 2020 13:02:20 +0200
Message-Id: <980aaffef450241ffe683e387e9c3a0cf516a7ba.1593342067.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593342067.git.berto@igalia.com>
References: <cover.1593342067.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 07:03:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


