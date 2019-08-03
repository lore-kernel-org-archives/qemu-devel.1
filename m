Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C79C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED2B2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 19:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyd6gD5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzHD-0001g7-Mt
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 15:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz53-0006p4-5e
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz52-0007Nx-2h
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:37 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz51-0007Nc-U0
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:36 -0400
Received: by mail-pl1-x644.google.com with SMTP id az7so34857836plb.5
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MpItA1dQTcuKZiJtCdjWs8WMTH2c/gBkJl0/pbYk+Ag=;
 b=dyd6gD5w/4Z2lzudxNV49llWNQPEJUnKWUVoGSgnqRWeB254Fu61z1VLQlr3V41LAf
 PUcSyUdJt4beh8L3lxmOq/VU6wJutjNQ9Bm2BEiE+OKjKmv/ef84XRZmNDgk4IEmUbEh
 X1jSvQReMowgAPMPo40P7JTnmTGiW7nVwAU1FRYBAfV8jHXjWfRNZI6rNiRqGBzlm825
 lfBfdP2/EIZlhzW8egdiiEFA8GDjYJIUQwt7pdjWMTU//wYGNPmxPqGhfCtUhtpwWScx
 +ifF/NZ80NPq3l2CwdHxEuuWSsCV5JhdPP/aBf25qxm66O/OUmdNyRN6y/7A5QW277e2
 ozbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MpItA1dQTcuKZiJtCdjWs8WMTH2c/gBkJl0/pbYk+Ag=;
 b=RZHOBlOZQtUq877ifM8BfVWfZg185HsvaQVhzKW96kvGHkoXVZ9fFW5DoO4zChaClk
 wBrJA5jpvKTuQ1xPA3xJSj+DcrC+66rRQM3JYHdFtsP6o5EARWkJ/6+X5JPYNh8awiHt
 flBl/taPBb8FIQP8SoxImxGPa8jA8ywy8y+sOX6HHWIx0hCWnEJWBuc3FVT3X44IJUqm
 VHhBPlocyujMv3+pDyeyxVfJ9axcVBUMBYMq0dZjEUSzVXJxCDlK6RNarIjf40z9ehM3
 RhKJPBU6WNuAb0R98w6ctvE6ofHm5aEU8i0TdDuZFRQNsInVwIv3pVJhHkJH/Bwx5yix
 dy8g==
X-Gm-Message-State: APjAAAUM1dpHo3oE7eew92EP0zey11OChAeEzonN9ERw9Nw/9GKKH3/a
 7yKrUkYmymGRLhkXX4Cu/3thKRX/fdY=
X-Google-Smtp-Source: APXvYqxR9hfFUx1qDYkUQWg15/UHOUV54tjNdwJbJkiJo9V2NUyvUCuagpp9ouCdRYROePBGgNLE3A==
X-Received: by 2002:a17:902:112c:: with SMTP id
 d41mr126176670pla.33.1564858114794; 
 Sat, 03 Aug 2019 11:48:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:53 -0700
Message-Id: <20190803184800.8221-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 27/34] target/arm: Install asids for E2&0
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
index b8c45eb484..9d74162bbd 100644
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
@@ -4670,6 +4689,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     ARMCPU *cpu = env_archcpu(env);
     /* Begin with bits defined in base ARMv8.0.  */
     uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
+    uint64_t old_value;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4696,15 +4716,25 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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


