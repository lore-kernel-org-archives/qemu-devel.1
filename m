Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC59C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3544120659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cl6tTLRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHTl-000108-Ah
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH39-0002aP-Ep
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH37-0006Op-88
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:43 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH36-0006Le-Tw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:41 -0500
Received: by mail-pf1-x441.google.com with SMTP id y14so2106022pfm.13
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SPzn+VTOyMQJa+XMTau4HeWDSYCIOZdHOCWei3+VPg4=;
 b=cl6tTLRQFOQdhgq5Q6NZ7uYAEDC3Mbt/eAS5tnOu+JBpV73JXyR6IrLc5/98zHlBnd
 C5RYxlYZP9EvW1sy2Ho1dXZLkBcOi64xAR/MzG1bNVnM/JinbQ+J7vdEKdlulpJQJGj7
 iNpAfVwAt4izyCwT9wrL94IKDLht5NXovFy72zFYCxp6oV81xW8oTBW5R3URm1ItX4cf
 kofZrx3ElQRDVfTKdCvnaN0z3lJNX57ot4Qn0ZK6e68oQ3v5Ak2wymgR07N8AlgV19Ct
 FANhVgJa1V7NsDdG8AuYn9Uv635+uZpsC026gLCT4fU+Pz3ZyuGJmc0yZXI12O1NAr4I
 p33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SPzn+VTOyMQJa+XMTau4HeWDSYCIOZdHOCWei3+VPg4=;
 b=b+KumRBGm6ayyJBhpN+XMlHYGdXthe0aa5keRBzfEAKBEUa1UwgDuI3QFVlbYOEHvE
 J+WM9sSYZAEvHALBgmbMh+5BrU0eHnS+qBfSrfarg9CNbFr7inXIcg13/l0Pf/OrT1Yi
 h0KbmNI8/8NPllJanm+mqgcd5dijx3oTlPp5I3FYezEiQ2s5x6AGXHimVGQ8H4swm83x
 F6IOabETZwHL3zm5VCPIjdvjpNbRXtmzjo9O0w5bZQg9+8E+epXFQafUFwNW+S6ZOXeO
 BtcVlfF7nDuPOVDD8ZtheeIp1vpD6/e0X1Iraa9IBA4N/L0MOVPKqQzH8s1SLg975lvI
 3oNw==
X-Gm-Message-State: APjAAAUM3BN3Pdb0c6BL58UTfFcdx+wnPunphF8H1t4zWvAC/TSgc9la
 hFP94DnUKgXbn0YsdU1KfxBzCySHVUs=
X-Google-Smtp-Source: APXvYqzPEg/8bhlt+aGndQlelRWyEr0YLkkCoWHHnSA65GjO8sO87eLoTosxyqLwCjrUamS9nuiO4g==
X-Received: by 2002:aa7:9d9c:: with SMTP id f28mr328728pfq.20.1575413619122;
 Tue, 03 Dec 2019 14:53:39 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/11] target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
Date: Tue,  3 Dec 2019 14:53:25 -0800
Message-Id: <20191203225333.17055-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To implement PAN, we will want to swap, for short periods
of time, to a different privileged mmu_idx.  In addition,
we cannot do this with flushing alone, because the AT*
instructions have both PAN and PAN-less versions.

Add the ARMMMUIdx*_PAN constants where necessary next to
the corresponding ARMMMUIdx* constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h     |  2 +-
 target/arm/cpu.h           | 35 +++++++++++++--------
 target/arm/internals.h     |  9 ++++++
 target/arm/helper.c        | 63 +++++++++++++++++++++++++++++++-------
 target/arm/translate-a64.c |  2 ++
 target/arm/translate.c     |  2 ++
 6 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 18ac562346..d593b60b28 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,6 +29,6 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif
 
-#define NB_MMU_MODES 9
+#define NB_MMU_MODES 12
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 22935e4433..22c5706835 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2715,20 +2715,22 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  5. we want to be able to use the TLB for accesses done as part of a
  *     stage1 page table walk, rather than having to walk the stage2 page
  *     table over and over.
