Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766EC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D152077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FfLvHL4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D152077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVEL-0002XX-LG
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8n-0005Dn-H3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8m-0005O8-9v
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:56:29 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:42197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=2346a8ea7=sveith@amazon.com>)
 id 1icV8j-00058h-Pi; Wed, 04 Dec 2019 08:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1575467786; x=1607003786;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=903Oin9iiuc+khCz3xboU318uHpQzskDGrltjVjcCSM=;
 b=FfLvHL4rlHS3OTiics/U3hMmZjFuBmt6+Mx/jDoVpOWeE04uCSpgsZvU
 4TqaJ0Uu0kt19Z0o2DVqQqvFn8tYIiEDySqUi/HUckopc0cInm3/OF9ds
 4dvnk4WFnk2nyJ0Y2lkf3I3b8OyHhdnwWAaUAysi1P+ryZK936629hjUt Q=;
IronPort-SDR: 14zrM5qDK+M1wIRKinaJl1On6utbiyQqfM9hpWiDqLLMvFtDYSLempEbZ898yszACoWOIFSjRH
 onZAOInhjG7w==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="7621894"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 04 Dec 2019 13:56:25 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
 by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS
 id 292F1A1FA7; Wed,  4 Dec 2019 13:56:23 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xB4DuMZO029396; Wed, 4 Dec 2019 14:56:22 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xB4DuMcV029395;
 Wed, 4 Dec 2019 14:56:22 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 3/5] hw/arm/smmuv3: Align stream table base address to table
 size
Date: Wed,  4 Dec 2019 14:55:46 +0100
Message-Id: <1575467748-28898-4-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575467748-28898-1-git-send-email-sveith@amazon.de>
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 52.95.48.154
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

Per the specification, and as observed in hardware, the SMMUv3 aligns
the SMMU_STRTAB_BASE address to the size of the table by masking out the
respective least significant bits in the ADDR field.

Apply this masking logic to our smmu_find_ste() lookup function per the
specification.

ref. ARM IHI 0070C, section 6.3.23.

Signed-off-by: Simon Veith <sveith@amazon.de>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/arm/smmuv3.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index aad4639..2d6c275 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -376,8 +376,9 @@ bad_ste:
 static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
                          SMMUEventInfo *event)
 {
-    dma_addr_t addr;
+    dma_addr_t addr, strtab_base;
     uint32_t log2size;
+    int strtab_size_shift;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
@@ -391,10 +392,23 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
     }
     if (s->features & SMMU_FEATURE_2LVL_STE) {
         int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
-        dma_addr_t strtab_base, l1ptr, l2ptr;
+        dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
 
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK;
+        /*
+         * Align strtab base address to table size. For this purpose, assume it
+         * is not bounded by SMMU_IDR1_SIDSIZE.
+         */
+        strtab_size_shift = log2size - s->sid_split - 1 + 3;
+        if (strtab_size_shift < DMA_ADDR_BITS) {
+            if (strtab_size_shift < 5) {
+                strtab_size_shift = 5;
+            }
+            strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+                          ~((1ULL << strtab_size_shift) - 1);
+        } else {
+            strtab_base = 0;
+        }
         l1_ste_offset = sid >> s->sid_split;
         l2_ste_offset = sid & ((1 << s->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
@@ -433,7 +447,14 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         }
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
-        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
+        strtab_size_shift = log2size + 5;
+        if (strtab_size_shift < DMA_ADDR_BITS) {
+            strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+                          ~((1ULL << strtab_size_shift) - 1);
+        } else {
+            strtab_base = 0;
+        }
+        addr = strtab_base + sid * sizeof(*ste);
     }
 
     if (smmu_get_ste(s, addr, ste, event)) {
-- 
2.7.4


