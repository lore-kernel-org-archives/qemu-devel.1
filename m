Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8AC2D0EE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CCA206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmlNXFd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CCA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYm6-0000bw-Us
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKs-0007Mb-D0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKq-0001wV-O6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:38 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:34757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKq-0001wH-Kp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:36 -0400
Received: by mail-qt1-x832.google.com with SMTP id 10so6558545qtp.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/LwMHVS2K3ViBvzIzyA4NKWMVEXcm6p526cQcn7ef0M=;
 b=FmlNXFd0SRVVZ7i48swP8G9E1xRBrUv8TX+A48RWqR47+YC6OasE2cYR5AkNjID8U5
 o9F50p9UavJKZ/4zkL4LO/uFZqSgm6yIt1er0hduU/J0iO35vTUNsFBce1L3Ey6nxUaQ
 Xo5GfgcKe8bI0c/606VnIVenNrALl7Iko4RttX6ToT0WpAJp9rAbmAi4KJA1Vwc4wH4i
 Ks9j57Oiu197EOIx+WeKEJo7Sq+DOFrC7W/LaK8ZF0GJic8YbWZMpOPD+XY0IEcThrvx
 BQZOB3Deh3g5iJKf0PtMr11Oh24D+eTff2wSDeheS7RcQhSe1cF4iNi6BrwugKWYAdIK
 nLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/LwMHVS2K3ViBvzIzyA4NKWMVEXcm6p526cQcn7ef0M=;
 b=KqKCInl3+5J6+dJ1J34R3rP2DyOKutEUNQaQuwKgyxd8Q+v7k/wCA7h5KyEAT3NHpt
 zu11wzRhUFNFo0mTKDxGSqyzHbQZCukFT4dAg3zqyNJXwHIZAJ31tydV9tbl9i43dxFX
 +MFTzLRxNvFKATmePTbMs64uuP3laygaSJXAfSZz6AfLt/hSb+7antHiql/dHyjCvmmw
 wo4iRkSFuLcjkYhzurC+vp7GZaxxDEibxm9X590hUeD14ePNrA7HfBDUrZ56Hp5tYjvP
 g7p88wmc+0kNRfJlgVGuFAootwm7YVc9bjfKIqRgJc3V/Z+qqmLjtpprjyIbdUL7/NJh
 L/gw==
X-Gm-Message-State: ANhLgQ2ENRQBNFrCHWXhlyRhUUvht8J67qnmPrQ8mD0nrQBATruc6fi1
 4oDfm1QqmL564u14HaKwGeJEvnM+28C71Q==
X-Google-Smtp-Source: ADFU+vslzFD2ZHm3SggqcbpOdie3YsS3McHssrfBghG6NRXpUT/gf98UcFFEbPB4XHgvw7pZjcyFsA==
X-Received: by 2002:ac8:6991:: with SMTP id o17mr10042670qtq.292.1585251515732; 
 Thu, 26 Mar 2020 12:38:35 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 45/74] ppc: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:27 -0400
Message-Id: <20200326193156.4322-46-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::832
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, qemu-ppc@nongnu.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Minor adjustment for new code in hvf_inject_interrupts]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/ppc/ppc.c                    |  2 +-
 target/i386/hvf/x86hvf.c        |  1 -
 target/ppc/kvm.c                |  2 +-
 target/ppc/translate_init.inc.c | 14 +++++++-------
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e7386ff88..89f92c4a88 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -89,7 +89,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
 
     LOG_IRQ("%s: %p n_IRQ %d level %d => pending %08" PRIx32
                 "req %08x\n", __func__, env, n_IRQ, level,
-                env->pending_interrupts, CPU(cpu)->interrupt_request);
+                env->pending_interrupts, cpu_interrupt_request(CPU(cpu)));
 
     if (locked) {
         qemu_mutex_unlock_iothread();
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 892ae0e99a..68175074e4 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -352,7 +352,6 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
 
     uint8_t vector;
     uint64_t intr_type;
-    uint32_t interrupt_request;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 13c6626ca7..c737b19242 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1348,7 +1348,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
         cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 5c2f8ffa4a..8d2e668ac5 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8540,7 +8540,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8564,7 +8564,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8702,7 +8702,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cpu_halted(cs)) {
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
         if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
@@ -8734,7 +8734,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -8904,7 +8904,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     if (cpu_halted(cs)) {
         uint64_t psscr = env->spr[SPR_PSSCR];
 
-        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
         }
 
@@ -8950,7 +8950,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
         }
         return false;
     } else {
-        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
     }
 }
 
@@ -10660,7 +10660,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
-    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
+    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
 static void ppc_cpu_reset(DeviceState *dev)
-- 
2.17.1


