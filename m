Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A412AC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6C42184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb075mdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C42184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5q-0007ri-F6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3f-0008VQ-I4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3a-0005ap-S6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3Y-0005BA-Pc
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:45 -0400
Received: by mail-pg1-x543.google.com with SMTP id i8so14955321pgm.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bxzC46fwqxvrE4MQBvA+quyPmJiFa6EsDSdprm2+Kco=;
 b=Pb075mdwZiVXxe5MOida1xlMwOxAT32nF/aDoWWz4Tiw3Z8i/zeRKtFd9ZtwXolEuK
 OvsFkOemU8m00aIEHfE1o07B9aMMnY2vr2Eov28E2qPunTyqrejVE35wwu5jgmOdo/BL
 1N3H+pOmJDI4b3MXgTd/rFKJv50LeKfKGfkYRqmjoH5J/z7zuSXLt+aPeeL9OlwhhuvU
 mtqvPSezoB+qMvLYYdJUQ2i400jPTjltk8+L4i1rR4k2lY25oDZUtZRUv6ipkySM7G+w
 vFJwisjBXTOkSYkfNOQVBdkOHp/S+UTfy+2DLX33tRoXk6464ecK3Vz1GDg7ytLyAoew
 H14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bxzC46fwqxvrE4MQBvA+quyPmJiFa6EsDSdprm2+Kco=;
 b=jBssBufbgh/+AkoIlbMNU/GrabkNrwk2aMsFX55+gq/nPkv3tZ5VlN0IpiB4DqvNaz
 A+LV2Q8wSjPwAf6UI97btU8me1uaoSD2APDnZyUTfXmFHM3U9xVnKqSm0lrh/VVYjS/d
 Yi7EAo0DJH6Bsc6SpO+QQ3vipsg4w+uCgYkawfRH3cYApAR2gwoIF7X9LPNkognQOSk/
 aeawsm6t1+WtLoJPb1IXnlwSofgrBnSl+uKaTQFYPFvzNZW0AaOx4psO/TKfgMSdkXpN
 EUuEmrNzB5LISx8foEXn4UPYE9A6GOEm+0ECB15PaHx31OGd59IsuzmOisme01XdrsOV
 kTIg==
X-Gm-Message-State: APjAAAXMG69Gs131qp6tBRhl9VuBAv+QgHZNBs17ilQbwbD9rm1I95/Z
 xoL4NL470M/ZOiKePWtBf61T3mA8yLs=
X-Google-Smtp-Source: APXvYqxivWQb2UxFm+Uz96xHWtMNFPE+qkkQ7fSfO8q/PKVEIKMXt3MX3vl7xUlMTUNkdtS2Ew3uiA==
X-Received: by 2002:a63:5c15:: with SMTP id q21mr33852189pgb.199.1563570225978; 
 Fri, 19 Jul 2019 14:03:45 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:17 -0700
