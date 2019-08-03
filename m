Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5EC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA172087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPtXKMjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA172087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzBH-0003ep-Jw
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4u-0006Ll-5Z
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4s-0007HE-3u
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4q-0007FA-0N
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id z14so437891pga.5
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=la7qxtvs05jrNqcA9h6vjUFPOQjXr0T0i1pOh4sumx8=;
 b=BPtXKMjQXEwSqf4ihkATokxXgdqYfxy91qDkVzIxkd8iyWIMNJcnybknDrqwLuSPO0
 v+TTl6BOSG4nU+HVMi5sEAifBXSQchp0yeklueMV0O6rn821vBeKviV8RKtAPheLeoaN
 4wZ8hwpcZ7AXYMhodmsLtWVbVGU5S+bMhZBtn1zhKcZ9e4sR5kEs1CSG3XPhYb369n2J
 B8Hp4xd9ZjqVXqXoKH2CHlj3R+mNrbFbbvG/hhjeDssuLwzTjTJrzP+ZIeJfmZIT8cMy
 FPZJxvYz7PvoLF6DG6sCYS+w9gHkTEEzgYeqMwH1a67K+LJ2gIxts7rsHFdkyunLSV+A
 b5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=la7qxtvs05jrNqcA9h6vjUFPOQjXr0T0i1pOh4sumx8=;
 b=NR658wglXv3f7H5DDqZgtNabFnTy1Dv+/nbDbxAVKtlgovnn4qG5Ec0KPH0kVXQzdY
 o1QmdFDvVP0Mk+F8ukU9prGEwYmHy/6+rahS5Mzyfz6EjuVNO9lMUU6ANAtVLJXm9o4K
 5wbSNiGfVl0U8WL2yjkd6IfzPnJBKLth6m1S/2J8cf6dW9nU7foSKlotSKM1PfrEDCJr
 Rjbhv74+EjDJM3+rxSfdRDgD71ZA8CGS6MJm77cYwgpL5Kub2STX52q2ZiDGYvyOzWQc
 MceB+UDgCZ1tdBBitYhwUEWsw29y4HlmCgn//zM7ebOVD2MQy9GCg0ZjGTHwuCKGBWWS
 N/Zw==
X-Gm-Message-State: APjAAAURxCRyUWOo63/BVISTpr9eBUDht9oKiqYrWPqPWQNaZy6I0BCD
 XNRZVEPWD3ZYId9enqzfLnHuUBjQsFk=
X-Google-Smtp-Source: APXvYqxuDAEGyeqJ0ZmaCVWpz2kKBg/VgvLK6A+238W+QhyfAL22XuxwQM85UonPGZLE9FD9b9NZeA==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr64994336pgj.204.1564858101921; 
 Sat, 03 Aug 2019 11:48:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:42 -0700
Message-Id: <20190803184800.8221-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 16/34] target/arm: Rename ARMMMUIdx_S2NS to
 ARMMMUIdx_Stage2
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The EL1&0 regime is the only one that uses 2-stage translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  4 +--
 target/arm/internals.h     |  2 +-
 target/arm/helper.c        | 54 +++++++++++++++++++-------------------
 target/arm/translate-a64.c |  2 +-
 target/arm/translate.c     |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8a3f61bc2c..14730d29c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2856,7 +2856,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
@@ -2882,7 +2882,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
-    ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_Stage2 = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MUserNegPri = 1 << 2,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fafefdc59e..1caa15e7e0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -813,7 +813,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e391654638..6c8eddfdf4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -684,7 +684,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_EL10_1 |
                         ARMMMUIdxBit_EL10_0 |
-                        ARMMMUIdxBit_S2NS);
+                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -695,7 +695,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_EL10_1 |
                                         ARMMMUIdxBit_EL10_0 |
-                                        ARMMMUIdxBit_S2NS);
+                                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -716,7 +716,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -732,7 +732,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 40);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3539,10 +3539,10 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     vmid = extract64(value, 48, 8);
 
     /*
-     * A change in VMID to the stage2 page table (S2NS) invalidates
+     * A change in VMID to the stage2 page table (Stage2) invalidates
      * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
      */
-    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
+    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_Stage2,
                             ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0);
 }
 
@@ -3937,7 +3937,7 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
@@ -4091,7 +4091,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4107,7 +4107,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 48);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8690,7 +8690,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     case ARMMMUIdx_S1E2:
         return 2;
     case ARMMMUIdx_S1E3:
@@ -8744,7 +8744,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* HCR.DC means HCR.VM behaves as 1 */
         return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
@@ -8775,7 +8775,7 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vttbr_el2;
     }
     if (ttbrn == 0) {
@@ -8790,7 +8790,7 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return &env->cp15.vtcr_el2;
     }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
@@ -8977,7 +8977,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     bool have_wxn;
     int wxn = 0;
 
-    assert(mmu_idx != ARMMMUIdx_S2NS);
+    assert(mmu_idx != ARMMMUIdx_Stage2);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -9069,7 +9069,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                ARMMMUFaultInfo *fi)
 {
     if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
-        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
@@ -9086,7 +9086,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             pcacheattrs = &cacheattrs;
         }
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
+        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
                                  &txattrs, &s2prot, &s2size, fi, pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
@@ -9558,7 +9558,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
             tbi = tbid = hpd = false;
         } else {
@@ -9619,7 +9619,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     int select, tsz;
     bool epd, hpd;
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* VTCR */
         bool sext = extract32(tcr, 4, 1);
         bool sign = extract32(tcr, 3, 1);
@@ -9721,7 +9721,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         level = 1;
         /* There is no TTBR1 for EL2 */
         ttbr1_valid = (el != 2);
-        addrsize = (mmu_idx == ARMMMUIdx_S2NS ? 40 : 32);
+        addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
 
@@ -9772,7 +9772,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_S2NS) {
+    if (mmu_idx != ARMMMUIdx_Stage2) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -9872,7 +9872,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -9903,7 +9903,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     ap = extract32(attrs, 4, 2);
     xn = extract32(attrs, 12, 1);
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
         *prot = get_S2prot(env, ap, xn);
     } else {
@@ -9930,7 +9930,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     if (cacheattrs != NULL) {
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             cacheattrs->attrs = convert_stage2_attrs(env,
                                                      extract32(attrs, 0, 4));
         } else {
@@ -9951,7 +9951,7 @@ do_fault:
     fi->type = fault_type;
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
+    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2);
     return true;
 }
 
@@ -10765,13 +10765,13 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                                 prot, page_size, fi, cacheattrs);
 
             /* If S1 fails or S2 is disabled, return early.  */
-            if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+            if (ret || regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
                 *phys_ptr = ipa;
                 return ret;
             }
 
             /* S1 is done. Now do S2 translation.  */
-            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_S2NS,
+            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_Stage2,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fi,
                                      cacheattrs != NULL ? &cacheattrs2 : NULL);
@@ -10813,7 +10813,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
-    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_S2NS
+    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ece749fe03..73801c5df7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -119,7 +119,7 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
         break;
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
         g_assert_not_reached();
     default:
         useridx = s->mmu_idx;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index afff595726..995010834f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -172,7 +172,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPrivNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     default:
         g_assert_not_reached();
     }
-- 
2.17.1


