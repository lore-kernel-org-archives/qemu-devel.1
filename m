Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99453C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697962072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wW+mQZsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697962072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIH2-000862-Ms
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyy-0005R1-HE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyx-0003iP-JV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id o6so580221pgh.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J2ezAdBRDnrkWMhAyjiFD4czb9AMeAMbprziLRhYAWw=;
 b=wW+mQZskGhF9jBDWsZKyoSp0hDN7MpgKf48LqKuR1gDhOU09lBFu1ycQoH2TkBuRRa
 ZzI7atoNYckPFuB9oTAM3CkPmBKnylzlRjgO7R/+3M+7XDVTcCpXd2q1U4vG3Eit4jfy
 kcvSoenUYqi/1uMTZSL7ZdfpAxdfbWoFmT1peQxieCUYwUo7lpA1DdNBVxDbTtJcwAJo
 7gZzeOq7omQ9THXVifbQcMCnV8HKCyKcU2HiHdXcyYmBpxwkoLQxGHxsWDMcmo9XqWUR
 uSNkj+RO2MWiU4ugg4Xb/5sWcZflJ5+IXp9qKOw8MV3uOAzcZnX0SauRhzh9d/U8B7z5
 puUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J2ezAdBRDnrkWMhAyjiFD4czb9AMeAMbprziLRhYAWw=;
 b=KEiIzjauZBpSfm7TZUdSKpv6/0uc3+fLKbvi9WKhIejfaK1g5NCYYx8i+70WPhUjCR
 XMjzm1FlNdKkmoPKKJcx39AqU1eXP8fTDAM1IfomKjO9fCzliAFW3MxxvBsnqaLYFig2
 XUUtDSqyMViXB1ydyn48ql7JGCoxp4hYEKRH5xoE4Hfs6cSSr4C1Hk1djt1BtptJLF7q
 JhzgIq8Edl9U/ueERR41IYPwTjU+B5myDVzBpNKwzOSQ2ElWSijJt8gXnV1PQliH8Vli
 LlBAXu1YbkFRkLlu/P3ZL3SyAL/NLa0bVzlwnyJ7/QvQDTAWt7BnFuqYnSIaUeB65BpO
 t9rg==
X-Gm-Message-State: AOAM533lb3rIKOO9rAQgSJGdLMbknlXIu0w6JUrp+YYU3WCCmwdwzl8/
 dccJNTpC/KfrN+Oo6flKNWH4LRLbkw4=
X-Google-Smtp-Source: ABdhPJyZQAVxQp2E9MgB2bOiPfMdoPgcKwgfEy7p9rPKy9bWMrbJMDOG48+ZFGGn9e+1lzmwg1+XfQ==
X-Received: by 2002:a17:90a:bf18:: with SMTP id
 c24mr2327985pjs.171.1591146853827; 
 Tue, 02 Jun 2020 18:14:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 42/42] target/arm: Add allocation tag storage for system
 mode
Date: Tue,  2 Jun 2020 18:13:17 -0700
Message-Id: <20200603011317.473934-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Look up the physical address for the given virtual address,
convert that to a tag physical address, and finally return
the host address that backs it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 128 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 175da11e01..b15fa665df 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/ram_addr.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 
@@ -74,8 +75,135 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    int ptr_size, MMUAccessType tag_access,
                                    int tag_size, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
     /* Tag storage not implemented.  */
     return NULL;
