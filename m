Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93112C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCF62173E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CDj6Mvi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCF62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3dd-0005yh-43
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3ar-0002QC-EN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3aq-0003mi-AZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:08:01 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=241120df0=sveith@amazon.com>)
 id 1if3an-0003ib-U2; Wed, 11 Dec 2019 10:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576076878; x=1607612878;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=PCOnbhJypslF5hM47QeKN1c0yopkDWzpKcTM5nMU8Xo=;
 b=CDj6Mvi7P+4CADYQe8O5TkJhkIB8rXEMrpGN4WoS1K30AUdk6i2jNV/B
 MmomEoFKZaxDq1GGgoVc/Zkp+HgklLUy4tXXtWxmwCLzw4hg7CTwVz6tm
 xdD0sVt5WrHdahXmJKVFUxo9uJWz2+JmrjLB6RDEbkLeVdL98JZgDzwhF k=;
IronPort-SDR: RWEUtVZsJacMYHqOeRxJKTi797ERWhrNiSGCdx/M2KVQwTbSZ9t73TaIVRHZabWOqmst+kEHDB
 3nLBTIXiDaEw==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="7181881"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 11 Dec 2019 15:07:55 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
 by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS
 id B6585A1BEC; Wed, 11 Dec 2019 15:07:54 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBBF7p0s024939; Wed, 11 Dec 2019 16:07:51 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBBF7olP024913;
 Wed, 11 Dec 2019 16:07:50 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 3/6] hw/arm/smmuv3: Check stream IDs against actual table
 LOG2SIZE
Date: Wed, 11 Dec 2019 16:07:37 +0100
Message-Id: <1576076860-24820-1-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576076260-18659-1-git-send-email-sveith@amazon.de>
References: <1576076260-18659-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 52.95.49.90
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
Also, ensure that we do not go one entry beyond the end of the table by
checking that its index is strictly smaller than the table size.

ref. ARM IHI 0070C, section 6.3.24.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
Changed in v2:

* Also check that stream ID is strictly lower than the table size

 hw/arm/smmuv3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eef9a18..727558b 100644
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
+    if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-- 
2.7.4


