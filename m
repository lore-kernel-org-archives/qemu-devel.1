Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05554C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53412075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WKX2B/p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53412075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs2A-00088w-V2
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzw-0002pZ-97; Sun, 24 May 2020 10:53:08 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzv-0002lM-9f; Sun, 24 May 2020 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=mTGU94LO6HR/OMZWQ6pWem/jp50yK+PBvsvLfQohQOI=; 
 b=WKX2B/p008WVqZIo4o7Y57/nua8D3dTy3yv2HdAyr3fNDrDtyFclw6AKN9CiYWOAJK88fXpn/3JawWlEiAkQLPxowVpi4k+Qhv0n42Ei807Yp8ZQEuGTL3KmL8lsP8NJsoFbsVzpaHWoUftzy/gzDs3/F73HOdypvkeY+Z5yM8qR23Ggp0/AtyBjVPjyAfvkK8hajomfvH/vKLE+8Ar6WmtLYYlUFrGrnQT5ijcSY7hd2EcrtsQ02EOWFx05gJ6lOxiRygDGL5+qs2/TbVAfRIjKO3jAkPcmCsd2T7dGYgdCteiSjeX0xuyNCwJup9iz2ShexcPJS2lg7aVu//h1BA==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrzF-0007GX-76; Sun, 24 May 2020 16:52:25 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005KU-4R; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/32] qcow2: Add qcow2_cluster_is_allocated()
Date: Sun, 24 May 2020 16:51:36 +0200
Message-Id: <19b963820f8e54c0ec833d7aa6c0b809368a2b6a.1590331741.git.berto@igalia.com>
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

This helper function tells us if a cluster is allocated (that is,
there is an associated host offset for it).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 27dbcbc502..ba7614e406 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -780,6 +780,12 @@ QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
     }
 }
 
+static inline bool qcow2_cluster_is_allocated(QCow2ClusterType type)
+{
+    return (type == QCOW2_CLUSTER_COMPRESSED || type == QCOW2_CLUSTER_NORMAL ||
+            type == QCOW2_CLUSTER_ZERO_ALLOC);
+}
+
 /* Check whether refcounts are eager or lazy */
 static inline bool qcow2_need_accurate_refcounts(BDRVQcow2State *s)
 {
-- 
2.20.1


