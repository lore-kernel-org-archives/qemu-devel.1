Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D0C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D492B20658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYIJxZNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D492B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3jH-0008NW-VF
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gw-0003Y2-Ep
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gu-0001zy-QX
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:50 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:56040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gu-0001yJ-K3
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:48 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so4655292pjz.5
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dN7CvXa72imyZeXEO8CPZOnz+QzApICtq/G6FJy1z4=;
 b=ZYIJxZNMn+Cuf/SgOVYrAv6nGy7xOv59j1lQvOh3gjCFiMfLSsyfqMsDH191JkIAyq
 IjyXrIBhQG99B+pMY6NZp5lUjjQhxdYXdt+ZeSCddtWcXAbsuSrqpEOr79ppLvPop0fK
 QdKtPiD+u7f9o80enhcXh0gJyQEvfMsRtRUlo0YQsq5+X9Wh7ccBjyfBGz9168WY0Lzc
 zhyO85q6B2owsMFSaDLoRh7dhlPKyjGdzpH8dOr4A+4NK/aqQGR9z53kIateVLFwVdZS
 MAuWYYuNncUUQ24JGey1NclrMZzoLg/ld4XuY+c+1GOzj7NOh98BvKYj8C0Ufh23jUEw
 LQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dN7CvXa72imyZeXEO8CPZOnz+QzApICtq/G6FJy1z4=;
 b=DW3CEbhQWMTPmcwmZxiaGBxo/weU6XZZS5EbqDWxNp/WPFycfsWFp3hSKOLcRlNNqb
 vNbTbUZ6yK7KeN+oyxXGvnC2CN6RSG65JxmCk1BbdKX6VRVqqBbJlKm4rcf0lnQPIEFO
 1iGkuBIf6pMOqXvwuWvi1sTgD0OBoT42t9KP+nj7yxPqN9Nk3wIVy8mXfjZpYRH80Qhd
 kdQG2ZjDtVapy3XQNiyZKXjUd2qOAM/iA2N1omgGTympXnhN2hvAPUGuPxjpahHwBTSn
 QGRBp1SnuVt1dpRWnEskDR0xrZUl9NQFbdXr1HK8Ypc2zNd3sl6gJGG6xoCRDh/9t0Fr
 kyng==
X-Gm-Message-State: APjAAAW9bJAnSi/lTIudJhwAC3FuvtvyIBHhcZuJqm9bIozmNm6jwkDL
 pHCg6hOB4iHjT4jkeR4NHqTTrhP/Szc=
X-Google-Smtp-Source: APXvYqxfUYg7SFsKjXO1kmeDV7bOfh9f0RF+Npxr1zOHRm86voNIa8n/uGBo9m+DeS7wD/5PfWPR7g==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id
 h5mr21250636pjs.79.1580605487261; 
 Sat, 01 Feb 2020 17:04:47 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/14] target/arm: Update MSR access for PAN
Date: Sat,  1 Feb 2020 17:04:30 -0800
Message-Id: <20200202010439.6410-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For aarch64, there's a dedicated msr (imm, reg) insn.
For aarch32, this is done via msr to cpsr; and writes
from el0 are ignored.

Since v8.0, the CPSR_RESERVED bits have been allocated.
We are not yet implementing ARMv8.0-SSBS or ARMv8.4-DIT,
so retain CPSR_RESERVED for now, so that the bits remain RES0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move regdef to file scope; merge patch for CPSR_RESERVED:
    do not remove CPSR_SSBS from CPSR_RESERVED yet, mask PAN
    from CPSR if feature not enabled (pmm).
---
 target/arm/cpu.h           | 11 +++++++++--
 target/arm/helper-a64.c    |  6 ++++++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/op_helper.c     |  9 ++++++++-
 target/arm/translate-a64.c | 14 ++++++++++++++
 target/arm/translate.c     |  6 +++++-
 6 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08b2f5d73e..b11fdc3001 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1186,12 +1186,18 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
-/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
+/*
+ * Note that the RESERVED bits include bit 21, which is PSTATE_SS in
  * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
  * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
  * where it is live state but not accessible to the AArch32 code.
+ *
+ * TODO: With ARMv8.4-DIT, bit 21 is DIT in AArch32 (bit 24 for AArch64).
+ * We will need to move AArch32 SS somewhere else at that point.
+ * TODO: With ARMv8.0-SSBS, bit 23 is SSBS in AArch32 (bit 12 for AArch64).
  */
-#define CPSR_RESERVED (0x7U << 21)
+#define CPSR_RESERVED (5U << 21)
+#define CPSR_PAN (1U << 22)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
@@ -1258,6 +1264,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_PAN (1U << 22)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bf45f8a785..70d6407f80 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1014,6 +1014,9 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
          * will sort the register banks out for us, and we've already
          * caught all the bad-mode cases in el_from_spsr().
          */
+        if (!cpu_isar_feature(aa32_pan, env_archcpu(env))) {
+            spsr &= ~CPSR_PAN;
+        }
         cpsr_write(env, spsr, ~0, CPSRWriteRaw);
         if (!arm_singlestep_active(env)) {
             env->uncached_cpsr &= ~PSTATE_SS;
@@ -1031,6 +1034,9 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
                       cur_el, new_el, env->regs[15]);
     } else {
         env->aarch64 = 1;
+        if (!cpu_isar_feature(aa64_pan, env_archcpu(env))) {
+            spsr &= ~PSTATE_PAN;
+        }
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 795ef727d0..90a22921dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4163,6 +4163,24 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->daif = value & PSTATE_DAIF;
 }
 
+static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_PAN;
+}
+
+static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    env->pstate = (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
+}
+
+static const ARMCPRegInfo pan_reginfo = {
+    .name = "PAN", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 3,
+    .type = ARM_CP_NO_RAW, .access = PL1_RW,
+    .readfn = aa64_pan_read, .writefn = aa64_pan_write
+};
+
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7608,6 +7626,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_lor, cpu)) {
         define_arm_cp_regs(cpu, lor_reginfo);
     }
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        define_one_arm_cp_reg(cpu, &pan_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 27d16ad9ad..7ba578e826 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -400,11 +400,18 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    uint32_t mask;
+
     qemu_mutex_lock_iothread();
     arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
-    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
+    mask = CPSR_ERET_MASK;
+    if (!cpu_isar_feature(aa32_pan, env_archcpu(env))) {
+        mask &= ~CPSR_PAN;
+    }
+
+    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49631c2340..d8ba240a15 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1602,6 +1602,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_NEXT;
         break;
 
+    case 0x04: /* PAN */
+        if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_PAN);
+        } else {
+            clear_pstate_bits(PSTATE_PAN);
+        }
+        t1 = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        break;
+
     case 0x05: /* SPSel */
         if (s->current_el == 0) {
             goto do_unallocated;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d58c328e08..0b1f0e0fea 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2760,13 +2760,17 @@ static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
     if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
         mask &= ~CPSR_IT;
     }
+    if (!dc_isar_feature(aa32_pan, s)) {
+        mask &= ~CPSR_PAN;
+    }
     /* Mask out execution state and reserved bits.  */
     if (!spsr) {
         mask &= ~(CPSR_EXEC | CPSR_RESERVED);
     }
     /* Mask out privileged bits.  */
-    if (IS_USER(s))
+    if (IS_USER(s)) {
         mask &= CPSR_USER;
+    }
     return mask;
 }
 
-- 
2.20.1


