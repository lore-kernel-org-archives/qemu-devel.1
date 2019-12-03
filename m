Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05811C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B601A20684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plT/L3/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B601A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby5u-0004Do-Rw
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxA-0003Go-Te
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwu-0008DX-MW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:05 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:41558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwt-0008Ax-Lb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:59 -0500
Received: by mail-pj1-x1041.google.com with SMTP id ca19so814043pjb.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5/YAtKa3WnIkaYSpx8eXnl6bZdS/00Vj/dGucoxzJq8=;
 b=plT/L3/7AR9eHO+T+YyHlYlqgi5/NCgbuLn2gyH7nCSkgAy83Q+WyBVEQNuwpOKG45
 tIBZOCQAvSboNU8k2M8GbejQqOcSrkFwT9u4OOTR44a9r1oeOyR2JJonqrV5ruKLW/rm
 OYM/6T/svGXwotj9xIf2zNJX4rpgisghRXLnK/CdmVF+ZzzUS9AiCRnaCRv7DWBPvO8Z
 KHjGlxlmPkutZEMYAWzhdObCpYaw1qjehJDOtyrhlEaYWEKCURoJH06dBHwXpt0mas2Z
 aJP9PZ3OaFD25E5maVwEejcHNlNZwpyT+Vk6UWrm4IxSb6oFSCOiyuNV3PE2hh4h7TC9
 XodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5/YAtKa3WnIkaYSpx8eXnl6bZdS/00Vj/dGucoxzJq8=;
 b=bge+vV1mNr2zZtdDBDqIhgB2tr9UNU6BkY+pd9mf2cscz7SonFY4Jb/CSsfLZSC6Bf
 WAVkWDXm4uUp7YOP1b4DprUQUgh0jMjGNZu431S1mzfUy4gQw9gzX9rmmcbIXDfWgXtN
 NiJbJAr43jArEg/bhZ1Lxie6HuI/5oBR6DA5OExJr2Jn2nVFAyGUEG7pTVy1rEXrJEjT
 bXP3sJmMXMh7MUVTG6UHgcJqbYlR0ploOxp1M+NKSVSqRhI3mpH00KftEUtHEzDnr2ty
 /Yst2lUlnRYne7PFW+NK9/KZ8j7t2NsTLkSVP2PU3DAcNBtvFeoLAqXa4cSnt4bkFmkj
 NcfQ==
X-Gm-Message-State: APjAAAVzKiGOG0tbYhz9rJsDHqc1E/Z9co/uo7WyXT9GcPZoORLqmT/R
 F7c9uVlymM0ArdNvZCrXY0nhDgaFCNA=
X-Google-Smtp-Source: APXvYqy5DE+VKjmgt1WG4K8GNTSJSUPPHFCB6Q8C9IO0UyhBwgzmgK22jVN/+m13yBI3nM7a6nRGfw==
X-Received: by 2002:a17:902:7205:: with SMTP id
 ba5mr2580962plb.95.1575340197732; 
 Mon, 02 Dec 2019 18:29:57 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/40] target/arm: Recover 4 bits from TBFLAGs
Date: Mon,  2 Dec 2019 18:29:11 -0800
Message-Id: <20191203022937.1474-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had completely run out of TBFLAG bits.
Split A- and M-profile bits into two overlapping buckets.
This results in 4 free bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 52 ++++++++++++++++++++++++---------------
 target/arm/helper.c    | 17 ++++++-------
 target/arm/translate.c | 56 +++++++++++++++++++++++-------------------
 3 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 28259be733..ae9fc1ded3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3188,38 +3188,50 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
  */
 FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
 
-/* Bit usage when in AArch32 state: */
-FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
-FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
-FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
+/*
+ * Bit usage when in AArch32 state, both A- and M-profile.
+ */
+FIELD(TBFLAG_AM32, CONDEXEC, 0, 8)      /* Not cached. */
+FIELD(TBFLAG_AM32, THUMB, 8, 1)         /* Not cached. */
+
+/*
+ * Bit usage when in AArch32 state, for A-profile only.
+ */
+FIELD(TBFLAG_A32, VECLEN, 9, 3)         /* Not cached. */
+FIELD(TBFLAG_A32, VECSTRIDE, 12, 2)     /* Not cached. */
 /*
  * We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime. This shares the same bits as
  * VECSTRIDE, which is OK as no XScale CPU has VFP.
  * Not cached, because VECLEN+VECSTRIDE are not cached.
  */
-FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
+FIELD(TBFLAG_A32, XSCALE_CPAR, 12, 2)
+FIELD(TBFLAG_A32, VFPEN, 14, 1)         /* Partially cached, minus FPEXC. */
+FIELD(TBFLAG_A32, SCTLR_B, 15, 1)
 /*
  * Indicates whether cp register reads and writes by guest code should access
  * the secure or nonsecure bank of banked registers; note that this is not
  * the same thing as the current security state of the processor!
  */
-FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
-FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
-FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
-/* For M profile only, set if FPCCR.LSPACT is set */
-FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
-/* For M profile only, set if we must create a new FP context */
-FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
-/* For M profile only, set if FPCCR.S does not match current security state */
-FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
-/* For M profile only, Handler (ie not Thread) mode */
-FIELD(TBFLAG_A32, HANDLER, 21, 1)
-/* For M profile only, whether we should generate stack-limit checks */
-FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
+FIELD(TBFLAG_A32, NS, 16, 1)
 
