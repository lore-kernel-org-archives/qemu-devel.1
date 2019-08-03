Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45327C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2682087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQIYGZ53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2682087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzEj-0004UM-Ae
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4y-0006c3-3d
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4v-0007JB-Ci
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:31 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4v-0007Iu-4U
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id u14so37642214pfn.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C4yPNU5MzTttlOEZGJqyKcDVIL6n5tI4jir190lVFFk=;
 b=JQIYGZ53MtqAowkP2w6l/7Wd/j/veiwZC49CUbVDamurSfVRPozCNx6usezA+jz41x
 FcmDYL3K1AiLcawd29RXtu04yyoFF5MBF0VnvK2j7RA9AgFlbiY7muB6HcIZTPfCIN8D
 VquiPPs5H1om2PMOzAMn4ANu22yrskwBy/GIAZFPmBgUAP4LnUdPteuNPc/lpai3BJTE
 UtSubYeZHkeaVLT5gxt4jLGss2bT8lr9gIK7X6nXptXNWQmzX5XJH2Bc+uftMbZztPIv
 TmhOSdgvkx+AySe/qCfggGSQCB067RNpdLxUHbas2ZcapbVt+aOwHrDLXDik/+UfakAU
 yFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C4yPNU5MzTttlOEZGJqyKcDVIL6n5tI4jir190lVFFk=;
 b=KAyoFcHrDDyTOCHlbAyPju2IDsB9/9Ud5DyYBKO0m8hz8CNXo/V3FotpAqDmGC7/SY
 93RCOzOehf0cWK29Yjgmu8fOntjpwsfrG2RQQUxyfGbEvmlmW7R4oMXDEH87zc9SxQUR
 t0qcNLMGL3SiZLKorNkvObeUgRPNlSXTBK7psLzkXlAe8C/8uvivDJ5dd5+Xji5EN3uO
 K24QWKMs4kWjTIs8uFjKnxxuUIenDcZd0SK0DNq+Y1rIFBaVl/N0GYJ0Hzz4ZO9oKEWB
 EWyGwt6aRjih9yS/WtW1aZ1HWfMf+63po8rv0oIenZxobcik6kwxaIqRzUSkI61nHOl4
 7vTg==
X-Gm-Message-State: APjAAAWMZm6Fv9++pJwhWWrOvJiE911O+2/RUqzDLmRj03XWPPMB4CMn
 n1NQPS+4kHeB9OKqcKL8Ib2NNiy5RAk=
X-Google-Smtp-Source: APXvYqwsvF3TjE7yXzXjfTRpgx4Mm/g8rY6+VhFa2dAecaLuIBPysJH9p21YIfbSMT99FZimcaeVaA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr98286967pgu.289.1564858107784; 
 Sat, 03 Aug 2019 11:48:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:47 -0700
Message-Id: <20190803184800.8221-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 21/34] target/arm: Reorganize ARMMMUIdx
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

Prepare for, but do not yet implement, the EL2&0 regime
and the Secure EL2 regime.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 173 ++++++++++++++++++++---------------------
 target/arm/internals.h |  44 +++++------
 target/arm/helper.c    |  60 ++++++++++++--
 target/arm/m_helper.c  |   6 +-
 target/arm/translate.c |   1 -
 5 files changed, 165 insertions(+), 119 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 552269daad..b5300f9014 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2764,7 +2764,10 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  *  + NonSecure EL1 & 0 stage 1
  *  + NonSecure EL1 & 0 stage 2
  *  + NonSecure EL2
- *  + Secure EL1 & EL0
+ *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
+ *  + Secure EL0
+ *  + Secure EL1
+ *  + Secure EL2          (ARMv8.4-SecEL2)
  *  + Secure EL3
  * If EL3 is 32-bit:
  *  + NonSecure PL1 & 0 stage 1
@@ -2774,8 +2777,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * (reminder: for 32 bit EL3, Secure PL1 is *EL3*, not EL1.)
  *
  * For QEMU, an mmu_idx is not quite the same as a translation regime because:
