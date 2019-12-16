Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F8220409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="fewE8Ynt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F8220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igs9S-0005Vw-Nv
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7e-0003tI-NU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7d-0001yU-FT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:17:22 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:53953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=246de4cf7=sveith@amazon.com>)
 id 1igs7b-0001qs-12; Mon, 16 Dec 2019 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1576509439; x=1608045439;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=tRSad7WoTFOponF+G6UnpmzO4ecidPjoO2ZvHdSbdBA=;
 b=fewE8YntJ/FWHnvYXTIByiEhniOkO0YmXv7icz6MzYmHYElgL1Vc72vm
 BvoMJrHD9k+p4vy0lSKLN2NqAH4GpLZHQ8HXWZC1RV6x/foeQZ41Pe+Wz
 iYBeKdToncyL/CidOzjXPwsjATn41ttlJt/SNwPW4SUHsP/CqUErRHLTP 4=;
IronPort-SDR: mnslBslxYJbZJhEZ8OcfCdpE+K3DZv88iBICrIRMc+gsWHv2RpDWm9BKNMwj/dAT/NS2JtydBw
 dcbjh0+KcVDg==
X-IronPort-AV: E=Sophos;i="5.69,322,1571702400"; d="scan'208";a="15161854"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 16 Dec 2019 15:17:08 +0000
Received: from sveith-desktop.aka.corp.amazon.com
 (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
 by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS
 id CE46AA1F39; Mon, 16 Dec 2019 15:17:06 +0000 (UTC)
Received: from sveith-desktop.aka.corp.amazon.com (localhost [127.0.0.1])
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 xBGFH4NR014072; Mon, 16 Dec 2019 16:17:04 +0100
Received: (from sveith@localhost)
 by sveith-desktop.aka.corp.amazon.com (8.15.2/8.15.2/Submit) id xBGFH3iK014070;
 Mon, 16 Dec 2019 16:17:03 +0100
From: Simon Veith <sveith@amazon.de>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Simon Veith <sveith@amazon.de>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 4/6] hw/arm/smmuv3: Align stream table base address to
 table size
Date: Mon, 16 Dec 2019 16:15:10 +0100
Message-Id: <1576509312-13083-5-git-send-email-sveith@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576509312-13083-1-git-send-email-sveith@amazon.de>
References: <1576509312-13083-1-git-send-email-sveith@amazon.de>
Precedence: Bulk
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.190.10
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
Changed in v2:

* Now using MAKE_64BIT_MASK()
* Eliminated unnecessary branches by using MAX()
* Removed unnecessary range check against DMA_ADDR_BITS

 hw/arm/smmuv3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 727558b..31ac3ca 100644
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
@@ -391,10 +392,16 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
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
+        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
+        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
         l1_ste_offset = sid >> s->sid_split;
         l2_ste_offset = sid & ((1 << s->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
@@ -433,7 +440,10 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         }
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
-        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
+        strtab_size_shift = log2size + 5;
+        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+        addr = strtab_base + sid * sizeof(*ste);
     }
 
     if (smmu_get_ste(s, addr, ste, event)) {
-- 
2.7.4


