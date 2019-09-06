Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43622070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jetbpzXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43622070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Kvs-0000BQ-1g
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Kod-00037R-BJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Kob-0002Se-U6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Kob-0002Rq-Mc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so7850290wrd.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=jetbpzXqcOiM6aQQejRDt2USV7rFRfJwJErSDSAnuCDdLPUjkNpPKU4GIjFsJfiLOR
 Vd7pWyztZU71P4gnvnRfV8VTK+urJF0mZ5L+Bnm+b/RAkNjYamBUdTf4KivU8jFxDIDd
 zXUzfuN78WHK6Rv4tHLuaW05u+tAFk5K5yGtlu3N+fDGKjuV75/H46M2P8qcdJ36e7gY
 jyJ4f5Lj55CReB0BOtKOqmHwKMeQSuOg3laWG2/SVaHrN5u8ggtWnXikuKWd0iZIYuA8
 0uLAKdLl9jgyW4zHoCXPGeiP7POdJN0CSbXjThL2Pc6NiRuLgbFzhleN+Aqq+8V6t/1a
 7pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=nEO9p3iyJig0HvqC6AmbvDhVAPpReVSC6Xr6fmq+bRj2oKFoKTMjpI6wo93KHQJFvv
 7b2U5MLjxMFVFvxMM4ba3bkJ0CrDM9UFWxjGC7yngqJH3aaA0d8tuU0r/CrMq6cFKQnQ
 Pz270mTQYcYNo1rIkcAPRkS3sBXBLaH6WcBo823fCHYHbJuPGwtFNhS323bXVDLOejTL
 HntkLe3lcXk6PIWtbRL0VoI9jcWVg7HiE97XZ8Wrdf8COZZ50ZBqha2w3bRRv/wII4MQ
 ss9tXsx9J7otfCKFDDba9IgxeZGfu3R6ts6bGhhbY2td9A8E8Cw+CYjRTINWzicx0VKB
 fWyg==
X-Gm-Message-State: APjAAAWeCxldm8m5G9BEkhB/XhWUgDVd4OyWPrB9agkd4BRs20sck/Xj
 cM1jqr9DwEvCPpqXOoEhU5xfKg==
X-Google-Smtp-Source: APXvYqzjkDiPVZBLBGuuFYI/G3PkA2clWjyNaK4RMJ/QSmYMBnVnEwJ1kaisr5lLSPEqjqcAX2yaVA==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr8588913wrq.205.1567801600508; 
 Fri, 06 Sep 2019 13:26:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm10513414wrh.25.2019.09.06.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 13:26:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4E141FF90;
 Fri,  6 Sep 2019 21:26:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 21:26:34 +0100
Message-Id: <20190906202636.28642-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906202636.28642-1-alex.bennee@linaro.org>
References: <20190906202636.28642-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v4 3/4] target/arm: remove run time semihosting
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


