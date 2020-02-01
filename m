Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85234C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DE2205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO9fuf1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixygG-0004jL-Fb
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixyT2-00088D-P7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixyT1-0007MK-N9
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:08 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixyT1-0007KD-Gy
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:07 -0500
Received: by mail-pj1-x1042.google.com with SMTP id n96so4463436pjc.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+p/P+yAizHAWC+Z0oIrQh7XKufbPcqsMPf7WqU6GqBM=;
 b=dO9fuf1/Od1i66tbh5lPsWxsNiLf0YyEsgCVnepPWUQSDc+98pS40l+6XHc+7/UiJ+
 19BgjsRCBMdxjEzKNLISwJXTGmAb/e0Hnd8AegNUUwZX51Ah7aRNNzAV8I/pUhzQk1je
 uMR35jdX6Cc4bMJkxzm8HEpf+wd/Ks+Woy91QL34SoqupGP1UcC4G4DZGrg20rvNNUBZ
 V+cWZ9DpGg8aBAorFg2EJG1LM37PeJ0+hoYiVqeblC4AtnI25Txr+X+zsrIGeXxN6yC2
 zAemXsw0d9z+cAlLAKTInxJUeHmQVyRAx69AAKUOGY/jVwDQuFx+AmvVs23iBjxas5PB
 M/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+p/P+yAizHAWC+Z0oIrQh7XKufbPcqsMPf7WqU6GqBM=;
 b=QCIYUYx7X9cMEHU34FqE0ua1+mch6kgWMRKyYUBKVPSglBfEww583DUT8ux7H+QIGB
 TvfuJdECM4pwDtpsrvuv0unOKstTbFgc49MM7pV4isNS7b2vHp88zFlSH/tMfexQB2F7
 uiSH2mks/WyeLcvKpjKHMt76jh+MaalN9OFpKfvmKotnyvnE9wJbr5/4tH7JYzXI+Kz0
 9zJ95VVuqPkPTb7mx6pxLgZAlE8IvgOpelcPXp0nPXHZ+p0tERUZjmBaQyD9LKoa88wq
 bgUc80oBsCpDAbvGcSlw4a8s/MCE0EAbdNWDni8+5grn3YYbgsrOo6yYzzFWhhzbXC8j
 0eBA==
X-Gm-Message-State: APjAAAV06r42mw5USsBjtlRRBq8kYdMAKsSpr0PZuOqdCLMuGMDbmJHK
 hrWbVwNFlKOWCJ0fuDZRzmrHGgVDjA4=
X-Google-Smtp-Source: APXvYqyjFM0Fqf/Z7WH/KylhZZBfJoliuKlH/ZKkEI/QV1r/qU1smAD4FgD13WnBcZesGELddGTIrw==
X-Received: by 2002:a17:902:a608:: with SMTP id
 u8mr15598340plq.76.1580585406364; 
 Sat, 01 Feb 2020 11:30:06 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:30:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 41/41] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
Date: Sat,  1 Feb 2020 11:29:16 -0800
Message-Id: <20200201192916.31796-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fall through organization of this function meant that we
would raise an interrupt, then might overwrite that with another.
Since interrupt prioritization is IMPLEMENTATION DEFINED, we
can recognize these in any order we choose.

Unify the code to raise the interrupt in a block at the end.

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


