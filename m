Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB809ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8259920640
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCEGC8kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8259920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvU9-0002ck-EC
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJR-0006CA-Ig
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJP-0004HN-RM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:33 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:38673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJP-0004GT-NE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:31 -0400
Received: by mail-yb1-xb43.google.com with SMTP id r68so3116423ybf.5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0RZ0xvYp1EHUhrR/jUU3w+01QyCWCYmAXLZX7xD3PR8=;
 b=uCEGC8kNa6GGYVrOD8nReHdJ3sk8I8nn+XU4yk6RFvoBXP+Pl+D084SCX2vV+BRJCV
 zxigj8xIMWW+5jlDnRAK/TI/2E8izDzFKIZowcLmWzRksk+bCBjWoY+LCq8aipZU22oP
 GsApGuzwZc+roaj2Cuk38hin78oVXv1x1dBfl4dwvNL4/egIBGfVdrwc0ixQcoOoGeeK
 ALsww59uoz73UMybGM+IDI3EQmWL2iqUNkj+ka6pMIMzujzGjvNG+JBKDRFX1pQiZ66J
 2jCcecy2SJVip86fz/t5y+Kw8hHvYN+46a3au5hKKHcLIYQ90ttwCADoGl4B/388yv7t
 XqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0RZ0xvYp1EHUhrR/jUU3w+01QyCWCYmAXLZX7xD3PR8=;
 b=SmCNMoBqVeesQtnjR1PctqLNmQQWQpMrhu8cahoeD7hP7Y/qB7L72/rVx7XJgMX4Xf
 oLJI/QjMyYqt7YCRy+O1QcJwnOW1YZKqk+D35RT4znXZ74KgWy2969YbomgEuAkArrTl
 tCag3eEt13P/7mLsElVToZ4NYkxHzkFKN4HS6mC5+WB0/tZgA+yKQMoEUcx/ERCKYExU
 u1O1IoryHkCZSbjlUClB/831vLcN6vHO2G5klfwB7zx068QUX32U3/4x8dxVJLoapWe6
 qEUmdLlSWT9X6/7BPGHWHZ4U0aLJrVlW5sLPg0eODy/LgyNtYla47H2lRvMUDOaeLsjZ
 4L7A==
X-Gm-Message-State: APjAAAVHm9ScPHhgcdzsUeUepzlqnqnVZXYbFWtdZPx/uTm5x5DCqcj7
 olBBYvZboVMsW/Tc7zcAMmCJWgzn1jI=
X-Google-Smtp-Source: APXvYqwLKlmgx7OizHSpjCvub3xKbRlR+q3x6vYr8/P6VzS2WuXiP0Rc2KaVZN0hAugCAFhHyp04mA==
X-Received: by 2002:a25:acc7:: with SMTP id x7mr10338104ybd.305.1570801830716; 
 Fri, 11 Oct 2019 06:50:30 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 22/22] target/arm: Add allocation tag storage for system
 mode
Date: Fri, 11 Oct 2019 09:47:44 -0400
Message-Id: <20191011134744.2477-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index e8d8a6bedb..657383ba0e 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -28,8 +28,69 @@
 static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
                                    bool write, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
     /* Tag storage not implemented.  */
     return NULL;
+#else
+    CPUState *cs = env_cpu(env);
+    uintptr_t index;
+    int mmu_idx;
+    CPUTLBEntry *entry;
+    CPUIOTLBEntry *iotlbentry;
+    MemoryRegionSection *section;
+    hwaddr physaddr, tag_physaddr;
+
+    /*
+     * Find the TLB entry for this access.
+     * As a side effect, this also raises an exception for invalid access.
+     *
+     * TODO: Perhaps there should be a cputlb helper that returns a
+     * matching tlb entry + iotlb entry.  That would also be able to
+     * make use of the victim tlb cache, which is currently private.
+     */
+    mmu_idx = cpu_mmu_index(env, false);
+    index = tlb_index(env, mmu_idx, ptr);
+    entry = tlb_entry(env, mmu_idx, ptr);
+    if (!tlb_hit(write ? tlb_addr_write(entry) : entry->addr_read, ptr)) {
+        bool ok = arm_cpu_tlb_fill(cs, ptr, 16,
+                                   write ? MMU_DATA_STORE : MMU_DATA_LOAD,
+                                   mmu_idx, false, ra);
+        assert(ok);
+        index = tlb_index(env, mmu_idx, ptr);
+        entry = tlb_entry(env, mmu_idx, ptr);
+    }
+
+    /* If the virtual page MemAttr != Tagged, nothing to do.  */
+    iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+    if (!iotlbentry->attrs.target_tlb_bit1) {
+        return NULL;
+    }
+
+    /*
+     * Find the physical address for the virtual access.
+     *
+     * TODO: It should be possible to have the tag mmu_idx map
+     * from main memory ram_addr to tag memory host address.
+     * that would allow this lookup step to be cached as well.
+     */
+    section = iotlb_to_section(cs, iotlbentry->addr, iotlbentry->attrs);
+    physaddr = ((iotlbentry->addr & TARGET_PAGE_MASK) + ptr
+                + section->offset_within_address_space
+                - section->offset_within_region);
+
+    /* Convert to the physical address in tag space.  */
+    tag_physaddr = physaddr >> (LOG2_TAG_GRANULE + 1);
+
+    /* Choose the tlb index to use for the tag physical access.  */
+    mmu_idx = iotlbentry->attrs.secure ? ARMMMUIdx_TagS : ARMMMUIdx_TagNS;
+    mmu_idx = arm_to_core_mmu_idx(mmu_idx);
+
+    /*
+     * FIXME: Get access length and type so that we can use
+     * probe_access, so that pages are marked dirty for migration.
+     */
+    return tlb_vaddr_to_host(env, tag_physaddr, MMU_DATA_LOAD, mmu_idx);
+#endif
 }
 
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
-- 
2.17.1


