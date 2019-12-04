Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93115C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6185720803
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="F01Fw8CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6185720803
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVBA-0007jO-TC
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8m-0005Bc-Ap
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8l-0005ML-4A
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:28 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8i-0005BH-HB; Wed, 04 Dec 2019 08:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1575467784; x=1607003784;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=mGz2Hs159Z/4+8pT881Ub7PtsnSyXxiUtbVakc2yFWM=;
 b=F01Fw8CDIdq4GZyQntiadzGH2NBKnZufGKnyhlu0SaepjkVzIj2ywRhF
 LKkillroCAZhyWJ936gRjDDt6Z0uclr8LHaB8a8EJB1qJ9JQhPQz5aW9W
 oNpYkA8djhq8YcDRt0rAZOjqmMFoRQ008YA+nwZs0p8slBUziq1UPUA3z g=;
IronPort-SDR: 6smuSj9Iia7aCLpemJErFU3iL5nFjvhmsp19zr4FoSQ1qTYGbMstT+LPjGnZTaJLRGtz6d5vZL
 L9Kv8Oo6K72Q==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="3177677"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 04 Dec 2019 13:56:22 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
 by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS
 id 19EF7A2330; Wed,  4 Dec 2019 13:56:20 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xB4DuJbQ029389; Wed, 4 Dec 2019 14:56:19 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xB4DuJ65029388;
 Wed, 4 Dec 2019 14:56:19 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 2/5] hw/arm/smmuv3: Check stream IDs against actual table
 LOG2SIZE
Date: Wed,  4 Dec 2019 14:55:45 +0100
Message-Id: <1575467748-28898-3-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575467748-28898-1-git-send-email-sveith@amazon.de>
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.184.25
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When checking whether a stream ID is in range of the stream table, we
have so far been only checking it against our implementation limit
(SMMU_IDR1_SIDSIZE). However, the guest can program the
STRTAB_BASE_CFG.LOG2SIZE field to a size that is smaller than this
limit.

Check the stream ID against this limit as well to match the hardware
behavior of raising C_BAD_STREAMID events in case the limit is exceeded.

ref. ARM IHI 0070C, section 6.3.24.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/arm/smmuv3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eef9a18..aad4639 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -377,11 +377,15 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
                          SMMUEventInfo *event)
 {
     dma_addr_t addr;
+    uint32_t log2size;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
-    /* Check SID range */
-    if (sid > (1 << SMMU_IDR1_SIDSIZE)) {
+    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    /*
+     * Check SID range against both guest-configured and implementation limits
+     */
+    if (sid > (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-- 
2.7.4


