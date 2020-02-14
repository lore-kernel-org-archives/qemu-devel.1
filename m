Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BFC3B1B1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370B3206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="howWY4qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370B3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fA7-0002v8-Ae
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7k-0005t7-9T
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7i-0000jp-8w
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7g-0000iB-FM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so11555138wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2XRfHOyhPSH4cYUDW/HDN1fLtRvOem+XGDBRyAVp+4g=;
 b=howWY4qzlzNbFfxTLB4TSROv/wu5EMJngCO5FaSXYWex4j5cbNsJzbSpksLIV7GXoK
 CrZDi8ssBLeBwunKyQ2SUwk1F8gX2iv3TLEFO70EPXdjuJzO3kcfsYXaEHsOruWXBeMn
 DEiW3YyVvfXkaIzTnRSjE9avp1x1olpym1yEuZy/uzSqp1MK8hx5n6cYAXSq+eTJuHj+
 9Qkms5M8j2NERs+hxs6K2Ab8Zj9E9zbp3rP5F5iNjMEz039mer0LBeLWqVYldaSvgdGP
 3KAH0wtExQo/QjRJ8pwOxcf2641IKAcYd6wYlztH0uLqk0jhRa9n00iTWfYchjks31xB
 pr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2XRfHOyhPSH4cYUDW/HDN1fLtRvOem+XGDBRyAVp+4g=;
 b=bpbTpDCTU04sH0OfufGWvN4IqQNq3W1+q0G1ZVl90bUxrfw9FUrnKlcMhKIUd03OYa
 v5RLUi9hl5Gaj6lZuqABtONQXIo2X5sHUEL+jibTGMm6sbB4kNI/FbIOc3ca3TkuIfQH
 IFPb3Okv8wo9PuRbczXRtvrNdnkAll/66UFi+myfAb42c7RJzJ/RxJ1I4DMg4ap77tOx
 PczhuKlB0uERQZo0d1+Aw8ATmO+wdiCk1wuRJUzQOXF/yvQvSJ/mpr9OXbDkKLei8Crv
 iUlXUeyAKTD3OTAV/zqyaYwUvq2V6N7lP4Son4pfBF4Wfn8u8tqT568rHmxeGgJXGKlm
 laaA==
X-Gm-Message-State: APjAAAU9aSSmkmagR4Bwwhx4zd/TA60XuwsKQ4A7pQ2Dc26lJ8uBoTAy
 R6faN13R2rFWB/EeLvjimXdjig==
X-Google-Smtp-Source: APXvYqxNtSAzvh3C4BzIoseHKH3vvaKuwZ1pzZIUnfIleYjw10BNjXP50Sbl8UrwijTH2/i5VgnirA==
X-Received: by 2002:a1c:e483:: with SMTP id b125mr5869729wmh.187.1581702687425; 
 Fri, 14 Feb 2020 09:51:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/21] target/arm: Factor out PMU register definitions
Date: Fri, 14 Feb 2020 17:51:00 +0000
Message-Id: <20200214175116.9164-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pull the code that defines the various PMU registers out
into its own function, matching the pattern we have
already for the debug registers.

Apart from one style fix to a multi-line comment, this
is purely movement of code with no changes to it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 158 +++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 76 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b3ced7f78ba..c53d6406474 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6317,6 +6317,87 @@ static void define_debug_regs(ARMCPU *cpu)
     }
 }
 
