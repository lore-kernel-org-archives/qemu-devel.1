Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74333C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6DF20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYpvg/Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6DF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZZl-00074y-SC
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTm-0005p6-12
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-00047c-Gv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTh-000431-4m
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id r11so10242200wrq.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9e+ltOlG4dXdl+NQ5FqVOuFr/RSUn1sJqHbtQBlPsQ=;
 b=PYpvg/ZnFWB9M2fmPTg8BYOc6zgHxYAikOQbeIAsTraPmQRl2S0nWY7FLq8xauI8OX
 oAmF0AXQxC+2j/iruauGFIq1gCpoz7NXS+6Scyx1wtJslaGpgokPJ0GERtnIt9WcbDAC
 tRPu5eNou8kMH+64n4hshgSDoPiYaw7HPePx3fGYB2an4R8Dz731+b8mZfwsXc+xEdPo
 pMjVRmSRtIWBEJuGZ1qBt1T8KYvNMHJuFVNDe30PHKbQumPnH2CNFjKXmvljPjKM5J3L
 DdmMvwPRXHJeiJFkiCtqKf8yJuATtrYfxntJCiXWz/4kaxssYrnsQoQb8pPL+YOxVcja
 MueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9e+ltOlG4dXdl+NQ5FqVOuFr/RSUn1sJqHbtQBlPsQ=;
 b=s4lec3tRXyx4Mp00iaabVgI72tqBCTvQSSlFXRBVcLzKjfQqjzR/o7tIQLVTItZTdY
 qmDoi6/9KZ1Lh7oS2UyOrh7k/oNTJmthMJlLKcRCu3kwXmt7tlMuGVdIyuvF4Z1Gj/F8
 ak6q/EGOtUvdcP5qnLIynMVYRXRq9AdH6AHcPavYagRpHFu5vnFKJ7pKPCwkYtKIcdHU
 RPFfHOdSAb6MXcJWfeVx0RBQFVKcE/rNN7RGJZmsSD169eWpTgYiHoJ3BjEAfoN5XJL2
 9xT/y8IzgbfkUAwsIrS10Y/5nCRAWWhDsPWBXfGEsKv12EglR0zXY6z2BAA8gOgtG18l
 yahQ==
X-Gm-Message-State: APjAAAWz42/tL5jdLPWlCgGEfrGn266fDiBTYyEWafgDdfllhYPnZ8bF
 +DiHV9yH51x0JZabXGH/1LpW+A==
X-Google-Smtp-Source: APXvYqzPLsp2dtNE5ZHGLbyySaeZl/s/KHaa2LLL1Z9QZXzI1TxrjF3zisLo9Ytzt9nqt8mh+im6dQ==
X-Received: by 2002:adf:f847:: with SMTP id d7mr9421008wrq.35.1581442658497;
 Tue, 11 Feb 2020 09:37:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/13] target/arm: Define an aa32_pmu_8_1 isar feature test
 function
Date: Tue, 11 Feb 2020 17:37:20 +0000
Message-Id: <20200211173726.22541-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of open-coding a check on the ID_DFR0 PerfMon ID register
field, create a standardly-named isar_feature for "does AArch32 have
a v8.1 PMUv3" and use it.

This entails moving the id_dfr0 field into the ARMISARegisters struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  9 ++++++++-
 hw/intc/armv7m_nvic.c |  2 +-
 target/arm/cpu.c      | 28 ++++++++++++++--------------
 target/arm/cpu64.c    |  6 +++---
 target/arm/helper.c   |  5 ++---
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f2194b27ba3..b55f6c8b7d3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -864,6 +864,7 @@ struct ARMCPU {
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
+        uint32_t id_dfr0;
         uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
         uint64_t id_aa64pfr0;
@@ -878,7 +879,6 @@ struct ARMCPU {
     uint32_t reset_sctlr;
     uint32_t id_pfr0;
     uint32_t id_pfr1;
-    uint32_t id_dfr0;
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint32_t id_afr0;
@@ -3562,6 +3562,13 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
+static inline bool isar_feature_aa32_pmu_8_1(const ARMISARegisters *id)
+{
+    /* 0xf means "non-standard IMPDEF PMU" */
+    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
+        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index f9e0eeaace6..5a403fc9704 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1227,7 +1227,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd44: /* PFR1.  */
         return cpu->id_pfr1;
     case 0xd48: /* DFR0.  */
-        return cpu->id_dfr0;
+        return cpu->isar.id_dfr0;
     case 0xd4c: /* AFR0.  */
         return cpu->id_afr0;
     case 0xd50: /* MMFR0.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e7858b073b5..ac0c96322d1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1603,7 +1603,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         cpu->id_aa64dfr0 = FIELD_DP32(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->id_dfr0 = FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);
+        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
@@ -1841,7 +1841,7 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0x2;
+    cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -1873,7 +1873,7 @@ static void arm1136_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0x2;
+    cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -1906,7 +1906,7 @@ static void arm1176_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x33;
+    cpu->isar.id_dfr0 = 0x33;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -1936,7 +1936,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0;
+    cpu->isar.id_dfr0 = 0;
     cpu->id_afr0 = 0x2;
     cpu->id_mmfr0 = 0x01100103;
     cpu->id_mmfr1 = 0x10020302;
@@ -1968,7 +1968,7 @@ static void cortex_m3_initfn(Object *obj)
     cpu->pmsav7_dregion = 8;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00000030;
     cpu->id_mmfr1 = 0x00000000;
@@ -1999,7 +1999,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00000030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2030,7 +2030,7 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00100030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2063,7 +2063,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
-    cpu->id_dfr0 = 0x00200000;
+    cpu->isar.id_dfr0 = 0x00200000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00101F40;
     cpu->id_mmfr1 = 0x00000000;
@@ -2115,7 +2115,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->id_pfr0 = 0x0131;
     cpu->id_pfr1 = 0x001;
-    cpu->id_dfr0 = 0x010400;
+    cpu->isar.id_dfr0 = 0x010400;
     cpu->id_afr0 = 0x0;
     cpu->id_mmfr0 = 0x0210030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2170,7 +2170,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x400;
+    cpu->isar.id_dfr0 = 0x400;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x31100003;
     cpu->id_mmfr1 = 0x20000000;
@@ -2243,7 +2243,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x000;
+    cpu->isar.id_dfr0 = 0x000;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x00100103;
     cpu->id_mmfr1 = 0x20000000;
@@ -2308,7 +2308,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x02010555;
+    cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10101105;
     cpu->id_mmfr1 = 0x40000000;
@@ -2354,7 +2354,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x02010555;
+    cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10201105;
     cpu->id_mmfr1 = 0x20000000;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf2cf278c03..f8fda7e0988 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -121,7 +121,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x03010066;
+    cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10101105;
     cpu->id_mmfr1 = 0x40000000;
@@ -175,7 +175,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x03010066;
+    cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10101105;
     cpu->id_mmfr1 = 0x40000000;
@@ -228,7 +228,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x03010066;
+    cpu->isar.id_dfr0 = 0x03010066;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10201105;
     cpu->id_mmfr1 = 0x40000000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2a57bfd9e86..ca0bf3402ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5886,8 +5886,7 @@ static void define_pmu_regs(ARMCPU *cpu)
         g_free(pmevtyper_name);
         g_free(pmevtyper_el0_name);
     }
-    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
+    if (cpu_isar_feature(aa32_pmu_8_1, cpu)) {
         ARMCPRegInfo v81_pmu_regs[] = {
             { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
@@ -6241,7 +6240,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->id_dfr0 },
+              .resetvalue = cpu->isar.id_dfr0 },
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


