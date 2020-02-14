Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B60C3B1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897B9222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHd69Z9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897B9222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2f9P-0000nr-MM
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7o-0005wb-92
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7m-0000p7-RM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7m-0000oH-KI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:34 -0500
Received: by mail-wm1-x335.google.com with SMTP id s10so10844383wmh.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+RSZKscRdCamXAJ0k30/EyUeGISH+9TDKdteY9Rg/DM=;
 b=LHd69Z9/E6GbSWIp12Y1fRT6SW8N7Yh8hivs/KTO/v6k1xYl46xC4xfH0aZnceSYt7
 QWbvXHvYXXZnryA4BDZj2gAWBy8QmzmkzzRF4ZmmgABKySk8kdbVH0JIwH138MnuKVNA
 AK2f2g5VstRGczRCOlDzyhHl+0DzPP0DNLHBXNLYFETqe7ObT91TzsiFr83rpwfCIDjW
 IDlrXh5692JXzmJRL3O2WtQQSsQL8jB4f7od+f/lmW6Al+b8HHjnyv61iqmZWZkIHi0O
 aYu0NnMZ5w73iKKjMC7TgssmqgWDEhQb8T1dTHiawvul7OQMTEtWdbwRH0HwQiB2kyiR
 zQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+RSZKscRdCamXAJ0k30/EyUeGISH+9TDKdteY9Rg/DM=;
 b=c0AwIpAQgs8hKViM2XgUjapAiqiBFhnVeHDpSN3MTntLfvUO+0FG6OFk6/78UJKCSl
 poDchrLc4Wmt7c+qJtRVZGWVdp9Yt/UIltbYaZw0F1FnbmI2mpQwK0RAyQ7SYRN1pEoc
 9XbTPnL/2WDWRRnpPq75i/BWvSRQNird1SlP4yFHwyYwJhfNiROAZzvGVbBq5rqJ6dPD
 cFATHXjJO1mafskoDn9uc/g/WhQ/mdNpnITxFm0s+Fsc7YLjV94byPhIlvVoKEN7ZDkB
 1sEDZRI7pv9q8Lizr6spESor89bl10V+5dgOJwS/x66W/bnaQcS5c5ACTX6+XpgCJYW9
 PHAw==
X-Gm-Message-State: APjAAAUmJaEQL8rcLx0FEDYyFcrbXsYiGuVpHgs68sKRMYueuFI/X2FJ
 6wVo2GEBtspiPNzNIdSNIwn5Kg==
X-Google-Smtp-Source: APXvYqzlEVGLRn00WqLArkcqinPKewDZWVKDTCAhf8FlkuJ2QG2cMi5qTOMSGCvuoQzwvdknnPaQ+w==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr6013917wmj.72.1581702693533; 
 Fri, 14 Feb 2020 09:51:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/21] target/arm: Stop assuming DBGDIDR always exists
Date: Fri, 14 Feb 2020 17:51:05 +0000
Message-Id: <20200214175116.9164-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

The AArch32 DBGDIDR defines properties like the number of
breakpoints, watchpoints and context-matching comparators.  On an
AArch64 CPU, the register may not even exist if AArch32 is not
supported at EL1.

Currently we hard-code use of DBGDIDR to identify the number of
breakpoints etc; this works for all our TCG CPUs, but will break if
we ever add an AArch64-only CPU.  We also have an assert() that the
AArch32 and AArch64 registers match, which currently works only by
luck for KVM because we don't populate either of these ID registers
from the KVM vCPU and so they are both zero.

Clean this up so we have functions for finding the number
of breakpoints, watchpoints and context comparators which look
in the appropriate ID register.

This allows us to drop the "check that AArch64 and AArch32 agree
on the number of breakpoints etc" asserts:
 * we no longer look at the AArch32 versions unless that's the
   right place to be looking
 * it's valid to have a CPU (eg AArch64-only) where they don't match
 * we shouldn't have been asserting the validity of ID registers
   in a codepath used with KVM anyway

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h          |  7 +++++++
 target/arm/internals.h    | 42 +++++++++++++++++++++++++++++++++++++++
 target/arm/debug_helper.c |  6 +++---
 target/arm/helper.c       | 21 +++++---------------
 4 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 98240224c0c..0f21b6ed803 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1840,6 +1840,13 @@ FIELD(ID_DFR0, MPROFDBG, 20, 4)
 FIELD(ID_DFR0, PERFMON, 24, 4)
 FIELD(ID_DFR0, TRACEFILT, 28, 4)
 
