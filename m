Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64627C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABB52468D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSKJdm1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB52468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qy9-0001wc-BD
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvf-0004wk-3q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvd-00067G-FK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:31 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvd-00066Z-1P
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:29 -0500
Received: by mail-pl1-x641.google.com with SMTP id d9so1900342plo.11
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=efqTpSOjpSCCNnyOhAFLjdUflto9CJ4CEmzuEd6bw/4=;
 b=KSKJdm1MWHzP4+FvHsH/rsgi5SDI7HyZ06m1p5Ow1bNKKarULv0AuXB938wRximmtJ
 X42qmN0Royp3cbfS9oqQ7jS1ykjwNf0bWFbvwFs/PTb100ZA6YKyUt8rVMqzWZ/daJ30
 vZDRLE3o2YOMa/qsJAHvwJsLaNVbmfx8K+LDOzonydZlBhwOllKKtCGLzA3pERtvoc38
 92X8DSLdbxcU7os87CCZzwRNL3gIrJs3arlNCwaMUDb4Cic8IyST74yEkvKbJg9U+hdx
 JcKAQYmaU9ZH0dGxcD1hFmqwFPtHtHETPKFT9Xkj5+G5ur3x5nGVk+a9vCrACYmTTQy/
 pJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=efqTpSOjpSCCNnyOhAFLjdUflto9CJ4CEmzuEd6bw/4=;
 b=Q1kFeNF4oudOa3QlyCAyowgQfSH22SyE07ZAg+aKIwDSbT/qmD697k5ACIiuiSrEy2
 03S1ZTCiOot2+GfWhjM6UA/t9TUCf6J4wK6ruODfTUwM9Fme5aDDwr3Grp+rAuptrVXZ
 pQIU9/GAWuGEPD0WxoYAk/oyDl0MjyJb5menQB+e+9D6zzGynDmRYJ1XVNoWULFnp0P1
 rXsrpii2i0OGnO5Gwo9JpTCklTa0RahXKHaSOa6kqJa3vRJwpYy+DmUGipEiOMAZDfjW
 eJy8UfbhYTpQC9Y4W1qGB2Vib9LaGT0womAyEQXYDWWWc8M/KIOC5AA1Onp7Gx69LieO
 AXcw==
X-Gm-Message-State: APjAAAWcQAXRAdzcHvlo+SIIVpgH7ob37v9Z1YCyW3KeOdFN9nfhdQBd
 Ygx3DrvFvsCgwZK6838bwHWpO7EltNo=
X-Google-Smtp-Source: APXvYqzjEqvjGJG9lUlXsNrC9eXXePkg+s9beHuvoW0unbqLXhgpHnXQ/TMOamJxljwUFBTUsN9TFA==
X-Received: by 2002:a17:902:b7c2:: with SMTP id
 v2mr6204491plz.54.1582939707425; 
 Fri, 28 Feb 2020 17:28:27 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/12] target/arm: Honor the HCR_EL2.TPU bit
Date: Fri, 28 Feb 2020 17:28:09 -0800
Message-Id: <20200229012811.24129-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit traps EL1 access to cache maintenance insns that operate
to the point of unification.  There are no longer any references to
plain aa64_cacheop_access, so remove it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Fix el0 fallthru (pmm).
---
 target/arm/helper.c | 53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e87a76c6f5..40faa70cb7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4301,19 +4301,6 @@ static const ARMCPRegInfo uao_reginfo = {
     .readfn = aa64_uao_read, .writefn = aa64_uao_write
 };
 
-static CPAccessResult aa64_cacheop_access(CPUARMState *env,
-                                          const ARMCPRegInfo *ri,
-                                          bool isread)
-{
-    /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
-     * SCTLR_EL1.UCI is set.
-     */
-    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
-        return CP_ACCESS_TRAP;
-    }
-    return CP_ACCESS_OK;
-}
-
 static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
                                               const ARMCPRegInfo *ri,
                                               bool isread)
@@ -4336,6 +4323,28 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult aa64_cacheop_pou_access(CPUARMState *env,
+                                              const ARMCPRegInfo *ri,
+                                              bool isread)
+{
+    /* Cache invalidate/clean to Point of Unification... */
+    switch (arm_current_el(env)) {
+    case 0:
+        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
+            return CP_ACCESS_TRAP;
+        }
+        /* fall through */
+    case 1:
+        /* ... EL1 must trap to EL2 if HCR_EL2.TPU is set.  */
+        if (arm_hcr_el2_eff(env) & HCR_TPU) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        break;
+    }
+    return CP_ACCESS_OK;
+}
+
 /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
  * Page D4-1736 (DDI0487A.b)
  */
@@ -4733,14 +4742,16 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     /* Cache ops: all NOPs since we don't emulate caches */
     { .name = "IC_IALLUIS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .type = ARM_CP_NOP,
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "IC_IALLU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .type = ARM_CP_NOP,
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "IC_IVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 5, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "DC_IVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
       .access = PL1_W, .accessfn = aa64_cacheop_poc_access,
@@ -4758,7 +4769,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DC_CVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 11, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_pou_access },
     { .name = "DC_CIVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
@@ -4932,13 +4943,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbiipas2_is_write },
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "BPIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 6,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "ICIALLU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 0,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "ICIMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "BPIALL", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 6,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "BPIMVA", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 7,
@@ -4952,7 +4963,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-- 
2.20.1


