Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA57C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC8B2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUHbYcT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC8B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby2h-0000b4-Ek
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwr-0003Bd-Ll
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwo-000884-Tv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwn-00086c-0Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:54 -0500
Received: by mail-pg1-x544.google.com with SMTP id x8so861852pgk.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9298xhTmvXNu+8P+Gy8ST3y6QgYH5tl8FVXemGU4CpA=;
 b=HUHbYcT1r4iSKymyVAA9XTwe5bZXwiNbkSxFcrrBcuxLX8TxEJ2xx0N2ZEa6Tt8F4q
 jwmYON+E1mqUXAeMsfYh8DkWU+otW+xXUfxMF7eyDfmOmmNV6Kh0NW2SU7b41AHNQSD5
 5V5/SnQ+QaqYruaelYLd+4q0Z7kdmtrjAw+cgveWgtghlLp5FhBhtYyypHXIuPvYIdIM
 YT9XJQEQKz+Q6hjLEb5vHVHUvA+tJHu5gDoCHY7Uv/6fK7SMgl561AHfMkM4BxmylSiO
 3tsZyNlry5ODDHyTWcrMhiCBWw33/GJ0fQ5qcQVQOBcV8FTf/sOsJKgp2JoXK30JdpG8
 u0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9298xhTmvXNu+8P+Gy8ST3y6QgYH5tl8FVXemGU4CpA=;
 b=DYflJ4mhxGAoEoXhBWtB5PPjduZSE9A7h2akIipxtVU/wmmUo549NSu92uy04ocHqE
 94hVgpa/a491Wak2h+Mp7NcfY5ObN1SC3NlweDLIu1B8u1YTuOLOCumfPNyKlmBHHz3X
 uIL6EOgVWBn2ISWScH8u+8bOjSAcobuwhhkrL4gl2/gxER2GSN4JFoSUv7dSvbHHFE3j
 MY3WMu2evTNugdOu6pK8gGAZkvWZZgDiEJ+ZdMDPPcGu3Mxe5VqPc4jsGhDw7BXqg/WP
 z9gzccxqmo+RFzEWELu3VhsGwYSkCRh8oByoHYcN0NCfnigs5OrHK4MId2cTGVmRkALR
 Wtjw==
X-Gm-Message-State: APjAAAVqqvcctfoM7JHM+QpWl1Ef1UX28a1KAW1YG8pfxtydlaYSyVjl
 6vf6FAyMa/3+xNNlcOpvVsvfUqDuc7A=
X-Google-Smtp-Source: APXvYqwbzbOm2CMiV/2h1p/4NsoV8rYM7xqSiHDSdJmU/Rh3Wi0q8VzVnkejLFUXSntXGW/B2VFrLw==
X-Received: by 2002:a63:5851:: with SMTP id i17mr2754191pgm.181.1575340190925; 
 Mon, 02 Dec 2019 18:29:50 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/40] target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
Date: Mon,  2 Dec 2019 18:29:06 -0800
Message-Id: <20191203022937.1474-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

The EL1&0 regime is the only one that uses 2-stage translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  4 +--
 target/arm/internals.h     |  2 +-
 target/arm/helper.c        | 57 ++++++++++++++++++++------------------
 target/arm/translate-a64.c |  2 +-
 target/arm/translate.c     |  2 +-
 5 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 802cddd2df..fdb868f2e9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2870,7 +2870,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
@@ -2896,7 +2896,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
-    ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_Stage2 = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MUserNegPri = 1 << 2,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 54142dd789..ca8be78bbf 100644
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
index d2b90763ca..97677f8482 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -672,7 +672,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_EL10_1 |
                         ARMMMUIdxBit_EL10_0 |
-                        ARMMMUIdxBit_S2NS);
+                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -683,7 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_EL10_1 |
                                         ARMMMUIdxBit_EL10_0 |
-                                        ARMMMUIdxBit_S2NS);
+                                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -704,7 +704,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -720,7 +720,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 40);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3528,12 +3528,15 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
+    /*
+     * A change in VMID to the stage2 page table (Stage2) invalidates
+     * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
+     */
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_EL10_1 |
                             ARMMMUIdxBit_EL10_0 |
-                            ARMMMUIdxBit_S2NS);
+                            ARMMMUIdxBit_Stage2);
         raw_write(env, ri, value);
     }
 }
@@ -3929,7 +3932,7 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
@@ -4083,7 +4086,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4099,7 +4102,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 48);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8560,7 +8563,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     case ARMMMUIdx_S1E2:
         return 2;
     case ARMMMUIdx_S1E3:
@@ -8614,7 +8617,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* HCR.DC means HCR.VM behaves as 1 */
         return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
@@ -8645,7 +8648,7 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vttbr_el2;
     }
     if (ttbrn == 0) {
@@ -8660,7 +8663,7 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return &env->cp15.vtcr_el2;
     }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
@@ -8847,7 +8850,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     bool have_wxn;
     int wxn = 0;
 
-    assert(mmu_idx != ARMMMUIdx_S2NS);
+    assert(mmu_idx != ARMMMUIdx_Stage2);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -8939,7 +8942,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                ARMMMUFaultInfo *fi)
 {
     if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
-        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
@@ -8956,7 +8959,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             pcacheattrs = &cacheattrs;
         }
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
+        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
                                  &txattrs, &s2prot, &s2size, fi, pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
@@ -9428,7 +9431,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
             tbi = tbid = hpd = false;
         } else {
@@ -9489,7 +9492,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     int select, tsz;
     bool epd, hpd;
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* VTCR */
         bool sext = extract32(tcr, 4, 1);
         bool sign = extract32(tcr, 3, 1);
@@ -9591,7 +9594,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         level = 1;
         /* There is no TTBR1 for EL2 */
         ttbr1_valid = (el != 2);
-        addrsize = (mmu_idx == ARMMMUIdx_S2NS ? 40 : 32);
+        addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
 
@@ -9642,7 +9645,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_S2NS) {
+    if (mmu_idx != ARMMMUIdx_Stage2) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -9742,7 +9745,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -9773,7 +9776,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     ap = extract32(attrs, 4, 2);
     xn = extract32(attrs, 12, 1);
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
         *prot = get_S2prot(env, ap, xn);
     } else {
@@ -9800,7 +9803,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     if (cacheattrs != NULL) {
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             cacheattrs->attrs = convert_stage2_attrs(env,
                                                      extract32(attrs, 0, 4));
         } else {
@@ -9821,7 +9824,7 @@ do_fault:
     fi->type = fault_type;
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
+    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2);
     return true;
 }
 
@@ -10635,13 +10638,13 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
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
@@ -10683,7 +10686,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
-    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_S2NS
+    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2703ebf32a..3a39315a6c 100644
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
index e3deea50e0..1716bbb615 100644
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


