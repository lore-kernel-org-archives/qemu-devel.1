Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CFFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D2F20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1FAcjUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D2F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhdE-0004oD-4t
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ8-0002YL-Lg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ6-0001P2-O2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so6471692wrq.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tRws1uvIR8Dz3INqgE4H34M7MpVxrffO/G7ZokVze8I=;
 b=L1FAcjUMlpcIFb/Kk2sdWXvlPST3jkAV7iM8DAil5+XLFcC/Z0ppi+HhLtWFDZ0S6b
 up8zp1f58+z9+nB7Vazg9UtSPKAPU6eWDEegX1d2hphj31cRo/WYy4k7ENVMrU31eg9l
 Ou46+lAcKxdCMIUr+OA0YT13uLNYLygZosQib4EpMP1j6b6jqnfgjnn3LSXQQd7+jCDa
 kwrlbDgxUZ81rpqt5sgIGxu/ImS8rDOhNStLvcN24tVoa1/VNXsyTwVRWeG8BnkaQ2fE
 ryVU57LfYvZDvgk/fOGeyWYKLtSEAiSAfSj/+sPbti63EFeNb2ItcoZXxyfnj+Lf6QV8
 JGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tRws1uvIR8Dz3INqgE4H34M7MpVxrffO/G7ZokVze8I=;
 b=nk7mFhCvDOfMLyYowQCF9fgRjXAEJgmny9LlXpsGKPh7k50fl3z+7Src5Wt8MoQG44
 lgpocXekAroutDOoq4yIElR9Kwot9d94vv586L+jGbr2tzlWFO8sto+m+eHUJbNBSXJm
 DmNth/1JhQKpA0BNzrRmujJrLhbirD3fTyCdyeA7ZqZulXBHkNtOW1hakNJaHq9j1XMn
 p7cQNmwhOwyWIdICTPCXZQWbX9kXXyqLGmZ0cUppYKQaBIISquB2ZNptZrCs4DI9UcUZ
 eMX8GVSywvKVjL/AHYQEZCglKcVy+RkACv08rmAKvB1Ke1Kgb49tiyJqo5d7JK7CX/Wf
 EIwg==
X-Gm-Message-State: AOAM530Dwl87kK48Vc+IJtWY+zuu/3L0R4zsV0/jSTVbs4UjCkJjyGfZ
 r4dJU1JRUSCVyJuxth7y7DG9hm9N7/w=
X-Google-Smtp-Source: ABdhPJy27qF6i1D8bTgsJwrG/kcbU7+RUjK4jy3UdjFEKK8GriZ1YTNizl5gfT7CTgxvhSaksNUonw==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr3199826wrp.367.1601969397024; 
 Tue, 06 Oct 2020 00:29:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/37] cpus: add handle_interrupt to the CpusAccel interface
Date: Tue,  6 Oct 2020 09:29:22 +0200
Message-Id: <20201006072947.487729-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

kvm: uses the generic handler
qtest: uses the generic handler
whpx: changed to use the generic handler (identical implementation)
hax: changed to use the generic handler (identical implementation)
hvf: changed to use the generic handler (identical implementation)
tcg: adapt tcg-cpus to point to the tcg-specific handler

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c    | 26 --------------------------
 accel/tcg/tcg-cpus.c   | 28 ++++++++++++++++++++++++++++
 hw/core/cpu.c          | 13 -------------
 include/hw/core/cpu.h  | 14 --------------
 include/sysemu/cpus.h  |  2 ++
 softmmu/cpus.c         | 18 ++++++++++++++++++
 target/i386/hax-all.c  | 10 ----------
 target/i386/hvf/hvf.c  |  9 ---------
 target/i386/whpx-all.c | 10 ----------
 9 files changed, 48 insertions(+), 82 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 000fe4dbd9..fa1208158f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -47,31 +47,6 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
-/* mask must never be zero, except for A20 change call */
-static void tcg_handle_interrupt(CPUState *cpu, int mask)
-{
-    int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
-
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
-
-    /*
-     * If called from iothread context, wake the target cpu in
-     * case its halted.
-     */
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    } else {
-        qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
-        if (icount_enabled() &&
-            !cpu->can_do_io
-            && (mask & ~old_mask) != 0) {
-            cpu_abort(cpu, "Raised interrupt while not in I/O function");
-        }
-    }
-}
-
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -128,7 +103,6 @@ static int tcg_init(MachineState *ms)
     TCGState *s = TCG_STATE(current_accel());
 
     tcg_exec_init(s->tb_size * 1024 * 1024);
-    cpu_interrupt_handler = tcg_handle_interrupt;
     mttcg_enabled = s->mttcg_enabled;
     cpus_register_accel(&tcg_cpus);
 
diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
index 4f15c7f0de..cedd1e6c4f 100644
--- a/accel/tcg/tcg-cpus.c
+++ b/accel/tcg/tcg-cpus.c
@@ -543,9 +543,37 @@ static int64_t tcg_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
+/* mask must never be zero, except for A20 change call */
+static void tcg_handle_interrupt(CPUState *cpu, int mask)
+{
+    int old_mask;
+    g_assert(qemu_mutex_iothread_locked());
+
+    old_mask = cpu->interrupt_request;
+    cpu->interrupt_request |= mask;
+
+    /*
+     * If called from iothread context, wake the target cpu in
+     * case its halted.
+     */
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    } else {
+        qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
+        if (icount_enabled() &&
+            !cpu->can_do_io
+            && (mask & ~old_mask) != 0) {
+            cpu_abort(cpu, "Raised interrupt while not in I/O function");
+        }
+    }
+}
+
 const CpusAccel tcg_cpus = {
     .create_vcpu_thread = tcg_start_vcpu_thread,
     .kick_vcpu_thread = tcg_kick_vcpu_thread,
+
+    .handle_interrupt = tcg_handle_interrupt,
+
     .get_virtual_clock = tcg_get_virtual_clock,
     .get_elapsed_ticks = tcg_get_elapsed_ticks,
 };
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index d596182621..8654550d39 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -35,8 +35,6 @@
 #include "qemu/plugin.h"
 #include "sysemu/hw_accel.h"
 
-CPUInterruptHandler cpu_interrupt_handler;
-
 CPUState *cpu_by_arch_id(int64_t id)
 {
     CPUState *cpu;
@@ -394,17 +392,6 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
     return addr;
 }
 
-static void generic_handle_interrupt(CPUState *cpu, int mask)
-{
-    cpu->interrupt_request |= mask;
-
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
-CPUInterruptHandler cpu_interrupt_handler = generic_handle_interrupt;
-
 static void cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6c34798c8b..4879f25026 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -844,12 +844,6 @@ bool cpu_exists(int64_t id);
  */
 CPUState *cpu_by_arch_id(int64_t id);
 
-#ifndef CONFIG_USER_ONLY
-
-typedef void (*CPUInterruptHandler)(CPUState *, int);
-
-extern CPUInterruptHandler cpu_interrupt_handler;
-
 /**
  * cpu_interrupt:
  * @cpu: The CPU to set an interrupt on.
@@ -857,17 +851,9 @@ extern CPUInterruptHandler cpu_interrupt_handler;
  *
  * Invokes the interrupt handler.
  */
-static inline void cpu_interrupt(CPUState *cpu, int mask)
-{
-    cpu_interrupt_handler(cpu, mask);
-}
-
-#else /* USER_ONLY */
 
 void cpu_interrupt(CPUState *cpu, int mask);
 
-#endif /* USER_ONLY */
-
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 26171697f5..231685955d 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -16,6 +16,8 @@ typedef struct CpusAccel {
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
 
+    void (*handle_interrupt)(CPUState *cpu, int mask);
+
     int64_t (*get_virtual_clock)(void);
     int64_t (*get_elapsed_ticks)(void);
 } CpusAccel;
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 99f418437b..f3d0c59f78 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -225,6 +225,24 @@ int64_t cpus_get_elapsed_ticks(void)
     return cpu_get_ticks();
 }
 
+static void generic_handle_interrupt(CPUState *cpu, int mask)
+{
+    cpu->interrupt_request |= mask;
+
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+void cpu_interrupt(CPUState *cpu, int mask)
+{
+    if (cpus_accel->handle_interrupt) {
+        cpus_accel->handle_interrupt(cpu, mask);
+    } else {
+        generic_handle_interrupt(cpu, mask);
+    }
+}
+
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index b66ddeb8bf..fd1ab673d7 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -297,15 +297,6 @@ int hax_vm_destroy(struct hax_vm *vm)
     return 0;
 }
 
-static void hax_handle_interrupt(CPUState *cpu, int mask)
-{
-    cpu->interrupt_request |= mask;
-
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
 static int hax_init(ram_addr_t ram_size, int max_cpus)
 {
     struct hax_state *hax = NULL;
@@ -350,7 +341,6 @@ static int hax_init(ram_addr_t ram_size, int max_cpus)
     qversion.cur_version = hax_cur_version;
     qversion.min_version = hax_min_version;
     hax_notify_qemu_version(hax->vm->fd, &qversion);
-    cpu_interrupt_handler = hax_handle_interrupt;
 
     return ret;
   error:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 7ac6987c1b..ed9356565c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -262,14 +262,6 @@ static void update_apic_tpr(CPUState *cpu)
 
 #define VECTORING_INFO_VECTOR_MASK     0xff
 
-static void hvf_handle_interrupt(CPUState * cpu, int mask)
-{
-    cpu->interrupt_request |= mask;
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
 void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
@@ -894,7 +886,6 @@ static int hvf_accel_init(MachineState *ms)
     }
   
     hvf_state = s;
-    cpu_interrupt_handler = hvf_handle_interrupt;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
     cpus_register_accel(&hvf_cpus);
     return 0;
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 91ee2e59f9..f4f3e33eac 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1488,15 +1488,6 @@ static void whpx_memory_init(void)
     memory_listener_register(&whpx_memory_listener, &address_space_memory);
 }
 
-static void whpx_handle_interrupt(CPUState *cpu, int mask)
-{
-    cpu->interrupt_request |= mask;
-
-    if (!qemu_cpu_is_self(cpu)) {
-        qemu_cpu_kick(cpu);
-    }
-}
-
 /*
  * Load the functions from the given library, using the given handle. If a
  * handle is provided, it is used, otherwise the library is opened. The
@@ -1651,7 +1642,6 @@ static int whpx_accel_init(MachineState *ms)
 
     whpx_memory_init();
 
-    cpu_interrupt_handler = whpx_handle_interrupt;
     cpus_register_accel(&whpx_cpus);
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
-- 
2.26.2