Message-Id: <20190719210326.15466-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH for-4.2 15/24] target/arm: Reorganize ARMMMUIdx
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prepare for, but do not yet implement, the EL2&0 regime and the
Secure EL2 regime.  Rename all of the a-profile symbols to make
the distictions clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 180 ++++++++++++++--------------
 target/arm/internals.h     |  46 ++++---
 target/arm/translate.h     |   2 +-
 target/arm/helper.c        | 237 ++++++++++++++++++++++---------------
 target/arm/m_helper.c      |   6 +-
 target/arm/translate-a64.c |  11 +-
 target/arm/translate.c     |  17 ++-
 7 files changed, 273 insertions(+), 226 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0f10b60eb..4b537c4613 100644
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
@@ -2837,62 +2848,93 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
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
-    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E0 = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2 = 2 | ARM_MMU_IDX_A,
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
-    ARMMMUIdx_S1NSE0 = 0 | ARM_MMU_IDX_NOTLB,
-    ARMMMUIdx_S1NSE1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_MSUser = 0 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSPriv = 1 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSUserNegPri = 2 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+    ARMMMUIdx_MSPrivNegPri = 3 | ARM_MMU_IDX_S | ARM_MMU_IDX_M,
+
+    /* Indicies that map onto the same core mmu_idx.  */
+    ARMMMUIdx_EL10_0 = ARMMMUIdx_E0 | ARM_MMU_IDX_A_EL10,
+    ARMMMUIdx_EL10_1 = ARMMMUIdx_E1 | ARM_MMU_IDX_A_EL10,
+    ARMMMUIdx_EL20_0 = ARMMMUIdx_E0 | ARM_MMU_IDX_A_EL20,
+    ARMMMUIdx_EL20_2 = ARMMMUIdx_E2 | ARM_MMU_IDX_A_EL20,
+
+    /* Indicies that are only used only for AT system or Stage1 walk.  */
+    ARMMMUIdx_Stage1_E0 = ARMMMUIdx_E0 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1 = ARMMMUIdx_E1 | ARM_MMU_IDX_NOTLB,
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
-    ARMMMUIdxBit_S12NSE0 = 1 << 0,
-    ARMMMUIdxBit_S12NSE1 = 1 << 1,
-    ARMMMUIdxBit_S1E2 = 1 << 2,
-    ARMMMUIdxBit_S1E3 = 1 << 3,
-    ARMMMUIdxBit_S1SE0 = 1 << 4,
-    ARMMMUIdxBit_S1SE1 = 1 << 5,
-    ARMMMUIdxBit_S2NS = 1 << 6,
-    ARMMMUIdxBit_MUser = 1 << 0,
-    ARMMMUIdxBit_MPriv = 1 << 1,
-    ARMMMUIdxBit_MUserNegPri = 1 << 2,
-    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
-    ARMMMUIdxBit_MSUser = 1 << 4,
-    ARMMMUIdxBit_MSPriv = 1 << 5,
-    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
-    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
+    TO_CORE_BIT(E0),
+    TO_CORE_BIT(E1),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(Stage2),
+    TO_CORE_BIT(SE0),
+    TO_CORE_BIT(SE1),
+    TO_CORE_BIT(SE2),
+    TO_CORE_BIT(SE3),
+    TO_CORE_BIT(EL10_0),
+    TO_CORE_BIT(EL10_1),
+    TO_CORE_BIT(EL20_0),
+    TO_CORE_BIT(EL20_2),
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
@@ -2900,44 +2942,6 @@ static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
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
index 232d963875..047cbfd1d7 100644
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
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
-    case ARMMMUIdx_S1E2:
-    case ARMMMUIdx_S2NS:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-        return false;
-    case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
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
@@ -966,7 +964,7 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env);
 #ifdef CONFIG_USER_ONLY
 static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 {
-    return ARMMMUIdx_S1NSE0;
+    return ARMMMUIdx_EL10_0;
 }
 #else
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e2056..715fa08e3b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -122,7 +122,7 @@ static inline int default_exception_el(DisasContext *s)
      * exceptions can only be routed to ELs above 1, so we target the higher of
      * 1 or the current EL.
      */
