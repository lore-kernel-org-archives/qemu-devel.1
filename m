Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22865C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEF1205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2/L1msj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEF1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvCt-0007eI-12
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6b-0006FI-NW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6Z-0001xD-MB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:37 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6Z-0001v3-9A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:35 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 39so1174667pjo.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hwv0ZdGNzk1JPF3B9TKzm+UaZXEnJM80ZJXFaFLa00w=;
 b=N2/L1msjt0mGGn+cirOIcg8NYShSTV/hYDQ59P8VIQpAf5S+ShR5sh2OuX2r3JvY8g
 UCDGflEv8oz8HRj0mlU47215JBpcOrDUjse83MJkXZaCosGYIGj1h/IeZMvuhr7ALRau
 CXJHgl+tJVFn20/93wkBMBRJPWOph/beNzPN82tDgaFzpfj5aCnFumB84CmnYp7XqVir
 3GhWX5ZPFC0jDd6g24cjnS7/yoL7PMmIuw90Ba/P/Ifeb0Av1J2TwnI64Pf4guEJrsT5
 7sq4MKLbk7KjQIHwAM9APieWLOMXVuJV9rjBltciNYy6ulCxq79tZQisXjOUNl/nQzen
 nOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hwv0ZdGNzk1JPF3B9TKzm+UaZXEnJM80ZJXFaFLa00w=;
 b=Pi9UnlpLvwHWkurJlANl4yL4DeEW8beBH9mLkcIj9VVYF1vr6LVnNDIctZY9Rm78lQ
 7mRMmrh+l9Hj6/K1WWdT+9+XMNO+T3uP+3GokbT4hJSBX1x1TVCJgbwQzVbCQZXz9OfJ
 hxmLRGSSPbl9O7GuGSyV+S69jCIv1s8Y8g0GhfEL6cAne2fHRi4ZuMqbKB7HeZf1PG9V
 4R0cMBG0GrxhuYbhKo0ZQQA9ifJpYnRvYUnP8EbIXYH3TI5nxMhZvm3OKOgLjFJVMS9g
 DNMFvGskuKlfG/XBjhIqr2xNrk84VSJdbWMPb8IeK/PJin8/th8A2II+wmMAYBbJz39o
 p7fw==
X-Gm-Message-State: ANhLgQ3BPBBh4F9e5PC0QXiG2lXcbCyPARRsHTpq4TfKSH+0smCd9y/T
 fT6G801uXTmLAxXUG8YWcHENv6Eh6hg=
X-Google-Smtp-Source: ADFU+vtBLBQXkKjkL9NKVvmD2eibpwa6DgfXdpLlYXmDhfPRXWZZCDj2/AhapkOb0vGc8m6jBO/OBA==
X-Received: by 2002:a17:90b:4c47:: with SMTP id
 np7mr1873292pjb.140.1583909072197; 
 Tue, 10 Mar 2020 23:44:32 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] target/arm: Use SVEContLdSt in sve_ld1_r
Date: Tue, 10 Mar 2020 23:44:12 -0700
Message-Id: <20200311064420.30606-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First use of the new helper functions, so we can remove the
unused markup.  No longer need a scratch for user-only, as
we completely probe the page set before reading; system mode
still requires a scratch for MMIO.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 188 +++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 91 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 1397c2b634..b827900a4e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4227,9 +4227,9 @@ typedef struct {
  * final element on each page.  Identify any single element that spans
  * the page boundary.  Return true if there are any active elements.
  */
-static bool __attribute__((unused))
-sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
-                       intptr_t reg_max, int esz, int msize)
+static bool sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr,
+                                   uint64_t *vg, intptr_t reg_max,
+                                   int esz, int msize)
 {
     const int esize = 1 << esz;
     const uint64_t pg_mask = pred_esz_masks[esz];
@@ -4319,10 +4319,9 @@ sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
  * Control the generation of page faults with @fault.  Return false if
  * there is no work to do, which can only happen with @fault == FAULT_NO.
  */
-static bool __attribute__((unused))
-sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault, CPUARMState *env,
-                    target_ulong addr, MMUAccessType access_type,
-                    uintptr_t retaddr)
+static bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
+                                CPUARMState *env, target_ulong addr,
+                                MMUAccessType access_type, uintptr_t retaddr)
 {
     int mmu_idx = cpu_mmu_index(env, false);
     int mem_off = info->mem_off_first[0];
@@ -4394,109 +4393,116 @@ static inline bool test_host_page(void *host)
 /*
  * Common helper for all contiguous one-register predicated loads.
  */
-static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                      uint32_t desc, const uintptr_t retaddr,
-                      const int esz, const int msz,
-                      sve_ldst1_host_fn *host_fn,
-                      sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
+               uint32_t desc, const uintptr_t retaddr,
+               const int esz, const int msz,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
-    const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
-    const int mmu_idx = get_mmuidx(oi);
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     void *vd = &env->vfp.zregs[rd];
-    const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
-    const intptr_t mem_max = reg_max >> diffsz;
-    ARMVectorReg scratch;
+    intptr_t reg_off, reg_last, mem_off;
+    SVEContLdSt info;
     void *host;
-    intptr_t split, reg_off, mem_off;
+    int flags;
 
-    /* Find the first active element.  */
-    reg_off = find_next_active(vg, 0, reg_max, esz);
-    if (unlikely(reg_off == reg_max)) {
+    /* Find the active elements.  */
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
         /* The entire predicate was false; no load occurs.  */
         memset(vd, 0, reg_max);
         return;
     }
-    mem_off = reg_off >> diffsz;
 
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
-            intptr_t i = reg_off;
-            host -= mem_off;
-            do {
-                host_fn(vd, i, host + (i >> diffsz));
-                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
-            } while (i < reg_max);
-            /* After having taken any fault, zero leading inactive elements. */
-            swap_memzero(vd, reg_off);
-            return;
-        }
-    }
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, retaddr);
 