- *  1. we need to split the "EL1 & 0" regimes into two mmu_idxes, because they
- *     may differ in access permissions even if the VA->PA map is the same
+ *  1. we need to split the "EL1 & 0" and "EL2 & 0" regimes into two mmu_idxes,
+ *     because they may differ in access permissions even if the VA->PA map is
+ *     the same
  *  2. we want to cache in our TLB the full VA->IPA->PA lookup for a stage 1+2
  *     translation, which means that we have one mmu_idx that deals with two
  *     concatenated translation regimes [this sort of combined s1+2 TLB is
@@ -2787,19 +2791,26 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
  *     translation regimes, because they map reasonably well to each other
  *     and they can't both be active at the same time.
- * This gives us the following list of mmu_idx values:
+ *  5. we want to be able to use the TLB for accesses done as part of a
+ *     stage1 page table walk, rather than having to walk the stage2 page
+ *     table over and over.
  *
- * NS EL0 (aka NS PL0) stage 1+2
- * NS EL1 (aka NS PL1) stage 1+2
+ * This gives us the following list of cases:
+ *
+ * NS EL0 (aka NS PL0) EL1&0 stage 1+2
+ * NS EL1 (aka NS PL1) EL1&0 stage 1+2
+ * NS EL0 (aka NS PL0) EL2&0
+ * NS EL2 (aka NS PL2) EL2&0
  * NS EL2 (aka NS PL2)
- * S EL3 (aka S PL1)
  * S EL0 (aka S PL0)
  * S EL1 (not used if EL3 is 32 bit)
- * NS EL0+1 stage 2
+ * S EL2 (not used if EL3 is 32 bit)
+ * S EL3 (aka S PL1)
+ * NS EL0&1 stage 2
  *
- * (The last of these is an mmu_idx because we want to be able to use the TLB
- * for the accesses done as part of a stage 1 page table walk, rather than
- * having to walk the stage 2 page table over and over.)
+ * We then merge the two NS EL0 cases, and two NS EL2 cases to produce
+ * 8 different mmu_idx.  We retain separate symbols for these four cases
+ * in order to simplify distinguishing them in the code.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2837,62 +2848,88 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
  * For M profile we arrange them to have a bit for priv, a bit for negpri
  * and a bit for secure.
  */
-#define ARM_MMU_IDX_A 0x10 /* A profile */
-#define ARM_MMU_IDX_NOTLB 0x20 /* does not have a TLB */
-#define ARM_MMU_IDX_M 0x40 /* M profile */
+#define ARM_MMU_IDX_S     0x04  /* Secure */
+#define ARM_MMU_IDX_A     0x10  /* A profile */
+#define ARM_MMU_IDX_M     0x20  /* M profile */
+#define ARM_MMU_IDX_NOTLB 0x100 /* does not have a TLB */
 
-/* meanings of the bits for M profile mmu idx values */
-#define ARM_MMU_IDX_M_PRIV 0x1
+/* Meanings of the bits for A profile mmu idx values */
+#define ARM_MMU_IDX_A_PRIV   0x3
+#define ARM_MMU_IDX_A_EL10   0x40
+#define ARM_MMU_IDX_A_EL20   0x80
+
+/* Meanings of the bits for M profile mmu idx values */
+#define ARM_MMU_IDX_M_PRIV   0x1
 #define ARM_MMU_IDX_M_NEGPRI 0x2
-#define ARM_MMU_IDX_M_S 0x4
 
-#define ARM_MMU_IDX_TYPE_MASK (~0x7)
+#define ARM_MMU_IDX_TYPE_MASK    (ARM_MMU_IDX_A | ARM_MMU_IDX_M)
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
 
 typedef enum ARMMMUIdx {
-    ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A | ARM_MMU_IDX_A_EL10,
+    ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A | ARM_MMU_IDX_A_EL10,
+    ARMMMUIdx_EL20_0 = 0 | ARM_MMU_IDX_A | ARM_MMU_IDX_A_EL20,
+    ARMMMUIdx_EL20_2 = 2 | ARM_MMU_IDX_A | ARM_MMU_IDX_A_EL20,
+
     ARMMMUIdx_E2 = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE0 = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE1 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
+
+    /*
+     * While Stage2 is used by A profile, and uses a TLB, it is only
+     * used for page table walks and is not a valid as an arm_mmu_idx().
+     * Overlap it on the non-existant non-secure el3 slot.
+     */
+    ARMMMUIdx_Stage2 = 3,
+
+    ARMMMUIdx_SE0 = 0 | ARM_MMU_IDX_S | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE1 = 1 | ARM_MMU_IDX_S | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE2 = 2 | ARM_MMU_IDX_S | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3 = 3 | ARM_MMU_IDX_S | ARM_MMU_IDX_A,
+
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPrivNegPri = 3 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUser = 4 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPriv = 5 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUserNegPri = 6 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPrivNegPri = 7 | ARM_MMU_IDX_M,
-    /* Indexes below here don't have TLBs and are used only for AT system
-     * instructions or for the first stage of an S12 page table walk.
-     */
-    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_MSUser = 0 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSPriv = 1 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSUserNegPri = 2 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSPrivNegPri = 3 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+
+    /* Indicies that are only used only for AT system or Stage1 walk.  */
+    ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_A | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_A | ARM_MMU_IDX_NOTLB,
 } ARMMMUIdx;
 
-/* Bit macros for the core-mmu-index values for each index,
+/*
+ * Bit macros for the core-mmu-index values for each index,
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
+#define TO_CORE_BIT(NAME) \
+    ARMMMUIdxBit_##NAME = 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX_MASK)
+
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_EL10_0 = 1 << 0,
-    ARMMMUIdxBit_EL10_1 = 1 << 1,
-    ARMMMUIdxBit_E2 = 1 << 2,
-    ARMMMUIdxBit_SE3 = 1 << 3,
-    ARMMMUIdxBit_SE0 = 1 << 4,
-    ARMMMUIdxBit_SE1 = 1 << 5,
-    ARMMMUIdxBit_Stage2 = 1 << 6,
-    ARMMMUIdxBit_MUser = 1 << 0,
-    ARMMMUIdxBit_MPriv = 1 << 1,
-    ARMMMUIdxBit_MUserNegPri = 1 << 2,
-    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
-    ARMMMUIdxBit_MSUser = 1 << 4,
-    ARMMMUIdxBit_MSPriv = 1 << 5,
-    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
-    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
+    TO_CORE_BIT(EL10_0),
+    TO_CORE_BIT(EL10_1),
+    TO_CORE_BIT(EL20_0),
+    TO_CORE_BIT(EL20_2),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(Stage2),
+    TO_CORE_BIT(SE0),
+    TO_CORE_BIT(SE1),
+    TO_CORE_BIT(SE2),
+    TO_CORE_BIT(SE3),
+
+    TO_CORE_BIT(MUser),
+    TO_CORE_BIT(MPriv),
+    TO_CORE_BIT(MUserNegPri),
+    TO_CORE_BIT(MPrivNegPri),
+    TO_CORE_BIT(MSUser),
+    TO_CORE_BIT(MSPriv),
+    TO_CORE_BIT(MSUserNegPri),
+    TO_CORE_BIT(MSPrivNegPri),
 } ARMMMUIdxBit;
 
+#undef TO_CORE_BIT
+
 #define MMU_USER_IDX 0
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
@@ -2900,44 +2937,6 @@ static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
     return mmu_idx & ARM_MMU_IDX_COREIDX_MASK;
 }
 
-static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
-{
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        return mmu_idx | ARM_MMU_IDX_M;
-    } else {
-        return mmu_idx | ARM_MMU_IDX_A;
-    }
-}
-
-/* Return the exception level we're running at if this is our mmu_idx */
-static inline int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
-    case ARM_MMU_IDX_A:
-        return mmu_idx & 3;
-    case ARM_MMU_IDX_M:
-        return mmu_idx & ARM_MMU_IDX_M_PRIV;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-/*
- * Return the MMU index for a v7M CPU with all relevant information
- * manually specified.
- */
-ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
-                              bool secstate, bool priv, bool negpri);
-
-/* Return the MMU index for a v7M CPU in the specified security and
- * privilege state.
- */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
-                                                bool secstate, bool priv);
-
-/* Return the MMU index for a v7M CPU in the specified security state */
-ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
-
 /**
  * cpu_mmu_index:
  * @env: The cpu environment
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 027878516f..dd0bc4377f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -769,6 +769,26 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 
+ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx);
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
+
+/*
+ * Return the MMU index for a v7M CPU with all relevant information
+ * manually specified.
+ */
+ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
+                              bool secstate, bool priv, bool negpri);
+
+/*
+ * Return the MMU index for a v7M CPU in the specified security and
+ * privilege state.
+ */
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
+                                                bool secstate, bool priv);
+
+/* Return the MMU index for a v7M CPU in the specified security state */
+ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
+
 /* Return true if the stage 1 translation regime is using LPAE format page
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx);
@@ -807,29 +827,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 /* Return true if this address translation regime is secure */
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    switch (mmu_idx) {
-    case ARMMMUIdx_EL10_0:
-    case ARMMMUIdx_EL10_1:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_E2:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-        return false;
-    case ARMMMUIdx_SE3:
-    case ARMMMUIdx_SE0:
-    case ARMMMUIdx_SE1:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return true;
-    default:
-        g_assert_not_reached();
-    }
+    return (mmu_idx & ARM_MMU_IDX_S) != 0;
 }
 
 /* Return the FSR value for a debug exception (watchpoint, hardware
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69c913d824..9c2c81c434 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8687,9 +8687,11 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #endif /* !CONFIG_USER_ONLY */
 
 /* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_EL20_0:
+    case ARMMMUIdx_EL20_2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_E2:
         return 2;
@@ -8700,6 +8702,8 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE1:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -11262,6 +11266,41 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
+ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
+{
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return mmu_idx | ARM_MMU_IDX_M;
+    }
+
+    mmu_idx |= ARM_MMU_IDX_A;
+    switch (mmu_idx) {
+    case 0 | ARM_MMU_IDX_A:
+        return ARMMMUIdx_EL10_0;
+    case 1 | ARM_MMU_IDX_A:
+        return ARMMMUIdx_EL10_1;
+    case ARMMMUIdx_E2:
+    case ARMMMUIdx_SE0:
+    case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE3:
+        return mmu_idx;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/* Return the exception level we're running at if this is our mmu_idx */
+int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx & ARM_MMU_IDX_TYPE_MASK) {
+    case ARM_MMU_IDX_A:
+        return mmu_idx & ARM_MMU_IDX_A_PRIV;
+    case ARM_MMU_IDX_M:
+        return mmu_idx & ARM_MMU_IDX_M_PRIV;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #ifndef CONFIG_TCG
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 {
@@ -11278,10 +11317,21 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     }
 
     el = arm_current_el(env);
-    if (el < 2 && arm_is_secure_below_el3(env)) {
-        return ARMMMUIdx_SE0 + el;
-    } else {
-        return ARMMMUIdx_EL10_0 + el;
+    switch (el) {
+    case 0:
+        /* TODO: ARMv8.1-VHE */
+    case 1:
+        return (arm_is_secure_below_el3(env)
+                ? ARMMMUIdx_SE0 + el
+                : ARMMMUIdx_EL10_0 + el);
+    case 2:
+        /* TODO: ARMv8.1-VHE */
+        /* TODO: ARMv8.4-SecEL2 */
+        return ARMMMUIdx_E2;
+    case 3:
+        return ARMMMUIdx_SE3;
+    default:
+        g_assert_not_reached();
     }
 }
 
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 84609f446e..f745c0d067 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -126,7 +126,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     hwaddr physaddr;
     int prot;
     ARMMMUFaultInfo fi = {};
-    bool secure = mmu_idx & ARM_MMU_IDX_M_S;
+    bool secure = mmu_idx & ARM_MMU_IDX_S;
     int exc;
     bool exc_secure;
 
@@ -218,7 +218,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     hwaddr physaddr;
     int prot;
     ARMMMUFaultInfo fi = {};
-    bool secure = mmu_idx & ARM_MMU_IDX_M_S;
+    bool secure = mmu_idx & ARM_MMU_IDX_S;
     int exc;
     bool exc_secure;
     uint32_t value;
@@ -2669,7 +2669,7 @@ ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
     }
 
     if (secstate) {
-        mmu_idx |= ARM_MMU_IDX_M_S;
+        mmu_idx |= ARM_MMU_IDX_S;
     }
 
     return mmu_idx;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4e79dbbdfc..f25d5f18c6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -172,7 +172,6 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPrivNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
-    case ARMMMUIdx_Stage2:
     default:
         g_assert_not_reached();
     }
-- 
2.17.1