-    return (s->mmu_idx == ARMMMUIdx_S1SE0 && s->secure_routed_to_el3)
+    return (s->mmu_idx == ARMMMUIdx_SE0 && s->secure_routed_to_el3)
             ? 3 : MAX(1, s->current_el);
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2b95fc763f..240a6ed168 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -566,10 +566,10 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
         switch (ri->secure) {
         case ARM_CP_SECSTATE_S:
-            idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+            idxmask = ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
             break;
         case ARM_CP_SECSTATE_NS:
-            idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+            idxmask = ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
             break;
         default:
             g_assert_not_reached();
@@ -682,9 +682,9 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
-                        ARMMMUIdxBit_S12NSE1 |
-                        ARMMMUIdxBit_S12NSE0 |
-                        ARMMMUIdxBit_S2NS);
+                        ARMMMUIdxBit_E1 |
+                        ARMMMUIdxBit_E0 |
+                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -693,9 +693,9 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                        ARMMMUIdxBit_S12NSE1 |
-                                        ARMMMUIdxBit_S12NSE0 |
-                                        ARMMMUIdxBit_S2NS);
+                                        ARMMMUIdxBit_E1 |
+                                        ARMMMUIdxBit_E0 |
+                                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -716,7 +716,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -731,8 +731,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -740,7 +739,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -748,7 +747,7 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -757,7 +756,7 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -766,8 +765,7 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static const ARMCPRegInfo cp_reginfo[] = {
@@ -3047,7 +3045,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+            if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3116,13 +3114,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_idx = ARMMMUIdx_SE3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE1;
+            mmu_idx = ARMMMUIdx_Stage1_E1;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
             break;
         default:
             g_assert_not_reached();
@@ -3132,13 +3130,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
         switch (el) {
         case 3:
-            mmu_idx = ARMMMUIdx_S1SE0;
+            mmu_idx = ARMMMUIdx_SE0;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_S1NSE0;
+            mmu_idx = ARMMMUIdx_Stage1_E0;
             break;
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+            mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
             break;
         default:
             g_assert_not_reached();
@@ -3146,11 +3144,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         break;
     case 4:
         /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
-        mmu_idx = ARMMMUIdx_S12NSE1;
+        mmu_idx = ARMMMUIdx_EL10_1;
         break;
     case 6:
         /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
-        mmu_idx = ARMMMUIdx_S12NSE0;
+        mmu_idx = ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3167,7 +3165,7 @@ static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
     MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t par64;
 
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
+    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -3192,26 +3190,26 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     case 0:
         switch (ri->opc1) {
         case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
+            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
             break;
         case 4: /* AT S1E2R, AT S1E2W */
-            mmu_idx = ARMMMUIdx_S1E2;
+            mmu_idx = ARMMMUIdx_E2;
             break;
         case 6: /* AT S1E3R, AT S1E3W */
-            mmu_idx = ARMMMUIdx_S1E3;
+            mmu_idx = ARMMMUIdx_SE3;
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 2: /* AT S1E0R, AT S1E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
+        mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_Stage1_E0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUIdx_SE0 : ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3422,15 +3420,15 @@ static void update_lpae_el1_asid(CPUARMState *env, int secure)
         ttbr0 = env->cp15.ttbr0_s;
         ttbr1 = env->cp15.ttbr1_s;
         ttcr = env->cp15.tcr_el[3].raw_tcr;
-        /* Note that cp15.ttbr0_s == cp15.ttbr0_el[3], so S1E3 is affected.  */
+        /* Note that cp15.ttbr0_s == cp15.ttbr0_el[3], so SE3 is affected.  */
         /* ??? Secure EL3 really using the ASID field?  Doesn't make sense.  */
-        idxmask = ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0 | ARMMMUIdxBit_S1E3;
+        idxmask = ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0 | ARMMMUIdxBit_SE3;
         break;
     case ARM_CP_SECSTATE_NS:
         ttbr0 = env->cp15.ttbr0_ns;
         ttbr1 = env->cp15.ttbr1_ns;
         ttcr = env->cp15.tcr_el[1].raw_tcr;
-        idxmask = ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        idxmask = ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
         break;
     default:
         g_assert_not_reached();
@@ -3542,11 +3540,11 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     vmid = extract64(value, 48, 8);
 
     /*
-     * A change in VMID to the stage2 page table (S2NS) invalidates
-     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
+     * A change in VMID to the stage2 page table (Stage2) invalidates
+     * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
      */
-    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
-                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
+    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_Stage2,
+                            ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0);
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
@@ -3902,9 +3900,9 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 static int vae1_tlbmask(CPUARMState *env)
 {
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
     }
 }
 
@@ -3938,11 +3936,11 @@ static int vmalle1_tlbmask(CPUARMState *env)
      * stage 1 translations.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+        return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0 | ARMMMUIdxBit_Stage2;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
     }
 }
 
@@ -3961,7 +3959,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3970,7 +3968,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3987,7 +3985,7 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3995,7 +3993,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_S1E3);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4009,7 +4007,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4023,7 +4021,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S1E3);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4061,8 +4059,7 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E2);
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_E2);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4071,8 +4068,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S1E3);
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_SE3);
 }
 
 static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4094,7 +4090,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4109,8 +4105,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4378,7 +4373,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "AT_S12E0W", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 8, .opc2 = 7,
       .access = PL2_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
-    /* AT S1E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
+    /* AT E2* are elsewhere as they UNDEF from EL3 if EL2 is not present */
     { .name = "AT_S1E3R", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 7, .crm = 8, .opc2 = 0,
       .access = PL3_W, .type = ARM_CP_NO_RAW, .writefn = ats_write64 },
@@ -8685,19 +8680,23 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #endif /* !CONFIG_USER_ONLY */
 
 /* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S2NS:
-    case ARMMMUIdx_S1E2:
+    case ARMMMUIdx_EL20_0:
+    case ARMMMUIdx_EL20_2:
+    case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_E2:
         return 2;
-    case ARMMMUIdx_S1E3:
+    case ARMMMUIdx_SE3:
         return 3;
-    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_SE0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
-    case ARMMMUIdx_S1SE1:
-    case ARMMMUIdx_S1NSE0:
-    case ARMMMUIdx_S1NSE1:
+    case ARMMMUIdx_SE1:
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -8742,7 +8741,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* HCR.DC means HCR.VM behaves as 1 */
         return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
