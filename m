Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B8C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C191D206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pu/iQU0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C191D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYkW-0005P3-Sv
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKl-0007G8-6r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKj-0001qi-An
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKj-0001qG-5T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:29 -0400
Received: by mail-qt1-x841.google.com with SMTP id a5so6515286qtw.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=peeEpurfJyQFOk/Y5mv4nylcNl/81VuZK9r+NVDwKgU=;
 b=Pu/iQU0wjw5Q8m4vkpiyRh6hZHgO1MATDuKPcN52fchs4/yKvslhi3ViUfiC5XVrYv
 S0ufH3bi5B66iPearsRvFt4wrlX/KecUZxHge8HrIJcx7RPhbqmaRF7OsdDL0THRdqrK
 +dz4NXobhiU9EmgtJS/1i9UIEIPQL3cyni0YrLKAgWgjB+p+5NPJc9xILR70km/y5u8n
 gIJNYyT0HUXohkjQA9+v0/6o+HEUIsjFNuJQcds7Hconv0/3qaKjVJDuIXDf3SWivTcq
 8Cmo3ie79lX0ebNTQOahscj6lqX7+pjy9rMeuYoWW5yrz5BzR+EBRdoEGT5Nj5BJKzrF
 SYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=peeEpurfJyQFOk/Y5mv4nylcNl/81VuZK9r+NVDwKgU=;
 b=IY+Fx8+xB5m548W06xeWavNZiXIq//Ub3qYOAzVALnUzyNONj9ip/mFyukofVd2Sjm
 /RhkbX+D5bPHi89LihLMIQtz9Y594QODKDbY5YOZgIIroDMNjRS+e536H8iup1ZGIfgF
 fVEZtqVgC7iuVAoHqy8hAtqTfl4+HccIVYsqhhdhJWYECQOa7f5LN3zNLKnR+1DiE2IJ
 COpj4Z3yqKwMR3Ea+r0zidhV4IUsnjKWeTJuAeHOGlM49STM9Xvwlh3zXsuIV4K22Vat
 DedM2ZiXu3JJhxjgefLL9iYQ/0xKcmTavEkgz5Aq44grvYfAoYz7Crnzqv87B/mWU+MF
 2ubg==
X-Gm-Message-State: ANhLgQ0csQNi/tgHJ8rGK8KyA5O4npCJWhzT6BCvbisRAcz5g4IaBvOw
 nVgjvgcxhASENEhmCpMmi9LgdrgmV7hGsQ==
X-Google-Smtp-Source: ADFU+vsRPu2bv++cyos4KLSlEBhrzmTtN5B5ntwiNulTvBwY1L/uAVQLMcEBOkw5jWSvC9zpfdGufg==
X-Received: by 2002:aed:2415:: with SMTP id r21mr1157382qtc.82.1585251507974; 
 Thu, 26 Mar 2020 12:38:27 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 39/74] arm: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:21 -0400
Message-Id: <20200326193156.4322-40-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
 richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 qemu-arm@nongnu.org, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/arm/cpu.c     |  6 +++---
 target/arm/helper.c  | 16 +++++++---------
 target/arm/machine.c |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9fa514c999..e190604ae2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -75,7 +75,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
+        && cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
          | CPU_INTERRUPT_EXITTB);
@@ -611,7 +611,7 @@ void arm_cpu_update_virq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
         } else {
@@ -632,7 +632,7 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
+    if (new_state != ((cpu_interrupt_request(cs) & CPU_INTERRUPT_VFIQ) != 0)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
         } else {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7b6887241..19efdc0b00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2132,26 +2132,27 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = env_cpu(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
     bool allow_virt = (arm_current_el(env) == 1 &&
                        (!arm_is_secure_below_el3(env) ||
                         (env->cp15.scr_el3 & SCR_EEL2)));
 
     if (allow_virt && (hcr_el2 & HCR_IMO)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        if (interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (interrupt_request & CPU_INTERRUPT_HARD) {
             ret |= CPSR_I;
         }
     }
 
     if (allow_virt && (hcr_el2 & HCR_FMO)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        if (interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+        if (interrupt_request & CPU_INTERRUPT_FIQ) {
             ret |= CPSR_F;
         }
     }
@@ -9676,10 +9677,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     }
 #endif
 
-    /* Hooks may change global state so BQL should be held, also the
-     * BQL needs to be held for any modification of
-     * cs->interrupt_request.
-     */
+    /* Hooks may change global state so BQL should be held */
     g_assert(qemu_mutex_iothread_locked());
 
     arm_call_pre_el_change_hook(cpu);
@@ -9694,7 +9692,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
-        cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index c5a2114f51..42f4368de3 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -713,7 +713,7 @@ static int cpu_post_load(void *opaque, int version_id)
     if (env->irq_line_state == UINT32_MAX) {
         CPUState *cs = CPU(cpu);
 
-        env->irq_line_state = cs->interrupt_request &
+        env->irq_line_state = cpu_interrupt_request(cs) &
             (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
              CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
     }
-- 
2.17.1


