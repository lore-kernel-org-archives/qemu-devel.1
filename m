Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB74C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C8D2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPhK4mvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C8D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58PM-0002T7-TP
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582r-0008Qd-Ts
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582p-0003vB-Lp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:40 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582p-0003uO-Eg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:39 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so1775901wmi.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lZW5fWoykryTlZydn2qsBAZbMdQAuH2IlE0NMzkYoxo=;
 b=UPhK4mvbVdgdJyzUg4GXrcs2LpeYxYqRHQKCInWWnAze3CJJxS694x7smWL6HvKypD
 xTQ8p1OrOv8lTHSN7i5/v1uFoWP6SKFbdjyFfP4zfL/e5m2hAuLRIuK62uQLrj3Cqj9Q
 TeTfQ3xjNKDdxR/4I/AL9LcDTZfNgf3tx8lb6GCx8CazZQfu6+Ajz2jQNbvEGmxxSQp+
 4xaElV5ip6C7mp8mFgWR4HAXnzOIiqzTfdAvbI0fLP+00blisEl6HPfWGAJQKAflYD53
 V5RPGgDGziF729e7nP0TX7rUtpzslW8mmzjehnKpe0401cGq74RXs66Q9LIG2AYFXnYy
 MnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lZW5fWoykryTlZydn2qsBAZbMdQAuH2IlE0NMzkYoxo=;
 b=rBcK6jFlrbcdykCdV1Mav7p6Ad7ctfYfy6N0tbXgTJWImMPuq61qfm7k1oVvo1isee
 ot0XiXQeJ0LdYxjarWrDuI+av3URtqAyAlxzWYjLI+ZJYoBW4r3kt/QeWSVmVEFQKswS
 62zdabYmUkVeYFC+z/cgn6Fo+zcIit/YbG0od6r67c65AoVaTDhlpsk5s6CVrZSQu09Q
 jkmD+ND4u12D3j3F4ZAIYAmqDFfn+Ejl3ZCOv1XVsWiwNBHPNexZH8Qo1cnmShV0uwPa
 6teZ5T/YVoMYfZydx+pAAjkgFOS3ZLKBHdY61ZK0V6A4f96D8aLmK1GqpD/Vwzl5KmNg
 NHlg==
X-Gm-Message-State: APjAAAW6PG9xlrx8PF/ZeZ1I5yYgy1Feh3EVXCH1esg2iw6ll3MD+bnh
 1aecDbaXzUC4M/ztaVm+GJFs2mjrwGolAg==
X-Google-Smtp-Source: APXvYqxmY55aOoQB7Shl8XAQLuabCU3devn0W6wItchx7L5yRzXuUq8cRWUC0xeBPupd0NX3TmAxKQ==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr3722500wme.76.1582290517687; 
 Fri, 21 Feb 2020 05:08:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/52] target/arm: Use isar_feature_aa32_simd_r32 more places
Date: Fri, 21 Feb 2020 13:07:33 +0000
Message-Id: <20200221130740.7583-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Richard Henderson <richard.henderson@linaro.org>

Many uses of ARM_FEATURE_VFP3 are testing for the number of simd
registers implemented.  Use the proper test vs MVFR0.SIMDReg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-4-richard.henderson@linaro.org
[PMM: fix typo in commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c       |  9 ++++-----
 target/arm/helper.c    | 13 ++++++-------
 target/arm/translate.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9f618e120aa..8085268a539 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1009,11 +1009,10 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     if (flags & CPU_DUMP_FPU) {
         int numvfpregs = 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs += 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs += 16;
+        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
+            numvfpregs = 32;
+        } else if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs = 16;
         }
         for (i = 0; i < numvfpregs; i++) {
             uint64_t v = *aa32_vfp_dreg(env, i);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1ac09f387ed..79db169e046 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -50,10 +50,10 @@ static void switch_mode(CPUARMState *env, int mode);
 
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
-    int nregs;
+    ARMCPU *cpu = env_archcpu(env);
+    int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
 
     /* VFP data registers are always little-endian.  */
-    nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
     if (reg < nregs) {
         stq_le_p(buf, *aa32_vfp_dreg(env, reg));
         return 8;
@@ -78,9 +78,9 @@ static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 
 static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
-    int nregs;
+    ARMCPU *cpu = env_archcpu(env);
+    int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
 
-    nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
     if (reg < nregs) {
         *aa32_vfp_dreg(env, reg) = ldq_le_p(buf);
         return 8;
@@ -906,8 +906,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
             /* VFPv3 and upwards with NEON implement 32 double precision
              * registers (D0-D31).
              */
-            if (!arm_feature(env, ARM_FEATURE_NEON) ||
-                    !arm_feature(env, ARM_FEATURE_VFP3)) {
+            if (!cpu_isar_feature(aa32_simd_r32, env_archcpu(env))) {
                 /* D32DIS [30] is RAO/WI if D16-31 are not implemented. */
                 value |= (1 << 30);
             }
@@ -7812,7 +7811,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     } else if (arm_feature(env, ARM_FEATURE_NEON)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  51, "arm-neon.xml", 0);
-    } else if (arm_feature(env, ARM_FEATURE_VFP3)) {
+    } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  35, "arm-vfp3.xml", 0);
     } else if (arm_feature(env, ARM_FEATURE_VFP)) {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ea6e984da65..79880adaad2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2612,7 +2612,7 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
 #define VFP_SREG(insn, bigbit, smallbit) \
   ((VFP_REG_SHR(insn, bigbit - 1) & 0x1e) | (((insn) >> (smallbit)) & 1))
 #define VFP_DREG(reg, insn, bigbit, smallbit) do { \
-    if (arm_dc_feature(s, ARM_FEATURE_VFP3)) { \
+    if (dc_isar_feature(aa32_simd_r32, s)) { \
         reg = (((insn) >> (bigbit)) & 0x0f) \
               | (((insn) >> ((smallbit) - 4)) & 0x10); \
     } else { \
-- 
2.20.1


