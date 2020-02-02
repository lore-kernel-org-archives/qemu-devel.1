Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF434C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EB220658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcHBbJ1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EB220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3ll-0005bG-On
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h0-0003lN-SN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gz-00028q-Jm
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gz-00027m-EL
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id s64so5713281pgb.9
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ABlKw+Ee4niadP/JeYKLANZAwZirqXwkkASseIFrEXM=;
 b=PcHBbJ1RlfITAOyME7zPemx8OjVC2hcpfNOn+1Xk2qkG3u5+vFwVQ83sF7MVTgNsTE
 ulOvnpL3+FnOfjx4sSIjWVRLAyoz4rRANBKt6d8GCOaEDdVKZ+TNWgcIkswmk3kiNTP5
 aVaoy/rHKarILH8ZuD2Yg1EctVn/zeHc3FLEu5Krjx9QklZ1pR8Onei/jTdrdetoTIOo
 GHIDDyhmLr4QFKkgFcuebECb7w6Hjs4LU0c4MP207Z39QH9NirvGrY5fdwtnO+Hdvcz0
 /poePsnJt5RibP7Y4eJYfnae+HNHHbUW+7UjPsvPGH+bIRnu2+r8+IZ1tcdjiGKHINEz
 uSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ABlKw+Ee4niadP/JeYKLANZAwZirqXwkkASseIFrEXM=;
 b=p5IeI5mJaAmdbQ4YQyzcEZxC3b0jtJfntGzut/TOYeFe5j5o3z4rKZzJ1xqLpDmyM5
 vU1KAMSHcMx2AL5ZJ7ZwaWK0V1ZSByXcY9lGwPwWzLl8cHzXQgr36luPjcJqTCtwz7Yw
 PUUwDlLejGB7+oxuSjS4gvx/QSWiDVrsKD8M9CakHQEga0yzcjYCfPdjs1OhJnHbe2E9
 hUleTEj0A1C2SLnXSe+JnRX4iIef1fMkRmeYcz7QbK05+4BEnQ0/qEA5u7mjsVEHT/ek
 RaOK3J6mLC0zMJdUsCBa06tBGxo/p19H7sWGvdkG+n3LjCKerVA9kUMP8obFVu4YL+aF
 WyBA==
X-Gm-Message-State: APjAAAXpCWblGK0QZl4CMVqz8CRHQISeZoZ89LNEhtkCJQPjJKGyA3gf
 /k2aCG9QqFLfpb4Hhq8JqHi2neOcJyE=
X-Google-Smtp-Source: APXvYqxFzNP2rJm3iGS5OjHLFsRYxn3kP8+FLNtIsoBpqvSQNZdgnEnQV9SD6k+yTgrt/E1kpXsKRA==
X-Received: by 2002:a62:8e0a:: with SMTP id k10mr18270835pfe.49.1580605492196; 
 Sat, 01 Feb 2020 17:04:52 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/14] target/arm: Implement ATS1E1 system registers
Date: Sat,  1 Feb 2020 17:04:34 -0800
Message-Id: <20200202010439.6410-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

This is a minor enhancement over ARMv8.1-PAN.
The *_PAN mmu_idx are used with the existing do_ats_write.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Move regdefs to file scope (pmm).
---
 target/arm/helper.c | 56 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4c0eb7e7d9..e69cde801f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3409,16 +3409,21 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
     switch (ri->opc2 & 6) {
     case 0:
-        /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
+        /* stage 1 current state PL1: ATS1CPR, ATS1CPW, ATS1CPRP, ATS1CPWP */
         switch (el) {
         case 3:
             mmu_idx = ARMMMUIdx_SE3;
             break;
         case 2:
-            mmu_idx = ARMMMUIdx_Stage1_E1;
-            break;
+            g_assert(!secure);  /* TODO: ARMv8.4-SecEL2 */
+            /* fall through */
         case 1:
-            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
+                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                           : ARMMMUIdx_Stage1_E1_PAN);
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         default:
             g_assert_not_reached();
@@ -3487,8 +3492,13 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     switch (ri->opc2 & 6) {
     case 0:
         switch (ri->opc1) {
-        case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+        case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
+            if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
+                mmu_idx = (secure ? ARMMMUIdx_SE10_1_PAN
+                           : ARMMMUIdx_Stage1_E1_PAN);
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE10_1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_E2;
@@ -6692,6 +6702,32 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+#ifndef CONFIG_USER_ONLY
+static const ARMCPRegInfo ats1e1_reginfo[] = {
+    { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+    { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write64 },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo ats1cp_reginfo[] = {
+    { .name = "ATS1CPRP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+    { .name = "ATS1CPWP",
+      .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+      .writefn = ats_write },
+    REGINFO_SENTINEL
+};
+#endif
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7629,6 +7665,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pan, cpu)) {
         define_one_arm_cp_reg(cpu, &pan_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1e1_reginfo);
+    }
+    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
+        define_arm_cp_regs(cpu, ats1cp_reginfo);
+    }
+#endif
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.20.1


