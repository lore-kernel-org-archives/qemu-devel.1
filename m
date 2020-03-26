Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8181C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B9B206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7/zUnkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B9B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYUE-0008C8-UE
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKF-0006gd-HC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKE-0001Wy-0H
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:59 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKD-0001Wl-ST
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:57 -0400
Received: by mail-qt1-x844.google.com with SMTP id g7so6489255qtj.13
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/m+IiebGsEqbgq5gGcyp7fO4NhJnxMLvbJZusMVHD1E=;
 b=v7/zUnkg75DmSoSn6s2WWDbBrGYmW6rd5cDhHhnJh2xXkxKzWj2vUqvO2XZUqNfg2A
 95XMrI4JyvBqu6wVWBPQl55XnVza+/EujjyihEJvhVVaJC5Ls6PReHWWjCmMoamzo2Wt
 UrwmNMFQf7Mz6gGFhOl8J2I642o7AKf2shGcEOZ9xbsC7eZiU/My23hDOr2iB7g4UEPt
 NCNPCuvZ65jfQebTYvIDVhTKtymbcNSQCV7cn0brmsPXEgDtxF5PFBzGjr3vuctHkZi/
 LDa1g+brfnJQOv/MYkOgQdA/j6SXV20abNP9RAL0+gyYtexKmTmnVREV8ZhPVF2ZfvPq
 A1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/m+IiebGsEqbgq5gGcyp7fO4NhJnxMLvbJZusMVHD1E=;
 b=apP9GVgk0qyWB8aV27u2pFXt0vsDaw8HixgZ2zaP+D455FDp8sUXzLb/juKvb8e8sE
 Apcvy4rt2gk7AOyBbelws/xE5EsXRHjry5oCODSoUK7siWpi1i44nrmUHFvjwdUQVRk4
 hNG1x11LlNmZ8hTmccQk6npYvJWkvDyvK2ovXvTzTErn6rrZtbKzCNvIoakUE9RMQ8vm
 c8vueNnSdFaHpf4n1t38Li2lfAGa3OJsVLph639wZVsdFZB+68BiOkVRaGv5qVLkTU6T
 wzZRULINfga3gGziyzh0p28DKHqBpiXqcPVzytryK5pnZq4NPMWCysr3XkTJJUnwLPtZ
 DcAw==
X-Gm-Message-State: ANhLgQ03U4LQBohTZc0cwCSoxKjn90afb0DNhFtEkK1ReoiyrBki7zl9
 QuTS3wfSYCNw40a/UTZZT5WC9Nk350zV6w==
X-Google-Smtp-Source: ADFU+vs2fRJ3M6rV9nk74aJ1oqNaLqGco21pfYcb3Onacni1tTfXg5t5TtiVuNC6ml64uCsVxuq5mA==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr10266198qtd.37.1585251476384; 
 Thu, 26 Mar 2020 12:37:56 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:55 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 18/74] arm: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:00 -0400
Message-Id: <20200326193156.4322-19-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, qemu-arm@nongnu.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/arm/omap1.c            | 4 ++--
 hw/arm/pxa2xx_gpio.c      | 2 +-
 hw/arm/pxa2xx_pic.c       | 2 +-
 target/arm/arm-powerctl.c | 6 +++---
 target/arm/cpu.c          | 2 +-
 target/arm/op_helper.c    | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 761cc17ea9..83b1d63f27 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -1776,7 +1776,7 @@ static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
     case 0x18:	/* DSP_SYSST */
         cpu = CPU(s->cpu);
         return (s->clkm.clocking_scheme << 11) | s->clkm.cold_start |
-                (cpu->halted << 6);      /* Quite useless... */
+                (cpu_halted(cpu) << 6);      /* Quite useless... */
     }
 
     OMAP_BAD_REG(addr);
@@ -3797,7 +3797,7 @@ void omap_mpu_wakeup(void *opaque, int irq, int req)
     struct omap_mpu_state_s *mpu = (struct omap_mpu_state_s *) opaque;
     CPUState *cpu = CPU(mpu->cpu);
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
     }
 }
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index f8df3cc227..23b4a06a4f 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -132,7 +132,7 @@ static void pxa2xx_gpio_set(void *opaque, int line, int level)
         pxa2xx_gpio_irq_update(s);
 
     /* Wake-up GPIOs */
-    if (cpu->halted && (mask & ~s->dir[bank] & pxa2xx_gpio_wake[bank])) {
+    if (cpu_halted(cpu) && (mask & ~s->dir[bank] & pxa2xx_gpio_wake[bank])) {
         cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
     }
 }
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 203d4d28af..057448c2ed 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -58,7 +58,7 @@ static void pxa2xx_pic_update(void *opaque)
     PXA2xxPICState *s = (PXA2xxPICState *) opaque;
     CPUState *cpu = CPU(s->cpu);
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         mask[0] = s->int_pending[0] & (s->int_enabled[0] | s->int_idle);
         mask[1] = s->int_pending[1] & (s->int_enabled[1] | s->int_idle);
         if (mask[0] || mask[1]) {
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index b75f813b40..f0db413519 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -64,7 +64,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
-    target_cpu_state->halted = 0;
+    cpu_halted_set(target_cpu_state, 0);
 
     if (info->target_aa64) {
         if ((info->target_el < 3) && arm_feature(&target_cpu->env,
@@ -241,7 +241,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
 
     /* Initialize the cpu we are turning on */
     cpu_reset(target_cpu_state);
-    target_cpu_state->halted = 0;
+    cpu_halted_set(target_cpu_state, 0);
 
     /* Finally set the power status */
     assert(qemu_mutex_iothread_locked());
@@ -297,7 +297,7 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
 
     assert(qemu_mutex_iothread_locked());
     target_cpu->power_state = PSCI_OFF;
-    target_cpu_state->halted = 1;
+    cpu_halted_set(target_cpu_state, 1);
     target_cpu_state->exception_index = EXCP_HLT;
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b17..9fa514c999 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -175,7 +175,7 @@ static void arm_cpu_reset(DeviceState *dev)
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
     cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
-    s->halted = cpu->start_powered_off;
+    cpu_halted_set(s, cpu->start_powered_off);
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb0de080f1..88c86a4346 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -305,7 +305,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     cs->exception_index = EXCP_HLT;
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_loop_exit(cs);
 }
 
-- 
2.17.1


