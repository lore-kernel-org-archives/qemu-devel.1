Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15801ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D682064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ4GJyGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D682064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvIc-0004NP-P1
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHG-0002su-Bj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHE-0002yG-Ld
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:18 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:47094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvHE-0002xZ-HO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:16 -0400
Received: by mail-yb1-xb41.google.com with SMTP id h202so3096383ybg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4U1VNzdFGB+MUTDr/itV77DWvfbivchrYuksbXDh0Hc=;
 b=fQ4GJyGdFsxuedYQWS4Bgm7JXo3sLB+cZ7kqE0WNA+6Sory1/T9rPKSY2kTfekL7Bl
 LyU/ZYXBgeOIkC6y8rZXG86YoWqUJ6ccx0s7oVdrpdIDi18erP7ufY7PzqJ/dxsSTj0F
 t5ENiGBl7yNy/AXDUgMBWWAs730hvT3yKiNnpV8eLtOo2lOKbeDCu8h6XeiL+dFHz/W7
 aGeKEDq3NczFlYf0T5wn5hyxHrOx3QP50wT6Wc/473q07WKSNgT2AGYrxb5NuGYsbATx
 Nxp9BamD5SX9wTOp0fH/U1Cpq7nUe0uuS3B/8mhAGAwBaHYi2+IATpGotmmbhCZub8oH
 gwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4U1VNzdFGB+MUTDr/itV77DWvfbivchrYuksbXDh0Hc=;
 b=bSQ2YAKLI8iTtmgckeq7EX8n0xazWKwwi9KwoRKGTODA310fAsd+8IWkernupHWMIJ
 FkM7AHhlw5dN9kxG3783BKspbOOHPBUa0e/RmWle9GujFQspPSh6Ey57UMZsWawLGlFe
 wgoeWsenuCr8aMOGnZ/VCOPKXKzKyvl0lf0UGYjASeYq1hryyhZKeIMDq+IBuXk6Ts3A
 D9GkdLkHGYyC+Bq5va/VE/J0P1d7deKubS+2mc3EV/UoE2LKGt5mgm4E4709TC+Ji9s0
 GmWApWUljJeZGi+n64JOPP+wJsLdlB0Ro4KsRDDAD0MR9jf6KwZIDpbZHqi/Xn7ZSWD9
 54OA==
X-Gm-Message-State: APjAAAUNmuIYNL8ZqLeMzixXWy9exzh1sRDwjUalrr4IidhVeXscrzqO
 xacuu4yBiBasrUbtsjrohhoxN1xu9dI=
X-Google-Smtp-Source: APXvYqwCLLpxMPDAVRHUChI2C734K2JjLT25iI0cBxSFhl4dK/vmtomNSulHRO2dm5PE2MRsTB3LJQ==
X-Received: by 2002:a25:d20f:: with SMTP id j15mr9906861ybg.174.1570801695496; 
 Fri, 11 Oct 2019 06:48:15 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:48:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/22] target/arm: Add MTE_ACTIVE to tb_flags
Date: Fri, 11 Oct 2019 09:47:23 -0400
Message-Id: <20191011134744.2477-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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

When MTE is fully enabled, i.e. access to tags are enabled and
tag checks affect the PE, then arrange to perform the check
while stripping the TBI.

The check is not yet implemented, just the plumbing to that point.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Clean TBI bits exactly.
    Fix license to lgpl 2.1.
v3: Remove stub helper_mte_check; moved to a later patch.
---
 target/arm/cpu.h           | 12 ++++++++
 target/arm/internals.h     | 19 ++++++++++++
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 61 ++++++++++++++++++++++++++++++--------
 target/arm/translate-a64.c |  1 +
 5 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 297ad5e47a..408d749b7a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1201,6 +1201,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_TCO (1U << 25)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3196,6 +3197,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, MTE_ACTIVE, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
@@ -3598,6 +3600,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..dcc5d6cca3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -983,6 +983,7 @@ typedef struct ARMVAParameters {
     bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
+    bool tcma       : 1;
     bool using16k   : 1;
     bool using64k   : 1;
 } ARMVAParameters;
