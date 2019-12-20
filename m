Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29151C2D0D4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F8024686
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwisGP7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F8024686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJJ6-0002Hi-KL
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF8-0004va-HU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF5-0007QG-VI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:02 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF5-0007Li-HC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id w15so9634727wru.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2KUP15f7qeOWW1oxuca3zmV/3aT0vejsyXqh6o12C1s=;
 b=nwisGP7sTkpQRSQOd5ibYJljXAKb3ExWypM5ZSRaidLBclrPXBIRCY/pZi0gBnBxgq
 h8YQjAy0GbDY/v8NVfm7KVt+O1MxmJ9A9lTcaDYYLMiEgEHdd0/QfObjbTqu/VnqX7YG
 RPam1vL1cHlDp1fuQBRLR1a/7rmHWFcwHu356IU9WGke5XAGeZwoCP3Kx66B8rXikh4z
 f1pJSTOoS7O+eQn53OMr+sqBUlFi049b2cPsflzt/4ipcyKP3p749cDhR81kjvQ/F7ch
 jqVB9qgyQv9KMYpUAy0ruJ/iYFPLA2zMZRvf/wDxTTy95BOD8EeDkQrUfNN2qlctMkcB
 3I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2KUP15f7qeOWW1oxuca3zmV/3aT0vejsyXqh6o12C1s=;
 b=Wau0W30bUHabz9X3jJnk8LCEz9ZVl8Cu/vuD657357h0pQX9KaMBqTb5ep04xhO/9D
 liblpTgs5utNR72xKGMuK3chRx6XgQuDoVCrtm+jovucdVZodfqIaVbQD3IZwvI71RFD
 xuMMIN514MGFiz+fESKRk/7W/OyuMMiAVmYsyiEoF8Rulfr3zfDlX7gBtGGZEnh2xLSw
 47+9zldMJQEO3PoNE6mQakf5zk8ezzusYhqNNWBWN7aWJtNL2Ng5Y0D/u9PnhvZ1UzYe
 mgWACjXL4UbpCJq+LQXvO0MPx17pGiQk5aRr3XJFYbSL0YixQ+gVeUHgmOI3/6ZPz/l2
 lP4A==
X-Gm-Message-State: APjAAAUcIbmJGc2GnwTPY9+J6/TAWwC2Tl0tdvcq/xN8cMKJRXZiC3/P
 St41j+fsZNjt0MOC8EqQ9BLaZh9gTMcW2A==
X-Google-Smtp-Source: APXvYqyNjgZ64L/MbX+DQ6HqvYld7yo8L2xt/Y3+Uo6vInIDksE0vl7J3M30kB7pbOesLp9Wy7Xx+Q==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr15258900wrm.278.1576852018159; 
 Fri, 20 Dec 2019 06:26:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] hw/arm/smmuv3: Align stream table base address to table
 size
Date: Fri, 20 Dec 2019 14:26:40 +0000
Message-Id: <20191220142644.31076-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Simon Veith <sveith@amazon.de>

Per the specification, and as observed in hardware, the SMMUv3 aligns
the SMMU_STRTAB_BASE address to the size of the table by masking out the
respective least significant bits in the ADDR field.

Apply this masking logic to our smmu_find_ste() lookup function per the
specification.

ref. ARM IHI 0070C, section 6.3.23.

Signed-off-by: Simon Veith <sveith@amazon.de>
Acked-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1576509312-13083-5-git-send-email-sveith@amazon.de
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 727558bcfa5..31ac3ca32eb 100644
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
2.20.1