+ *  6. we need separate EL1/EL2 mmu_idx for handling the Priviledged Access
+ *     Never (PAN) bit within PSTATE.
  *
  * This gives us the following list of cases:
  *
  * NS EL0 (aka NS PL0) EL1&0 stage 1+2
- * NS EL1 (aka NS PL1) EL1&0 stage 1+2
+ * NS EL1 (aka NS PL1) EL1&0 stage 1+2 (+PAN)
  * NS EL0 EL2&0
- * NS EL2 EL2&0
+ * NS EL2 EL2&0 (+PAN)
  * NS EL2 (aka NS PL2)
  * S EL0 (aka S PL0)
- * S EL1 (not used if EL3 is 32 bit)
+ * S EL1 (not used if EL3 is 32 bit) (+PAN)
  * S EL3 (aka S PL1)
  * NS EL0&1 stage 2
  *
- * for a total of 9 different mmu_idx.
+ * for a total of 12 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2783,19 +2785,22 @@ typedef enum ARMMMUIdx {
     /*
      * A-profile.
      */
-    ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_EL20_0 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_0 =     0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL20_0 =     1 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_EL10_1 = 2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_1 =     2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_1_PAN = 3 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_E2 =     3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_EL20_2 = 4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2 =         4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL20_2 =     5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL20_2_PAN = 6 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_SE0 =    5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE1 =    6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE3 =    7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE0 =        7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE1 =        8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE1_PAN =    9 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3 =       10 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_Stage2 = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2 =    11 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -2803,6 +2808,7 @@ typedef enum ARMMMUIdx {
      */
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
@@ -2828,10 +2834,13 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(EL10_0),
     TO_CORE_BIT(EL20_0),
     TO_CORE_BIT(EL10_1),
+    TO_CORE_BIT(EL10_1_PAN),
     TO_CORE_BIT(E2),
     TO_CORE_BIT(EL20_2),
+    TO_CORE_BIT(EL20_2_PAN),
     TO_CORE_BIT(SE0),
     TO_CORE_BIT(SE1),
+    TO_CORE_BIT(SE1_PAN),
     TO_CORE_BIT(SE3),
     TO_CORE_BIT(Stage2),
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 850f204f14..2408953031 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -843,12 +843,16 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
     case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
     case ARMMMUIdx_SE0:
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
         return true;
     default:
         return false;
@@ -861,10 +865,13 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
     case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
@@ -874,6 +881,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
         return false;
     case ARMMMUIdx_SE0:
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
@@ -1039,6 +1047,7 @@ static inline bool arm_mmu_idx_is_stage1(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
         return true;
     default:
         return false;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fdb86ea427..4e3fe00316 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -671,6 +671,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_EL10_1 |
+                        ARMMMUIdxBit_EL10_1_PAN |
                         ARMMMUIdxBit_EL10_0 |
                         ARMMMUIdxBit_Stage2);
 }
@@ -682,6 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_EL10_1 |
+                                        ARMMMUIdxBit_EL10_1_PAN |
                                         ARMMMUIdxBit_EL10_0 |
                                         ARMMMUIdxBit_Stage2);
 }
@@ -2660,6 +2662,7 @@ static int gt_phys_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
         return GTIMER_HYP;
     default:
         return GTIMER_PHYS;
@@ -2671,6 +2674,7 @@ static int gt_virt_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
         return GTIMER_HYPVIRT;
     default:
         return GTIMER_VIRT;
@@ -3288,7 +3292,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
+            if (mmu_idx == ARMMMUIdx_EL10_0 ||
+                mmu_idx == ARMMMUIdx_EL10_1 ||
+                mmu_idx == ARMMMUIdx_EL10_1_PAN) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3746,7 +3752,9 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
         extract64(raw_read(env, ri) ^ value, 48, 16)) {
         tlb_flush_by_mmuidx(env_cpu(env),
-                            ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0);
+                            ARMMMUIdxBit_EL20_2 |
+                            ARMMMUIdxBit_EL20_2_PAN |
+                            ARMMMUIdxBit_EL20_0);
     }
     raw_write(env, ri, value);
 }
@@ -3764,6 +3772,7 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_EL10_1 |
+                            ARMMMUIdxBit_EL10_1_PAN |
                             ARMMMUIdxBit_EL10_0 |
                             ARMMMUIdxBit_Stage2);
         raw_write(env, ri, value);