@@ -1007,6 +1008,24 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+/* Determine if allocation tags are available.  */
+static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+                                                 uint64_t sctlr)
+{
+    if (el < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ATA)) {
+        return false;
+    }
+    if (el < 2
+        && arm_feature(env, ARM_FEATURE_EL2)
+        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return false;
+    }
+    sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
+    return sctlr != 0;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /* Security attributes for an address, as returned by v8m_security_lookup. */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dd24f91f26..9913c35cc2 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -75,6 +75,8 @@ typedef struct DisasContext {
     bool is_ldex;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True if v8.5-MTE tag checks affect the PE.  */
+    bool mte_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0d9a2d2ab7..b690eda136 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1904,6 +1904,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= SCR_API | SCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= SCR_ATA;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -4158,22 +4161,31 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
 
-    if (raw_read(env, ri) == value) {
-        /* Skip the TLB flush if nothing actually changed; Linux likes
-         * to do a lot of pointless SCTLR writes.
-         */
-        return;
-    }
-
     if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
         /* M bit is RAZ/WI for PMSA with no MPU implemented */
         value &= ~SCTLR_M;
     }
 
-    raw_write(env, ri, value);
+    if (!cpu_isar_feature(aa64_mte, cpu)) {
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+        } else {
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                       SCTLR_ATA0 | SCTLR_ATA);
+        }
+    }
+
     /* ??? Lots of these bits are not implemented.  */
-    /* This may enable/disable the MMU, so do a TLB flush.  */
-    tlb_flush(CPU(cpu));
+
+    if (raw_read(env, ri) != value) {
+        /*
+         * This may enable/disable the MMU, so do a TLB flush.
+         * Skip the TLB flush if nothing actually changed;
+         * Linux likes to do a lot of pointless SCTLR writes.
+         */
+        raw_write(env, ri, value);
+        tlb_flush(CPU(cpu));
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4679,6 +4691,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= HCR_API | HCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= HCR_ATA;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
@@ -9302,7 +9317,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint32_t el = regime_el(env, mmu_idx);
-    bool tbi, tbid, epd, hpd, using16k, using64k;
+    bool tbi, tbid, epd, hpd, tcma, using16k, using64k;
     int select, tsz;
 
     /*
@@ -9317,11 +9332,12 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_S2NS) {
             /* VTCR_EL2 */
-            tbi = tbid = hpd = false;
+            tbi = tbid = hpd = tcma = false;
         } else {
             tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
             tbid = extract32(tcr, 29, 1);
+            tcma = extract32(tcr, 30, 1);
         }
         epd = false;
     } else if (!select) {
@@ -9332,6 +9348,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tbi = extract64(tcr, 37, 1);
         hpd = extract64(tcr, 41, 1);
         tbid = extract64(tcr, 51, 1);
+        tcma = extract64(tcr, 57, 1);
     } else {
         int tg = extract32(tcr, 30, 2);
         using16k = tg == 1;
@@ -9341,6 +9358,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tbi = extract64(tcr, 38, 1);
         hpd = extract64(tcr, 42, 1);
         tbid = extract64(tcr, 52, 1);
+        tcma = extract64(tcr, 58, 1);
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
@@ -9352,6 +9370,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
+        .tcma = tcma,
         .using16k = using16k,
         .using64k = using64k,
     };
@@ -11065,6 +11084,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (is_a64(env)) {
         ARMCPU *cpu = env_archcpu(env);
         uint64_t sctlr;
+        int tbid;
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
@@ -11073,7 +11093,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         {
             ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
+            int tbii;
 
             /* FIXME: ARMv8.1-VHE S2 translation regime.  */
             if (regime_el(env, stage1) < 2) {
@@ -11126,6 +11146,21 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+
+        /*
+         * Set MTE_ACTIVE if any access may be Checked, and leave clear
+         * if all accesses must be Unchecked:
+         * 1) If no TBI, then there are no tags in the address to check,
+         * 2) If Tag Check Override, then all accesses are Unchecked,
+         * 3) If Tag Check Fail == 0, then Checked access have no effect,
+         * 4) If no Allocation Tag Access, then all accesses are Unchecked.
+         */
+        if (tbid
+            && !(env->pstate & PSTATE_TCO)
+            && (sctlr & (current_el == 0 ? SCTLR_TCF0 : SCTLR_TCF))
+            && allocation_tag_access_enabled(env, current_el, sctlr)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, MTE_ACTIVE, 1);
+        }
     } else {
         *pc = env->regs[15];
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d6cd09634..51f3af9cd9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14161,6 +14161,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->mte_active = FIELD_EX32(tb_flags, TBFLAG_A64, MTE_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.17.1


