Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2FBC3B1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20236206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wsh2MgwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20236206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fGm-0006Go-AB
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7m-0005vX-Qq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7l-0000n3-5C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7k-0000lp-Bn
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so11896337wrw.8
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8vZsaT2+tk9YLi++unYB+Z+jW0b/JEinNqFa1FTVjNg=;
 b=Wsh2MgwVg3QN3APiAcgnIcN5PpHA4mrawspkWx3oP8RMnEH8yxw9cQzSkdWF1syp7W
 rr4lpoZYYXATfKVwwUv+2wPjF3IojpHixzeTjkSTziWHM/SdtC8Wrk30trA7IA2BJ+O3
 gXyvMsYTSrpt2XNGotUpqCpLVW2oZuWfzi/UHH2j+6OkFS+hODXJLJ0hEfDj0jf3qAja
 h5zDJBWuy1ULhGg18Td5phzH0jrHJZvr7V10QoEZL/DccAU7l6+/hUNirA9nxEzoBaHE
 u/TrJt/jXKC8miXkI68Vr3xIpgL3yQbGp4itS4bkbXqGDAsmXW/w4a57eFtLYM19Ngwf
 vtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8vZsaT2+tk9YLi++unYB+Z+jW0b/JEinNqFa1FTVjNg=;
 b=MZJtfyi465k3FwV5K2XJlnAiTf7fQwmZ/3YcCV/Uej1SpWzufzzp/BobAYByM1WhDI
 LWTASCkNA1c6iDlgG+Teuhmk3BR/Ty1AbV2BtoZcLoP4NA1vA/Q+4ABTpnb6Q6Hah1Bs
 EJL8xsQ8GLOzPfzCNdb8y3qG8UzTWImIvv4FiGyVH0rgzJy7qArSKXcP7fqOTAJN9zRy
 2cHPrJo9K+2kUdxreEKloR36dItMqQs0gxX69zVW07uJzw7P4oMOZtaHtvLY0t/wRI3P
 t8WbiiUAZgvfvXU3hjS3ntZsQLWZrGT6XnxBTBskgHFOaMfn+DuiLSbLQrex2W1Z6oGQ
 aJOQ==
X-Gm-Message-State: APjAAAX4muQGf+bV+/6gX5snZ4oy3CIAS8iBpZfCIuT7AIJWz8SOEabo
 nqdsXFhcaPApfYqqRjKN8ArCfg==
X-Google-Smtp-Source: APXvYqx+zdrwc0GGyH2blXS2VLhQIl+1v6OVJgzUkMMwOSBBdng1lxvOhkxkLxcbLTQYaiZmfzsjbw==
X-Received: by 2002:adf:e5c6:: with SMTP id a6mr5253518wrn.185.1581702691276; 
 Fri, 14 Feb 2020 09:51:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/21] target/arm: Define an aa32_pmu_8_1 isar feature test
 function
Date: Fri, 14 Feb 2020 17:51:03 +0000
Message-Id: <20200214175116.9164-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Instead of open-coding a check on the ID_DFR0 PerfMon ID register
field, create a standardly-named isar_feature for "does AArch32 have
a v8.1 PMUv3" and use it.

This entails moving the id_dfr0 field into the ARMISARegisters struct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |  9 ++++++++-
 hw/intc/armv7m_nvic.c |  2 +-
 target/arm/cpu.c      | 28 ++++++++++++++--------------
 target/arm/cpu64.c    |  6 +++---
 target/arm/helper.c   |  5 ++---
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 081955094dc..6c6088eb587 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -865,6 +865,7 @@ struct ARMCPU {
         uint32_t mvfr0;
         uint32_t mvfr1;
         uint32_t mvfr2;
+        uint32_t id_dfr0;
         uint64_t id_aa64isar0;
         uint64_t id_aa64isar1;
         uint64_t id_aa64pfr0;
@@ -880,7 +881,6 @@ struct ARMCPU {
     uint32_t reset_sctlr;
     uint32_t id_pfr0;
     uint32_t id_pfr1;
-    uint32_t id_dfr0;
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint32_t id_afr0;
@@ -3500,6 +3500,13 @@ static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
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
index 1024f506c51..b85040d36bc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1719,7 +1719,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         cpu->id_aa64dfr0 = FIELD_DP64(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->id_dfr0 = FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);
+        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
@@ -1957,7 +1957,7 @@ static void arm1136_r2_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0x2;
+    cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -1989,7 +1989,7 @@ static void arm1136_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0x2;
+    cpu->isar.id_dfr0 = 0x2;
     cpu->id_afr0 = 0x3;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -2022,7 +2022,7 @@ static void arm1176_initfn(Object *obj)
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x33;
+    cpu->isar.id_dfr0 = 0x33;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x01130003;
     cpu->id_mmfr1 = 0x10030302;
@@ -2052,7 +2052,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->id_dfr0 = 0;
+    cpu->isar.id_dfr0 = 0;
     cpu->id_afr0 = 0x2;
     cpu->id_mmfr0 = 0x01100103;
     cpu->id_mmfr1 = 0x10020302;
@@ -2084,7 +2084,7 @@ static void cortex_m3_initfn(Object *obj)
     cpu->pmsav7_dregion = 8;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00000030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2115,7 +2115,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00000030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2146,7 +2146,7 @@ static void cortex_m7_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->id_dfr0 = 0x00100000;
+    cpu->isar.id_dfr0 = 0x00100000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00100030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2179,7 +2179,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->isar.mvfr2 = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
-    cpu->id_dfr0 = 0x00200000;
+    cpu->isar.id_dfr0 = 0x00200000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x00101F40;
     cpu->id_mmfr1 = 0x00000000;
@@ -2231,7 +2231,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->id_pfr0 = 0x0131;
     cpu->id_pfr1 = 0x001;
-    cpu->id_dfr0 = 0x010400;
+    cpu->isar.id_dfr0 = 0x010400;
     cpu->id_afr0 = 0x0;
     cpu->id_mmfr0 = 0x0210030;
     cpu->id_mmfr1 = 0x00000000;
@@ -2286,7 +2286,7 @@ static void cortex_a8_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x400;
+    cpu->isar.id_dfr0 = 0x400;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x31100003;
     cpu->id_mmfr1 = 0x20000000;
@@ -2359,7 +2359,7 @@ static void cortex_a9_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->id_dfr0 = 0x000;
+    cpu->isar.id_dfr0 = 0x000;
     cpu->id_afr0 = 0;
     cpu->id_mmfr0 = 0x00100103;
     cpu->id_mmfr1 = 0x20000000;
@@ -2424,7 +2424,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x02010555;
+    cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10101105;
     cpu->id_mmfr1 = 0x40000000;
@@ -2470,7 +2470,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->id_dfr0 = 0x02010555;
+    cpu->isar.id_dfr0 = 0x02010555;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10201105;
     cpu->id_mmfr1 = 0x20000000;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f0d98bc79d1..9e4387158f9 100644
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
index 376c6412f91..048e541eda4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6381,8 +6381,7 @@ static void define_pmu_regs(ARMCPU *cpu)
         g_free(pmevtyper_name);
         g_free(pmevtyper_el0_name);
     }
-    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
+    if (cpu_isar_feature(aa32_pmu_8_1, cpu)) {
         ARMCPRegInfo v81_pmu_regs[] = {
             { .name = "PMCEID2", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 4,
@@ -6856,7 +6855,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


