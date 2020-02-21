Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E8C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1D0208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="isA+TSRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D0208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Tv-0001Ma-Qs
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582u-00006a-W1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582s-0003zq-Rs
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582s-0003xG-Jp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a5so1737089wmb.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XOZCmV/LRRvs4SHMu0PR/HJGYRQoHyJpDUcGa+N8A1M=;
 b=isA+TSRJrhE5N3Gn0g1afjqJK1oVlwqvlAvqwOje/33xFzxM7ffnwMLivtkYUglIHH
 g29jhUnUqsxSsM39tBfE90jyhWj/WlpIMzrZKl5f3g3EnAWt9Xj/a9xp+KGsM7hFzIpx
 FQPJ1EV1iz0pcJkSPisRLkI/UgK7knwhnlOX1DiRPLXN9ggkYOBOvuQeGORdOvYyREKv
 2qu/+yAd3BeMp7VwmRxSin2wIzpqNei+y6dW1Rn098tDMmu41rpHVqXrgmv3L8EiiBXE
 SS4CTmFbUpu9894Zhi5aFD/6AwNyxfgulP8e/hSea0eevLFc5qHhKaRV/39eaeu2A12I
 wWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XOZCmV/LRRvs4SHMu0PR/HJGYRQoHyJpDUcGa+N8A1M=;
 b=eU0/OwnWEspL0ZMVZKkYPUFeUhYDGKhF0oikfICRhOUUuxpiuukxENe0ObVSz+M9D1
 Wbc8KHqj6p019m5y58xJU1hlVuEvC3xno9ZQK2QojmOPd9Tf6xDHL2vcRUX8UFVNNEsG
 93tmTsqVq6kypGSoxgJCCnrz5w2pxtVcCs+RjJDRWtF6690LHFPyf7/axPQWCoQV7WWN
 KT8ex5X/mSogZd3jtv6CcFDmGi+qmtXAxossYOO0oN0rRZiDJr6Oi1PgyCTLm9Z89RaF
 EpV0A1ff/QGA2a3m2gEwXDqJ6d+rc0tC62Cp88qEPVAA5hVmRQPhlEXMZzwpYnPeaaTq
 ASww==
X-Gm-Message-State: APjAAAVjOOEbq8EopgGNH+usk/pixY/uFjnG3ZYJ1rlA2WslmjecR/H7
 dyDnZoJq5lg4JlOURo28ErMUKVY+2QuDmQ==
X-Google-Smtp-Source: APXvYqx9kRK75/VCGAm/UsL8eY4aF860uIm5SFFKgnRzwFcESiyzGluw7BPNpDLCPuiIufDVJE+M6g==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3621569wmg.63.1582290519919; 
 Fri, 21 Feb 2020 05:08:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/52] target/arm: Add isar_feature_aa32_simd_r16
Date: Fri, 21 Feb 2020 13:07:35 +0000
Message-Id: <20200221130740.7583-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use this in the places that were checking ARM_FEATURE_VFP, and
are obviously testing for the existance of the register set
as opposed to testing for some particular instruction extension.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  6 ++++++
 hw/intc/armv7m_nvic.c   | 20 ++++++++++----------
 linux-user/arm/signal.c |  4 ++--
 target/arm/arch_dump.c  | 11 ++++++-----
 target/arm/cpu.c        |  8 ++++----
 target/arm/helper.c     |  4 ++--
 target/arm/m_helper.c   | 11 ++++++-----
 target/arm/machine.c    |  3 +--
 8 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65171cb30ee..5a62586dd29 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3450,6 +3450,12 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+static inline bool isar_feature_aa32_simd_r16(const ARMISARegisters *id)
+{
+    /* Return true if D0-D15 are implemented */
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
+}
+
 static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 22a43e49847..78cde4ed237 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1262,12 +1262,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
     case 0xd88: /* CPACR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.cpacr[attrs.secure];
     case 0xd8c: /* NSACR */
