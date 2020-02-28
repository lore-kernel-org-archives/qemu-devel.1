Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DEC24672
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKqo9iVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DEC24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ixj-0007iM-Q5
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifN-0007tD-0b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifK-0001yj-QS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifK-0001yH-J0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id p9so3856107wmc.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Li0UuQunOn+1b7qXuee2MpCV0HZHZNa8ULuV4VqSjn8=;
 b=UKqo9iVSitRHWZURRI1pFbDNnKB18/hrLd1Kf/tZm9OEiaj6UrvkFkhfZnHThFDf0d
 RlT5TESIKzdHdwzDUTp2UXubH2D4F+QdF/edesskaGRo9pCnhTmcKLnEdHBWh0byHAra
 t4B40GkEmN3Zc7c16zQIGwPtpzk6hwHS9eBYiNN8VCZi8rzp1tL6GHLvJKn9Vy0jY62p
 zqcCdWNdjsX5QO6wNqSijZnWXJ/rxnAQdt430HjAYgPe7o5ISqF5fBKM6CHBo6WOocZr
 EWNEg8y6ooNJeBSOZRFbXRqkO24qkPC0cxNuMDVF6Z2GHxS+RQ/cvHC+ikOp0Xmn9NS3
 T9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Li0UuQunOn+1b7qXuee2MpCV0HZHZNa8ULuV4VqSjn8=;
 b=PzOkciJizfon9KAAQ/ZR8j8wrfiYpdG85ONaqCN6SZ/OUMJiPqtlODUG4Wt8KOFZDL
 zhDSEIn/P6GaGs+gUCD2N1W+jTCmAVrXK2pQagoQKjGTBOwt2H/hAPXxpDOXbaVhCkfP
 u5m56YcgIhNl7Y3Sza1T0BBw7mvjJ9jqPhuG8AP+R2BQVktWrEbhVzXj0VB3Wt2EDqsV
 MXFAKLWWY/0o44Bc5JqGVLibyR3K4A/bQz7T/Rpo4Wnrht8Czj/bOYeYVwfUK48yeMAJ
 UhR/f/tccJOU0TPCHDyxddKgMXMINVbK05Z2JsqGchAamTLe90ZH3CoNO8Kdj2ZOweuD
 WBzg==
X-Gm-Message-State: APjAAAVhyn5s51doIREG1wpzpplVY+D3g4FEpOKpG3L2tTPqN8uE9jdc
 tBiiLKFJ4Ubg4GWIqKYeaVwMonPmNJWvUQ==
X-Google-Smtp-Source: APXvYqzIyksyoUB7B0sxJ1dIxa4WNU9mQp6mrY/NuJeeSzaA3Ol+gEiVQW5weqFwGNq0ME0PBwFsfA==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr5639318wmh.84.1582907945050; 
 Fri, 28 Feb 2020 08:39:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] target/arm: Remove ARM_FEATURE_VFP*
Date: Fri, 28 Feb 2020 16:38:26 +0000
Message-Id: <20200228163840.23585-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

