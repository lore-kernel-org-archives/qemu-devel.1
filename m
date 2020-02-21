Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B2BC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC4F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIsp5g1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC4F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Dw-0001SG-ET
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582Q-0007Gb-2J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582O-0002yE-GL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582O-0002w8-9Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id g3so1978405wrs.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fQNBVqODkD8LKZELJsekhva6udMFsBGMkDMTJVnh7us=;
 b=aIsp5g1QZ0hcFrX94r0NMD3lYJjW8PYVK6vgAafAR5yi4jkLSE+LmCMhiXCnoCcteP
 KY4JsKJh5N8aig9W4gWAuAUwwagVe6lewJpdAwSgYhydTl5HgyZnOFrUT8CuAT/OOOga
 VEASguYBrkeDVTVNF02EMCkSxsyddpkjCvnjs9PWfosSxVkoiS4dxkqzQ58I5y9emv2y
 pmL7uhI4rFjtPivkfAQGQZlWZ4Thtcwvdb0uf21oGmoW65OgZusN0zxz+vrVN9J9iEKV
 H0wDhl7CqqCYYyP/qZhQ0zwui8w2GvWvN7dxtowlLGQJNBrqz8YDdN9W8zewKP7/P1/M
 WqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fQNBVqODkD8LKZELJsekhva6udMFsBGMkDMTJVnh7us=;
 b=rdWuZA0SxK4mbk5tVqDunnuTGlk4Bu3pSD6b+IzyzB2xqhCSzaWcm14b0JYy6bJl5D
 VosDSjH7uMNepp9HPTFrPU8y0KomKwwnWGBRzoZ3d9ReUZEnVcuRv/pYXlGz3EQTXyZY
 Kzbjd9BQQfy+w90GwO1J69HFCA9eWNP2XMNt80J0RDzzvo34nC6xLRsdrb+GE7yyszpf
 oFUCYZesqADVS8Mric6d/4eJXAe2Dw+k9TISNshLagVvFqqK7DreeITJNkum0I9MwY5W
 zODBbBG/AMxdcOglk3FpO7M9cTPr9pNugklxNArYmGGs/qMngYX5HncrrUpgysgMOEsl
 /4Jw==
X-Gm-Message-State: APjAAAWuixAEkMOhqFW1QUrJz0uP6/q8tcKf4+fro7gEEhQs3Wm719AX
 NXRA7I27akErBv6KP27wjC/YJYChnhsiRA==
X-Google-Smtp-Source: APXvYqyogsNgWQ2d52kjlrRLfMf5H4ZJ9TrTOr3zVwvlixt4Y4RLjlFNYfmixuJXX6EUyv3Xg27NFQ==
X-Received: by 2002:adf:f084:: with SMTP id n4mr48355644wro.200.1582290490763; 
 Fri, 21 Feb 2020 05:08:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/52] target/arm: Stop assuming DBGDIDR always exists
Date: Fri, 21 Feb 2020 13:07:11 +0000
Message-Id: <20200221130740.7583-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-11-peter.maydell@linaro.org
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
index 31aaa0eff87..e07a7306c77 100644
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
index 679f340c55f..87e71fb8c78 100644
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