-        if (!attrs.secure || !arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!attrs.secure || !cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.nsacr;
@@ -1417,7 +1417,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return cpu->env.v7m.sfar;
     case 0xf34: /* FPCCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         if (attrs.secure) {
@@ -1444,12 +1444,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
             return value;
         }
     case 0xf38: /* FPCAR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpcar[attrs.secure];
     case 0xf3c: /* FPDSCR */
-        if (!arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             return 0;
         }
         return cpu->env.v7m.fpdscr[attrs.secure];
@@ -1711,13 +1711,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xd88: /* CPACR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.cpacr[attrs.secure] = value & (0xf << 20);
         }
         break;
     case 0xd8c: /* NSACR */
-        if (attrs.secure && arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (attrs.secure && cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* We implement only the Floating Point extension's CP10/CP11 */
             cpu->env.v7m.nsacr = value & (3 << 10);
         }
@@ -1951,7 +1951,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         break;
     }
     case 0xf34: /* FPCCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             /* Not all bits here are banked. */
             uint32_t fpccr_s;
 
@@ -2005,13 +2005,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         break;
     case 0xf38: /* FPCAR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             value &= ~7;
             cpu->env.v7m.fpcar[attrs.secure] = value;
         }
         break;
     case 0xf3c: /* FPDSCR */
-        if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             value &= 0x07c00000;
             cpu->env.v7m.fpdscr[attrs.secure] = value;
         }
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index b0e753801b6..2871a7cc21d 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -346,7 +346,7 @@ static void setup_sigframe_v2(struct target_ucontext_v2 *uc,
     setup_sigcontext(&uc->tuc_mcontext, env, set->sig[0]);
     /* Save coprocessor signal frame.  */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
         regspace = setup_sigframe_v2_vfp(regspace, env);
     }
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
@@ -671,7 +671,7 @@ static int do_sigframe_return_v2(CPUARMState *env,
 
     /* Restore coprocessor signal frame */
     regspace = uc->tuc_regspace;
-    if (arm_feature(env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
         regspace = restore_sigframe_v2_vfp(env, regspace);
         if (!regspace) {
             return 1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 2345dec3c2c..a5a4f4e1f8f 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -363,9 +363,11 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque)
 {
     struct arm_note note;
-    CPUARMState *env = &ARM_CPU(cs)->env;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     DumpState *s = opaque;
-    int ret, i, fpvalid = !!arm_feature(env, ARM_FEATURE_VFP);
+    int ret, i;
+    bool fpvalid = cpu_isar_feature(aa32_simd_r16, cpu);
 
     arm_note_init(&note, s, "CORE", 5, NT_PRSTATUS, sizeof(note.prstatus));
 
@@ -444,7 +446,6 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
-    CPUARMState *env = &cpu->env;
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -452,12 +453,12 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
 #ifdef TARGET_AARCH64
         if (cpu_isar_feature(aa64_sve, cpu)) {
-            note_size += AARCH64_SVE_NOTE_SIZE(env);
+            note_size += AARCH64_SVE_NOTE_SIZE(&cpu->env);
         }
 #endif
     } else {
         note_size = ARM_PRSTATUS_NOTE_SIZE;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             note_size += ARM_VFP_NOTE_SIZE;
         }
     }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2eadf4dcb8b..d5a75c265ac 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -293,7 +293,7 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
         }
 
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             env->v7m.fpccr[M_REG_NS] = R_V7M_FPCCR_ASPEN_MASK;
             env->v7m.fpccr[M_REG_S] = R_V7M_FPCCR_ASPEN_MASK |
                 R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK;
@@ -1011,7 +1011,7 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         int numvfpregs = 0;
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             numvfpregs = 32;
-        } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+        } else if (cpu_isar_feature(aa32_simd_r16, cpu)) {
             numvfpregs = 16;
         }
         for (i = 0; i < numvfpregs; i++) {
@@ -1260,7 +1260,7 @@ void arm_cpu_post_init(Object *obj)
      * KVM does not currently allow us to lie to the guest about its
      * ID/feature registers, so the guest always sees what the host has.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+    if (cpu_isar_feature(aa32_simd_r16, cpu)) {
         cpu->has_vfp = true;
         if (!kvm_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
@@ -1636,7 +1636,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * We rely on no XScale CPU having VFP so we can use the same bits in the
      * TB flags field for VECSTRIDE and XSCALE_CPAR.
      */
-    assert(!(arm_feature(env, ARM_FEATURE_VFP) &&
+    assert(!(cpu_isar_feature(aa32_simd_r16, cpu) &&
              arm_feature(env, ARM_FEATURE_XSCALE)));
 
     if (arm_feature(env, ARM_FEATURE_V7) &&
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e046..402f9ffab9b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -894,7 +894,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          * ASEDIS [31] and D32DIS [30] are both UNK/SBZP without VFP.
          * TRCDIS [28] is RAZ/WI since we do not implement a trace macrocell.
          */
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
             /* VFP coprocessor: cp10 & cp11 [23:20] */
             mask |= (1 << 31) | (1 << 30) | (0xf << 20);
 
@@ -7814,7 +7814,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  35, "arm-vfp3.xml", 0);
-    } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+    } else if (cpu_isar_feature(aa32_simd_r16, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  19, "arm-vfp.xml", 0);
     }
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 33d414a684b..c0249702212 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -738,7 +738,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
      */
     uint32_t sig = 0xfefa125a;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
+    if (!cpu_isar_feature(aa32_simd_r16, env_archcpu(env))
+        || (lr & R_V7M_EXCRET_FTYPE_MASK)) {
         sig |= 1;
     }
     return sig;
@@ -841,7 +842,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
 
     if (dotailchain) {
         /* Sanitize LR FType and PREFIX bits */
-        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+        if (!cpu_isar_feature(aa32_simd_r16, cpu)) {
             lr |= R_V7M_EXCRET_FTYPE_MASK;
         }
         lr = deposit32(lr, 24, 8, 0xff);
@@ -1373,7 +1374,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     ftype = excret & R_V7M_EXCRET_FTYPE_MASK;
 
-    if (!arm_feature(env, ARM_FEATURE_VFP) && !ftype) {
+    if (!ftype && !cpu_isar_feature(aa32_simd_r16, cpu)) {
         qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero FTYPE in exception "
                       "exit PC value 0x%" PRIx32 " is UNPREDICTABLE "
                       "if FPU not present\n",
@@ -2450,7 +2451,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
              * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
              * RES0 if the FPU is not present, and is stored in the S bank
              */
-            if (arm_feature(env, ARM_FEATURE_VFP) &&
+            if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env)) &&
                 extract32(env->v7m.nsacr, 10, 1)) {
                 env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
                 env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
@@ -2565,7 +2566,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
+        if (cpu_isar_feature(aa32_simd_r16, env_archcpu(env))) {
             /*
              * SFPA is RAZ/WI from NS or if no FPU.
              * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 241890ac8cf..7050bde459a 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,9 +9,8 @@
 static bool vfp_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_VFP);
+    return cpu_isar_feature(aa32_simd_r16, cpu);
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-- 
2.20.1


