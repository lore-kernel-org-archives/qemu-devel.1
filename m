Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B6C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955682171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylcLI33w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955682171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvU3-0003x6-SW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN2-0005PO-8U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN1-0003hI-3w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN0-0003gn-U7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id u14so32533841pfn.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LCePFTUgV8mXAATt2U3SG8TFwN2aa4K3amCrfCCSR5k=;
 b=ylcLI33wAu8jB+aF2RW3yIA7CY7z4OkSO67AZXkNhw0oJWzLdIplqnhrrRQRhUGiX+
 MRrS1dCFaWrcsZ0CO/dMpxAui4+ZBtg6dRA+TlZauo6VV7NXtil+5dpCzWVBuUm8dJko
 /9CVVD5eQh14fJaRha5bs2zg5EnLxDyMGgTBKJduh6Tact3fBZf1Zyl7r+KrKheGa0L2
 582ykZER8T+zrtCCauIOt96pruwGsEkhYX2Ydq4ZcFPUvZrO2H7Yb1eItzoLkCLK9pV/
 li33q3IkeJPZf4kTyGLEMWO2Ad7kUp+8GQITwwrzPkOgBn9Y6TwLlsRNmyHGrAuvKeoE
 xQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LCePFTUgV8mXAATt2U3SG8TFwN2aa4K3amCrfCCSR5k=;
 b=hszQfhAzO1gbLiewpBPR6wEyNs/XNj71Op47fGPYD5ZDRDyBtI+qh7pbsThaYg+qhH
 cw5eCD/mpTqjWOz507Y4xvNaF2qvDuQcaBFpYuZULoBjntvOxVVrNSyRs7JgOSZ6IgMd
 dsOGCtfIeqA6WESAJ+NoNNHC6RFnQ1GdxV60HEIzOsjtIw/wEcRPkKgV/n+uIJ4RRBKw
 WudHjcR/PiS8DjGPGKWlUElq1KVfeiqwtZ9VzUvXoAytoHOyqPPIBmOySbc6Qz65I4YQ
 NYdPYBfTHAo1GNJULUEeWqZDBJIDZj4qN5k2Nl1GtpnXUh9dzB0x0UGFRtdX2qEG7Tjh
 KGfQ==
X-Gm-Message-State: APjAAAVToFgKEw2AqdKOKNq1ZcPdAIihsmpMpqfavTc7Kset6U/B/YbF
 N+KjHz4VF77ttfOPXv2pLeyhkFbEIeU=
X-Google-Smtp-Source: APXvYqxnYjLEeHlM08/x5xP620ezHYZoGXIJPtdB14e+wl1qym3Dj9OqqPwR/DEsiQD8o7781IX0JA==
X-Received: by 2002:aa7:93a8:: with SMTP id x8mr50841612pff.49.1564605525791; 
 Wed, 31 Jul 2019 13:38:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:06 -0700
Message-Id: <20190731203813.30765-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 25/32] target/arm: Install asids for E2&0
 translation regime
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When clearing HCR_E2H, this involves re-installing the EL1&0 asid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2883d6e568..30f93f4792 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3518,10 +3518,29 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void update_el2_asid(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t ttbr0, ttbr1, ttcr;
+    int asid, idxmask;
+
+    ttbr0 = env->cp15.ttbr0_el[2];
+    ttbr1 = env->cp15.ttbr1_el[2];
+    ttcr = env->cp15.tcr_el[2].raw_tcr;
+    idxmask = ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
+    asid = extract64(ttcr & TTBCR_A1 ? ttbr1 : ttbr0, 48, 16);
+
+    tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+}
+
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     raw_write(env, ri, value);
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        /* We are running with EL2&0 regime and the ASID is active.  */
+        update_el2_asid(env);
+    }
 }
 
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4654,6 +4673,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     ARMCPU *cpu = env_archcpu(env);
     /* Begin with bits defined in base ARMv8.0.  */
     uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
+    uint64_t old_value;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4680,15 +4700,25 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-    /* These bits change the MMU setup:
+    old_value = env->cp15.hcr_el2;
+    env->cp15.hcr_el2 = value;
+
+    /*
+     * These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
      * HCR_PTW forbids certain page-table setups
-     * HCR_DC Disables stage1 and enables stage2 translation
+     * HCR_DC disables stage1 and enables stage2 translation
+     * HCR_E2H enables E2&0 translation regime.
      */
-    if ((env->cp15.hcr_el2 ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
+    if ((old_value ^ value) & (HCR_VM | HCR_PTW | HCR_DC | HCR_E2H)) {
         tlb_flush(CPU(cpu));
+        /* Also install the correct ASID for the regime.  */
+        if (value & HCR_E2H) {
+            update_el2_asid(env);
+        } else {
+            update_lpae_el1_asid(env, false);
+        }
     }
-    env->cp15.hcr_el2 = value;
 
     /*
      * Updates to VI and VF require us to update the status of
-- 
2.17.1


