Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD4C0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9C62147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td4dCOby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9C62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hun01-0007rK-3D
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1humyZ-0003x7-GF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1humyW-0008ED-Px
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:15 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1humyW-0008Dl-Hs
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:12 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so40529940pgp.12
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q3fMzXTaQgWcqA1jzonJJWI6KonpSOhpHjOAjFnriUA=;
 b=Td4dCObyB69MfMWp17LHApSABP0W0K4ZGlODyP4AmFxjtqmrTvO67Ruz5m4Q6DONd8
 7BjOREVdhEvqq1JMYGAHLq0eA88cEmuBlFRiqdfapooPJbFLRRL/gVyl9PTbLsMAl/L+
 MBD0+P1dunAy67o4plvvXMbZAMGZp8FDDbf1B3efhhvNHJWk82sr8blyEXY/WsE8RvgW
 yFqecIcPi/3ukofzCYO8k1U8v4pJRJpeDQ3m32t7srv5iVtZoU9u/CdLZuamxyOg9RE5
 Q4maoKamugRV/7K/zzxm8LCX37AvlQFuPTRp44J+nVyfBaMdQTr3YMwmmhrSJU574hPp
 Vp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q3fMzXTaQgWcqA1jzonJJWI6KonpSOhpHjOAjFnriUA=;
 b=iFvbHXz/spIVlleylT5IyOivTqkL6EDr43zL96cysZTB4vjERh0TOEx84AhMP/1AKl
 xDBbasfoIoEz7bu8NkwrZGaK/2L0KHGrbsH4ipysx/muvF680Zt/Lo24ayJbyZ2OLctK
 f1GrlYR2r7X12YMFCcCRzsFNNIaUYaSGu38ly8YUvmgfDpkdwJSgb7FRuwSNe61OeiDv
 oknbjL27QupIyZWd0FnUi2Y1Cb6c5IqJgxhtEfe3xmO/9dE3StN4ErPWt4TeyBL4I7SJ
 YgJQfbA0d1GDwQaZSDkHQ8wEICubA7KjmJ1BPX+wEBLEpuhlMkxHWDo1A9hxXyZIAhcc
 HPyQ==
X-Gm-Message-State: APjAAAXiz87bdVN/WB5qybZjr8WYIDUEkjrM+8nNYsSLSaRjN6TXPbjt
 RvciGvyQ/rvp/hWV5wPPwSt33hrPQ3o=
X-Google-Smtp-Source: APXvYqy15pBDDKVn44OMS433RMZ0bY22N9aG0EQBsJXpYq+y95Ecv9Ozn3QzGE61T6/7zxS0SguzGA==
X-Received: by 2002:a17:90a:8591:: with SMTP id
 m17mr309706pjn.100.1565049910997; 
 Mon, 05 Aug 2019 17:05:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i3sm92149782pfo.138.2019.08.05.17.05.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 17:05:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:05:04 -0700
Message-Id: <20190806000506.10833-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806000506.10833-1-richard.henderson@linaro.org>
References: <20190806000506.10833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 1/3] target/arm: Split out recompute_hflags
 et al
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

Create functions to compute the values of the a64 and a32 hflags,
as well as one to compute the values that are shared between them.
For now, the env->hflags variable is not used, and the results are
fed back to cpu_get_tb_cpu_state.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Do not cache VECLEN, VECSTRIDE, VFPEN.
    Move HANDLER and STACKCHECK to rebuild_hflags_a32.
v4: Do not cache XSCALE_CPAR now that it overlaps VECSTRIDE.
---
 target/arm/cpu.h       |  35 +++--
 target/arm/helper.h    |   3 +
 target/arm/internals.h |   3 +
 target/arm/helper.c    | 322 ++++++++++++++++++++++++-----------------
 4 files changed, 218 insertions(+), 145 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddb..c13633e6a0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -231,6 +231,9 @@ typedef struct CPUARMState {
     uint32_t pstate;
     uint32_t aarch64; /* 1 if CPU is in aarch64 state; inverse of PSTATE.nRW */
 
+    /* Cached TBFLAGS state.  See below for which bits are included.  */
+    uint32_t hflags;
+
     /* Frequently accessed CPSR bits are stored separately for efficiency.
        This contains all the other bits.  Use cpsr_{read,write} to access
        the whole CPSR.  */
@@ -3130,27 +3133,31 @@ typedef ARMCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
-/* Bit usage in the TB flags field: bit 31 indicates whether we are
+/*
+ * Bit usage in the TB flags field: bit 31 indicates whether we are
  * in 32 or 64 bit mode. The meaning of the other bits depends on that.
  * We put flags which are shared between 32 and 64 bit mode at the top
  * of the word, and flags which apply to only one mode at the bottom.
+ *
+ * Unless otherwise noted, these bits are cached in env->hflags.
  */
 FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
 FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
 FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
-FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
+FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 
 /* Bit usage when in AArch32 state: */
-FIELD(TBFLAG_A32, THUMB, 0, 1)
-FIELD(TBFLAG_A32, VECLEN, 1, 3)
-FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
+FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
 /*
  * We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime. This shares the same bits as
  * VECSTRIDE, which is OK as no XScale CPU has VFP.
+ * Not cached, because VECLEN+VECSTRIDE are not cached.
  */
 FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
 /*
@@ -3159,15 +3166,15 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
  * the same thing as the current security state of the processor!
  */
 FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)
-FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
+FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* For M profile only, set if FPCCR.LSPACT is set */
-FIELD(TBFLAG_A32, LSPACT, 18, 1)
+FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
 /* For M profile only, set if we must create a new FP context */
-FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1)
+FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
 /* For M profile only, set if FPCCR.S does not match current security state */
-FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
+FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
@@ -3179,7 +3186,7 @@ FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
 FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
-FIELD(TBFLAG_A64, BTYPE, 10, 2)
+FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 
 static inline bool bswap_code(bool sctlr_b)
@@ -3264,6 +3271,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
 
+/**
+ * arm_rebuild_hflags:
+ * Rebuild the cached TBFLAGS for arbitrary changed processor state.
+ */
+void arm_rebuild_hflags(CPUARMState *env);
+
 /**
  * aa32_vfp_dreg:
  * Return a pointer to the Dn register within env in 32-bit mode.
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e..3919acbe63 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -91,6 +91,9 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
 DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
+DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, i32)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d963875..db6f010798 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -992,6 +992,9 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
+uint32_t rebuild_hflags_a32(CPUARMState *env, int el);
+uint32_t rebuild_hflags_a64(CPUARMState *env, int el);
+
 static inline int exception_target_el(CPUARMState *env)
 {
     int target_el = MAX(1, arm_current_el(env));
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc..43b7c41f11 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11013,165 +11013,219 @@ ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
-                          target_ulong *cs_base, uint32_t *pflags)
+static uint32_t common_hflags(CPUARMState *env, int el, ARMMMUIdx mmu_idx,
+                              int fp_el, uint32_t flags)
 {
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    int current_el = arm_current_el(env);
-    int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
-
-    if (is_a64(env)) {
-        ARMCPU *cpu = env_archcpu(env);
-        uint64_t sctlr;
-
-        *pc = env->pc;
-        flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
-
-        /* Get control bits for tagged addresses.  */
-        {
-            ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-            ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
-
-            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-            if (regime_el(env, stage1) < 2) {
-                ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-                tbid = (p1.tbi << 1) | p0.tbi;
-                tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-            } else {
-                tbid = p0.tbi;
-                tbii = tbid & !p0.tbid;
-            }
-
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
-            flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-        }
-
-        if (cpu_isar_feature(aa64_sve, cpu)) {
-            int sve_el = sve_exception_el(env, current_el);
-            uint32_t zcr_len;
-
-            /* If SVE is disabled, but FP is enabled,
-             * then the effective len is 0.
-             */
-            if (sve_el != 0 && fp_el == 0) {
-                zcr_len = 0;
-            } else {
-                zcr_len = sve_zcr_len_for_el(env, current_el);
-            }
-            flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
-            flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
-        }
-
-        sctlr = arm_sctlr(env, current_el);
-
-        if (cpu_isar_feature(aa64_pauth, cpu)) {
-            /*
-             * In order to save space in flags, we record only whether
-             * pauth is "inactive", meaning all insns are implemented as
-             * a nop, or "active" when some action must be performed.
-             * The decision of which action to take is left to a helper.
-             */
-            if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
-            }
-        }
-
-        if (cpu_isar_feature(aa64_bti, cpu)) {
-            /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
-            if (sctlr & (current_el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
-                flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
-            }
-            flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-        }
-    } else {
-        *pc = env->regs[15];
-        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
-        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-        }
-        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
-        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32,
-                               XSCALE_CPAR, env->cp15.c15_cpar);
-        }
-    }
-
-    flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
-
-    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-     * states defined in the ARM ARM for software singlestep:
-     *  SS_ACTIVE   PSTATE.SS   State
-     *     0            x       Inactive (the TB flag for SS is always 0)
-     *     1            0       Active-pending
-     *     1            1       Active-not-pending
-     */
-    if (arm_singlestep_active(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
-        if (is_a64(env)) {
-            if (env->pstate & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        } else {
-            if (env->uncached_cpsr & PSTATE_SS) {
-                flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
-            }
-        }
-    }
+    flags = FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
+    flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX,
+                       arm_to_core_mmu_idx(mmu_idx));
     if (arm_cpu_data_is_big_endian(env)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
     }
-    flags = FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
+    if (arm_singlestep_active(env)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
+    }
+    return flags;
+}
+
+uint32_t rebuild_hflags_a32(CPUARMState *env, int el)
+{
+    uint32_t flags = 0;
+    ARMMMUIdx mmu_idx;
+    int fp_el;
+
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
 
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
 
-    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
-     * suppressing them because the requested execution priority is less than 0.
+    mmu_idx = arm_mmu_idx(env);
+
+    /*
+     * v8M always applies stack limit checks unless CCR.STKOFHFNMIGN
+     * is suppressing them because the requested execution priority
+     * is less than 0.
      */
     if (arm_feature(env, ARM_FEATURE_V8) &&
         arm_feature(env, ARM_FEATURE_M) &&
-        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
+        !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
           (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
         flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
     }
 
-    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+    fp_el = fp_exception_el(env, el);
+    return common_hflags(env, el, mmu_idx, fp_el, flags);
+}
+
+uint32_t rebuild_hflags_a64(CPUARMState *env, int el)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
+    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    int fp_el = fp_exception_el(env, el);
+    uint32_t flags = 0;
+    uint64_t sctlr;
+    int tbii, tbid;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
+
+    /* Get control bits for tagged addresses.  */
+    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+    if (regime_el(env, stage1) < 2) {
+        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
+        tbid = (p1.tbi << 1) | p0.tbi;
+        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
+    } else {
+        tbid = p0.tbi;
+        tbii = tbid & !p0.tbid;
     }
 
-    if (arm_feature(env, ARM_FEATURE_M) &&
-        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
-        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
-         (env->v7m.secure &&
-          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
-        /*
-         * ASPEN is set, but FPCA/SFPA indicate that there is no active
-         * FP context; we must create a new FP context before executing
-         * any FP insn.
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
+    flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
+
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        int sve_el = sve_exception_el(env, el);
+        uint32_t zcr_len;
+
+        /* If SVE is disabled, but FP is enabled,
+         * then the effective len is 0.
          */
-        flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+        if (sve_el != 0 && fp_el == 0) {
+            zcr_len = 0;
+        } else {
+            zcr_len = sve_zcr_len_for_el(env, el);
+        }
+        flags = FIELD_DP32(flags, TBFLAG_A64, SVEEXC_EL, sve_el);
+        flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
     }
 
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
-
-        if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+    if (el == 0) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        sctlr = env->cp15.sctlr_el[1];
+    } else {
+        sctlr = env->cp15.sctlr_el[el];
+    }
+    if (cpu_isar_feature(aa64_pauth, cpu)) {
+        /*
+         * In order to save space in flags, we record only whether
+         * pauth is "inactive", meaning all insns are implemented as
+         * a nop, or "active" when some action must be performed.
+         * The decision of which action to take is left to a helper.
+         */
+        if (sctlr & (SCTLR_EnIA | SCTLR_EnIB | SCTLR_EnDA | SCTLR_EnDB)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, PAUTH_ACTIVE, 1);
         }
     }
 
