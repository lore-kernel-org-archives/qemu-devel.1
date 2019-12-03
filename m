Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F65C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7338D206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7WCX4/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7338D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby8p-0008CF-8U
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwq-0003BA-V9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwo-00087h-RG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:56 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwl-000862-1D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id z124so850495pgb.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4fmp+B7ZQONDNO2I4Fh6/DwMwJ80JOOXXH0hQuh4p3Y=;
 b=h7WCX4/WtKG58R2fDgzuV9CB44gpaAzfTgPkyShc5UhOatA+rCGEQbDUi4hcxwJqmC
 0eqfu+ZK5ODq1ej4TOwtYaiUslkTdbB+pjq2Mh/qlblDPzD56SxV0WH5b7DDHb4wqNRT
 ZjCegX4zHb3NZasyU1ZeN19mk6eYq4NN+AUzWeumL1PPpa/PosNiw58lgr2i3CooX0vn
 PxTOsrkQVdIie1FVqMaujPe61i8RQB66TFmh8tdN+C8lNhHmpk9Eb8GZQHGoRPbf4Ebi
 cffI6ninrKX3ZO+cpWt/5dN+oQC+xPkgBoVcxmeuIq7Ef2sr8vtPlmMWxkpJFBA8BNw2
 Zgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4fmp+B7ZQONDNO2I4Fh6/DwMwJ80JOOXXH0hQuh4p3Y=;
 b=RwBxwrlvJwG92jKCb8V7zjEmFLTr+lzWPuHaEYM9Csu0PQVns97/WbGV6N/Q0BPbAZ
 08ahqb1UDdGq9uI36XfQ6uyVPvHZZD3K9wxaBFSoDJaShccr0gZo9oytTwweS/yp/CQv
 wFvVuYEL/t2JHd2LoGjYTjtc2wQlrsrMF/SLyFvOyYSH7x8swmsWWXXe5eATI9VEyRHh
 QiNrpF/CcuJzdCmWxS9pqxtLNe5yPRA/jhBfMbY5VwnIr/+zA2Zcg8sewwMrYdNrfZbx
 +8zQWuAE9hD17KUx2O/zMU2kxUcZoqUUeBYa9T/ZEYTKE3SNsf7zxrrmpAaDNAbqroIX
 eo8A==
X-Gm-Message-State: APjAAAUGYjxh3dWWOZQ1BM30+To5RdIoNw0JcKh84YGHKWjUp5D5SUrk
 LSNRcJh27XURTOOTJ1BLarA9CpvAY7s=
X-Google-Smtp-Source: APXvYqywtAnLjuS7bvEe8rYRlnGtFIbwNhYTeOrvmeD48Yz3E4CQNncl6pRTGiXqGTAb+Z6ZN2f89g==
X-Received: by 2002:a62:1687:: with SMTP id 129mr2386952pfw.44.1575340189548; 
 Mon, 02 Dec 2019 18:29:49 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/40] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
Date: Mon,  2 Dec 2019 18:29:05 -0800
Message-Id: <20191203022937.1474-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

This is part of a reorganization to the set of mmu_idx.
This emphasizes that they apply to the EL1&0 regime.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  8 ++++----
 target/arm/internals.h     |  4 ++--
 target/arm/helper.c        | 40 +++++++++++++++++++-------------------
 target/arm/translate-a64.c |  4 ++--
 target/arm/translate.c     |  6 +++---
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9729e62d2c..802cddd2df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2864,8 +2864,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_MMU_IDX_COREIDX_MASK 0x7
 
 typedef enum ARMMMUIdx {
-    ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S12NSE1 = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_0 = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_EL10_1 = 1 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E2 = 2 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
@@ -2890,8 +2890,8 @@ typedef enum ARMMMUIdx {
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_S12NSE0 = 1 << 0,
-    ARMMMUIdxBit_S12NSE1 = 1 << 1,
+    ARMMMUIdxBit_EL10_0 = 1 << 0,
+    ARMMMUIdxBit_EL10_1 = 1 << 1,
     ARMMMUIdxBit_S1E2 = 1 << 2,
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5313dd3d4..54142dd789 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -808,8 +808,8 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
 static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6c09cda4ea..d2b90763ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -670,8 +670,8 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx(cs,
-                        ARMMMUIdxBit_S12NSE1 |
-                        ARMMMUIdxBit_S12NSE0 |
+                        ARMMMUIdxBit_EL10_1 |
+                        ARMMMUIdxBit_EL10_0 |
                         ARMMMUIdxBit_S2NS);
 }
 
@@ -681,8 +681,8 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                        ARMMMUIdxBit_S12NSE1 |
-                                        ARMMMUIdxBit_S12NSE0 |
+                                        ARMMMUIdxBit_EL10_1 |
+                                        ARMMMUIdxBit_EL10_0 |
                                         ARMMMUIdxBit_S2NS);
 }
 
@@ -3068,7 +3068,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         format64 = arm_s1_regime_using_lpae_format(env, mmu_idx);
 
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+            if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
                 format64 |= env->cp15.hcr_el2 & (HCR_VM | HCR_DC);
             } else {
                 format64 |= arm_current_el(env) == 2;
@@ -3167,11 +3167,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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
@@ -3229,10 +3229,10 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
         mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
         break;
     case 4: /* AT S12E1R, AT S12E1W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
+        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_EL10_1;
         break;
     case 6: /* AT S12E0R, AT S12E0W */
-        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
+        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_EL10_0;
         break;
     default:
         g_assert_not_reached();
@@ -3531,8 +3531,8 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
+                            ARMMMUIdxBit_EL10_1 |
+                            ARMMMUIdxBit_EL10_0 |
                             ARMMMUIdxBit_S2NS);
         raw_write(env, ri, value);
     }
@@ -3893,7 +3893,7 @@ static int vae1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -3929,9 +3929,9 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_S2NS;
     } else {
-        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+        return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
 }
 
@@ -8671,8 +8671,8 @@ static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
  */
 static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
-        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_S12NSE0);
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
+        mmu_idx += (ARMMMUIdx_S1NSE0 - ARMMMUIdx_EL10_0);
     }
     return mmu_idx;
 }
@@ -8715,8 +8715,8 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
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
@@ -10620,7 +10620,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    if (mmu_idx == ARMMMUIdx_EL10_0 || mmu_idx == ARMMMUIdx_EL10_1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -11148,7 +11148,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
-        return ARMMMUIdx_S12NSE0 + el;
+        return ARMMMUIdx_EL10_0 + el;
     }
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d4bebbe629..2703ebf32a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -113,8 +113,8 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     ARMMMUIdx useridx;
 
     switch (s->mmu_idx) {
-    case ARMMMUIdx_S12NSE1:
-        useridx = ARMMMUIdx_S12NSE0;
+    case ARMMMUIdx_EL10_1:
+        useridx = ARMMMUIdx_EL10_0;
         break;
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d5d4bd888..e3deea50e0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -153,9 +153,9 @@ static inline int get_a32_user_mem_index(DisasContext *s)
      */
     switch (s->mmu_idx) {
     case ARMMMUIdx_S1E2:        /* this one is UNPREDICTABLE */
-    case ARMMMUIdx_S12NSE0:
-    case ARMMMUIdx_S12NSE1:
-        return arm_to_core_mmu_idx(ARMMMUIdx_S12NSE0);
+    case ARMMMUIdx_EL10_0:
+    case ARMMMUIdx_EL10_1:
+        return arm_to_core_mmu_idx(ARMMMUIdx_EL10_0);
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
-- 
2.17.1