-    /*
-     * Perform the predicated read into a temporary, thus ensuring
-     * if the load of the last element faults, Vd is not modified.
-     */
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
 #ifdef CONFIG_USER_ONLY
-    swap_memzero(&scratch, reg_off);
-    host = g2h(addr);
-    do {
-        host_fn(&scratch, reg_off, host + (reg_off >> diffsz));
-        reg_off += 1 << esz;
-        reg_off = find_next_active(vg, reg_off, reg_max, esz);
-    } while (reg_off < reg_max);
+        g_assert_not_reached();
 #else
-    memset(&scratch, 0, reg_max);
-    goto start;
-    while (1) {
-        reg_off = find_next_active(vg, reg_off, reg_max, esz);
-        if (reg_off >= reg_max) {
-            break;
-        }
-        mem_off = reg_off >> diffsz;
-        split = max_for_page(addr, mem_off, mem_max);
+        /*
+         * At least one page includes MMIO (or watchpoints).
+         * Any bus operation can fail with cpu_transaction_failed,
+         * which for ARM will raise SyncExternal.  Perform the load
+         * into scratch memory to preserve register state until the end.
+         */
+        ARMVectorReg scratch;
 
-    start:
-        if (split - mem_off >= (1 << msz)) {
-            /* At least one whole element on this page.  */
-            host = tlb_vaddr_to_host(env, addr + mem_off,
-                                     MMU_DATA_LOAD, mmu_idx);
-            if (host) {
-                host -= mem_off;
-                do {
-                    host_fn(&scratch, reg_off, host + mem_off);
-                    reg_off += 1 << esz;
-                    reg_off = find_next_active(vg, reg_off, reg_max, esz);
-                    mem_off = reg_off >> diffsz;
-                } while (split - mem_off >= (1 << msz));
-                continue;
+        memset(&scratch, 0, reg_max);
+        mem_off = info.mem_off_first[0];
+        reg_off = info.reg_off_first[0];
+        reg_last = info.reg_off_last[1];
+        if (reg_last < 0) {
+            reg_last = info.reg_off_split;
+            if (reg_last < 0) {
+                reg_last = info.reg_off_last[0];
             }
         }
 
-        /*
-         * Perform one normal read.  This may fault, longjmping out to the
-         * main loop in order to raise an exception.  It may succeed, and
-         * as a side-effect load the TLB entry for the next round.  Finally,
-         * in the extremely unlikely case we're performing this operation
-         * on I/O memory, it may succeed but not bring in the TLB entry.
-         * But even then we have still made forward progress.
-         */
-        tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
-        reg_off += 1 << esz;
-    }
-#endif
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
+                }
+                reg_off += 1 << esz;
+                mem_off += 1 << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
 
-    memcpy(vd, &scratch, reg_max);
+        memcpy(vd, &scratch, reg_max);
+        return;
+#endif
+    }
+
+    /* The entire operation is in RAM, on valid pages. */
+
+    memset(vd, 0, reg_max);
+    mem_off = info.mem_off_first[0];
+    reg_off = info.reg_off_first[0];
+    reg_last = info.reg_off_last[0];
+    host = info.page[0].host;
+
+    while (reg_off <= reg_last) {
+        uint64_t pg = vg[reg_off >> 6];
+        do {
+            if ((pg >> (reg_off & 63)) & 1) {
+                host_fn(vd, reg_off, host + mem_off);
+            }
+            reg_off += 1 << esz;
+            mem_off += 1 << msz;
+        } while (reg_off <= reg_last && (reg_off & 63));
+    }
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    mem_off = info.mem_off_split;
+    if (unlikely(mem_off >= 0)) {
+        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
+    }
+
+    mem_off = info.mem_off_first[1];
+    if (unlikely(mem_off >= 0)) {
+        reg_off = info.reg_off_first[1];
+        reg_last = info.reg_off_last[1];
+        host = info.page[1].host;
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    host_fn(vd, reg_off, host + mem_off);
+                }
+                reg_off += 1 << esz;
+                mem_off += 1 << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
+    }
 }
 
 #define DO_LD1_1(NAME, ESZ) \
-- 
2.20.1


