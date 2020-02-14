Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A546C3B1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0442187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmkcU+or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0442187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fMp-0007tM-3g
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f81-0006Ht-GC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f80-0001BT-3r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:49 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7z-0001AT-T5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:48 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so10829876wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6KTNckWA4+ATf5z/mBrn8Lcv/aBBE2/oWgefPULbIw0=;
 b=xmkcU+orzKzljDZz60HJPquXMNvZrrirlkMCapLPwLD/z31OvkB3OCG5UlPyK45BgD
 opLSNY4PUkx9ypxds4CflLaTfp5opUklKscOEpLR7wX8jL+xyiK28r+xXhx2ktAaOkzB
 SOWGnBfgiQZq6u5leJMd7X6jYpe3f84IgnhUB52OUggp9TsiarFifmCrldCXQupvBHQn
 LsjEw4Z9TfKBCz/ynsaRDAT58X9Ap3EsG4HxfVe0B8kUK0Ymm64WhUb8qOHK2cajliN7
 JRgLzcmCMKXHbZv90Qw1IyvxMIAsP0MvhGvrc7SBS5PvY7Uk5+lJhocPQ8CEFfuSFe6X
 oIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6KTNckWA4+ATf5z/mBrn8Lcv/aBBE2/oWgefPULbIw0=;
 b=EcWyB5xCFsX1fkiqtJ4Kqg3e+anf2sFiN0idvMXfo1Yfv7gvqKbWv+slaMv8PAdl2W
 x2HYGRhUHT8vdukZIgUVGt83au8q7b/+h/zrm11yJ5fbANtPMqzSplnUllB9wPjrXof8
 io8IzL+yPrSgP2oNWZ14zP0i9aqeGO3Yegj/q4iH9u9xQ8kFlhWqJnZPcKdwE2RG09Hy
 hfWtdkv5nxFpD1Nq4z1dNoHyZ+mkylhPVdwNo5cSKtHBQ4cEIDU1TiSLiPLyWE99NddF
 XO0gbFTg+Ia2xKnIbSeXI6RBl5XMimlvLbmONxG7SSqff2myZ63Hog9tXep4t7EFQF7l
 A8Yw==
X-Gm-Message-State: APjAAAUSNAwwgKQAEOCsyLyiBz1QdQGlLboLn5/s3Z46q1lXxkzi+3J+
 KApeYrbFQVKR5RZLypZRbZmuXw==
X-Google-Smtp-Source: APXvYqx7WH2v6/xtGWAIansO3priUF8nzgK8bgy33UVia/oOToZukQY+9+ns+i5tfyQx1oJxKLZxbw==
X-Received: by 2002:a1c:6645:: with SMTP id a66mr6125346wmc.121.1581702706955; 
 Fri, 14 Feb 2020 09:51:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 21/21] target/arm: Correctly implement ACTLR2, HACTLR2
Date: Fri, 14 Feb 2020 17:51:16 +0000
Message-Id: <20200214175116.9164-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
index 8430d432943..32cf8ee98b0 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -703,6 +703,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
         cpu->isar.id_mmfr3 = u;
 
+        u = cpu->isar.id_mmfr4;
+        u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 implemented */
+        cpu->isar.id_mmfr4 = u;
+
         u = cpu->isar.id_aa64dfr0;
         u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
         cpu->isar.id_aa64dfr0 = u;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 56b1c08f027..513f4edbb46 100644
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