We have converted all tests against these features
to ISAR tests.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   |  3 ---
 target/arm/cpu.c   | 25 -------------------------
 target/arm/cpu64.c |  3 ---
 target/arm/kvm32.c |  5 -----
 target/arm/kvm64.c |  1 -
 5 files changed, 37 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b29b0eddfc3..05aa9711cd8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1880,7 +1880,6 @@ QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
  * mapping in linux-user/elfload.c:get_elf_hwcap().
  */
 enum arm_features {
-    ARM_FEATURE_VFP,
     ARM_FEATURE_AUXCR,  /* ARM1026 Auxiliary control register.  */
     ARM_FEATURE_XSCALE, /* Intel XScale extensions.  */
     ARM_FEATURE_IWMMXT, /* Intel iwMMXt extension.  */
@@ -1889,7 +1888,6 @@ enum arm_features {
     ARM_FEATURE_V7,
     ARM_FEATURE_THUMB2,
     ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
-    ARM_FEATURE_VFP3,
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
@@ -1900,7 +1898,6 @@ enum arm_features {
     ARM_FEATURE_V5,
     ARM_FEATURE_STRONGARM,
     ARM_FEATURE_VAPA, /* cp15 VA to PA lookups */
-    ARM_FEATURE_VFP4, /* VFPv4 (implies that NEON is v2) */
     ARM_FEATURE_GENERIC_TIMER,
     ARM_FEATURE_MVFR, /* Media and VFP Feature Registers 0 and 1 */
     ARM_FEATURE_DUMMY_C15_REGS, /* RAZ/WI all of cp15 crn=15 */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc45865c7a7..e6016e33cec 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1208,13 +1208,6 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
         set_feature(&cpu->env, ARM_FEATURE_PMSA);
     }
-    /* Similarly for the VFP feature bits */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP4)) {
-        set_feature(&cpu->env, ARM_FEATURE_VFP3);
-    }
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP3)) {
-        set_feature(&cpu->env, ARM_FEATURE_VFP);
-    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
@@ -1442,10 +1435,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        unset_feature(env, ARM_FEATURE_VFP);
-        unset_feature(env, ARM_FEATURE_VFP3);
-        unset_feature(env, ARM_FEATURE_VFP4);
-
         t = cpu->isar.id_aa64isar1;
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
         cpu->isar.id_aa64isar1 = t;
@@ -1865,7 +1854,6 @@ static void arm926_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm926";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
     cpu->midr = 0x41069265;
@@ -1906,7 +1894,6 @@ static void arm1026_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1026";
     set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
@@ -1954,7 +1941,6 @@ static void arm1136_r2_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -1986,7 +1972,6 @@ static void arm1136_initfn(Object *obj)
     cpu->dtb_compatible = "arm,arm1136";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
     set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
@@ -2017,7 +2002,6 @@ static void arm1176_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm1176";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
@@ -2050,7 +2034,6 @@ static void arm11mpcore_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,arm11mpcore";
     set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_MPIDR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2116,7 +2099,6 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110021;
@@ -2147,7 +2129,6 @@ static void cortex_m7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x411fc272; /* r1p2 */
     cpu->pmsav7_dregion = 8;
     cpu->isar.mvfr0 = 0x10110221;
@@ -2179,7 +2160,6 @@ static void cortex_m33_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
@@ -2263,7 +2243,6 @@ static void cortex_r5f_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cortex_r5_initfn(obj);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     cpu->isar.mvfr0 = 0x10110221;
     cpu->isar.mvfr1 = 0x00000011;
 }
@@ -2282,7 +2261,6 @@ static void cortex_a8_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a8";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
@@ -2350,7 +2328,6 @@ static void cortex_a9_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_VFP3);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -2415,7 +2392,6 @@ static void cortex_a7_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a7";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
@@ -2461,7 +2437,6 @@ static void cortex_a15_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a15";
     set_feature(&cpu->env, ARM_FEATURE_V7VE);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index db695384ebc..8f2a43c938a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -102,7 +102,6 @@ static void aarch64_a57_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -156,7 +155,6 @@ static void aarch64_a53_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a53";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
@@ -210,7 +208,6 @@ static void aarch64_a72_initfn(Object *obj)
 
     cpu->dtb_compatible = "arm,cortex-a72";
     set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 7981ae3bc4e..f703c4fcad8 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -147,7 +147,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * bits, but a few must be tested.
      */
     set_feature(&features, ARM_FEATURE_V7VE);
-    set_feature(&features, ARM_FEATURE_VFP3);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     if (extract32(id_pfr0, 12, 4) == 1) {
@@ -156,10 +155,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_NEON);
     }
-    if (extract32(ahcf->isar.mvfr1, 28, 4) == 1) {
-        /* FMAC support implies VFPv4 */
-        set_feature(&features, ARM_FEATURE_VFP4);
-    }
 
     ahcf->features = features;
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0ad96c3500a..93ba1448daf 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -649,7 +649,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * feature bits.
      */
     set_feature(&features, ARM_FEATURE_V8);
-    set_feature(&features, ARM_FEATURE_VFP4);
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
-- 
2.20.1