@@ -8755,7 +8754,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
     }
 
     if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1)) {
+        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -8773,7 +8772,7 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vttbr_el2;
     }
     if (ttbrn == 0) {
@@ -8788,7 +8787,7 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return &env->cp15.vtcr_el2;
     }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
@@ -8799,8 +8798,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
  */
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
+        mmu_idx += (ARMMMUIdx_Stage1_E0 - ARMMMUIdx_EL10_0);
     }
     return mmu_idx;
 }
@@ -8834,8 +8833,8 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_SE0:
+    case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
     case ARMMMUIdx_MUserNegPri:
@@ -8843,8 +8842,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
         g_assert_not_reached();
     }
 }
@@ -8975,7 +8974,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     bool have_wxn;
     int wxn = 0;
 
-    assert(mmu_idx != ARMMMUIdx_S2NS);
+    assert(mmu_idx != ARMMMUIdx_Stage2);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -9066,8 +9065,8 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
-        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
+        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
@@ -9084,7 +9083,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             pcacheattrs = &cacheattrs;
         }
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
+        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
                                  &txattrs, &s2prot, &s2size, fi, pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
@@ -9556,7 +9555,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
             tbi = tbid = hpd = false;
         } else {
@@ -9617,7 +9616,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     int select, tsz;
     bool epd, hpd;
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* VTCR */
         bool sext = extract32(tcr, 4, 1);
         bool sign = extract32(tcr, 3, 1);
@@ -9719,7 +9718,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         level = 1;
         /* There is no TTBR1 for EL2 */
         ttbr1_valid = (el != 2);
-        addrsize = (mmu_idx == ARMMMUIdx_S2NS ? 40 : 32);
+        addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
 
@@ -9770,7 +9769,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_S2NS) {
+    if (mmu_idx != ARMMMUIdx_Stage2) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -9870,7 +9869,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -9901,7 +9900,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     ap = extract32(attrs, 4, 2);
     xn = extract32(attrs, 12, 1);
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
         *prot = get_S2prot(env, ap, xn);
     } else {
@@ -9928,7 +9927,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     if (cacheattrs != NULL) {
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             cacheattrs->attrs = convert_stage2_attrs(env,
                                                      extract32(attrs, 0, 4));
         } else {
@@ -9949,7 +9948,7 @@ do_fault:
     fi->type = fault_type;
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
+    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2);
     return true;
 }
 
@@ -10748,7 +10747,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -10763,13 +10762,13 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
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
@@ -10811,7 +10810,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
-    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_S2NS
+    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
@@ -11260,6 +11259,41 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
+    case ARMMMUIdx_E0:
+        return ARMMMUIdx_EL10_0;
+    case ARMMMUIdx_E1:
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
@@ -11276,10 +11310,21 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     }
 
     el = arm_current_el(env);
-    if (el < 2 && arm_is_secure_below_el3(env)) {
-        return ARMMMUIdx_S1SE0 + el;
-    } else {
-        return ARMMMUIdx_S12NSE0 + el;
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
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3231477a2..a9e65fe347 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -113,13 +113,14 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     ARMMMUIdx useridx;
 
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        useridx = ARMMMUIdx_S12NSE0;
+    case ARMMMUIdx_EL10_1:
+        /* FIXME: ARMv8.1-VHE */
+        useridx = ARMMMUIdx_EL10_0;
         break;
-    case ARMMMUIdx_S1SE1:
-        useridx = ARMMMUIdx_S1SE0;
+    case ARMMMUIdx_SE1:
+        useridx = ARMMMUIdx_SE0;
         break;
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
         g_assert_not_reached();
     default:
         useridx = s->mmu_idx;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21..0346088e75 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -152,14 +152,14 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      *  otherwise, access as if at PL0.
      */
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
-    case ARMMMUIdx_S1E3:
-    case ARMMMUIdx_S1SE0:
-    case ARMMMUIdx_S1SE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S1SE0);
+    case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
+    case ARMMMUIdx_EL10_1:
+    case ARMMMUIdx_EL10_0:
+        return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
+    case ARMMMUIdx_SE3:
+    case ARMMMUIdx_SE1:
+    case ARMMMUIdx_SE0:
+        return arm_to_core_mmu_idx(ARMMMUIdx_SE0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
         return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
@@ -172,7 +172,6 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPrivNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
-    case ARMMMUIdx_S2NS:
     default:
         g_assert_not_reached();
     }
-- 
2.17.1


