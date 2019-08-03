Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365FC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7F6214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzRDhP10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7F6214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzDO-0000Ca-5W
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz58-0006rl-Aq
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz53-0007Oe-KB
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz53-0007OJ-DQ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id w3so463131pgt.13
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AKU1gGfJD0fHB3QeRt9QRaO7IOfL7ZvP1zaRZud/BsE=;
 b=RzRDhP10pg0B8kssRnKpGMDyeZ0CTYSkr/iXpyetK+I8OqDcpyaHvTOEzBw9q1+vnS
 yRXRNdfbYkO7LoK95UnEZ+G6QuxWCyTwjDy/eBXf4WpoKjVDPqMUSIS5pHc7BzDaztVT
 8f5XPqSlCC5FCy6ick5E2j062jJ91k70CN8IBZxr5CsWTIB29MKBccHdbLbERCCpFMur
 vS8dfJo8ddRCKHLQzpXt1t+/3sjVieV8Qz0Z01+0EuNNoAJL4eGO3RVvsKoIaltd1syB
 eBQh2rtbnAiKOx1WHALl/cLcW2DlglBKn8iLF0Bdx8cm3qv2uCP7WuYf68vS057Sy+1Z
 KX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AKU1gGfJD0fHB3QeRt9QRaO7IOfL7ZvP1zaRZud/BsE=;
 b=CWo3nh0Okf/xfFRttII0SALON4RbDIJ/wUSIW5f8C2pLd5Zp76lWjhroySFnEDoecE
 myk3hYVC+88/FOChNm5Idv1pczLNHOXKIC6xPjLjavahP62sYi1kGK8/l/tQ1E2AkR5q
 3qvPrWpDcatRjlGvNGu9Wc34lpgloAuO/9jUNlJ3f3wjRtm0Qz5LDbX13nvELfyuUUOu
 uEvWwt4sxh2tZBBbzkTFybD+EhDSaJtC1mixPUMvfQNV9SU67bSsueXCyqje8tYKzrFr
 xEV2tA9jra2CHFjAoe1brXZTuD4pkLEcVh8DkyfVt5sPvgmI7XL8ZFdPgplf9DuQxOTj
 UOHg==
X-Gm-Message-State: APjAAAXymRkdADGaHRp77HMvyMaXw5BbGAbC0EawFYoT0qe3rDFhTzq+
 oNpd+2HQSJXelb3kGxlXjlpkLUyhCOM=
X-Google-Smtp-Source: APXvYqxfGRFlZW0fGSbd060rHVdWw+XBpeejBw0pnbxlt97oLl0uZuoml62TGlrd5/xB8IhgPdTSOw==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr133449832pgr.52.1564858116151; 
 Sat, 03 Aug 2019 11:48:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:54 -0700
Message-Id: <20190803184800.8221-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 28/34] target/arm: Flush tlbs for E2&0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9d74162bbd..984a441cc4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3917,8 +3917,11 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 
 static int vae1_tlbmask(CPUARMState *env)
 {
+    /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+    } else if (env->cp15.hcr_el2 & HCR_E2H) {
+        return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL10_0;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
     }
@@ -3956,6 +3959,10 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
+        /* Since we exclude secure first, we may read HCR_EL2 directly. */
+        if (env->cp15.hcr_el2 & HCR_E2H) {
+            return ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_EL20_0;
+        }
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0 | ARMMMUIdxBit_Stage2;
     } else {
         return ARMMMUIdxBit_EL10_1 | ARMMMUIdxBit_EL10_0;
@@ -3971,13 +3978,22 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -4002,8 +4018,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4021,11 +4038,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
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