+FIELD(DBGDIDR, SE_IMP, 12, 1)
+FIELD(DBGDIDR, NSUHD_IMP, 14, 1)
+FIELD(DBGDIDR, VERSION, 16, 4)
+FIELD(DBGDIDR, CTX_CMPS, 20, 4)
+FIELD(DBGDIDR, BRPS, 24, 4)
+FIELD(DBGDIDR, WRPS, 28, 4)
+
 FIELD(MVFR0, SIMDREG, 0, 4)
 FIELD(MVFR0, FPSP, 4, 4)
 FIELD(MVFR0, FPDP, 8, 4)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 052449b4826..39239186def 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -931,6 +931,48 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
+/**
+ * arm_num_brps: Return number of implemented breakpoints.
+ * Note that the ID register BRPS field is "number of bps - 1",
+ * and we return the actual number of breakpoints.
+ */
+static inline int arm_num_brps(ARMCPU *cpu)
+{
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+    } else {
+        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, BRPS) + 1;
+    }
+}
+
+/**
+ * arm_num_wrps: Return number of implemented watchpoints.
+ * Note that the ID register WRPS field is "number of wps - 1",
+ * and we return the actual number of watchpoints.
+ */
+static inline int arm_num_wrps(ARMCPU *cpu)
+{
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+    } else {
+        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, WRPS) + 1;
+    }
+}
+
+/**
+ * arm_num_ctx_cmps: Return number of implemented context comparators.
+ * Note that the ID register CTX_CMPS field is "number of cmps - 1",
+ * and we return the actual number of comparators.
+ */
+static inline int arm_num_ctx_cmps(ARMCPU *cpu)
+{
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) + 1;
+    } else {
+        return FIELD_EX32(cpu->dbgdidr, DBGDIDR, CTX_CMPS) + 1;
+    }
+}
+
 /* Note make_memop_idx reserves 4 bits for mmu_idx, and MO_BSWAP is bit 3.
  * Thus a TCGMemOpIdx, without any MO_ALIGN bits, fits in 8 bits.
  */
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 2e3e90c6a57..2ff72d47d19 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -16,8 +16,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
 {
     CPUARMState *env = &cpu->env;
     uint64_t bcr = env->cp15.dbgbcr[lbn];
-    int brps = extract32(cpu->dbgdidr, 24, 4);
-    int ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
+    int brps = arm_num_brps(cpu);
+    int ctx_cmps = arm_num_ctx_cmps(cpu);
     int bt;
     uint32_t contextidr;
     uint64_t hcr_el2;
@@ -29,7 +29,7 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
      * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
      * We choose the former.
      */
-    if (lbn > brps || lbn < (brps - ctx_cmps)) {
+    if (lbn >= brps || lbn < (brps - ctx_cmps)) {
         return false;
     }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 11b87723e47..8415cc6b154 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6256,23 +6256,12 @@ static void define_debug_regs(ARMCPU *cpu)
     };
 
     /* Note that all these register fields hold "number of Xs minus 1". */
-    brps = extract32(cpu->dbgdidr, 24, 4);
-    wrps = extract32(cpu->dbgdidr, 28, 4);
-    ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
+    brps = arm_num_brps(cpu);
+    wrps = arm_num_wrps(cpu);
+    ctx_cmps = arm_num_ctx_cmps(cpu);
 
     assert(ctx_cmps <= brps);
 
-    /* The DBGDIDR and ID_AA64DFR0_EL1 define various properties
-     * of the debug registers such as number of breakpoints;
-     * check that if they both exist then they agree.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
-        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
-        assert(FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS)
-               == ctx_cmps);
-    }
-
     define_one_arm_cp_reg(cpu, &dbgdidr);
     define_arm_cp_regs(cpu, debug_cp_reginfo);
 
@@ -6280,7 +6269,7 @@ static void define_debug_regs(ARMCPU *cpu)
         define_arm_cp_regs(cpu, debug_lpae_cp_reginfo);
     }
 
-    for (i = 0; i < brps + 1; i++) {
+    for (i = 0; i < brps; i++) {
         ARMCPRegInfo dbgregs[] = {
             { .name = "DBGBVR", .state = ARM_CP_STATE_BOTH,
               .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = i, .opc2 = 4,
@@ -6299,7 +6288,7 @@ static void define_debug_regs(ARMCPU *cpu)
         define_arm_cp_regs(cpu, dbgregs);
     }
 
-    for (i = 0; i < wrps + 1; i++) {
+    for (i = 0; i < wrps; i++) {
         ARMCPRegInfo dbgregs[] = {
             { .name = "DBGWVR", .state = ARM_CP_STATE_BOTH,
               .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = i, .opc2 = 6,
-- 
2.20.1


