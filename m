Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE57620738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkfYDUUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE57620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboTA-0000GX-TI
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIS-0002xs-Pc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:52 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:42237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIR-0006Yh-3S
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:52 -0400
Received: by mail-qk1-x744.google.com with SMTP id s1so7835957qkf.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WqInjgZviyNdzW5p2Hg5xhlKpmgDlxcslWkF7JOAFYA=;
 b=ZkfYDUUgKAGy5gWJ52+BEeFQi29PP6rBSegwRrL7iwnA+lQL8U9jVTc1qVmX3UZ6SB
 E/2bDy/H69RDUeIB8fHzgZclwxLndyZDP/SFsHfBNghvnUOjmB4puCH+Go78ZUYJ08Zw
 zcRtGdvEmJpV8Unf7qgLaHRtAQ/bsT4ZAlq9rU4h9ZRd56fSfO2YMlmU3G6qnl7Uz45U
 JTu4HKBFKLVV17YC1ZR68FVuAPyGyLmwGFG8JL9ijgSMxQNQ8LZzmTpQ8UbJUdxxrJnO
 mTWB+WlW8I9pDhY1+WOwue8nFcfUtHBPAvzerIJmbJDyC5UXWW3ehRQzYj2Ebj6n7hK8
 +l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WqInjgZviyNdzW5p2Hg5xhlKpmgDlxcslWkF7JOAFYA=;
 b=bu7/JQyLou0U004XlfA/mMA8yOBANvWGo1eV2NvrjouC6TIVxVr4iOOh2PmtuPF4AH
 FXPbFcrU+uOdym177cjQ1xCEWxUY5JWquBCvsuwcZzIoHJ9cWUDP+8iVh7Mk5T9gVaL7
 ysC3bN3DKnI1kehmW5Bn99YEzQot05JS6/uVh5LFyQmQeqJ6cquFFC/jMvCt3gI8Jm3O
 /bV4qPEkevEZUQZOY6fxsmUu9V/g9NOLM2R0SLlnP6Zy7Z2PtVw/62s5NYcq+foQmTeF
 eXpCVQYNRwkju9mxalvuvJp9klQaYqVvb8r1PmZXxB/ibRvD4wvq+3g2DBC8ZWNSPWmW
 r/gg==
X-Gm-Message-State: AOAM5332tqLw1YKKuh08QNY9677FRpwAu5VGL6I+kx3wCc1QhMISmAe+
 VZuAaeNbRZWwss4sUJ/svc1mzDAfSOpX2A==
X-Google-Smtp-Source: ABdhPJxmQY+QPlxS11ljJsb1F1MnPxOiUEaHhO0JzZc+Ks7lGnlbOkxzAduA0w3S1uY25eTzJoLwUQ==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr10906870qke.154.1590079429752; 
 Thu, 21 May 2020 09:43:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 26/74] s390x: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:23 -0400
Message-Id: <20200521164011.638-27-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 richard.henderson@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

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
index baca4d8a2d..a1c6b8a6f6 100644
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
index ca50b70451..4b1961694e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -293,7 +293,7 @@ static void s390_cpu_initfn(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cpu_set_cpustate_pointers(cpu);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
@@ -320,8 +320,8 @@ static void s390_cpu_finalize(Object *obj)
 #if !defined(CONFIG_USER_ONLY)
 static bool disabled_wait(CPUState *cpu)
 {
-    return cpu->halted && !(S390_CPU(cpu)->env.psw.mask &
-                            (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
+    return cpu_halted(cpu) && !(S390_CPU(cpu)->env.psw.mask &
+                                (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
 static unsigned s390_count_running_cpus(void)
@@ -347,10 +347,16 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
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
@@ -360,10 +366,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
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
index 69881a0da0..ae3e0880f1 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1094,7 +1094,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
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


