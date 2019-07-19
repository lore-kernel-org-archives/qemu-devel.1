Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D982C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8702184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UI0M0X5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8702184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa4j-0004MP-US
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3a-00088Y-9T
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3X-0005Yb-56
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3W-0005CR-I0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so8750472pgc.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GHJ3UWi076gcoHxg1DQBmNZO36QuD3aqqu+CJJcjV+8=;
 b=UI0M0X5duZMFsvuhBKChZV8Q3IonwiWAvOKRQ0Zetrx3KdqfFTWFMvrb/GUXs6gTSP
 EJyKZrpz2Txv9Prlf3TLzTKim9DwpUXm72h8g5B39M6yWVqCoL0cpJA/1h5sQen/Q24I
 YHbi66ttPl5iR+r89O/R/IXLYjZFhbI3oErz75Jn5QaQRPcjzXIvr162ErZL8fJI04tG
 Qcjey2zEWw+G+nR+YVLT682IIf6xTNFRt2pJ3pYh5jGdrC8A9M0af4UzelwlinfSKtAt
 6292CfGkz3RpCHAuarBJmHBBcfpeFAlKzZX4bcJSH0rodErlzpmCv6+qjUejenzTVw6C
 A+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GHJ3UWi076gcoHxg1DQBmNZO36QuD3aqqu+CJJcjV+8=;
 b=nfqTe1xcJbD0NiXkQdZBj24ZyIMZyTBSqBasvhzwvcgiFuhcnVUlynAbN8uuW5+zRU
 uUO8XgXP9cj5KC8PXfcD7LNPqqUNLYUV6tKgDJ5sCnTrGOxm67u2C83aH/dYHKuh5+7t
 yi0anfOBzLR+VnbDTJrTiT4Taphj39vrSoe2d4G86HXk1nQgvgep+6nJ7vKPGA/VhAhy
 Gw7/DbnPmSiCKOsnJ8c6kvyZhgw1LxkRY9MFMTQswwyE+Wu25obU8gOneA9d7RYdc20Y
 9JjRaJi6uKYpG/C0cI9R/da9ANXn6chwtL01aNKBuDJFbjY5uTA0lVGKi/p3pDXEsKyX
 PtPg==
X-Gm-Message-State: APjAAAW4UOVNws6d40IHGo5dXVDdvOfNwz4bfj1La2vUrt4LLsFYb9b+
 wEeUMvqYnAkU7kn/A3iLY/lSttr09JE=
X-Google-Smtp-Source: APXvYqwVrsEqJSOGHoXP/CE81jLbFWWioMzlQxvPpGQQjlk019aPX/509MfuwBdNds12CtXAG7QKPw==
X-Received: by 2002:a63:89c7:: with SMTP id
 v190mr54263084pgd.299.1563570231150; 
 Fri, 19 Jul 2019 14:03:51 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:21 -0700
Message-Id: <20190719210326.15466-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH for-4.2 19/24] target/arm: Install asids for
 E2&0 translation regime
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

When clearing HCR_E2H, this involves re-installing the E1&0 asid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index db13a8f9c0..22eb056b27 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3516,12 +3516,28 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
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
+    idxmask = ARMMMUIdxBit_E2 | ARMMMUIdxBit_E0;
+    asid = extract64(ttcr & TTBCR_A1 ? ttbr1 : ttbr0, 48, 16);
+
+    tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
+}
+
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     raw_write(env, ri, value);
     if (arm_hcr_el2_eff(env) & HCR_E2H) {
-        /* The ASID field is active.  */
+        /* We are running with EL2&0 regime and the ASID is active.  */
+        update_el2_asid(env);
     }
 }
 
@@ -4652,6 +4668,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     ARMCPU *cpu = env_archcpu(env);
     /* Begin with bits defined in base ARMv8.0.  */
     uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
+    uint64_t old_value;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4678,15 +4695,25 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
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


