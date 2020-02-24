Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AEAC38BE1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FA320838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdYAVEng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FA320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ISs-0005NA-UE
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6IR7-0003yP-9d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6IR5-0008Mc-Mm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:33 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6IR5-0008HK-EW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:26:31 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so324320wmi.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fKQmEnKZJuNZsPfvpBVEajHZNwqQB+7sHdSwgPxunc0=;
 b=gdYAVEngSdi3vR3SAPt5awKZjkAHoa/dmUFuVFo/GL1bzZIl35VLJDeDnOwbfB3suT
 3x+5VlgKizGM0RdMesIUUJ15m5RqxB/1rVl1Wi4sb0N51vxp3ImfDb0M/RxQlPjDnEna
 hNstDicyIjrmCz5oM8VyM1eXnVKMxb+vnoV1ZSHQ8uPQ0Y7URyWzkQE2oO1ZCosN4pXD
 CdZ2nHQeD0dMTLnJQqYCxaDEDeKmMyri/1ea13aApLn9pZX4c32lEwhTCVsPK7WTMxB9
 GLq+OJ0kiine644w3NhmgN1G0UyAq1HREj4+TLPHI5Zd0Ni8ICWJHR8h4xRWKMSnORTS
 32fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fKQmEnKZJuNZsPfvpBVEajHZNwqQB+7sHdSwgPxunc0=;
 b=jW8jrz0QMG/WI7JTnvfiYLVHuZ4vfAF7fth7wI7aUZ1lG/hHjGm29mt1Qcx+mJeF1n
 f1pyzMTq2E/RxNU3Jmug8jmqwHjRlN4sWpGmbo6kChmzwvcNpkJMel7pKpiG6SlykVFV
 YGAm9Jw9xHAnr/3lST0uI0P1CaRod9myL/zyr1HdbijWK4/fj5ryBI4PYwVvvblaVPGL
 lngxhDwqQ/HYPs48d9TcAhuH1ct5A3s0tLpy4OaSdkOM4U9qMuIV1N5yW8yX9HoQVKdW
 yxFvx5umGvYTwy6zIeKpi8YR8p827hD8p+7+CtAQ9Di9ZE5UsWMVy6378VmgsNj6hSig
 VVoQ==
X-Gm-Message-State: APjAAAUIUCH4F15Vuq4O0dTqRtENXhZRegojcE6JuSR8QIdbMQU7BpWP
 xOf0IwZNeDBaybuM+dFsQ2TrgCisHMhm4w==
X-Google-Smtp-Source: APXvYqxvUCzQM0WFTHgssXQHSgOCpoE9PhR1TFXMv52nGMVUlBiDuv1cPxW1iNa9DeViNdc+FyIlsg==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr309138wme.41.1582568789901;
 Mon, 24 Feb 2020 10:26:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l132sm336983wmf.16.2020.02.24.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:26:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Implement ARMv8.3-CCIDX
Date: Mon, 24 Feb 2020 18:26:26 +0000
Message-Id: <20200224182626.29252-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv8.3-CCIDX extension makes the CCSIDR_EL1 system ID registers
have a format that uses the full 64 bit width of the register, and
adds a new CCSIDR2 register so AArch32 can get at the high 32 bits.

QEMU doesn't implement caches, so we just treat these ID registers as
opaque values that are set to the correct constant values for each
CPU.  The only thing we need to do is allow 64-bit values in our
cssidr[] array and provide the CCSIDR2 accessors.

We don't set the CCIDX field in our 'max' CPU because the CCSIDR
constant values we use are the same as the ones used by the
Cortex-A57 and they are in the old 32-bit format. This means
that the extra regdef added here is unused currently, but it
means that whenever in the future we add a CPU that does need
the new 64-bit format it will just work when we set the cssidr
values and the ID registers for it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is to some extent just ticking off the architecture
feature from our todo list, but it does avoid an unexpected
surprise for whoever is the first to need to implement a
core with ARMv8.3-CCIDX...

Based-on: 20200224172846.13053-1-peter.maydell@linaro.org
("target/arm: Implement v8.3-RCPC and v8.4-RCPC")
but only to avoid a textual conflict in cpu.h

 target/arm/cpu.h    | 17 ++++++++++++++++-
 target/arm/helper.c | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3ce453f1e01..7c860ca39ca 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -904,7 +904,7 @@ struct ARMCPU {
     /* The elements of this array are the CCSIDR values for each cache,
      * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
      */
-    uint32_t ccsidr[16];
+    uint64_t ccsidr[16];
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
@@ -3536,6 +3536,11 @@ static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
 }
 
+static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3737,6 +3742,11 @@ static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
 }
 
+static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3760,6 +3770,11 @@ static inline bool isar_feature_any_pmu_8_4(const ARMISARegisters *id)
     return isar_feature_aa64_pmu_8_4(id) || isar_feature_aa32_pmu_8_4(id);
 }
 
+static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e046..045f1b680a4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6726,6 +6726,21 @@ static const ARMCPRegInfo predinv_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static uint64_t ccsidr2_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Read the high 32 bits of the current CCSIDR */
+    return extract64(ccsidr_read(env, ri), 32, 32);
+}
+
+static const ARMCPRegInfo ccsidr2_reginfo[] = {
+    { .name = "CCSIDR2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 2,
+      .access = PL1_R,
+      .accessfn = access_aa64_tid2,
+      .readfn = ccsidr2_read, .type = ARM_CP_NO_RAW },
+    REGINFO_SENTINEL
+};
+
 static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
@@ -7788,6 +7803,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
 
+    if (cpu_isar_feature(any_ccidx, cpu)) {
+        define_arm_cp_regs(cpu, ccsidr2_reginfo);
+    }
+
 #ifndef CONFIG_USER_ONLY
     /*
      * Register redirections and aliases must be done last,
-- 
2.20.1


