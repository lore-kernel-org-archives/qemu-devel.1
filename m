Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14B62068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MO5NaQ+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14B62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHd9-0007UX-PQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3e-0002wo-U1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3Z-0006vN-AG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:11 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3V-0006bt-UA
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:07 -0500
Received: by mail-pj1-x1041.google.com with SMTP id w23so1032520pjd.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yh3Zl0Yfgd5t5mYjFXJ95PB0dxs1Lxcsdr6CBQV1gYs=;
 b=MO5NaQ+fWAcCRw8VDgNrpdsX+WE2S6qwB+PHclgbzfqvmArsAARrtN2c3SHs25Vkmv
 Cro5Zf6oeiRfhtmRbH6sFrgJGbmu1uSiQ3uVLtMAdVNqVM8aFciYg9CJK0p0vwPMtU07
 CGPsy8tp7a3O4pSeIGPk98/FPFdn75Bi/nXOZcizAcP8Gbsv2Ood4iIf/YsmVjM7Z2qa
 0tPgcakSmNCO/kbPqE9QfzFc6d8ya7sGR7QB2u29z7gxOktq/atKaG/rM1UYY87aQkhQ
 Oy5CfGzCUPFeOoWho3HAx3V8JKLDM2vE4Tax0vNiLfbZEOOApSh6u68LfirTR7U5Nvos
 MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yh3Zl0Yfgd5t5mYjFXJ95PB0dxs1Lxcsdr6CBQV1gYs=;
 b=k61auEUPGg2RJV6KGzMvcQYoUB/v5Ut6efjVgEQiQ0VgGNzI8YuT8Et2lugyPTUPDo
 qtnum2skrkmjCErB7BJygjxvunKJMV3NxGdSJHfyMNtGTfDl9pt7kmN0ICehQsOcSOA+
 DaUSct20ZeLCDIVe106yrNvlTheIAfrEO0Rl1hzApemyLAl4j/zW+l+F2sluWvnLJtbF
 VQCvYJ65NUIFdV5oC3UkgEEf17ykb1fhs5ODw5/9zJgZzxzqqoY1/qpvqafMNTiMYPXJ
 C5kxSqmwtfJoxTWulDmxcmEyo1P1mwFH7rao+JO3AdWWyk2mwWfjVceafK7tKCNlyTQx
 HJxw==
X-Gm-Message-State: APjAAAXbsmu/w6M7p3VZ+3rh2ueFhFcSLyb83XI+H8umK6Z0r/xZ440i
 po8diXefmwp2x5zmCLDGrDibOIiZNWE=
X-Google-Smtp-Source: APXvYqwe5gK7CBpQMgu7t8Ovhe+hpyTDwLjOF6zmhJMiNp3XvrZmoLZUniCmcUor65vqN42DuxFghQ==
X-Received: by 2002:a17:902:d201:: with SMTP id
 t1mr367250ply.322.1575413628230; 
 Tue, 03 Dec 2019 14:53:48 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] target/arm: Implement ATS1E1 system registers
Date: Tue,  3 Dec 2019 14:53:32 -0800
Message-Id: <20191203225333.17055-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a minor enhancement over ARMv8.1-PAN.
The *_PAN mmu_idx are used with the existing do_ats_write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 50 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 043e44d73d..f1eab4fb28 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3360,16 +3360,20 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 
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
-            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
+            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
+                mmu_idx = secure ? ARMMMUIdx_SE1_PAN : ARMMMUIdx_Stage1_E1_PAN;
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         default:
             g_assert_not_reached();
@@ -3438,8 +3442,12 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     switch (ri->opc2 & 6) {
     case 0:
         switch (ri->opc1) {
-        case 0: /* AT S1E1R, AT S1E1W */
-            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
+        case 0: /* AT S1E1R, AT S1E1W, AT S1E1RP, AT S1E1WP */
+            if (ri->crm == 9 && (env->pstate & PSTATE_PAN)) {
+                mmu_idx = secure ? ARMMMUIdx_SE1_PAN : ARMMMUIdx_Stage1_E1_PAN;
+            } else {
+                mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
+            }
             break;
         case 4: /* AT S1E2R, AT S1E2W */
             mmu_idx = ARMMMUIdx_E2;
@@ -7426,6 +7434,36 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         };
         define_arm_cp_regs(cpu, pan_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu_isar_feature(aa64_ats1e1, cpu)) {
+        static const ARMCPRegInfo ats1e1_reginfo[] = {
+            { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
+              .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+              .writefn = ats_write64 },
+            { .name = "AT_S1E1W", .state = ARM_CP_STATE_AA64,
+              .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+              .writefn = ats_write64 },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, ats1e1_reginfo);
+    }
+    if (cpu_isar_feature(aa32_ats1e1, cpu)) {
+        static const ARMCPRegInfo ats1cp_reginfo[] = {
+            { .name = "ATS1CPRP",
+              .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 0,
+              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+              .writefn = ats_write },
+            { .name = "ATS1CPWP",
+              .cp = 15, .opc1 = 0, .crn = 7, .crm = 9, .opc2 = 1,
+              .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_RAISES_EXC,
+              .writefn = ats_write },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, ats1cp_reginfo);
+    }
+#endif
 
     if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
         static const ARMCPRegInfo vhe_reginfo[] = {
-- 
2.17.1


