Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C4C47256
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C4C2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkeqVueN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C4C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCHJ-0007Gg-K3
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3G-0001uh-Gz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3A-0006gS-Vf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:42 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC39-0006fk-Vx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:36 -0400
Received: by mail-pj1-x1041.google.com with SMTP id fu13so907147pjb.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ufJAM7+O3t9uSk4u1leOqQvbmYyjTat9N2uJ2S+dGpE=;
 b=EkeqVueNiiR+Vr4xziYhB4FqBz3PGxVFnhFc3Lq01RX/WNCbRrDMGdvKegug+XWAZJ
 guCzuisYXPQbK+WAQ681aa8KPQbBJp2LziD2B6LBQabrEtCjF/uwivfgeALvfVw1qvGI
 9g5dC7i7LhSX8Qud5e89NUAUzdVmFPyJfQim5fcLcWCJCnl6bQBegQHCqRHWrxJxXJ7U
 ACH8foR29CT3RApzZq1z6UhDAAUp0DjVAgBQLJD8XpnrRhPqMAvHqMfrjnu5FKYvJ77Y
 IpLuNFsGo1vMDpyEtpugVhEQG3Z2VJxLpB1pc9E+dfvzm0chZ89h+NbD5SlbYxhCrdiC
 OUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ufJAM7+O3t9uSk4u1leOqQvbmYyjTat9N2uJ2S+dGpE=;
 b=NAbeP2N1A89W03MFdbFWmm2i5MscMR4jdrqkuJKegdneTHtuHRccbCu2Thm1KW/1Vn
 vukJvHwr2bWr9WuOd3htwNIjBdjuQ2W4WGg2sBKwnE4cEIb3bP2zKEehUHCoxftL+J7a
 90F4kH210SK7AZ9MPjW1SLm1J8lXlMWSkwEE+KK+j0FrL5ixXxol5oElE6dNl4oWaPb/
 Uw7O8ube/uLDyi+35jeqBZiC3KUVaXcguPIzr4WQD+AspsdUVnDmKjwe5IKO1qEcmW5M
 UTul3DPung+a0V81fNQLOtpUb2IWzoRutNLBckZqdxKMGL7gdtjtbh1+KXA5MpH+nK1D
 KGHg==
X-Gm-Message-State: AGi0PuavY2rL9s91T6WLIBuBz0uzhFLUz0xwgS/IBMbQfpFLdBqitW3y
 RCTilzwr/gthWZwarFe0C/EDSA41FBE=
X-Google-Smtp-Source: APiQypIln3dHuV/9nbG7oQiAmexOpQEQuRMI/87+V7BN3ExfmddlmpEd/zpd7ODGDvweP5iBCD5wrA==
X-Received: by 2002:a17:902:b495:: with SMTP id
 y21mr4410433plr.111.1588264113299; 
 Thu, 30 Apr 2020 09:28:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
Date: Thu, 30 Apr 2020 09:28:08 -0700
Message-Id: <20200430162813.17671-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With sve_cont_ldst_pages, the differences between first-fault and no-fault
are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
to make progress through pages with TLB_WATCHPOINT set when the watchpoint
does not actually fire.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 346 +++++++++++++++++++---------------------
 1 file changed, 162 insertions(+), 184 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9365e32646..f4969347d4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4101,18 +4101,6 @@ static intptr_t find_next_active(uint64_t *vg, intptr_t reg_off,
     return reg_off;
 }
 
-/*
- * Return the maximum offset <= @mem_max which is still within the page
- * referenced by @base + @mem_off.
- */
-static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
-                             intptr_t mem_max)
-{
-    target_ulong addr = base + mem_off;
-    intptr_t split = -(intptr_t)(addr | TARGET_PAGE_MASK);
-    return MIN(split, mem_max - mem_off) + mem_off;
-}
-
 /*
  * Resolve the guest virtual address to info->host and info->flags.
  * If @nofault, return false if the page is invalid, otherwise
@@ -4435,19 +4423,6 @@ static void sve_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
 #endif
 }
 
-/*
- * The result of tlb_vaddr_to_host for user-only is just g2h(x),
- * which is always non-null.  Elide the useless test.
- */
-static inline bool test_host_page(void *host)
-{
-#ifdef CONFIG_USER_ONLY
-    return true;
-#else
-    return likely(host != NULL);
-#endif
-}
-
 /*
  * Common helper for all contiguous 1,2,3,4-register predicated stores.
  */
@@ -4705,167 +4680,167 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
 }
 
 /*
- * Common helper for all contiguous first-fault loads.
+ * Common helper for all contiguous no-fault and first-fault loads.
  */
