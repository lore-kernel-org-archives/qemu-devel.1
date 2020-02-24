Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DA8C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182882176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIiZp6BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182882176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MHP-0004rg-5R
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7e-00046A-D9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7d-0005o0-6C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:42 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7d-0005nN-0s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:41 -0500
Received: by mail-pj1-x1042.google.com with SMTP id d5so353532pjz.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fkzyGWRSXdTJhJxOryRfsTh15ycVqgk6twtD/0ShqhM=;
 b=ZIiZp6BQh+GleQv7Rca9wbyU29s8BiX2n4uTR5x20mHeKhHbeebuX10GFqD2eluxOF
 tRazJJiFtlhw4byypMlQrIcFmTcvKFGF2V9TFs8emCHyF8K4lb41bSseWDu/pdLIx0qr
 9iAMcK5Wpqmblmz8rsO42bucwfaAHrueDlm40r3zyLML/nqAGtJncI6yfbmERfJFCRSO
 osetWS7UntZ3ANyaQ+XlcLNfvhDUQUPihLW19yKr1ohMyu6QXl14GkFchAr4bsy186/F
 zBu8bro/sGqV5ExjHQ5IKSgWw84psiP8dOw4Ycwn5imVJthVM/XZREnvTzghKm/1BleQ
 KFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fkzyGWRSXdTJhJxOryRfsTh15ycVqgk6twtD/0ShqhM=;
 b=CIuvpRQKMWRE0PKZOa9dkOWSZNzMp/13Wh0d16f5KM4Mptb62EWqOVIWhLUuT2mN/6
 V7esvuahbLKnSg/obcKe2AOvcYxEkg0qrXapAdhbJnQMNXt+rLvn9QfGneMVXNP+ezAm
 QK8+AqQ0cEvj1TgMFF0yxGKmyXrI34m3ma6L3MPUHkwExlNHNM2SOIvyVW7aDX0TPMWh
 JEztQA0o8SHazareTmZjOuYDX5wrn1qz1T9wdYZA9l8jZlp/Bo0eOZeBOLB5efAMjT5Y
 tCEbcxG3VVMCkUxl+HnHblXuN/kDFAiBtiRUaOM4ctLoZtBXzPCaKIEDwRQMyJwEQuQp
 ReYw==
X-Gm-Message-State: APjAAAVEe/5kLPsNRqy/TzRJMnjUJGe9cru/6JAgT0tCQAwUwaF/uKhw
 xfqVA0Wrq3FTeK/YtHEXNnlr1+lKJYE=
X-Google-Smtp-Source: APXvYqxcBYmHnV+0TierSwaC8cJ2YfYouTi62Gz51hiq27WOJSqS+3lwE5ZjG8EBQUEBbUThYudVww==
X-Received: by 2002:a17:90b:14a:: with SMTP id
 em10mr1479681pjb.4.1582582959513; 
 Mon, 24 Feb 2020 14:22:39 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] target/arm: Add isar_feature_aa64_fp_simd,
 isar_feature_aa32_vfp
Date: Mon, 24 Feb 2020 14:22:19 -0800
Message-Id: <20200224222232.13807-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We cannot easily create "any" functions for these, because the
ID_AA64PFR0 fields for FP and SIMD signal "enabled" with zero.
Which means that an aarch32-only cpu will return incorrect results
when testing the aarch64 registers.

To use these, we must either have context or additionally test
vs ARM_FEATURE_AARCH64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 11 +++++++++++
 target/arm/cpu.c     |  9 ++++++---
 target/arm/machine.c |  5 +++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f7a90f512e..b94d2a5ace 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3494,6 +3494,11 @@ static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
 }
 
+static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
+{
+    return isar_feature_aa32_fpsp_v2(id) || isar_feature_aa32_fpdp_v2(id);
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
@@ -3696,6 +3701,12 @@ static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
 }
 
+static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
+{
+    /* We always set the AdvSIMD and FP fields identically.  */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index be4c2a1253..5be4c25809 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1260,7 +1260,9 @@ void arm_cpu_post_init(Object *obj)
      * KVM does not currently allow us to lie to the guest about its
      * ID/feature registers, so the guest always sees what the host has.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+        ? cpu_isar_feature(aa64_fp_simd, cpu)
+        : cpu_isar_feature(aa32_vfp, cpu)) {
         cpu->has_vfp = true;
         if (!kvm_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
@@ -1636,8 +1638,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * We rely on no XScale CPU having VFP so we can use the same bits in the
      * TB flags field for VECSTRIDE and XSCALE_CPAR.
      */
-    assert(!(arm_feature(env, ARM_FEATURE_VFP) &&
-             arm_feature(env, ARM_FEATURE_XSCALE)));
+    assert(arm_feature(&cpu->env, ARM_FEATURE_AARCH64) ||
+           !cpu_isar_feature(aa32_vfp_simd, cpu) ||
+           !arm_feature(env, ARM_FEATURE_XSCALE));
 
     if (arm_feature(env, ARM_FEATURE_V7) &&
         !arm_feature(env, ARM_FEATURE_M) &&
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 241890ac8c..c5a2114f51 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,9 +9,10 @@
 static bool vfp_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_VFP);
+    return (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+            ? cpu_isar_feature(aa64_fp_simd, cpu)
+            : cpu_isar_feature(aa32_vfp_simd, cpu));
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-- 
2.20.1


