Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2082AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01A82080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4K94r2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01A82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd45-0003cc-TU
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0V-0006al-Oz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0T-00034s-IF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:23 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0T-00032e-AN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so18568757wru.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8r+HTQiaz0B+9GBGLlyu4AdBjlkmGcwLI10SNr8Qdfk=;
 b=f4K94r2u99Lt9ufV9Pi8Hwf/reIRLqrA0gHSXISmZmVirERW8Del9vY4FTB2lr7KSb
 3y2D1kdpRl5BDcwepocpmybfoDjfcrF1DMjDg1Gbg0fzyMwPSm8kKIkzHMQ0hJMtJRuj
 RhavSE1j62FvjuaJiv2HXrbZm47tURmyY3xusTFd+4lI64q31fTbK+nK91CQx9E/KwZV
 eDXVmoEn2mYqO5TNnbdoezaq1C5mbPzKMKSAmOGq1XWlRRNiyPS+XcHHqFvZEDP2PjZ6
 fo/YcqBg1xzkdCHzB9d2E7Hb8R0VY0aLCpUqNlz2D+/0l9rJ7NPqXSzslvTv2B8uUjRa
 R76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8r+HTQiaz0B+9GBGLlyu4AdBjlkmGcwLI10SNr8Qdfk=;
 b=Ue5hfVEJnTZt1NdrLUhgDla6Wn3F5BFelpmCBm5vpT0Ek3If9rScfEpHlsrIbL8RJI
 sDBFPJtsOioymxxfDNqTjNRGe4J27G0NJ/QDVRDJSnqcYjnCPScWtZ3SbEFOtphJaqzC
 Ph/TaNkl4erHR1c5ba7+hP7s4Q8INYDIO3HlyjfAxyCKJWb6jV8LI43n8/4yAMZ6t8xu
 1mYArNVZaDnujyc7FIcusjoTEOnWzNj8Pj5jwnGUXfTVDh3TjXaaj0E5e6Sa06JUOz8O
 Wg3bxYa+oCUUlBDkHlOn1Us9K8nEyQIdYXoKvuQUWenbhjsYz14ibOnDcEH2ebbrT971
 MP3Q==
X-Gm-Message-State: APjAAAVLm537Ql9+5vYsGsSFJdqYOrJBEFr7q4/gdfB7tP+y9/lj2OEJ
 3Wkb3MZ7rG4P4Br/D0ttJY7NqsA/7kKWYA==
X-Google-Smtp-Source: APXvYqxIQ11WXF8HypIGHR1wj2/mp+gM0EakuqMhr00KHMcbjyVnkX1YEPMifhaDG7K8qpJfOrGbYg==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr17002103wrn.124.1580741239725; 
 Mon, 03 Feb 2020 06:47:19 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/20] target/arm: Add mmu_idx for EL1 and EL2 w/ PAN
 enabled
Date: Mon,  3 Feb 2020 14:46:58 +0000
Message-Id: <20200203144716.32204-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

To implement PAN, we will want to swap, for short periods
of time, to a different privileged mmu_idx.  In addition,
we cannot do this with flushing alone, because the AT*
instructions have both PAN and PAN-less versions.

Add the ARMMMUIdx*_PAN constants where necessary next to
the corresponding ARMMMUIdx* constant.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h     |  2 +-
 target/arm/cpu.h           | 33 ++++++++++++++-------
 target/arm/internals.h     |  9 ++++++
 target/arm/helper.c        | 60 +++++++++++++++++++++++++++++++-------
 target/arm/translate-a64.c |  3 ++
 target/arm/translate.c     |  2 ++
 6 files changed, 87 insertions(+), 22 deletions(-)

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
index 0b3036c484..c63bceaaa5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2751,20 +2751,24 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  5. we want to be able to use the TLB for accesses done as part of a
  *     stage1 page table walk, rather than having to walk the stage2 page
  *     table over and over.
+ *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
+ *     Never (PAN) bit within PSTATE.
  *
  * This gives us the following list of cases:
  *
  * NS EL0 EL1&0 stage 1+2 (aka NS PL0)
  * NS EL1 EL1&0 stage 1+2 (aka NS PL1)
