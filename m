Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F6C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8B2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6Yc8ZuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvbY-0004Lq-DW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN6-0005Tj-UP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN2-0003jd-SB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:51 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN2-0003iX-Kq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id t132so32632817pgb.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YBFs9iOiLgu7VKenmzw4aXW6nYPbjotzvVPML6HKYTM=;
 b=k6Yc8ZuBX4U2Cf5P4Q38L4WBfL+KxeqRknh+AXILTGEQ6PRNkpVJa9gf4KdGj+GTcb
 0bD1ELvDm4LRZtVLcHYvYdHus+mHicLOuU/hMLVTVWhC5jdvQCLcohfYwzVSMDEbsGB3
 XTIqIhLnFrOXrR02pYdmjKHgqZDgwekvj+c8V2mIjYs1H1tvwDM+UrSqeVJAkFFcOm0z
 sn9sGlpsNaLxmcU/Z4QzX91A18J/jZy7uRcR2s5cF1WdcAcG1gh22MRBMoB0ymTvQU+9
 2fsn9g5XmvZKmGwvzrMTyaFFzNeNajzhzUfcUmlfYNK1AeXUWuvHDkO+OqBexipY0/+i
 hD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YBFs9iOiLgu7VKenmzw4aXW6nYPbjotzvVPML6HKYTM=;
 b=YfhhTWSvf94qBkgdMk/DV4YeYuBCxb3YuBnLDkKULA4YU7iJzTiR0ELYf9TmI48bAz
 n2vnjddb3MioYifddWBHRAN87mEts0hl+Yh1XmEMi8i0V8vd94uy9uk5RJlSwUCqWyGp
 JvS85zZYsUlnPHcqh/g9DSLTghH46mrS9+XtmOw3hRWgq4JTqcvNego2mVpoxkc7QpRd
 YhVyzKys2LRBhL8GHkRB4hehvbveDquqD0ScvWZHtg3i4/pfzOXEkP5sKutdFZsDcflZ
 o/M4aDFNQIQZXKxWS0D/c9ndqHfiRUoHt3Dt3/z9aNc1GBeD/GWz/22E/0fATrQqnGEj
 3uVA==
X-Gm-Message-State: APjAAAU+pxfMb8gEhvmWNQ+8aBaVZr6uLrrtUgvAg4T2sGVs6AELDrw0
 g8geTC5WsJTzn9+y7Qpf9NJrb1bi2o8=
X-Google-Smtp-Source: APXvYqzs+e0yce+b0Wn1L/LBNw7LkwwUyudDlOpEWjZbRa2l+ynSc3FUc9+06wJlMLvxDRLu2eneyA==
X-Received: by 2002:a62:8246:: with SMTP id w67mr50443183pfd.226.1564605527448; 
 Wed, 31 Jul 2019 13:38:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:07 -0700
Message-Id: <20190731203813.30765-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 26/32] target/arm: Flush tlbs for E2&0
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
index 30f93f4792..b9f0d387f4 100644
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