-static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                        uint32_t desc, const uintptr_t retaddr,
-                        const int esz, const int msz,
-                        sve_ldst1_host_fn *host_fn,
-                        sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
+                   uint32_t desc, const uintptr_t retaddr,
+                   const int esz, const int msz, const SVEContFault fault,
+                   sve_ldst1_host_fn *host_fn,
+                   sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
-    const int mmu_idx = get_mmuidx(oi);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     void *vd = &env->vfp.zregs[rd];
-    const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
-    const intptr_t mem_max = reg_max >> diffsz;
-    intptr_t split, reg_off, mem_off, i;
+    intptr_t reg_off, mem_off, reg_last;
+    SVEContLdSt info;
+    int flags;
     void *host;
 
-    /* Skip to the first active element.  */
-    reg_off = find_next_active(vg, 0, reg_max, esz);
-    if (unlikely(reg_off == reg_max)) {
+    /* Find the active elements.  */
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
         /* The entire predicate was false; no load occurs.  */
         memset(vd, 0, reg_max);
         return;
     }
-    mem_off = reg_off >> diffsz;
+    reg_off = info.reg_off_first[0];
 
-    /*
-     * If the (remaining) load is entirely within a single page, then:
-     * For softmmu, and the tlb hits, then no faults will occur;
-     * For user-only, either the first load will fault or none will.
-     * We can thus perform the load directly to the destination and
-     * Vd will be unmodified on any exception path.
-     */
-    split = max_for_page(addr, mem_off, mem_max);
-    if (likely(split == mem_max)) {
-        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
-        if (test_host_page(host)) {
-            i = reg_off;
-            host -= mem_off;
-            do {
-                host_fn(vd, i, host + (i >> diffsz));
-                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
-            } while (i < reg_max);
-            /* After any fault, zero any leading inactive elements.  */
+    /* Probe the page(s). */
+    if (!sve_cont_ldst_pages(&info, fault, env, addr, MMU_DATA_LOAD, retaddr)) {
+        /* Fault on first element. */
+        tcg_debug_assert(fault == FAULT_NO);
+        memset(vd, 0, reg_max);
+        goto do_fault;
+    }
+
+    mem_off = info.mem_off_first[0];
+    flags = info.page[0].flags;
+
+    if (fault == FAULT_FIRST) {
+        /*
+         * Special handling of the first active element,
+         * if it crosses a page boundary or is MMIO.
+         */
+        bool is_split = mem_off == info.mem_off_split;
+        /* TODO: MTE check. */
+        if (unlikely(flags != 0) || unlikely(is_split)) {
+            /*
+             * Use the slow path for cross-page handling.
+             * Might trap for MMIO or watchpoints.
+             */
+            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
+
+            /* After any fault, zero the other elements. */
             swap_memzero(vd, reg_off);
-            return;
+            reg_off += 1 << esz;
+            mem_off += 1 << msz;
+            swap_memzero(vd + reg_off, reg_max - reg_off);
+
+            if (is_split) {
+                goto second_page;
+            }
+        } else {
+            memset(vd, 0, reg_max);
+        }
+    } else {
+        memset(vd, 0, reg_max);
+        if (unlikely(mem_off == info.mem_off_split)) {
+            /* The first active element crosses a page boundary. */
+            flags |= info.page[1].flags;
+            if (unlikely(flags & TLB_MMIO)) {
+                /* Some page is MMIO, see below. */
+                goto do_fault;
+            }
+            if (unlikely(flags & TLB_WATCHPOINT) &&
+                (cpu_watchpoint_address_matches
+                 (env_cpu(env), addr + mem_off, 1 << msz)
+                 & BP_MEM_READ)) {
+                /* Watchpoint hit, see below. */
+                goto do_fault;
+            }
+            /* TODO: MTE check. */
+            /*
+             * Use the slow path for cross-page handling.
+             * This is RAM, without a watchpoint, and will not trap.
+             */
+            tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
+            goto second_page;
         }
     }
 
     /*
-     * Perform one normal read, which will fault or not.
-     * But it is likely to bring the page into the tlb.
+     * From this point on, all memory operations are MemSingleNF.
+     *
+     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
+     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
+     *
+     * Unfortuately we do not have access to the memory attributes from the
+     * PTE to tell Device memory from Normal memory.  So we make a mostly
+     * correct check, and indicate (UNKNOWN, FAULT) for any MMIO.
+     * This gives the right answer for the common cases of "Normal memory,
+     * backed by host RAM" and "Device memory, backed by MMIO".
+     * The architecture allows us to suppress an NF load and return
+     * (UNKNOWN, FAULT) for any reason, so our behaviour for the corner
+     * case of "Normal memory, backed by MMIO" is permitted.  The case we
+     * get wrong is "Device memory, backed by host RAM", for which we
+     * should return (UNKNOWN, FAULT) for but do not.
+     *
+     * Similarly, CPU_BP breakpoints would raise exceptions, and so
+     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
+     * architectural breakpoints the same.
      */
-    tlb_fn(env, vd, reg_off, addr + mem_off, retaddr);
+    if (unlikely(flags & TLB_MMIO)) {
+        goto do_fault;
+    }
 
-    /* After any fault, zero any leading predicated false elts.  */
-    swap_memzero(vd, reg_off);
-    mem_off += 1 << msz;
-    reg_off += 1 << esz;
+    reg_last = info.reg_off_last[0];
+    host = info.page[0].host;
 
-    /* Try again to read the balance of the page.  */
-    split = max_for_page(addr, mem_off - 1, mem_max);
-    if (split >= (1 << msz)) {
-        host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
-        if (host) {
-            host -= mem_off;
-            do {
+    do {
+        uint64_t pg = *(uint64_t *)(vg + (reg_off >> 3));
+        do {
+            if ((pg >> (reg_off & 63)) & 1) {
+                if (unlikely(flags & TLB_WATCHPOINT) &&
+                    (cpu_watchpoint_address_matches
+                     (env_cpu(env), addr + mem_off, 1 << msz)
+                     & BP_MEM_READ)) {
+                    goto do_fault;
+                }
+                /* TODO: MTE check. */
                 host_fn(vd, reg_off, host + mem_off);
-                reg_off += 1 << esz;
-                reg_off = find_next_active(vg, reg_off, reg_max, esz);
-                mem_off = reg_off >> diffsz;
-            } while (split - mem_off >= (1 << msz));
-        }
-    }
-
-    record_fault(env, reg_off, reg_max);
-}
-
-/*
- * Common helper for all contiguous no-fault loads.
- */
-static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                        uint32_t desc, const int esz, const int msz,
-                        sve_ldst1_host_fn *host_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    void *vd = &env->vfp.zregs[rd];
-    const int diffsz = esz - msz;
-    const intptr_t reg_max = simd_oprsz(desc);
-    const intptr_t mem_max = reg_max >> diffsz;
-    const int mmu_idx = cpu_mmu_index(env, false);
-    intptr_t split, reg_off, mem_off;
-    void *host;
-
-#ifdef CONFIG_USER_ONLY
-    host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
-    if (likely(page_check_range(addr, mem_max, PAGE_READ) == 0)) {
-        /* The entire operation is valid and will not fault.  */
-        reg_off = 0;
-        do {
-            mem_off = reg_off >> diffsz;
-            host_fn(vd, reg_off, host + mem_off);
+            }
             reg_off += 1 << esz;
-            reg_off = find_next_active(vg, reg_off, reg_max, esz);
-        } while (reg_off < reg_max);
-        return;
-    }
-#endif
+            mem_off += 1 << msz;
+        } while (reg_off <= reg_last && (reg_off & 63));
+    } while (reg_off <= reg_last);
 
-    /* There will be no fault, so we may modify in advance.  */
-    memset(vd, 0, reg_max);
-
-    /* Skip to the first active element.  */
-    reg_off = find_next_active(vg, 0, reg_max, esz);
-    if (unlikely(reg_off == reg_max)) {
-        /* The entire predicate was false; no load occurs.  */
-        return;
-    }
-    mem_off = reg_off >> diffsz;
-
-#ifdef CONFIG_USER_ONLY
-    if (page_check_range(addr + mem_off, 1 << msz, PAGE_READ) == 0) {
-        /* At least one load is valid; take the rest of the page.  */
-        split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
-        do {
-            host_fn(vd, reg_off, host + mem_off);
-            reg_off += 1 << esz;
-            reg_off = find_next_active(vg, reg_off, reg_max, esz);
-            mem_off = reg_off >> diffsz;
-        } while (split - mem_off >= (1 << msz));
-    }
-#else
     /*
-     * If the address is not in the TLB, we have no way to bring the
-     * entry into the TLB without also risking a fault.  Note that
-     * the corollary is that we never load from an address not in RAM.
-     *
-     * This last is out of spec, in a weird corner case.
-     * Per the MemNF/MemSingleNF pseudocode, a NF load from Device memory
-     * must not actually hit the bus -- it returns UNKNOWN data instead.
-     * But if you map non-RAM with Normal memory attributes and do a NF
-     * load then it should access the bus.  (Nobody ought actually do this
-     * in the real world, obviously.)
-     *
-     * Then there are the annoying special cases with watchpoints...
-     * TODO: Add a form of non-faulting loads using cc->tlb_fill(probe=true).
+     * MemSingleNF is allowed to fail for any reason.  We have special
+     * code above to handle the first element crossing a page boundary.
+     * As an implementation choice, decline to handle a cross-page element
+     * in any other position.
      */
-    host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
-    split = max_for_page(addr, mem_off, mem_max);
-    if (host && split >= (1 << msz)) {
-        host -= mem_off;
-        do {
-            host_fn(vd, reg_off, host + mem_off);
-            reg_off += 1 << esz;
-            reg_off = find_next_active(vg, reg_off, reg_max, esz);
-            mem_off = reg_off >> diffsz;
-        } while (split - mem_off >= (1 << msz));
+    reg_off = info.reg_off_split;
+    if (reg_off >= 0) {
+        goto do_fault;
     }
-#endif
 
+ second_page:
+    reg_off = info.reg_off_first[1];
+    if (likely(reg_off < 0)) {
+        /* No active elements on the second page.  All done. */
+        return;
+    }
+
+    /*
+     * MemSingleNF is allowed to fail for any reason.  As an implementation
+     * choice, decline to handle elements on the second page.  This should
+     * be low frequency as the guest walks through memory -- the next
+     * iteration of the guest's loop should be aligned on the page boundary,
+     * and then all following iterations will stay aligned.
+     */
+
+ do_fault:
     record_fault(env, reg_off, reg_max);
 }
 
@@ -4873,58 +4848,61 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, 0,                   \
-                sve_ld1##PART##_host, sve_ld1##PART##_tlb);             \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnf1_r(env, vg, addr, desc, ESZ, 0, sve_ld1##PART##_host);     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO,    \
+                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }
 
 #define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
