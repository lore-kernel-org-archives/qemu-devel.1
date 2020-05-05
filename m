Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F44C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B01206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O4c4WQEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B01206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1Yw-0008S6-Ln
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1XK-0006FF-Qd; Tue, 05 May 2020 13:39:18 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1XJ-00089e-68; Tue, 05 May 2020 13:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Vk2B9SteFyDcjC0pSegxTjepsJ/H9UnjSaSopEjnPPg=; 
 b=O4c4WQEsCtzQ31C7fMIF7YsuYkRofXoAkgwU5qMS/l5auF2lkpPBaG79J1Mlmr9hCEVN6dHLP1vC5GRn43jsqmvn0bAptVttNjcPUCMjt7TanuRO3dGTu+CDCJL6SwD5uia+PAaHxEhairc8vPvMEgt2sFZw8HINLknByXMhL+C61+OGs2mRi9XuIbZ+u2uFZo9Pt3Y8AVxW/zEHIky3vFstukYp+AZeJ1gH8n6B9wwdc/XQyqSMlsjn27BhU4KoTqFubQ3yIyFMTvQzqzY9j1ayxa1NlpgIxJM/8ZGII8hxn+ZuMbETpSS/MJgCmLtYHnXxceAH+/yJSr/xzGn6QQ==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025D-CU; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wc-00043r-Oj; Tue, 05 May 2020 19:38:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/31] qcow2: Add offset_to_sc_index()
Date: Tue,  5 May 2020 19:38:10 +0200
Message-Id: <3f533eec7fd06dc67e21c938ca5f23a3b92291bf.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For a given offset, return the subcluster number within its cluster
(i.e. with 32 subclusters per cluster it returns a number between 0
and 31).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9d8ca8068c..e68febb15b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -563,6 +563,11 @@ static inline int offset_to_l2_slice_index(BDRVQcow2State *s, int64_t offset)
     return (offset >> s->cluster_bits) & (s->l2_slice_size - 1);
 }
 
+static inline int offset_to_sc_index(BDRVQcow2State *s, int64_t offset)
+{
+    return (offset >> s->subcluster_bits) & (s->subclusters_per_cluster - 1);
+}
+
 static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
 {
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bits);
-- 
2.20.1