+static void define_pmu_regs(ARMCPU *cpu)
+{
+    /*
+     * v7 performance monitor control register: same implementor
+     * field as main ID register, and we implement four counters in
+     * addition to the cycle count register.
+     */
+    unsigned int i, pmcrn = 4;
+    ARMCPRegInfo pmcr = {
+        .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
+        .access = PL0_RW,
+        .type = ARM_CP_IO | ARM_CP_ALIAS,
+        .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
+        .accessfn = pmreg_access, .writefn = pmcr_write,
+        .raw_writefn = raw_write,
+    };
+    ARMCPRegInfo pmcr64 = {
+        .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
+        .access = PL0_RW, .accessfn = pmreg_access,
+        .type = ARM_CP_IO,
+        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
+        .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
+        .writefn = pmcr_write, .raw_writefn = raw_write,
+    };
+    define_one_arm_cp_reg(cpu, &pmcr);
+    define_one_arm_cp_reg(cpu, &pmcr64);
+    for (i = 0; i < pmcrn; i++) {
+        char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
+        char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
+        char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
+        char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
+        ARMCPRegInfo pmev_regs[] = {
+            { .name = pmevcntr_name, .cp = 15, .crn = 14,
+              .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+              .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
+              .accessfn = pmreg_access },
+            { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
+              .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+              .type = ARM_CP_IO,
+              .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
+              .raw_readfn = pmevcntr_rawread,
+              .raw_writefn = pmevcntr_rawwrite },
+            { .name = pmevtyper_name, .cp = 15, .crn = 14,
+              .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
+              .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
+              .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
+              .accessfn = pmreg_access },
+            { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
+              .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
+              .type = ARM_CP_IO,
+              .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
+              .raw_writefn = pmevtyper_rawwrite },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, pmev_regs);
+        g_free(pmevcntr_name);
+        g_free(pmevcntr_el0_name);
+        g_free(pmevtyper_name);
+        g_free(pmevtyper_el0_name);
+    }
+    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
+            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
+        ARMCPRegInfo v81_pmu_regs[] = {
+            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
+            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
+              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
+              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, v81_pmu_regs);
+    }
+}
+
 /* We don't know until after realize whether there's a GICv3
  * attached, and that is what registers the gicv3 sysregs.
  * So we have to fill in the GIC fields in ID_PFR/ID_PFR1_EL1/ID_AA64PFR0_EL1
@@ -6859,67 +6940,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
-        /* v7 performance monitor control register: same implementor
-         * field as main ID register, and we implement four counters in
-         * addition to the cycle count register.
-         */
-        unsigned int i, pmcrn = 4;
-        ARMCPRegInfo pmcr = {
-            .name = "PMCR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 0,
-            .access = PL0_RW,
-            .type = ARM_CP_IO | ARM_CP_ALIAS,
-            .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-            .accessfn = pmreg_access, .writefn = pmcr_write,
-            .raw_writefn = raw_write,
-        };
-        ARMCPRegInfo pmcr64 = {
-            .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
-            .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
-            .access = PL0_RW, .accessfn = pmreg_access,
-            .type = ARM_CP_IO,
-            .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-            .resetvalue = (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT),
-            .writefn = pmcr_write, .raw_writefn = raw_write,
-        };
-        define_one_arm_cp_reg(cpu, &pmcr);
-        define_one_arm_cp_reg(cpu, &pmcr64);
-        for (i = 0; i < pmcrn; i++) {
-            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
-            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
-            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
-            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
-            ARMCPRegInfo pmev_regs[] = {
-                { .name = pmevcntr_name, .cp = 15, .crn = 14,
-                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
-                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
-                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
-                  .accessfn = pmreg_access },
-                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
-                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
-                  .type = ARM_CP_IO,
-                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
-                  .raw_readfn = pmevcntr_rawread,
-                  .raw_writefn = pmevcntr_rawwrite },
-                { .name = pmevtyper_name, .cp = 15, .crn = 14,
-                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
-                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
-                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
-                  .accessfn = pmreg_access },
-                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
-                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
-                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
-                  .type = ARM_CP_IO,
-                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
-                  .raw_writefn = pmevtyper_rawwrite },
-                REGINFO_SENTINEL
-            };
-            define_arm_cp_regs(cpu, pmev_regs);
-            g_free(pmevcntr_name);
-            g_free(pmevcntr_el0_name);
-            g_free(pmevtyper_name);
-            g_free(pmevtyper_el0_name);
-        }
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
@@ -6930,24 +6950,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
         define_debug_regs(cpu);
+        define_pmu_regs(cpu);
     } else {
         define_arm_cp_regs(cpu, not_v7_cp_reginfo);
     }
-    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
-        ARMCPRegInfo v81_pmu_regs[] = {
-            { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
-              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
-              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = extract64(cpu->pmceid0, 32, 32) },
-            { .name = "PMCEID3", .state = ARM_CP_STATE_AA32,
-              .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 5,
-              .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
-              .resetvalue = extract64(cpu->pmceid1, 32, 32) },
-            REGINFO_SENTINEL
-        };
-        define_arm_cp_regs(cpu, v81_pmu_regs);
-    }
     if (arm_feature(env, ARM_FEATURE_V8)) {
         /* AArch64 ID registers, which all have impdef reset values.
          * Note that within the ID register ranges the unused slots
-- 
2.20.1


