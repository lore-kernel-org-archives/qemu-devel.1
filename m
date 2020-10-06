Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B08EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4DF20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM8kEhid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4DF20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhWs-0002ow-Tc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ4-0002OH-Dz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ2-0001Nr-5v
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id n18so4414774wrs.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2EgtVjM3/ycQDYmpVws4Od1mOvuE8ipTuPkscDkDf3k=;
 b=sM8kEhidy2G4DCu+2AIEBVjGPDyZyzkHjxGp9+hRmS2cJU6VbT2lN78L5iHThyvsDz
 Xq1dLHDwnsWFa1V6zwtT76mU6WjVk90H4CArOGm5hY3bHUB6B0r+xBRoF5ZNMCgGBX9h
 KC8AQwnrmPbR0YMMUvfX1GKVDIFd/k5fPdwJB5S00tX5RZFHNaeXgk32/8WgfqyZGzL/
 qb007njjYzf7+9/fpDSWFdLnk++2KiTOy7kWTl/cW02Mw9v0gdWlv9k77BWrvz6XrfUh
 yHtzKmdKzld8xIBTGDM1itn2NyuTKlmBfyriT5bxkmxYguyeGCXYonX/+kOaMFkfDFNc
 5J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2EgtVjM3/ycQDYmpVws4Od1mOvuE8ipTuPkscDkDf3k=;
 b=cE/lf84mcrmRfQjRHIyuPecxDSbHHKHUaJO02YZFLKwQx8zFsSR7imcMw8ej3ic2Pw
 gRgXkG9LshlacjzePPuEPKhMnZVtFD5spnTWPY9bECovJNYJKZiJyiAcd9Ytc9FXNh8B
 ukJMWnfZm5jCGaGceq4AzDvS3SBtZLs0ITMSZuCFX3lWYVqQQw995kEhaq2Vn/UcVzXL
 2MP04wR+Q/9yPizyTwIhr+T+3zH9GnKpQeZi/7VWgfi5bT6OnBrW3HBtA6L7SucUmjsP
 OiuXrplnCWU8QexLWE0a4EibeMgO6TJxGO2mYsHEDKI1b7GcZZv5qd4BNFjrA1dvGjO9
 jO0g==
X-Gm-Message-State: AOAM531OMyoynaML07OYuG8lHUktMvmPOa9pgI5wzuN+Fg42I5fy+IO9
 VgfFCSzjjP3obFUKHaKsbvXQxUIo0cY=
X-Google-Smtp-Source: ABdhPJwMRbMDbCzfTmogEulMjDoZZqJH0M7h2AjoV3GHwDeUjZIjlD3iiLWf3p+up/XsWK+wydOuuw==
X-Received: by 2002:a5d:688b:: with SMTP id h11mr3213897wru.319.1601969392418; 
 Tue, 06 Oct 2020 00:29:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/37] cpus: extract out hax-specific code to target/i386/
Date: Tue,  6 Oct 2020 09:29:17 +0200
Message-Id: <20201006072947.487729-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x431.google.com
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

register a "CpusAccel" interface for HAX as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/cpus.c            | 80 +-----------------------------------
 target/i386/hax-all.c     |  6 ++-
 target/i386/hax-cpus.c    | 85 +++++++++++++++++++++++++++++++++++++++
 target/i386/hax-cpus.h    | 17 ++++++++
 target/i386/hax-i386.h    |  2 +
 target/i386/hax-posix.c   | 12 ++++++
 target/i386/hax-windows.c | 20 +++++++++
 target/i386/meson.build   |  9 ++++-
 8 files changed, 149 insertions(+), 82 deletions(-)
 create mode 100644 target/i386/hax-cpus.c
 create mode 100644 target/i386/hax-cpus.h

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 9fa73735a2..900fff827a 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -33,7 +33,6 @@
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
-#include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
@@ -179,9 +178,6 @@ void cpu_synchronize_state(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_state) {
         cpus_accel->synchronize_state(cpu);
     }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_state(cpu);
