Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13177C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18DB217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2fzxg1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18DB217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsy8-0004wU-Rx
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSb-0002SA-3Q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSY-00088L-LC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSW-000878-3r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id y19so3150692wrd.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JKlJ3zQyg/agT15Rk69c8I3/U6JgvjvxcZfaHQAKKCs=;
 b=w2fzxg1K4jgq/Ta3in1K3PNzRbFh1hqXkVaGI4H5r5JyyQdmhmNkmVr8Sf5lG7eqMD
 e2O89+NemKk1PxSA3TLREsBeRrPRkPOcwikB0faJC+BVl0qtXw5kXA14z+MpTCSyQWRu
 7r3dWIx4udXaJ9gw15OE6XTkyksTT1jkt6i+ZfcVy0BkXyoypkn/lDwCQh2kx95WwQg3
 8zDPCSG3vl0idVZRg4CO2VeDb20V6NkxOXXykQXMtfgelPR8pAEPIw2ir3S0N82jmnha
 pq7gu7TFCsJXPpNF6uiaTr0sMsgmoMY57pMimb/NF8cQ2I6H9CKunSzq8JXODMhlJDf5
 Oq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JKlJ3zQyg/agT15Rk69c8I3/U6JgvjvxcZfaHQAKKCs=;
 b=Ktnx7rzkA1aYvmS98DayI49v2/U4nLgS2JGBQc94zw4TzzcPr0krv8LWonWNgYoAYy
 MUvrF3oXgXRaErGjwZTRbxb7gdw+JcDrrMwoYmNWZsEABL6dWyXL8MNk0rnuM5k2eiM0
 eh413i81mY4GetGXAcYhAsGC/grvXyik+i7+pAqJFwyiBSb37tb0QOYUvVrLeAd/jg1V
 nIqBCxXQyrRcwzzYg62FxJmM+C5TeHG1X9n6bzxJRZ40z0Pb4vU4FveWxdSDqbrXNzSr
 PYvXArijobPzbyNszhK+5wtdMasVALmcanpVYvHDX66UExawnAoEWh4Dqbis5u3n7QIW
 QyWQ==
X-Gm-Message-State: APjAAAX1F1gnA7Oa4H7L1m0ApMbdg/emblNuVDbHtisjMFwYprOlo/f4
 YPv5AeeAw77RXbbKaUM1yJDm2Loz9xrwcw==
X-Google-Smtp-Source: APXvYqzLU4RCs8p6erASAEMyPqlVlThuOCXW3SjVQnb8Z3Quqmaivo3qM9eYbAGWhUMtTcov0/z4zg==
X-Received: by 2002:adf:f649:: with SMTP id x9mr3226235wrp.163.1569595376573; 
 Fri, 27 Sep 2019 07:42:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] target/arm: remove run time semihosting checks
Date: Fri, 27 Sep 2019 15:42:45 +0100
Message-Id: <20190927144249.29999-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190913151845.12582-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 96 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bc1130d989d..0d9a2d2ab74 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8352,88 +8352,32 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   new_el, env->pc, pstate_read(env));
 }
 
-static inline bool check_for_semihosting(CPUState *cs)
-{
+/*
+ * Do semihosting call and set the appropriate return value. All the
+ * permission and validity checks have been done at translate time.
+ *
+ * We only see semihosting exceptions in TCG only as they are not
+ * trapped to the hypervisor in KVM.
+ */
 #ifdef CONFIG_TCG
-    /* Check whether this exception is a semihosting call; if so
-     * then handle it and return true; otherwise return false.
-     */
+static void handle_semihosting(CPUState *cs)
+{
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
     if (is_a64(env)) {
-        if (cs->exception_index == EXCP_SEMIHOST) {
-            /* This is always the 64-bit semihosting exception.
-             * The "is this usermode" and "is semihosting enabled"
-             * checks have been done at translate time.
-             */
-            qemu_log_mask(CPU_LOG_INT,
-                          "...handling as semihosting call 0x%" PRIx64 "\n",
-                          env->xregs[0]);
-            env->xregs[0] = do_arm_semihosting(env);
-            return true;
-        }
-        return false;
+        qemu_log_mask(CPU_LOG_INT,
+                      "...handling as semihosting call 0x%" PRIx64 "\n",
+                      env->xregs[0]);
+        env->xregs[0] = do_arm_semihosting(env);
     } else {
-        uint32_t imm;
-
-        /* Only intercept calls from privileged modes, to provide some
-         * semblance of security.
-         */
-        if (cs->exception_index != EXCP_SEMIHOST &&
-            (!semihosting_enabled() ||
-             ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_USR))) {
-            return false;
-        }
-
-        switch (cs->exception_index) {
-        case EXCP_SEMIHOST:
-            /* This is always a semihosting call; the "is this usermode"
-             * and "is semihosting enabled" checks have been done at
-             * translate time.
-             */
-            break;
-        case EXCP_SWI:
-            /* Check for semihosting interrupt.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    break;
-                }
-            } else {
-                imm = arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b(env))
-                    & 0xffffff;
-                if (imm == 0x123456) {
-                    break;
-                }
-            }
-            return false;
-        case EXCP_BKPT:
-            /* See if this is a semihosting syscall.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    env->regs[15] += 2;
-                    break;
-                }
-            }
-            return false;
-        default:
-            return false;
-        }
-
         qemu_log_mask(CPU_LOG_INT,
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
-        return true;
     }
-#else
-    return false;
-#endif
 }
+#endif
 
 /* Handle a CPU exception for A and R profile CPUs.
  * Do any appropriate logging, handle PSCI calls, and then hand off
@@ -8464,13 +8408,17 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
-    /* Semihosting semantics depend on the register width of the
-     * code that caused the exception, not the target exception level,
-     * so must be handled here.
+    /*
+     * Semihosting semantics depend on the register width of the code
+     * that caused the exception, not the target exception level, so
+     * must be handled here.
      */
-    if (check_for_semihosting(cs)) {
+#ifdef CONFIG_TCG
+    if (cs->exception_index == EXCP_SEMIHOST) {
+        handle_semihosting(cs);
         return;
     }
+#endif
 
     /* Hooks may change global state so BQL should be held, also the
      * BQL needs to be held for any modification of
-- 
2.20.1


