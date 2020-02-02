Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02DDC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8896320658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJ0m8RND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8896320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3nb-0007zC-Pa
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h7-0003sD-4z
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h5-0002IR-P5
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:01 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3h5-0002FD-IN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: by mail-pf1-x442.google.com with SMTP id 84so5526471pfy.6
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xC4Xxk2IMOJbSiLn0Ct8GHjNAdWvn3ZYodeP0ZE4BIc=;
 b=qJ0m8RND6J49V6WyTN9F8sOrTXj4Mn74tmtzVQzSKgVKJuVoKcGCk6RJKvgU1iU58Q
 yMMkKBsosYqs9/yD53n0zfxOreO3O/OUXCUTcAQn/WoqgU4/lJrpRYsrghGrug8OTJML
 JhRijioW+O9wIwI4bb9M3SNWMFe0/cgkzeiHSdRwsQN4SUT5giWD1pxp2FktkTvmsdo6
 q9bj7URQKsD4c2KeCIQD4yAdCvfjoOatPHnBdQI7fKhCyKFINq9/RI5thu+bLT3x/+zf
 9pibnRBdyjHiN6HNZrO2U/1kcoETjLMI2IBhUQBc79Wm+hpo/7AjOSE4m8ynzIIG/p95
 xw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xC4Xxk2IMOJbSiLn0Ct8GHjNAdWvn3ZYodeP0ZE4BIc=;
 b=XCz9eI4ijOOuucFePIKXe7WXWXyKTM/PpxmRbpMDYeWEMZNNSnuUAZNVGjDaaTv3m+
 IBp8WFGaQ3ZTnQ3k1Avqc3XmzuvGyHqATeab6qHqyxfzM/9/TLMqUyv1a4tHHYT/udll
 3bPDT+s5a/nRvpI24jyw9+4CJkAaHb+5nF/E/BZi+I5lbx0VKI/4j0z7gROCWpTrs/OQ
 BEH7QjL7OG2wiQWv5TzCaLTCpv9vy7D415Jr1+sj+fjH3UHOgexFlpKv/FwQNleU7INA
 EObs+eSWBZ7RmRNPBBXpcic9Lt8sFeYAazcloLj1wCAHXnzxPfnXQidegyHkzmc2BG8j
 oNQA==
X-Gm-Message-State: APjAAAWGuQ7dQ578BWR5yiPeDcqo/BQ/W0KpbY5W4q+GMI7YHv0aj1dK
 qDAGePgMFSOFJYwl4aiCl5ZZU16VKPQ=
X-Google-Smtp-Source: APXvYqzYu12ZsUV0LXflVGzHueHPlkO1WIICtLX/VZXNQ9bbQNuDKv+fMn5/WwuQmRt1AlRyq+XogA==
X-Received: by 2002:a63:234f:: with SMTP id u15mr17836020pgm.88.1580605495952; 
 Sat, 01 Feb 2020 17:04:55 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] target/arm: Update MSR access to UAO
Date: Sat,  1 Feb 2020 17:04:37 -0800
Message-Id: <20200202010439.6410-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move reginfo to file scope; avoid setting uao from spsr
    when the feature is not enabled (pmm).
---
 target/arm/cpu.h           |  6 ++++++
 target/arm/helper-a64.c    |  3 +++
 target/arm/helper.c        | 21 +++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a6a8f74be8..a0ac70e0fb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1266,6 +1266,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
 #define PSTATE_PAN (1U << 22)
+#define PSTATE_UAO (1U << 23)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3655,6 +3656,11 @@ static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
 }
 
+static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 70d6407f80..9dda94644f 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1037,6 +1037,9 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         if (!cpu_isar_feature(aa64_pan, env_archcpu(env))) {
             spsr &= ~PSTATE_PAN;
         }
+        if (!cpu_isar_feature(aa64_uao, env_archcpu(env))) {
+            spsr &= ~PSTATE_UAO;
+        }
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a48f37dc05..d847b0f40b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4191,6 +4191,24 @@ static const ARMCPRegInfo pan_reginfo = {
     .readfn = aa64_pan_read, .writefn = aa64_pan_write
 };
 
+static uint64_t aa64_uao_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return env->pstate & PSTATE_UAO;
+}
+
+static void aa64_uao_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    env->pstate = (env->pstate & ~PSTATE_UAO) | (value & PSTATE_UAO);
+}
+
+static const ARMCPRegInfo uao_reginfo = {
+    .name = "UAO", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 4,
+    .type = ARM_CP_NO_RAW, .access = PL1_RW,
+    .readfn = aa64_uao_read, .writefn = aa64_uao_write
+};
+
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7673,6 +7691,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, ats1cp_reginfo);
     }
 #endif
+    if (cpu_isar_feature(aa64_uao, cpu)) {
+        define_one_arm_cp_reg(cpu, &uao_reginfo);
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d8ba240a15..7c26c3bfeb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1602,6 +1602,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
         s->base.is_jmp = DISAS_NEXT;
         break;
 
+    case 0x03: /* UAO */
+        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
+            goto do_unallocated;
+        }
+        if (crm & 1) {
+            set_pstate_bits(PSTATE_UAO);
+        } else {
+            clear_pstate_bits(PSTATE_UAO);
+        }
+        t1 = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, t1);
+        tcg_temp_free_i32(t1);
+        break;
+
     case 0x04: /* PAN */
         if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
             goto do_unallocated;
-- 
2.20.1


