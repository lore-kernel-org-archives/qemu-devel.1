Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43176C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276C2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNkUe5L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58BH-0005QH-5p
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582K-00071b-Gd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582I-0002pq-QB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:08 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582I-0002oy-J2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:06 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so1995631wrt.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8bdHdi62p5PzPAd0CdOGxqVtsuzmqbR0T0M8VLe4aj4=;
 b=nNkUe5L7XNgCNJYsr+LNVUTzdRO1VHn2BJnWzNthWjvcRXoWe+vuoNfiPERXua08P6
 FMeQoXNLMtVmtl9MvDXlG/rC5b1rFJ8gmwtxdfn1usZXFtWRlfue2JptzLjhMJc8agUG
 pwTzA6mFCy99xCkB4s8LyifPcdz7tnF9Lx2W3WzQlm8NAhILOfga1cdsJxl2UvBIhlJl
 Omnn1SVjBkbnbmXq5Iyu+UIPcFGDanJEGFSnoRt0mGrftVvu1xNQ6JbNRL/wcwHJ976y
 HvXnMl7BFfqbZ7yIHOMOfTO7PblF7OecV668vFuJHqVAxJ8YqMGiowjCuYi8GRU1prnm
 OwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8bdHdi62p5PzPAd0CdOGxqVtsuzmqbR0T0M8VLe4aj4=;
 b=BbDiOI2jMA1teBGsTcJ6MCM2KemHk33brYpCCfoPREpBjPuIBHTSNbQJ3Lr0vhN5DL
 GPGYckWBnZkBaHPyX22NaJMHG3HOJU5Qfp1mk0fGWaRaVsKWy06Y5/UpZnwCqQNHHCf+
 xeCQesSBSQq2N1N9IUnqgeJ+XkhEZatpfKTPG1WdCrYN++gHAxy28Jd1abs9ngWt9ZIJ
 8jrVd2USGpjKnSN//DGKlziavFzMVBoS3xjgeVeOzjdOlSetBAYiNAfaOrg3f3GlVBA5
 z6N/N0iUe1hg7sLK77fuDv+egW2aHodcEkAy3hB08V8pJaUa02HJ7QMZ9kQzOSbCnXIr
 XQqA==
X-Gm-Message-State: APjAAAU9XXnUye/VXK+cwzhAHjMCncWFqFwJbO9r4/skK21iP04vMzlf
 lCZBzZ+TBd6oqFoYOARENN0Zq2nd//5L6Q==
X-Google-Smtp-Source: APXvYqyZGOp6lCNV6Ciu/5lSYz81JU03rAsqg1vhtfYSjT01XM3m31T7ef469ZRMtUDyTdyWnecZgg==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr22577212wru.143.1582290484848; 
 Fri, 21 Feb 2020 05:08:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/52] target/arm: Factor out PMU register definitions
Date: Fri, 21 Feb 2020 13:07:06 +0000
Message-Id: <20200221130740.7583-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Pull the code that defines the various PMU registers out
into its own function, matching the pattern we have
already for the debug registers.

Apart from one style fix to a multi-line comment, this
is purely movement of code with no changes to it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-6-peter.maydell@linaro.org
---
 target/arm/helper.c | 158 +++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 76 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ab36f33b719..cb2f4d8bbdb 100644
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


