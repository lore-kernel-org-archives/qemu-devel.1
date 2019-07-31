Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496D7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14585206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UO5G9+rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14585206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrCZ-0007S8-BP
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8U-00022M-2w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8O-0000dZ-QZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8O-0000cL-C2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so70279133wru.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SWna9UxNFjHgSxxpvUscIhoIHkEj4BqQ4tH+9BGOa3A=;
 b=UO5G9+rcGZ5XmAXAxpryg7fOu5CohkrhcC0NWHWk2zbNSnedwbSgdSedzKdZVklKl3
 vWts0bzK+80fVS8FzhiGS5SzOpL3c9IQ2/5vEdFA0wzY+hChEG2X+5rRflelaUIr2zPN
 zj9vfXyr7pLNjuuI7FDnOXawx2GKxh2jASiU0eO4V1gMCsrvAp9/jdF51zV8tqiqPtM2
 hXTsDDeCkH9yytBhQqgJfaTAV5kDSMjk4ySksDcEdj33N80+yx0mc23gNnTDw4yLN9KA
 fEASMzsiKAmKK6DDNjbfVZ/VR2Uf3NLUF1lsXTaKCffcNAAT5Hp54JJslX0A7djoM+wP
 rY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SWna9UxNFjHgSxxpvUscIhoIHkEj4BqQ4tH+9BGOa3A=;
 b=B3iP3KQ3ufyGTtK3Ttm+PAUhbhO+AkCZjeLnbuIF/QkGtVbb9JOgfonh7nFxxxpTEh
 m3T2Uuql4fLLNNUWy7mukzlKCJc211bje1AnMA7ws2m7fJ+skWqsQxR49IcQWzW7Nufe
 WHeCa4R8wds7F3FAxA/VqEyncAmmSYM+YPr9JF2bw9JY4QioCorVfQa02VNhk+Hp3qIW
 TF2Up2aXR2ddYLjC6GBm/84o1+Ij1DJQBeBU/EzTf+S7lnDiVwl0Up6pkOoHKLYqOtZt
 6Kft5KzIayUN5xzwNENJLDy/jKezPguI8B+KIRaZTz9oRWixU/UfwqwppQD9TMFFhxNc
 ZrIw==
X-Gm-Message-State: APjAAAWf6M8IXPZwuB3R818VA+hVqGJdCmMp60UsH7AiMGqXG4hsAB/z
 Ib6+OeVdgVrMBkAaikM9lnAPgw==
X-Google-Smtp-Source: APXvYqz3GnwA05tW0vBlHCYvNyfgu8hypO9oW57pfsupEm56IiJchEx0NHftAK0dCsP7wFUafbsFDw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr86500409wrm.230.1564589242963; 
 Wed, 31 Jul 2019 09:07:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p10sm2143203wmk.2.2019.07.31.09.07.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8BD71FF91;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:29 +0100
Message-Id: <20190731160719.11396-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 04/54] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 bobby.prani@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix re-base conflicts
  - hoist EXCP_SEMIHOST check
  - comment cleanups
---
 target/arm/helper.c | 90 +++++++++------------------------------------
 1 file changed, 18 insertions(+), 72 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc0..c5b90a83d36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8259,86 +8259,30 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   new_el, env->pc, pstate_read(env));
 }
 
-static inline bool check_for_semihosting(CPUState *cs)
+/*
+ * Do semihosting call and set the appropriate return value. All the
+ * permission and validity checks have been done at translate time.
+ *
+ * We only see semihosting exceptions in TCG only as they are not
+ * trapped to the hypervisor in KVM.
+ */
+static void handle_semihosting(CPUState *cs)
 {
 #ifdef CONFIG_TCG
-    /* Check whether this exception is a semihosting call; if so
-     * then handle it and return true; otherwise return false.
-     */
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
 #endif
 }
 
@@ -8371,11 +8315,13 @@ void arm_cpu_do_interrupt(CPUState *cs)
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
+    if (cs->exception_index == EXCP_SEMIHOST) {
+        handle_semihosting(cs);
         return;
     }
 
-- 
2.20.1


