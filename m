Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE2C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F75222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSgF97U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F75222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58N6-0007C1-Uy
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582c-0007q2-TZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582b-0003EI-Kl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582b-0003Dh-ED
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so1998682wru.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bB3JhtGyxiZSnQrMH3G4ul64IiYEPWbc6FcCjlU/wjY=;
 b=QSgF97U4BSdNF6VMo6tCZt0e9VHNduJgwOQPGwc+0QGo8rtGxOe5XVuvFqZmGNJ0Si
 X6PT4IhNVwllk6z72l97E6w8WbUKZqJE+VyIY/+uka2T5kGLdv4gKlwi4D4oMy5HDM63
 XzBW0QVkSCbQyXx6xq3AcADp1SNjp1Pv2jsIBButA77aH22MRXayDZv3kcAocbD9POo0
 xJbDpzVKHtR5WndKfxGl5iaBB07na7YL6WihlP+semyZoim4noX4bbuV0solvBAS+tCP
 HzKTjR5ucTJkKpuVk45yPUEjvYkEviuciMhDj7aABp1nX/O9vq5CxdxEmdQHy185Wk4J
 h9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bB3JhtGyxiZSnQrMH3G4ul64IiYEPWbc6FcCjlU/wjY=;
 b=c3WAXXMf9x1DSkVuVSLPfchb9j+am7FeyRIVoaKo3ZZN+Q6dDSEYSbMJ+QruFhTVrk
 fB+bnsYrNBJtQaXHY7CRP5WVWHtFKK0sQIhv5V/IWhrKFJvBKaGt2o0DGZgx4Pd2u+VT
 gWbVwhPLyVZQNdbbCrst6OrH7udVaq/8sAzYrjr2lqLA0gpj/HZstpxUQMDKtHb7Ckhn
 1mGs/FB6IaZ5UJOOZovMmUfwYtlMUSTAeh/BmTm/tfKd7Llvs5JR0ARNwXVczy64XPq9
 jO2J//QbEzoZKyR66qTflr5/FNj4DsUyK8aoggivaBDTh2vHjAUpx5ef6Bi2oWEm17vC
 2sNw==
X-Gm-Message-State: APjAAAVtrMmUqBGMui/zrZ7cSaXxHvqmjgJI/cXIvcwSVnWGDfgHBx+S
 covWk+ly+KbvBS4wn079gBFflfoskopBbw==
X-Google-Smtp-Source: APXvYqwKKa1DubV8VKFejEVNwsHEjrKQJIUHWajQ49HwhJ3ivFbzyv7l+YtuTVaz9leRhvOOqgVLxQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr47294765wru.422.1582290504068; 
 Fri, 21 Feb 2020 05:08:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/52] target/arm: Correctly implement ACTLR2, HACTLR2
Date: Fri, 21 Feb 2020 13:07:22 +0000
Message-Id: <20200221130740.7583-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The ACTLR2 and HACTLR2 AArch32 system registers didn't exist in ARMv7
or the original ARMv8.  They were later added as optional registers,
whose presence is signaled by the ID_MMFR4.AC2 field.  From ARMv8.2
they are mandatory (ie ID_MMFR4.AC2 must be non-zero).

We implemented HACTLR2 in commit 0e0456ab8895a5e85, but we
incorrectly made it exist for all v8 CPUs, and we didn't implement
ACTLR2 at all.

Sort this out by implementing both registers only when they are
supposed to exist, and setting the ID_MMFR4 bit for -cpu max.

Note that this removes HACTLR2 from our Cortex-A53, -A47 and -A72
CPU models; this is correct, because those CPUs do not implement
this register.

Fixes: 0e0456ab8895a5e85
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-22-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  5 +++++
 target/arm/cpu.c    |  1 +
 target/arm/cpu64.c  |  4 ++++
 target/arm/helper.c | 32 +++++++++++++++++++++++---------
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6af3290caf..b4c83a1cb52 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3531,6 +3531,11 @@ static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
 }
 
+static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c46bb5a5c09..9f618e120aa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2718,6 +2718,7 @@ static void arm_max_initfn(Object *obj)
 
             t = cpu->isar.id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
+            t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
             cpu->isar.id_mmfr4 = t;
         }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8430d432943..0929401a4dd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -703,6 +703,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
         cpu->isar.id_mmfr3 = u;
 
+        u = cpu->isar.id_mmfr4;
+        u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+        cpu->isar.id_mmfr4 = u;
+
         u = cpu->isar.id_aa64dfr0;
         u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
         cpu->isar.id_aa64dfr0 = u;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19d749a1913..1ac09f387ed 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6862,6 +6862,27 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
 };
 #endif
 
+/*
+ * ACTLR2 and HACTLR2 map to ACTLR_EL1[63:32] and
+ * ACTLR_EL2[63:32]. They exist only if the ID_MMFR4.AC2 field
+ * is non-zero, which is never for ARMv7, optionally in ARMv8
+ * and mandatorily for ARMv8.2 and up.
+ * ACTLR2 is banked for S and NS if EL3 is AArch32. Since QEMU's
+ * implementation is RAZ/WI we can ignore this detail, as we
+ * do for ACTLR.
+ */
+static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
+    { .name = "ACTLR2", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 3,
+      .access = PL1_RW, .type = ARM_CP_CONST,
+      .resetvalue = 0 },
+    { .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
+      .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
+      .access = PL2_RW, .type = ARM_CP_CONST,
+      .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -7623,15 +7644,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, auxcr_reginfo);
-        if (arm_feature(env, ARM_FEATURE_V8)) {
-            /* HACTLR2 maps to ACTLR_EL2[63:32] and is not in ARMv7 */
-            ARMCPRegInfo hactlr2_reginfo = {
-                .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
-                .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
-                .access = PL2_RW, .type = ARM_CP_CONST,
-                .resetvalue = 0
-            };
-            define_one_arm_cp_reg(cpu, &hactlr2_reginfo);
+        if (cpu_isar_feature(aa32_ac2, cpu)) {
+            define_arm_cp_regs(cpu, actlr2_hactlr2_reginfo);
         }
     }
 
-- 
2.20.1


