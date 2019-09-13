Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C756C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC87320693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3OmRINk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC87320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nRC-00054z-Td
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLY-0007h9-HI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLX-0000LA-3C
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLW-0000K7-PU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id a11so22725638wrx.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=k3OmRINk6Vsi7l5jsDJxN0Ct0QJYjyDjUZd+5CMVF8pdEXD59M5NLKGoUs0EmhSpDe
 +DuhSRF8o2bP//qqlNflAEgdRebc0+j6oYub8vNAJg9004yg31CwgLLBUPTdX8zW66PT
 Q/blKQzmGEjdK5/FjqfLS2nWF8RxwXl7tsw2Wcognn2NB696Fd/scK0safP2tJwuGHB2
 oTD0WxnoGJPoolGM2Jgu7V0jucEEUMyyUft0AsSbfUXctvd+5WpQR/kKGovZ/gzfxv+Y
 +f0frVOqQ0Ogu0bRD4Pqyttm6Em64k4aN91uTZzUAZ9x+Cu559IS3SwaXIKNhbMHsmzk
 RhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=tI73juzS13+5oYs6NzVsFgIr2csw60J6Dr5TVTFNRWl7g05reS/3mBS+TwshHyme1z
 VscFhz2VSM2eG2XkgdmGhf95NQLGdZQS28V4SjaESeCxI2P1u+nkMGv9myiXrqqZGExy
 zKAmXo5WUyUjBwquNwIl95pu1YxYJ564a5C4/xADdMB1Kgo6hchc+dqgqwehqIoGqo8F
 npAsQoprexh49miApdDUuP0xkdcNTgNz9HQ6TdhRk94/uAdbIOoj+B6aad2aaG6t2tme
 9s/dvT54RcoAvcIMImYdi7l8ymoQg0jJ0LMY9VBVq3d0+2w5gegWKQDfNGv4wzPpSHEQ
 D0rw==
X-Gm-Message-State: APjAAAW++oWVJZ/+4QKI5cnezG5uvPltau41oVBMc89wHvPTIsUruu91
 glQWN3t3eOlEoiRSKR0rhaerRQ==
X-Google-Smtp-Source: APXvYqzAGdy887Inur93gPt/OC7ij5XACN3bINTjKzRsFBhiuCh6PbwNQu1Y+kMwxwsjMpwwCr9dlw==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr40200849wrw.170.1568387929702; 
 Fri, 13 Sep 2019 08:18:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm2491691wrp.91.2019.09.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C72D71FF91;
 Fri, 13 Sep 2019 16:18:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:43 +0100
Message-Id: <20190913151845.12582-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 4/6] target/arm: remove run time semihosting
 checks
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - fix re-base conflicts
  - hoist EXCP_SEMIHOST check
  - comment cleanups
v5
  - move CONFIG_TCG ifdefs
---
 target/arm/helper.c | 96 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c9154..a87ae6d46a1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8339,88 +8339,32 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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
@@ -8451,13 +8395,17 @@ void arm_cpu_do_interrupt(CPUState *cs)
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