+ * NS EL1 EL1&0 stage 1+2 +PAN
  * NS EL0 EL2&0
- * NS EL2 EL2&0
+ * NS EL2 EL2&0 +PAN
  * NS EL2 (aka NS PL2)
  * S EL0 EL1&0 (aka S PL0)
  * S EL1 EL1&0 (not used if EL3 is 32 bit)
+ * S EL1 EL1&0 +PAN
  * S EL3 (aka S PL1)
  * NS EL1&0 stage 2
  *
- * for a total of 9 different mmu_idx.
+ * for a total of 12 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2819,19 +2823,22 @@ typedef enum ARMMMUIdx {
     /*
      * A-profile.
      */
-    ARMMMUIdx_E10_0 =  0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_0 =  1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_0      =  0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_0      =  1 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_E10_1 =  2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1      =  2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1_PAN  =  3 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_E2 =     3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2 =  4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2         =  4 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2      =  5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2_PAN  =  6 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_SE10_0 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE10_1 = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_SE3 =    7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_0     = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1     = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE10_1_PAN = 9 | ARM_MMU_IDX_A,
+    ARMMMUIdx_SE3        = 10 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_Stage2 = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2     = 11 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -2839,6 +2846,7 @@ typedef enum ARMMMUIdx {
      */
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
@@ -2864,10 +2872,13 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(E10_0),
     TO_CORE_BIT(E20_0),
     TO_CORE_BIT(E10_1),
+    TO_CORE_BIT(E10_1_PAN),
     TO_CORE_BIT(E2),
     TO_CORE_BIT(E20_2),
+    TO_CORE_BIT(E20_2_PAN),
     TO_CORE_BIT(SE10_0),
     TO_CORE_BIT(SE10_1),
+    TO_CORE_BIT(SE10_1_PAN),
     TO_CORE_BIT(SE3),
     TO_CORE_BIT(Stage2),
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f8ee5f573..6be8b2d1a9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -843,12 +843,16 @@ static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return true;
     default:
         return false;
@@ -861,10 +865,13 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E2:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
@@ -875,6 +882,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
@@ -1046,6 +1054,7 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
         return true;
     default:
         return false;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 852fd71dcc..739d2d4cc5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -671,6 +671,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_E10_1 |
+                        ARMMMUIdxBit_E10_1_PAN |
                         ARMMMUIdxBit_E10_0 |
                         ARMMMUIdxBit_Stage2);
 }
@@ -682,6 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_E10_1 |
+                                        ARMMMUIdxBit_E10_1_PAN |
                                         ARMMMUIdxBit_E10_0 |
                                         ARMMMUIdxBit_Stage2);
 }
@@ -2700,6 +2702,7 @@ static int gt_phys_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return GTIMER_HYP;
     default:
         return GTIMER_PHYS;
@@ -2711,6 +2714,7 @@ static int gt_virt_redir_timeridx(CPUARMState *env)
     switch (arm_mmu_idx(env)) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return GTIMER_HYPVIRT;
     default:
         return GTIMER_VIRT;
@@ -3337,7 +3341,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+            if (mmu_idx == ARMMMUIdx_E10_0 ||
+                mmu_idx == ARMMMUIdx_E10_1 ||
+                mmu_idx == ARMMMUIdx_E10_1_PAN) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3797,7 +3803,9 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
         tlb_flush_by_mmuidx(env_cpu(env),
-                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+                            ARMMMUIdxBit_E20_2 |
+                            ARMMMUIdxBit_E20_2_PAN |
+                            ARMMMUIdxBit_E20_0);
     }
     raw_write(env, ri, value);
 }
@@ -3815,6 +3823,7 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_E10_1 |
+                            ARMMMUIdxBit_E10_1_PAN |
                             ARMMMUIdxBit_E10_0 |
                             ARMMMUIdxBit_Stage2);
         raw_write(env, ri, value);
@@ -4175,12 +4184,18 @@ static int vae1_tlbmask(CPUARMState *env)
 {
     /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+        return ARMMMUIdxBit_SE10_1 |
+               ARMMMUIdxBit_SE10_1_PAN |
+               ARMMMUIdxBit_SE10_0;
     } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
                == (HCR_E2H | HCR_TGE)) {
-        return ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0;
+        return ARMMMUIdxBit_E20_2 |
+               ARMMMUIdxBit_E20_2_PAN |
+               ARMMMUIdxBit_E20_0;
     } else {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0;
     }
 }
 
