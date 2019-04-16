Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159CC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6D820693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0Ilpe1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNjN-000863-Hi
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:02:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf8-0004cf-IM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf6-0001Bt-VT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf6-00019V-KM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id h18so25326435wml.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BFL/4mmLnGxA0smTiBCKZfrdKeTsfE6ZtDY8NLO49os=;
	b=e0Ilpe1NU8SWZ4EcFHTIQOONo+Vj7nYG75Oum+SzAr3zQfR5WwR9fkNbHE7r29s+pH
	oNnXCH/bHBS95C5VsCeXYTYVT7RAnRjDTQXdry0QwixKSit9jHCpKt0Chh97TY+16MqV
	kSz54y2buvyI5iR6cWQ4rG7Ff5yaoMz1dHzZKak0zzUVic+ku0oFv32ku53zzUfc+BfE
	MoKzbmfbtDnA7q4uoxTURYsz9Yj+EJEquh2dSosSK8K2J/JfZ5GGCiJVYV8WYeNCQAzO
	jiWvAQCAwTNib5RK9ADU8hbWniprDy7KzXyGzKbSjz/NKMyWITE9SD9Rg8tAmKDsBHrf
	clQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BFL/4mmLnGxA0smTiBCKZfrdKeTsfE6ZtDY8NLO49os=;
	b=dDvsKX18/oVOwLg+rQTMLsZo2HQIThsO9Ep8TlEDw/AR8AnNlNGQtIRnynclAM99UM
	b58hrZyx+IzZFThiIdT94aitYDGZZEtJ0nNiBM8e5dnH6/AXop1ayGwqW19AgMm2q+lD
	dn2JK/hmCaU9Sc7t29k6yD3fmWOq7pPUg0yFV+5BJieOsPergksYUp0qaPZwXzAZBjqi
	cOzf0gOGyB81dpv/LrHVDjve+4+7jZp3m94U2qolpB+3E+beBBuRfiSWgvSpxHnxVxa5
	TkwCEPeO8KEbFYR7N3DV8Vh4lh6ae+uC9zAiuR/dltX7VIgcK650m5mgvvJdUGqf/ey0
	drQw==
X-Gm-Message-State: APjAAAWRUFl5WyspKHpIA7Rj+iAG9Im3NDe6SXDcX8ceTP7z3N0acm4D
	GSQvVDDIdLzQGw2QYG54yOfQtg==
X-Google-Smtp-Source: APXvYqxSUXTBSAtxr7EyxlwJXcDSCBKJw/Gw/OU8s7s/Hcte2ShcoY/EwYvSyhFdzthzFWm5cHrnlQ==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194mr25672482wmg.51.1555419485136;
	Tue, 16 Apr 2019 05:58:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:27 +0100
Message-Id: <20190416125744.27770-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PATCH 09/26] target/arm/helper: don't return early
 for STKOF faults during stacking
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125727.p-m7C8IYRicBjh9dDU5zfaU1odGkMo80ix7rmtp3OhI@z>

Currently the code in v7m_push_stack() which detects a violation
of the v8M stack limit simply returns early if it does so. This
is OK for the current integer-only code, but won't work for the
floating point handling we're about to add. We need to continue
executing the rest of the function so that we check for other
exceptions like not having permission to use the FPU and so
that we correctly set the FPCCR state if we are doing lazy
stacking. Refactor to avoid the early return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 297eb38fef0..a2222f84803 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8187,7 +8187,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * should ignore further stack faults trying to process
      * that derived exception.)
      */
-    bool stacked_ok;
+    bool stacked_ok = true, limitviol = false;
     CPUARMState *env = &cpu->env;
     uint32_t xpsr = xpsr_read(env);
     uint32_t frameptr = env->regs[13];
@@ -8218,7 +8218,14 @@ static bool v7m_push_stack(ARMCPU *cpu)
             armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
                                     env->v7m.secure);
             env->regs[13] = limit;
-            return true;
+            /*
+             * We won't try to perform any further memory accesses but
+             * we must continue through the following code to check for
+             * permission faults during FPU state preservation, and we
+             * must update FPCCR if lazy stacking is enabled.
+             */
+            limitviol = true;
+            stacked_ok = false;
         }
     }
 
@@ -8227,7 +8234,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
      * (which may be taken in preference to the one we started with
      * if it has higher priority).
      */
-    stacked_ok =
+    stacked_ok = stacked_ok &&
         v7m_stack_write(cpu, frameptr, env->regs[0], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 4, env->regs[1], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 8, env->regs[2], mmu_idx, false) &&
@@ -8237,8 +8244,14 @@ static bool v7m_push_stack(ARMCPU *cpu)
         v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
 
-    /* Update SP regardless of whether any of the stack accesses failed. */
-    env->regs[13] = frameptr;
+    /*
+     * If we broke a stack limit then SP was already updated earlier;
+     * otherwise we update SP regardless of whether any of the stack
+     * accesses failed or we took some other kind of fault.
+     */
+    if (!limitviol) {
+        env->regs[13] = frameptr;
+    }
 
     return !stacked_ok;
 }
-- 
2.20.1


