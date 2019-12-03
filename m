Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD45C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBF520684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUBiTl0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBF520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyEw-0007r6-5E
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxI-0003M9-Tg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxF-000094-OM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:23 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxD-0008VY-EQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id ay6so1016845plb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sgf9PjMDcr7YkI/Fw1uObi5dAB9s8zvthtA9mINjU3o=;
 b=GUBiTl0d9K/QvgfTFCt5yHLT4hoEcCy4anS6I8v6lAkd5BdOr5vEC5hCDeI5QNv9+S
 2JZYtdqUcnPVm1bCELOZs8qoeh9RJCCsTcV4Mwa6UVXszo3w1kloqf1h/Y0NsYA0BBPZ
 yrPX4mqtIlHjZK69JDGSA70e4exqI6puK7JuV3w570SEYgq2LYltOhhojViW5es9ScM6
 dwR9GTZuuxlBsysrINzuY1Bd2jzVUWagg4gjOW8fd83KQiZPQmLdoviq5OqvtUkspoRr
 UuTvyz+KpW9avgrBWaibvT6kc+kd/XvVCJeTr22Z8LGFNzMY0pv/ZDr/pIrgi7qeZf7I
 xhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sgf9PjMDcr7YkI/Fw1uObi5dAB9s8zvthtA9mINjU3o=;
 b=mrUAbEjJEgaRe0i3rKTDAgCvoQGyQojU12doPpOxtBm+Bivw9aOgdNfMnTQGQbim1P
 pGsXmnubr2Jl3EVuo6xkl7nGkvRRp5UAW/FAVrwTFMLLqWLEXvyyx2I1bxAMe4226PGI
 QwVKJXwF9ZndPQRlx0+oUArqQRr8PD3umru5wHjYaX5fnAUmN62pFTh7kvt5nbI7zoSE
 YoEcy2nHgtMRh7r2fdtBiMmK6DyQZxtBAL2HsJAh+sVyxyOxnmqlW0xjiHm4VAIvGa2l
 7eXtOTVA4A5x3ST1icOc5Mo/ERy+CT+VeEhz6oBzfM4OtJEuH+Gg+vNvTNngPi/GRDcK
 m4sA==
X-Gm-Message-State: APjAAAWF8WJvVvU3x92j90Xti0LqoFjtx9+FNSstdHZEeQaa82pmry3m
 YXvQNcgdaAO1HzUZk4UtQvjCr6Qz6qA=
X-Google-Smtp-Source: APXvYqxqhdsOrHoCMI6js5wteaRS2kgsejeukOFOQOOTq4NI93VDgbbzAKR2a+2J3dzMb2IqbsgSOg==
X-Received: by 2002:a17:90a:ae01:: with SMTP id
 t1mr2959645pjq.32.1575340217654; 
 Mon, 02 Dec 2019 18:30:17 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 30/40] target/arm: Flush tlbs for E2&0 translation regime
Date: Mon,  2 Dec 2019 18:29:27 -0800
Message-Id: <20191203022937.1474-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2a4d4c2c0d..b059d9f81a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4123,8 +4123,12 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 
 static int vae1_tlbmask(CPUARMState *env)
 {
+    /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
+               == (HCR_E2H | HCR_TGE)) {
+        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
@@ -4158,9 +4162,14 @@ static int vmalle1_tlbmask(CPUARMState *env)
      * Note that the 'ALL' scope must invalidate both stage 1 and
      * stage 2 translations, whereas most other scopes only invalidate
      * stage 1 translations.
+     *
+     * Since we exclude secure first, we may read HCR_EL2 directly.
      */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
+               == (HCR_E2H | HCR_TGE)) {
+        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
     } else {
@@ -4177,13 +4186,22 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, mask);
 }
 
+static int vae2_tlbmask(CPUARMState *env)
+{
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        return ARMMMUIdxBit_EL20_0 | ARMMMUIdxBit_EL20_2;
+    } else {
+        return ARMMMUIdxBit_E2;
+    }
+}
+
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4208,8 +4226,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4227,11 +4246,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * Currently handles both VAE2 and VALE2, since we don't support
      * flush-last-level-only.
      */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.17.1