-/* Bit usage when in AArch64 state */
+/*
+ * Bit usage when in AArch32 state, for M-profile only.
+ */
+/* Handler (ie not Thread) mode */
+FIELD(TBFLAG_M32, HANDLER, 9, 1)
+/* Whether we should generate stack-limit checks */
+FIELD(TBFLAG_M32, STACKCHECK, 10, 1)
+/* Set if FPCCR.LSPACT is set */
+FIELD(TBFLAG_M32, LSPACT, 11, 1)                 /* Not cached. */
+/* Set if we must create a new FP context */
+FIELD(TBFLAG_M32, NEW_FP_CTXT_NEEDED, 12, 1)     /* Not cached. */
+/* Set if FPCCR.S does not match current security state */
+FIELD(TBFLAG_M32, FPCCR_S_WRONG, 13, 1)          /* Not cached. */
+
+/*
+ * Bit usage when in AArch64 state
+ */
 FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5172843667..ec5c7fa325 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11207,11 +11207,8 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
-    /* v8M always enables the fpu.  */
-    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-
     if (arm_v7m_is_handler_mode(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
+        flags = FIELD_DP32(flags, TBFLAG_M32, HANDLER, 1);
     }
 
     /*
@@ -11222,7 +11219,7 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     if (arm_feature(env, ARM_FEATURE_V8) &&
         !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
           (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
+        flags = FIELD_DP32(flags, TBFLAG_M32, STACKCHECK, 1);
     }
 
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
@@ -11385,7 +11382,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
                 FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
                 != env->v7m.secure) {
-                flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, FPCCR_S_WRONG, 1);
             }
 
             if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
@@ -11397,12 +11394,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                  * active FP context; we must create a new FP context before
                  * executing any FP insn.
                  */
-                flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, NEW_FP_CTXT_NEEDED, 1);
             }
 
             bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
             if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-                flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+                flags = FIELD_DP32(flags, TBFLAG_M32, LSPACT, 1);
             }
         } else {
             /*
@@ -11423,8 +11420,8 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
         }
 
-        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
+        flags = FIELD_DP32(flags, TBFLAG_AM32, THUMB, env->thumb);
+        flags = FIELD_DP32(flags, TBFLAG_AM32, CONDEXEC, env->condexec_bits);
         pstate_for_ss = env->uncached_cpsr;
     }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 51ea99e6f9..cd757165e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10841,37 +10841,46 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      */
     dc->secure_routed_to_el3 = arm_feature(env, ARM_FEATURE_EL3) &&
                                !arm_el_is_aa64(env, 3);
-    dc->thumb = FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
-    dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
-    dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
-    condexec = FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
+    dc->thumb = FIELD_EX32(tb_flags, TBFLAG_AM32, THUMB);
+    condexec = FIELD_EX32(tb_flags, TBFLAG_AM32, CONDEXEC);
     dc->condexec_mask = (condexec & 0xf) << 1;
     dc->condexec_cond = condexec >> 4;
+
     core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
     dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
     dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
 #if !defined(CONFIG_USER_ONLY)
     dc->user = (dc->current_el == 0);
 #endif
-    dc->ns = FIELD_EX32(tb_flags, TBFLAG_A32, NS);
     dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
-    dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
-    dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
-    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-        dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
-        dc->vec_stride = 0;
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        dc->vfp_enabled = 1;
+        dc->be_data = MO_TE;
+        dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_M32, HANDLER);
+        dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+            regime_is_secure(env, dc->mmu_idx);
+        dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_M32, STACKCHECK);
+        dc->v8m_fpccr_s_wrong =
+            FIELD_EX32(tb_flags, TBFLAG_M32, FPCCR_S_WRONG);
+        dc->v7m_new_fp_ctxt_needed =
+            FIELD_EX32(tb_flags, TBFLAG_M32, NEW_FP_CTXT_NEEDED);
+        dc->v7m_lspact = FIELD_EX32(tb_flags, TBFLAG_M32, LSPACT);
     } else {
-        dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
-        dc->c15_cpar = 0;
+        dc->be_data =
+            FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
+        dc->debug_target_el =
+            FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
+        dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
+        dc->ns = FIELD_EX32(tb_flags, TBFLAG_A32, NS);
+        dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
+        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+            dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
+        } else {
+            dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
+            dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
+        }
     }
-    dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_A32, HANDLER);
-    dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-        regime_is_secure(env, dc->mmu_idx);
-    dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
-    dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
-    dc->v7m_new_fp_ctxt_needed =
-        FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
-    dc->v7m_lspact = FIELD_EX32(tb_flags, TBFLAG_A32, LSPACT);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
@@ -10893,9 +10902,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->ss_active = FIELD_EX32(tb_flags, TBFLAG_ANY, SS_ACTIVE);
     dc->pstate_ss = FIELD_EX32(tb_flags, TBFLAG_ANY, PSTATE_SS);
     dc->is_ldex = false;
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        dc->debug_target_el = FIELD_EX32(tb_flags, TBFLAG_ANY, DEBUG_TARGET_EL);
-    }
 
     dc->page_start = dc->base.pc_first & TARGET_PAGE_MASK;
 
@@ -11332,10 +11338,10 @@ static const TranslatorOps thumb_translator_ops = {
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
-    DisasContext dc;
+    DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
 
-    if (FIELD_EX32(tb->flags, TBFLAG_A32, THUMB)) {
+    if (FIELD_EX32(tb->flags, TBFLAG_AM32, THUMB)) {
         ops = &thumb_translator_ops;
     }
 #ifdef TARGET_AARCH64
-- 
2.17.1