+#else
+    uintptr_t index;
+    CPUIOTLBEntry *iotlbentry;
+    int in_page, flags;
+    ram_addr_t ptr_ra;
+    hwaddr ptr_paddr, tag_paddr, xlat;
+    MemoryRegion *mr;
+    ARMASIdx tag_asi;
+    AddressSpace *tag_as;
+    void *host;
+
+    /*
+     * The caller must split calls to this function such that it will
+     * not access *tag* memory beyond the end of the page.
+     */
+    in_page = -(ptr | -(TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1)));
+    g_assert(tag_size <= in_page);
+
+    /*
+     * Probe the first byte of the virtual address.  This raises an
+     * exception for inaccessible pages, and resolves the virtual address
+     * into the softmmu tlb.
+     */
+    flags = probe_access_flags(env, ptr, ptr_access, ptr_mmu_idx,
+                               false, &host, ra);
+
+    /*
+     * Find the iotlbentry for ptr.  This *must* be present in the TLB
+     * because we just found the mapping.
+     * TODO: Perhaps there should be a cputlb helper that returns a
+     * matching tlb entry + iotlb entry.
+     */
+    index = tlb_index(env, ptr_mmu_idx, ptr);
+# ifdef CONFIG_DEBUG_TCG
+    {
+        CPUTLBEntry *entry = tlb_entry(env, ptr_mmu_idx, ptr);
+        target_ulong comparator = (ptr_access == MMU_DATA_LOAD
+                                   ? entry->addr_read
+                                   : tlb_addr_write(entry));
+        g_assert(tlb_hit(comparator, ptr));
+    }
+# endif
+    iotlbentry = &env_tlb(env)->d[ptr_mmu_idx].iotlb[index];
+
+    /* If the virtual page MemAttr != Tagged, access unchecked. */
+    if (!iotlbentry->attrs.target_tlb_bit1) {
+        return NULL;
+    }
+
+    /* If not normal memory, tag storage is not implemented, access unchecked. */
+    if (unlikely(flags & TLB_MMIO)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
+                      "but is Device memory\n", ptr);
+        return NULL;
+    }
+
+    /*
+     * The Normal memory access can extend to the next page.  E.g. a single
+     * 8-byte access to the last byte of a page will check only the last
+     * tag on the first page.
+     * Any page access exception has priority over tag check exception.
+     */
+    in_page = -(ptr | TARGET_PAGE_MASK);
+    if (unlikely(ptr_size > in_page)) {
+        void *ignore;
+        flags |= probe_access_flags(env, ptr + in_page, ptr_access,
+                                    ptr_mmu_idx, false, &ignore, ra);
+    }
+
+    /* Any debug exception has priority over a tag check exception. */
+    if (unlikely(flags & TLB_WATCHPOINT)) {
+        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size,
+                             iotlbentry->attrs, wp, ra);
+    }
+
+    /*
+     * Find the physical address within the normal mem space.
+     * The memory region lookup must succeed because TLB_MMIO was
+     * not set in the cputlb lookup above.
+     */
+    mr = memory_region_from_host(host, &ptr_ra);
+    tcg_debug_assert(mr != NULL);
+    tcg_debug_assert(memory_region_is_ram(mr));
+    ptr_paddr = ptr_ra;
+    do {
+        ptr_paddr += mr->addr;
+        mr = mr->container;
+    } while (mr);
+
+    /* Convert to the physical address in tag space.  */
+    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
+
+    /* Look up the address in tag space. */
+    tag_asi = iotlbentry->attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
+    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
+    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
+                                 tag_access == MMU_DATA_STORE,
+                                 iotlbentry->attrs);
+
+    /*
+     * Note that @mr will never be NULL.  If there is nothing in the address
+     * space at @tag_paddr, the translation will return the unallocated memory
+     * region.  For our purposes, the result must be ram.
+     */
+    if (unlikely(!memory_region_is_ram(mr))) {
+        /* ??? Failure is a board configuration error. */
+        qemu_log_mask(LOG_UNIMP,
+                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
+                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
+                      tag_paddr, ptr_paddr);
+        return NULL;
+    }
+
+    /*
+     * Ensure the tag memory is dirty on write, for migration.
+     * Tag memory can never contain code or display memory (vga).
+     */
+    if (tag_access == MMU_DATA_STORE) {
+        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
+        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
+    }
+
+    return memory_region_get_ram_ptr(mr) + xlat;
+#endif
 }
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
-- 
2.25.1


