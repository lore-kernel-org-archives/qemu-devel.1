Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56841C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229D7206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4s+tp2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229D7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYdZ-00023w-AL
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKR-00074R-G7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKP-0001eH-Vt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:11 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKP-0001e3-SY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:09 -0400
Received: by mail-qk1-x744.google.com with SMTP id d11so8192284qko.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s4mQ5k/NFT8aD81RSmqYx0sDT6UNU273vdP3vhK24kE=;
 b=u4s+tp2qSwdxTNOdNzQk47YjtHGUOt4SfzY2lkPX6WGZiQFqJSOQySONkZLu0CMM4A
 AwdcJFxb3gz/dzLvAVGKu4oTjc4V2+WEaYissCvgGqxA9jhVUq1mAr6LHR90Y0C8dGAB
 fj+U3r3rEsmlK5KD7nFo8gYxPUi9s5eyhaDswoNuBtUdbXpTtoASUz2AOdAFwEW79UZc
 3iaZAutCxWptOQuW1jYOd3cfhI+9oA6YQO4S77His2vop9tpvvA9NsOrpJ/n/8KXxChC
 bnMvDQKa4QqVuGBsDEqd6dmv1QRg21i33cEkHV8LaWqFe+D78KcPhWol2y8qziq5ZIbl
 lIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s4mQ5k/NFT8aD81RSmqYx0sDT6UNU273vdP3vhK24kE=;
 b=fg60ay03iZb5HiHx0lbbJzss681RBAIhvzpomgaXktYI18c1SwLJG147qXGDQPiP4o
 JVsIE4HQehFjXflwP6EfqfaJYKJNbByMCvTvxkMAi5cZuS5PuLHw8wKCFn9xoKYkwi/s
 q8jYPXaZxs1f/4pKxrc66o67wjocK3xaRsqqh4wAk7cjxuYcEUZxNRaJDKdtcb5850kv
 ugFTr/hw7uOCnduVcYhJrGoP5neb85f5Z2ocsRnCDoDioKUQRUN++h8OotQrKodFgyVw
 GhgXC33CJQdY8bMMvWRF1YFUNpEzDwfUcDvEphgPnh3Hzb8J+8Uucf3+uj0qRB/en1S/
 od0A==
X-Gm-Message-State: ANhLgQ0QuVbfC32GyOK5AIjmzM+xi0AMua5TV/Tr2Vw6T8U/bIKmgvxE
 +k4jhFBXpZu6q3uEVoSe1ecgLkkcYlrl5A==
X-Google-Smtp-Source: ADFU+vu8vvy52psmjb3BIuJaHD8IpWgel6kJMj0+xSIV2bh5eGwGW6YZOV8i6mqkoHQddx2oqovjWw==
X-Received: by 2002:a37:b4c1:: with SMTP id
 d184mr10455207qkf.452.1585251488931; 
 Thu, 26 Mar 2020 12:38:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:08 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 26/74] s390x: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:08 -0400
Message-Id: <20200326193156.4322-27-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: robert.foley@linaro.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/intc/s390_flic.c        |  2 +-
 target/s390x/cpu.c         | 22 +++++++++++++++-------
 target/s390x/excp_helper.c |  2 +-
 target/s390x/kvm.c         |  2 +-
 target/s390x/sigp.c        |  8 ++++----
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f290f5410..9db3a4258c 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -200,7 +200,7 @@ static void qemu_s390_flic_notify(uint32_t type)
         }
 
         /* we always kick running CPUs for now, this is tricky */
-        if (cs->halted) {
+        if (cpu_halted(cs)) {
             /* don't check for subclasses, CPUs double check when waking up */
             if (type & FLIC_PENDING_SERVICE) {
                 if (!(cpu->env.psw.mask & PSW_MASK_EXT)) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 427a46e3e1..7910deed35 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -284,7 +284,7 @@ static void s390_cpu_initfn(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cpu_set_cpustate_pointers(cpu);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
@@ -311,8 +311,8 @@ static void s390_cpu_finalize(Object *obj)
 #if !defined(CONFIG_USER_ONLY)
 static bool disabled_wait(CPUState *cpu)
 {
-    return cpu->halted && !(S390_CPU(cpu)->env.psw.mask &
-                            (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
+    return cpu_halted(cpu) && !(S390_CPU(cpu)->env.psw.mask &
+                                (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
 static unsigned s390_count_running_cpus(void)
@@ -338,10 +338,16 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_halt(cs->cpu_index);
 
-    if (!cs->halted) {
-        cs->halted = 1;
+    /*
+     * cpu_halted and cpu_halted_set acquire the cpu lock if it
+     * isn't already held, so acquire it first.
+     */
+    cpu_mutex_lock(cs);
+    if (!cpu_halted(cs)) {
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
+    cpu_mutex_unlock(cs);
 
     return s390_count_running_cpus();
 }
@@ -351,10 +357,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_unhalt(cs->cpu_index);
 
-    if (cs->halted) {
-        cs->halted = 0;
+    cpu_mutex_lock(cs);
+    if (cpu_halted(cs)) {
+        cpu_halted_set(cs, 0);
         cs->exception_index = -1;
     }
+    cpu_mutex_unlock(cs);
 }
 
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3b58d10df3..db6640ba2c 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -537,7 +537,7 @@ try_deliver:
     if ((env->psw.mask & PSW_MASK_WAIT) || stopped) {
         /* don't trigger a cpu_loop_exit(), use an interrupt instead */
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
-    } else if (cs->halted) {
+    } else if (cpu_halted(cs)) {
         /* unhalt if we had a WAIT PSW somehwere in our injection chain */
         s390_cpu_unhalt(cpu);
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1d6fd6a27b..ea8596c95e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1060,7 +1060,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int s390_kvm_irq_to_interrupt(struct kvm_s390_irq *irq,
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c604f17710..44d22ae3bf 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -115,7 +115,7 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     }
 
     /* disabled wait - sleeping in user space */
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     } else {
         /* execute the stop function */
@@ -131,7 +131,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     /* disabled wait - sleeping in user space */
-    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cs->halted) {
+    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     }
 
@@ -313,7 +313,7 @@ static void sigp_cond_emergency(S390CPU *src_cpu, S390CPU *dst_cpu,
     }
 
     /* this looks racy, but these values are only used when STOPPED */
-    idle = CPU(dst_cpu)->halted;
+    idle = cpu_halted(CPU(dst_cpu));
     psw_addr = dst_cpu->env.psw.addr;
     psw_mask = dst_cpu->env.psw.mask;
     asn = si->param;
@@ -347,7 +347,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
     }
 
     /* If halted (which includes also STOPPED), it is not running */
-    if (CPU(dst_cpu)->halted) {
+    if (cpu_halted(CPU(dst_cpu))) {
         set_sigp_status(si, SIGP_STAT_NOT_RUNNING);
     } else {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-- 
2.17.1