-    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
@@ -192,9 +188,6 @@ void cpu_synchronize_post_reset(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_reset) {
         cpus_accel->synchronize_post_reset(cpu);
     }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_reset(cpu);
-    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
@@ -205,9 +198,6 @@ void cpu_synchronize_post_init(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_init) {
         cpus_accel->synchronize_post_init(cpu);
     }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_init(cpu);
-    }
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
@@ -218,9 +208,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
         cpus_accel->synchronize_pre_loadvm(cpu);
     }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_pre_loadvm(cpu);
-    }
     if (hvf_enabled()) {
         hvf_cpu_synchronize_pre_loadvm(cpu);
     }
@@ -416,35 +403,6 @@ void qemu_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
-static void *qemu_hax_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-    int r;
-
-    rcu_register_thread();
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    current_cpu = cpu;
-    hax_init_vcpu(cpu);
-    cpu_thread_signal_created(cpu);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = hax_smp_cpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-    rcu_unregister_thread();
-    return NULL;
-}
-
 /* The HVF-specific vCPU thread function. This one should only run when the host
  * CPU supports the VMX "unrestricted guest" feature. */
 static void *qemu_hvf_cpu_thread_fn(void *arg)
@@ -529,12 +487,6 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-#ifdef _WIN32
-static void CALLBACK dummy_apc_func(ULONG_PTR unused)
-{
-}
-#endif
-
 void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -553,10 +505,6 @@ void cpus_kick_thread(CPUState *cpu)
     if (!qemu_cpu_is_self(cpu)) {
         if (whpx_enabled()) {
             whpx_vcpu_kick(cpu);
-        } else if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
-            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
-                    __func__, GetLastError());
-            exit(1);
         }
     }
 #endif
@@ -567,14 +515,7 @@ void qemu_cpu_kick(CPUState *cpu)
     qemu_cond_broadcast(cpu->halt_cond);
     if (cpus_accel && cpus_accel->kick_vcpu_thread) {
         cpus_accel->kick_vcpu_thread(cpu);
-    } else {
-        if (hax_enabled()) {
-            /*
-             * FIXME: race condition with the exit_request check in
-             * hax_vcpu_hax_exec
-             */
-            cpu->exit_request = 1;
-        }
+    } else { /* default */
         cpus_kick_thread(cpu);
     }
 }
@@ -722,23 +663,6 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_lock_iothread();
 }
 
-static void qemu_hax_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
-}
-
 static void qemu_hvf_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -800,8 +724,6 @@ void qemu_init_vcpu(CPUState *cpu)
     if (cpus_accel) {
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->create_vcpu_thread(cpu);
-    } else if (hax_enabled()) {
-        qemu_hax_start_vcpu(cpu);
     } else if (hvf_enabled()) {
         qemu_hvf_start_vcpu(cpu);
     } else if (whpx_enabled()) {
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index c93bb23a44..b66ddeb8bf 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -32,9 +32,10 @@
 #include "sysemu/accel.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-#include "qemu/main-loop.h"
 #include "hw/boards.h"
 
+#include "hax-cpus.h"
+
 #define DEBUG_HAX 0
 
 #define DPRINTF(fmt, ...) \
@@ -374,6 +375,9 @@ static int hax_accel_init(MachineState *ms)
                 !ret ? "working" : "not working",
                 !ret ? "fast virt" : "emulation");
     }
+    if (ret == 0) {
+        cpus_register_accel(&hax_cpus);
+    }
     return ret;
 }
 
diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c
new file mode 100644
index 0000000000..9aad98bc7a
--- /dev/null
+++ b/target/i386/hax-cpus.c
@@ -0,0 +1,85 @@
+/*
+ * QEMU HAX support
+ *
+ * Copyright IBM, Corp. 2008
+ *           Red Hat, Inc. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Glauber Costa     <gcosta@redhat.com>
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "hax-i386.h"
+#include "sysemu/runstate.h"
+#include "sysemu/cpus.h"
+#include "qemu/guest-random.h"
+
+#include "hax-cpus.h"
+
+static void *hax_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+
+    rcu_register_thread();
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    hax_init_vcpu(cpu);
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = hax_smp_cpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void hax_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, hax_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+}
+
+const CpusAccel hax_cpus = {
+    .create_vcpu_thread = hax_start_vcpu_thread,
+    .kick_vcpu_thread = hax_kick_vcpu_thread,
+
+    .synchronize_post_reset = hax_cpu_synchronize_post_reset,
+    .synchronize_post_init = hax_cpu_synchronize_post_init,
+    .synchronize_state = hax_cpu_synchronize_state,
+    .synchronize_pre_loadvm = hax_cpu_synchronize_pre_loadvm,
+};
diff --git a/target/i386/hax-cpus.h b/target/i386/hax-cpus.h
new file mode 100644
index 0000000000..a64417fe2d
--- /dev/null
+++ b/target/i386/hax-cpus.h
@@ -0,0 +1,17 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HAX_CPUS_H
+#define HAX_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern const CpusAccel hax_cpus;
+
+#endif /* HAX_CPUS_H */
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index ec28708185..48c4abe14e 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -60,6 +60,8 @@ int hax_inject_interrupt(CPUArchState *env, int vector);
 struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus);
 int hax_vcpu_run(struct hax_vcpu_state *vcpu);
 int hax_vcpu_create(int id);
+void hax_kick_vcpu_thread(CPUState *cpu);
+
 int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
                         int set);
 int hax_sync_msr(CPUArchState *env, struct hax_msr_data *msrs, int set);
diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 5f9d1b803d..6fb7867d11 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -16,6 +16,8 @@
 
 #include "target/i386/hax-i386.h"
 
+#include "sysemu/cpus.h"
+
 hax_fd hax_mod_open(void)
 {
     int fd = open("/dev/HAX", O_RDWR);
@@ -292,3 +294,13 @@ int hax_inject_interrupt(CPUArchState *env, int vector)
 
     return ioctl(fd, HAX_VCPU_IOCTL_INTERRUPT, &vector);
 }
+
+void hax_kick_vcpu_thread(CPUState *cpu)
+{
+    /*
+     * FIXME: race condition with the exit_request check in
+     * hax_vcpu_hax_exec
+     */
+    cpu->exit_request = 1;
+    cpus_kick_thread(cpu);
+}
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 863c2bcc19..469b48e608 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -463,3 +463,23 @@ int hax_inject_interrupt(CPUArchState *env, int vector)
         return 0;
     }
 }
+
+static void CALLBACK dummy_apc_func(ULONG_PTR unused)
+{
+}
+
+void hax_kick_vcpu_thread(CPUState *cpu)
+{
+    /*
+     * FIXME: race condition with the exit_request check in
+     * hax_vcpu_hax_exec
+     */
+    cpu->exit_request = 1;
+    if (!qemu_cpu_is_self(cpu)) {
+        if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
+            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
+                    __func__, GetLastError());
+            exit(1);
+        }
+    }
+}
diff --git a/target/i386/meson.build b/target/i386/meson.build
index e0b71ade56..1db619841c 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -31,8 +31,13 @@ i386_softmmu_ss.add(files(
 i386_softmmu_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 i386_softmmu_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 i386_softmmu_ss.add(when: 'CONFIG_WHPX', if_true: files('whpx-all.c'))
-i386_softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_HAX'], if_true: files('hax-all.c', 'hax-mem.c', 'hax-posix.c'))
-i386_softmmu_ss.add(when: ['CONFIG_WIN32', 'CONFIG_HAX'], if_true: files('hax-all.c', 'hax-mem.c', 'hax-windows.c'))
+i386_softmmu_ss.add(when: 'CONFIG_HAX', if_true: files(
+  'hax-all.c',
+  'hax-mem.c',
+  'hax-cpus.c',
+))
+i386_softmmu_ss.add(when: ['CONFIG_HAX', 'CONFIG_POSIX'], if_true: files('hax-posix.c'))
+i386_softmmu_ss.add(when: ['CONFIG_HAX', 'CONFIG_WIN32'], if_true: files('hax-windows.c'))
 
 subdir('hvf')
 
-- 
2.26.2



