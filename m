Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9731206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGji574y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9731206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf8j-0000KQ-PS
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeol-0003WQ-Gd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoj-0000PM-QW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoh-0000Bi-SN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so6454408wmi.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PlQncbgF47pMapzIaA4NjY5mlZwQMC8/lcrQ+9CvfyQ=;
 b=hGji574yXf8GOf4EfAOH6s9AKD5+GCjDDHv9PqSg6cnskHJk5DqrafpDbcM80IWYxj
 ygV11VQaWxtJD865ol1V/fw2jCXvg2y9cZOnA8g2/diONIguvkHi64GHqQx+zw8psp1U
 ZhDWE/wO3ZT0TXUgHZGVcrH21dp62vFsMJ6jM6qrEV9XjKFOi9OXCRS31E0gmksYt/3W
 Fy61+FP6cAX9ZAxdj3vXmXqoOfNIoEiEy+tQw6Klgdd3JbJPGa+HmAMTwaoa4V7Lt/CT
 1thNzWTrdyPwT6HYKWla6EhxaNNSOsLXtQ35MlnBYjMFEMy87P6gPYVRRLQrx7L9Acjf
 3XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PlQncbgF47pMapzIaA4NjY5mlZwQMC8/lcrQ+9CvfyQ=;
 b=dSS5d+Rs1Tpx53sotLTiF2wybILvcMkAM7ATDgJAZ9yTUJ60gQSpbSO5/Pd3Ddb7s8
 jpJEAn29wgf6pfuWMa8ic+dup6vCfSzCL2GnZbJPWlgyAE7RDU/M1gRjGZTI+qQfBYLC
 FXCwvIhWxzQLmqkK5fgNGJ0JS1woNJG6UGs/5LnR/ZBUMviEFALU6Qvd40WOUVbBr7Ny
 ZgHlDHaYr6guFk7G6jK1COihi5ztfia9twd82uaGRdd8MqCALq405tNP8j9HhpBnRvwY
 qJIbH+iqcIzXqawkSE9vKihASw7mrsoUR9eMk8h+hwAmGlJfGszJX0ccf76e1MWuewiq
 d76A==
X-Gm-Message-State: APjAAAWuz1kG47qYQqbtR/2FnJ+vWXQEA/E8ci2L0wpyb/Efml7rll+/
 C2txwVApjEXqamOkh/Ek7lUCDVGRb/k8gQ==
X-Google-Smtp-Source: APXvYqwKfq8x0UtKi4HQBHPj3BMeBme1StTJ9beZZo+5c3yBAORiVhkg4NVaI2N0LkVBv8xxUo63dg==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr3960830wmb.150.1580986524725; 
 Thu, 06 Feb 2020 02:55:24 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 41/41] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
Date: Thu,  6 Feb 2020 10:54:48 +0000
Message-Id: <20200206105448.4726-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fall through organization of this function meant that we
would raise an interrupt, then might overwrite that with another.
Since interrupt prioritization is IMPLEMENTATION DEFINED, we
can recognize these in any order we choose.

Unify the code to raise the interrupt in a block at the end.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4ffc09909d..b0762a76c4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -535,17 +535,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint32_t target_el;
     uint32_t excp_idx;
-    bool ret = false;
+
+    /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
 
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -553,10 +551,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_VIRQ) {
@@ -564,10 +559,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = 1;
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
     if (interrupt_request & CPU_INTERRUPT_VFIQ) {
@@ -575,14 +567,16 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         target_el = 1;
         if (arm_excp_unmasked(cs, excp_idx, target_el,
                               cur_el, secure, hcr_el2)) {
-            cs->exception_index = excp_idx;
-            env->exception.target_el = target_el;
-            cc->do_interrupt(cs);
-            ret = true;
+            goto found;
         }
     }
+    return false;
 
-    return ret;
+ found:
+    cs->exception_index = excp_idx;
+    env->exception.target_el = target_el;
+    cc->do_interrupt(cs);
+    return true;
 }
 
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-- 
2.20.1