@@ -4124,12 +4133,18 @@ static int vae1_tlbmask(CPUARMState *env)
 {
     /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+        return ARMMMUIdxBit_SE1 |
+               ARMMMUIdxBit_SE1_PAN |
+               ARMMMUIdxBit_SE0;
     } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
                == (HCR_E2H | HCR_TGE)) {
-        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
+        return ARMMMUIdxBit_EL20_2 |
+               ARMMMUIdxBit_EL20_2_PAN |
+               ARMMMUIdxBit_EL20_0;
     } else {
-        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
+        return ARMMMUIdxBit_EL10_1 |
+               ARMMMUIdxBit_EL10_1_PAN |
+               ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -4165,14 +4180,23 @@ static int vmalle1_tlbmask(CPUARMState *env)
      * Since we exclude secure first, we may read HCR_EL2 directly.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+        return ARMMMUIdxBit_SE1 |
+               ARMMMUIdxBit_SE1_PAN |
+               ARMMMUIdxBit_SE0;
     } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
                == (HCR_E2H | HCR_TGE)) {
-        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
+        return ARMMMUIdxBit_EL20_2 |
+               ARMMMUIdxBit_EL20_2_PAN |
+               ARMMMUIdxBit_EL20_0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
+        return ARMMMUIdxBit_EL10_1 |
+               ARMMMUIdxBit_EL10_1_PAN |
+               ARMMMUIdxBit_EL10_0 |
+               ARMMMUIdxBit_Stage2;
     } else {
-        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
+        return ARMMMUIdxBit_EL10_1 |
+               ARMMMUIdxBit_EL10_1_PAN |
+               ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -4188,7 +4212,9 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static int vae2_tlbmask(CPUARMState *env)
 {
     if (arm_hcr_el2_eff(env) & HCR_E2H) {
-        return ARMMMUIdxBit_EL20_0 | ARMMMUIdxBit_EL20_2;
+        return ARMMMUIdxBit_EL20_0 |
+               ARMMMUIdxBit_EL20_2 |
+               ARMMMUIdxBit_EL20_2_PAN;
     } else {
         return ARMMMUIdxBit_E2;
     }
@@ -9080,6 +9106,7 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_E2:
         return 2;
@@ -9088,10 +9115,13 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -9207,6 +9237,8 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
         return ARMMMUIdx_Stage1_E0;
     case ARMMMUIdx_EL10_1:
         return ARMMMUIdx_Stage1_E1;
+    case ARMMMUIdx_EL10_1_PAN:
+        return ARMMMUIdx_Stage1_E1_PAN;
     default:
         return mmu_idx;
     }
@@ -9253,6 +9285,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return false;
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
         g_assert_not_reached();
     }
 }
@@ -11145,7 +11178,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
+    if (mmu_idx == ARMMMUIdx_EL10_0 ||
+        mmu_idx == ARMMMUIdx_EL10_1 ||
+        mmu_idx == ARMMMUIdx_EL10_1_PAN) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11672,10 +11707,13 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE0:
         return 0;
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
         return 1;
     case ARMMMUIdx_E2:
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
@@ -11886,11 +11924,14 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     /* TODO: ARMv8.2-UAO */
     switch (mmu_idx) {
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
         /* TODO: ARMv8.3-NV */
         flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
         break;
     case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_EL20_2_PAN:
         /* TODO: ARMv8.4-SecEL2 */
         /*
          * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fe492bea90..b5c7bc2d76 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -124,9 +124,11 @@ static int get_a64_user_mem_index(DisasContext *s)
          */
         switch (useridx) {
         case ARMMMUIdx_EL10_1:
+        case ARMMMUIdx_EL10_1_PAN:
             useridx = ARMMMUIdx_EL10_0;
             break;
         case ARMMMUIdx_EL20_2:
+        case ARMMMUIdx_EL20_2_PAN:
             useridx = ARMMMUIdx_EL20_0;
             break;
         case ARMMMUIdx_SE1:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b7f726e733..47a374b53d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -155,10 +155,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_EL10_0:
     case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE0:
     case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_SE0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
-- 
2.17.1