@@ -4214,18 +4229,28 @@ static int alle1_tlbmask(CPUARMState *env)
      * stage 1 translations.
      */
     if (arm_is_secure_below_el3(env)) {
-        return ARMMMUIdxBit_SE10_1 | ARMMMUIdxBit_SE10_0;
+        return ARMMMUIdxBit_SE10_1 |
+               ARMMMUIdxBit_SE10_1_PAN |
+               ARMMMUIdxBit_SE10_0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_Stage2;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0 |
+               ARMMMUIdxBit_Stage2;
     } else {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
+        return ARMMMUIdxBit_E10_1 |
+               ARMMMUIdxBit_E10_1_PAN |
+               ARMMMUIdxBit_E10_0;
     }
 }
 
 static int alle2_tlbmask(CPUARMState *env)
 {
     /* TODO: ARMv8.4-SecEL2 */
-    return ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E2;
+    return ARMMMUIdxBit_E20_0 |
+           ARMMMUIdxBit_E20_2 |
+           ARMMMUIdxBit_E20_2_PAN |
+           ARMMMUIdxBit_E2;
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -9215,6 +9240,7 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     switch (mmu_idx) {
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
     case ARMMMUIdx_Stage2:
     case ARMMMUIdx_E2:
         return 2;
@@ -9223,10 +9249,13 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
         return arm_el_is_aa64(env, 3) ? 1 : 3;
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
+    case ARMMMUIdx_Stage1_E1_PAN:
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -9342,6 +9371,8 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
         return ARMMMUIdx_Stage1_E0;
     case ARMMMUIdx_E10_1:
         return ARMMMUIdx_Stage1_E1;
+    case ARMMMUIdx_E10_1_PAN:
+        return ARMMMUIdx_Stage1_E1_PAN;
     default:
         return mmu_idx;
     }
@@ -9388,6 +9419,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return false;
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
         g_assert_not_reached();
     }
 }
@@ -11280,7 +11312,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_E10_0 || mmu_idx == ARMMMUIdx_E10_1) {
+    if (mmu_idx == ARMMMUIdx_E10_0 ||
+        mmu_idx == ARMMMUIdx_E10_1 ||
+        mmu_idx == ARMMMUIdx_E10_1_PAN) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11807,10 +11841,13 @@ int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
     case ARMMMUIdx_SE10_0:
         return 0;
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return 1;
     case ARMMMUIdx_E2:
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         return 2;
     case ARMMMUIdx_SE3:
         return 3;
@@ -12027,11 +12064,14 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     /* TODO: ARMv8.2-UAO */
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         /* TODO: ARMv8.3-NV */
         flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
         break;
     case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
         /* TODO: ARMv8.4-SecEL2 */
         /*
          * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6e82486884..49631c2340 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -124,12 +124,15 @@ static int get_a64_user_mem_index(DisasContext *s)
          */
         switch (useridx) {
         case ARMMMUIdx_E10_1:
+        case ARMMMUIdx_E10_1_PAN:
             useridx = ARMMMUIdx_E10_0;
             break;
         case ARMMMUIdx_E20_2:
+        case ARMMMUIdx_E20_2_PAN:
             useridx = ARMMMUIdx_E20_0;
             break;
         case ARMMMUIdx_SE10_1:
+        case ARMMMUIdx_SE10_1_PAN:
             useridx = ARMMMUIdx_SE10_0;
             break;
         default:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e11a5871d0..d58c328e08 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -155,10 +155,12 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_E2:        /* this one is UNPREDICTABLE */
     case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_E10_0);
     case ARMMMUIdx_SE3:
     case ARMMMUIdx_SE10_0:
     case ARMMMUIdx_SE10_1:
+    case ARMMMUIdx_SE10_1_PAN:
         return arm_to_core_mmu_idx(ARMMMUIdx_SE10_0);
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MPriv:
-- 
2.20.1


