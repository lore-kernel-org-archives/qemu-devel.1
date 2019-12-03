Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D40C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF0C2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRh6x+Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF0C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHWi-0002H6-NN
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3R-0002fA-I6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3H-0006dN-Bc
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:56 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3A-0006Wb-FO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:44 -0500
Received: by mail-pl1-x641.google.com with SMTP id k20so2268231pll.13
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9AspWquiqmrjmokhsjjXAIAYddZO8ijvxyMTH0rKsT4=;
 b=TRh6x+GxhqCDb8UUvIybqVpfm0N1XLS/bBqzZZvb+XYzetMcaNvXmq9AhE5q7QVkrf
 Hy76zd/nVEaeq3IDtdmwSFKXd49YAezuKD97ShCEiN/e6C9nDVQIWspWwMfUT3KJD1Xn
 dS3GKRk2wEgRK+FYP+Dw1aoJnbwM+znVoOnPDzg8eyq6P9Pmcp2LggGXUjE2uJXeQDf4
 AHs58DWiTxnEJwu/uhGLeTGVju6gburY7S/zINoPhaI+ONw72XD/LL5ppK+qH2jVqC83
 NCI65qjq63kEq+9NhQnSq6tNvGO84jHLG+Bn2OTv/mIXSXhsfjjgkx7g27LaikN2e6pj
 LlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9AspWquiqmrjmokhsjjXAIAYddZO8ijvxyMTH0rKsT4=;
 b=MBl8HhKs69a47bZkc7tb+vXlRIHQnsyA5zKIS2DmmuWSeiAB7aYo52rTegW1m8DSbA
 ZJgNOQDO0072WIEZvHS0TTnzMkhCDBeBuQJclyaZh5Df+ahCB9lwbViXLUjvKdWJD52P
 Jvziww6msHlEjGfYsS4KPKGp1aJjcyEY0Ot0zeJjdPw1MQ5iwfaxBgmy+pJAxGlLU9LL
 tRoBkJ+o71IEyPHiqrsavXSM4X9/5GYD82bIRO1saEHtJ4elGQNk3QlaRYdEE+Q2MEP+
 psLCbsoD97FwEggUwTUNClDyjecw+s0HCItDRSH4N6RY6ga7UldhCDmdAjqomFFsg/I6
 RxeA==
X-Gm-Message-State: APjAAAVRt17rPHXjBFzYi79YUOrzN31fa1KzPqgMH44cqpihrqwYmJqd
 Y1iXw5+VaQYc+05acvJYXSaX6K2YimU=
X-Google-Smtp-Source: APXvYqxSM55ZsmKw6xGoNdwrlm50u45BNK5tlpteDRGvldW+jBNBz5K2LHi+P+L2XAkotvfxAvx8NQ==
X-Received: by 2002:a17:902:a502:: with SMTP id
 s2mr325104plq.327.1575413622675; 
 Tue, 03 Dec 2019 14:53:42 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] target/arm: Update MSR access for PAN
Date: Tue,  3 Dec 2019 14:53:28 -0800
Message-Id: <20191203225333.17055-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

For aarch64, there's a dedicated msr (imm, reg) insn.
For aarch32, this is done via msr to cpsr; and writes
from el0 are ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  2 ++
 target/arm/helper.c        | 22 ++++++++++++++++++++++
 target/arm/translate-a64.c | 14 ++++++++++++++
 target/arm/translate.c     |  4 ++++
 4 files changed, 42 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 170dd5b124..f0e61bf34f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1159,6 +1159,7 @@ void pmu_init(ARMCPU *cpu);
  * We will need to move AArch32 SS somewhere else at that point.
  */
 #define CPSR_RESERVED (1U << 21)
+#define CPSR_PAN (1U << 22)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
@@ -1225,6 +1226,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_PAN (1U << 22)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4e3fe00316..512be5c644 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4112,6 +4112,17 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
 static CPAccessResult aa64_cacheop_access(CPUARMState *env,
                                           const ARMCPRegInfo *ri,
                                           bool isread)
@@ -7405,6 +7416,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
+    if (cpu_isar_feature(aa64_pan, cpu)) {
+        static const ARMCPRegInfo pan_reginfo[] = {
+            { .name = "PAN", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 2, .opc2 = 3,
+              .type = ARM_CP_NO_RAW, .access = PL1_RW,
+              .readfn = aa64_pan_read, .writefn = aa64_pan_write, },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, pan_reginfo);
+    }
+
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         static const ARMCPRegInfo vhe_reginfo[] = {
             { .name = "CONTEXTIDR_EL2", .state = ARM_CP_STATE_AA64,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b5c7bc2d76..7f5a68106b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1601,6 +1601,20 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
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
index 47a374b53d..98e6072dd4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2785,6 +2785,10 @@ static int gen_set_psr(DisasContext *s, uint32_t mask, int spsr, TCGv_i32 t0)
         tcg_gen_or_i32(tmp, tmp, t0);
         store_cpu_field(tmp, spsr);
     } else {
+        /* Data writes to CPSR.PAN using an MSR insn at EL0 are ignored.  */
+        if (IS_USER(s)) {
+            mask &= ~CPSR_PAN;
+        }
         gen_set_cpsr(t0, mask);
     }
     tcg_temp_free_i32(t0);
-- 
2.17.1


