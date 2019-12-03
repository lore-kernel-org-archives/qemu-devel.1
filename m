Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1241C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895FC206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0p4GsWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895FC206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyRS-0008Ou-F6
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 22:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxQ-0003Xi-Og
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxP-0000Tm-98
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:32 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxO-0000RW-WB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:31 -0500
Received: by mail-pj1-x1041.google.com with SMTP id s8so829838pji.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s9VJVdTUiMlwkcjgw0/3sV/2Ka0DCPLGSdMwx4oTNII=;
 b=V0p4GsWs+jcwUzHv4bb8Yz8DP1b1lGHslfoJocTsXr/CU50SNzcn8TLxMED8zLq4f6
 NfHYTW2woNYsEBhvG3M8+ORu6M4WHsEANzTO+na5PgxHVxK+J8Ooi9V2FUkar/0bXpGu
 ePLgeZFcNVmYlzHzS6D5jmB2dpcL2tIDu/CfdWPcVb6t3VgPHxCtAqArpAI0AnqRaVsn
 hFSvcJDIT4OFCvxi8MccdMN4ggBXA1pGlC9gadXU1AAJi2YXQpWmKKKQxba1qXSNccjq
 wx+mwSp/SJ11kgkdHYf18amU6pRQHrhMidLmFelF1PZqMfinxDDObaN32daBrHO+KoPm
 sY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s9VJVdTUiMlwkcjgw0/3sV/2Ka0DCPLGSdMwx4oTNII=;
 b=o3YZCCXS6CwEOqlxQlR3pKqPAXgpHR3teKZV1YTirJUBm1vqpgV3a/6aOlu6n9Yp5A
 Vjhi/DUP0ucFBFcOElE1ODKc/4zAR2c7QB55J0ex4NZYBLOrly0wYawtNKh1TYO7Gn2R
 PMOa/1H8aJpTlgCf5GVUR3AvdjsH/RIrCZ9K6zKjEQm7ytTIfYQn2qCwzaCLMa3HKD5k
 sqUzoSoruX69cPQGQihGsD+5zhWDqHjkbeff5mgOO13Rj4MXWTPW0lbhO4Lq1yrF29C/
 iKQGkPxw/bf5O5yLY1TUopL4K6ZSncQzjc+aEhiP8+xdckTMaU0PBm+OMuuQj20kgzaz
 EMrA==
X-Gm-Message-State: APjAAAVXshOVe9j/zHNH87fUXFnsE7kIR7BS7+4OZz61X9BUi2DlT07F
 w4csgUUdk5nBwQpqhdr2TywNW8uGoKI=
X-Google-Smtp-Source: APXvYqwxAzSk+ImtzKahchUNa86+ODx4shdMYeOyuP00FOkVu4R7Q/jJIjV0YNof1d8ZzwpGEf3Rnw==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr2767564plb.38.1575340229666; 
 Mon, 02 Dec 2019 18:30:29 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 40/40] target/arm: Raise only one interrupt in
 arm_cpu_exec_interrupt
Date: Mon,  2 Dec 2019 18:29:37 -0800
Message-Id: <20191203022937.1474-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fall through organization of this function meant that we
would raise an interrupt, then might overwrite that with another.
Since interrupt prioritization is IMPLEMENTATION DEFINED, we
can recognize these in any order we choose.

Unify the code to raise the interrupt in a block at the end.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a366448c6d..f3360dbb98 100644
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
2.17.1