-    *pflags = flags;
+    if (cpu_isar_feature(aa64_bti, cpu)) {
+        /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
+        if (sctlr & (el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
+        }
+    }
+
+    return common_hflags(env, el, mmu_idx, fp_el, flags);
+}
+
+void arm_rebuild_hflags(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    env->hflags = (is_a64(env)
+                   ? rebuild_hflags_a64(env, el)
+                   : rebuild_hflags_a32(env, el));
+}
+
+void HELPER(rebuild_hflags_a32)(CPUARMState *env, uint32_t el)
+{
+    tcg_debug_assert(!is_a64(env));
+    env->hflags = rebuild_hflags_a32(env, el);
+}
+
+void HELPER(rebuild_hflags_a64)(CPUARMState *env, uint32_t el)
+{
+    tcg_debug_assert(is_a64(env));
+    env->hflags = rebuild_hflags_a64(env, el);
+}
+
+void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
+                          target_ulong *cs_base, uint32_t *pflags)
+{
+    int current_el = arm_current_el(env);
+    uint32_t flags;
+    uint32_t pstate_for_ss;
+
     *cs_base = 0;
+    if (is_a64(env)) {
+        *pc = env->pc;
+        flags = rebuild_hflags_a64(env, current_el);
+        flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
+        pstate_for_ss = env->pstate;
+    } else {
+        *pc = env->regs[15];
+        flags = rebuild_hflags_a32(env, current_el);
+        flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
+        flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
+        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
+        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+            flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR,
+                               env->cp15.c15_cpar);
+        } else {
+            flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
+            flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
+                               env->vfp.vec_stride);
+        }
+        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
+            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
+            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+        }
+
+        /* TODO: Perhaps cache these bits too?  */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
+                != env->v7m.secure) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+            }
+
+            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+                 (env->v7m.secure &&
+                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+                /*
+                 * ASPEN is set, but FPCA/SFPA indicate that there is no
+                 * active FP context; we must create a new FP context
+                 * before executing any FP insn.
+                 */
+                flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+            }
+
+            bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+            }
+        }
+
+        pstate_for_ss = env->uncached_cpsr;
+    }
+
+    /*
+     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
+     * states defined in the ARM ARM for software singlestep:
+     *  SS_ACTIVE   PSTATE.SS   State
+     *     0            x       Inactive (the TB flag for SS is always 0)
+     *     1            0       Active-pending
+     *     1            1       Active-not-pending
+     * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
+     */
+    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)
+        && (pstate_for_ss & PSTATE_SS)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
+    }
+
+    *pflags = flags;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.17.1


