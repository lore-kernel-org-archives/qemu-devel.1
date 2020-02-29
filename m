Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D3F2468D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq+2nEB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D3F2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qyC-00023w-9z
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvU-0004j2-58
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvR-0005y0-Kw
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:19 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvR-0005xT-G9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:17 -0500
Received: by mail-pf1-x442.google.com with SMTP id b185so2590483pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f02zxp7l+Sqo1gI6cxnt5pVpIauWmflCG9BwYQEIz+Q=;
 b=gq+2nEB6tyfr3suuUaJuiFLEN8m1kb2LsIfDX2ppB3XERpvWN0o0Ta5vf0DLZlxshs
 BREHJsZvV98bBlvrXdZGiMAGIuPTx5xr4QN/l+QRfFHHUnRLCXSlEM7UhxAM6Rxw9MIy
 30ULRp743uMLYPFflyx12tJ6TO4FPVm+N3iFQSCKMxwbe8UMTF4ll1YRDkAqrA21pp+k
 B8wJLfOdGQvSfH1c63nwVWPvg/Zw4Gm4gvo9snbqd2Qn4kZsZliAeAEQsJZo07/WEJYN
 IIp1HdTZyoi3jmo4we5EGhkK23OtfzPeCkQFEMkWOfY/d5I09xMt11/aTF9YRNjExjtR
 hkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f02zxp7l+Sqo1gI6cxnt5pVpIauWmflCG9BwYQEIz+Q=;
 b=SH1pKHWPPdn82g2Sm+5NuRh+Zvuotx+9zC549B/FM0pWcTc0cIZa303YlJ/aVJIDPe
 yH/oLiz/IpNPUr3XpcGGfLYuPHETTSc6yZHq6LG+hHpBPQ/FZYomgzfhWVHHMoVutGvG
 yPDEvsc2MgvHpt8W0Wn+vStq9qoouWl4d4OZ24VNkc3y4Ty9OtUnm9DULob4Qpk0WfTV
 UHQbXPM6GIWq94gDG+bmoHlokpaF0nx4Js9IBCVIRMRcrmyhkKETkvIjSuF9b4onGfJy
 9ujh7OMCabpJAtAGSFh0eDdPiJjzw/EGIvIoDWWWGQ0mUmI5VP05VunYYMApuznJgh1z
 HF6w==
X-Gm-Message-State: APjAAAUVFvuhvFoZTrhT12CURV31voQMhlMu9gc3PulHdb0Rct+GhWdq
 1ZKPC28ubG2LmjSMnL72nqLVkwx6hVw=
X-Google-Smtp-Source: APXvYqxH7PSKC4OcarpZEGhN7oFImq/RUYYrC+yzfnFAc3KtGTxFJlhTw/jt3SmGCco1/b6pUEAoYg==
X-Received: by 2002:a62:f247:: with SMTP id y7mr7062056pfl.5.1582939696093;
 Fri, 28 Feb 2020 17:28:16 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/12] target/arm: Improve masking of HCR/HCR2 RES0 bits
Date: Fri, 28 Feb 2020 17:28:00 -0800
Message-Id: <20200229012811.24129-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Don't merely start with v8.0, handle v7VE as well.  Ensure that writes
from aarch32 mode do not change bits in the other half of the register.
Protect reads of aa64 id registers with ARM_FEATURE_AARCH64.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6be9ffa09e..e68e16b85b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5086,11 +5086,15 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
-static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
 {
     ARMCPU *cpu = env_archcpu(env);
-    /* Begin with bits defined in base ARMv8.0.  */
-    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        valid_mask |= MAKE_64BIT_MASK(0, 34);  /* ARMv8.0 */
+    } else {
+        valid_mask |= MAKE_64BIT_MASK(0, 28);  /* ARMv7VE */
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -5104,14 +5108,17 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
-    if (cpu_isar_feature(aa64_vh, cpu)) {
-        valid_mask |= HCR_E2H;
-    }
-    if (cpu_isar_feature(aa64_lor, cpu)) {
-        valid_mask |= HCR_TLOR;
-    }
-    if (cpu_isar_feature(aa64_pauth, cpu)) {
-        valid_mask |= HCR_API | HCR_APK;
+
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        if (cpu_isar_feature(aa64_vh, cpu)) {
+            valid_mask |= HCR_E2H;
+        }
+        if (cpu_isar_feature(aa64_lor, cpu)) {
+            valid_mask |= HCR_TLOR;
+        }
+        if (cpu_isar_feature(aa64_pauth, cpu)) {
+            valid_mask |= HCR_API | HCR_APK;
+        }
     }
 
     /* Clear RES0 bits.  */
@@ -5143,12 +5150,17 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     arm_cpu_update_vfiq(cpu);
 }
 
+static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
+{
+    do_hcr_write(env, value, 0);
+}
+
 static void hcr_writehigh(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Handle HCR2 write, i.e. write to high half of HCR_EL2 */
     value = deposit64(env->cp15.hcr_el2, 32, 32, value);
-    hcr_write(env, NULL, value);
+    do_hcr_write(env, value, MAKE_64BIT_MASK(0, 32));
 }
 
 static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -5156,7 +5168,7 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     /* Handle HCR write, i.e. write to low half of HCR_EL2 */
     value = deposit64(env->cp15.hcr_el2, 0, 32, value);
-    hcr_write(env, NULL, value);
+    do_hcr_write(env, value, MAKE_64BIT_MASK(32, 32));
 }
 
 /*
-- 
2.20.1


