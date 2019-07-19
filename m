Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C2C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DDC20880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBVQdbb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DDC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48253 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5S-0006kY-0L
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3j-0000Kw-FY
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3h-0005gI-BX
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:54 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3g-0005Cu-DL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id b7so16204213pls.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u+zufnM9gRgzS4x3zT5MZp9Zbq0icAPgD/z46c/Vn/8=;
 b=EBVQdbb40qsdrjb1HYN0dW6Lmr0OYmWD72rwDfyQNsyz+PyS+xC6/EpOoV1PtvqEAf
 Lz9r5xH/zAkYVfzlVhns96lY0X7y+wGakxMP07jJPDbbBFlmFp0h1UmEb/dYu/oAE8Sj
 JzKg9n1UwD6/EUfNv+w5FdcS2xEMUxMrI+caP4qyFroemVfpwg7ixoHTn0COZ2mzI6AF
 PNRJbRe2sQUdsAG76Zw563yoskDt3xbfMUUeGugF3JHnjmO3Oq1CmAV9oumnfLjlWRwY
 8UTucg21wUX9oWu0MJZv1nZcfat5xTnSv81y2hK8s2zQ22iC6RPGDO12wX8qbjsNp3x6
 JHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u+zufnM9gRgzS4x3zT5MZp9Zbq0icAPgD/z46c/Vn/8=;
 b=pd+VQ9kf1oAh42O8sObhMfXDz6+gDZarQLUQMKqe+MOcpvdM0hDI6B3WGWKRAV0Lb8
 K8LRacm/6k22MlTdYINUWmX55NncD3apK+genAb5XC4Ynkuhj+UDS1oGZAzDB/X1oVae
 TZEDNlVM7kC2SL0jv3GxouyAX0uUW7pdEG7qS6aHJDlHc+pDZqbw/Zq9ZtKql9ttq2xE
 /tRMCF3foxOgUR46S3FDgFg2IS7gEE8s9X6LyBXZGlBEpF31OJDC8nANaZ+B2AwlvUjt
 vjyKSd/PuDPLj27eSz6qr/N0pB8z+IQml9KaM6TC9jBItPYiTOKQXOMZd03w3uZYxrmv
 0oCQ==
X-Gm-Message-State: APjAAAXJnqt9POyt0c5O1x/fJdKkZTCfHPEEl5ODHDnkFvs8LjHroI56
 KdV+uGoVXrhJG2w/S+YfgFUY2Vdn1ks=
X-Google-Smtp-Source: APXvYqx0pUvSlgCRT4udLbBs/ItH2yelyuwQ4tybmUhkNj2Xwls1fD1Nm+Lp9BXK/JPe7qL1/tVTMA==
X-Received: by 2002:a17:902:9041:: with SMTP id
 w1mr60290622plz.132.1563570232442; 
 Fri, 19 Jul 2019 14:03:52 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:22 -0700
Message-Id: <20190719210326.15466-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH for-4.2 20/24] target/arm: Flush tlbs for E2&0
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22eb056b27..fe022f51d6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3915,8 +3915,11 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 
 static int vae1_tlbmask(CPUARMState *env)
 {
+    /* Since we exclude secure first, we may read HCR_EL2 directly. */
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
+    } else if (env->cp15.hcr_el2 & HCR_E2H) {
+        return ARMMMUIdxBit_E2 | ARMMMUIdxBit_E0;
     } else {
         return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
     }
@@ -3954,7 +3957,12 @@ static int vmalle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_SE1 | ARMMMUIdxBit_SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0 | ARMMMUIdxBit_Stage2;
+        /* Since we exclude secure first, we may read HCR_EL2 directly. */
+        if (env->cp15.hcr_el2 & HCR_E2H) {
+            return ARMMMUIdxBit_E2 | ARMMMUIdxBit_E0;
+        } else {
+            return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0 | ARMMMUIdxBit_Stage2;
+        }
     } else {
         return ARMMMUIdxBit_E1 | ARMMMUIdxBit_E0;
     }
@@ -3969,13 +3977,22 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, mask);
 }
 
+static int vae2_tlbmask(CPUARMState *env)
+{
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        return ARMMMUIdxBit_E0 | ARMMMUIdxBit_E2;
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
@@ -4000,8 +4017,9 @@ static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4019,11 +4037,11 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
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