-                sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);       \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+                  sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_le_host); \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+                  sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,                 \
-                sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);       \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+                  sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnf1_r(env, vg, addr, desc, ESZ, MSZ, sve_ld1##PART##_be_host); \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+                  sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }
 
-DO_LDFF1_LDNF1_1(bb,  0)
-DO_LDFF1_LDNF1_1(bhu, 1)
-DO_LDFF1_LDNF1_1(bhs, 1)
-DO_LDFF1_LDNF1_1(bsu, 2)
-DO_LDFF1_LDNF1_1(bss, 2)
-DO_LDFF1_LDNF1_1(bdu, 3)
-DO_LDFF1_LDNF1_1(bds, 3)
+DO_LDFF1_LDNF1_1(bb,  MO_8)
+DO_LDFF1_LDNF1_1(bhu, MO_16)
+DO_LDFF1_LDNF1_1(bhs, MO_16)
+DO_LDFF1_LDNF1_1(bsu, MO_32)
+DO_LDFF1_LDNF1_1(bss, MO_32)
+DO_LDFF1_LDNF1_1(bdu, MO_64)
+DO_LDFF1_LDNF1_1(bds, MO_64)
 
-DO_LDFF1_LDNF1_2(hh,  1, 1)
-DO_LDFF1_LDNF1_2(hsu, 2, 1)
-DO_LDFF1_LDNF1_2(hss, 2, 1)
-DO_LDFF1_LDNF1_2(hdu, 3, 1)
-DO_LDFF1_LDNF1_2(hds, 3, 1)
+DO_LDFF1_LDNF1_2(hh,  MO_16, MO_16)
+DO_LDFF1_LDNF1_2(hsu, MO_32, MO_16)
+DO_LDFF1_LDNF1_2(hss, MO_32, MO_16)
+DO_LDFF1_LDNF1_2(hdu, MO_64, MO_16)
+DO_LDFF1_LDNF1_2(hds, MO_64, MO_16)
 
-DO_LDFF1_LDNF1_2(ss,  2, 2)
-DO_LDFF1_LDNF1_2(sdu, 3, 2)
-DO_LDFF1_LDNF1_2(sds, 3, 2)
+DO_LDFF1_LDNF1_2(ss,  MO_32, MO_32)
+DO_LDFF1_LDNF1_2(sdu, MO_64, MO_32)
+DO_LDFF1_LDNF1_2(sds, MO_64, MO_32)
 
-DO_LDFF1_LDNF1_2(dd,  3, 3)
+DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
 
 #undef DO_LDFF1_LDNF1_1
 #undef DO_LDFF1_LDNF1_2
-- 
2.20.1


