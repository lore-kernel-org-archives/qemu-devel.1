Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC681C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474F7223E8
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474F7223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYMe-0000pb-CS
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIO-0003CF-No
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIC-0003pH-VC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id ED347B3B9;
 Wed, 16 Sep 2020 14:20:28 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v8 06/17] cpus: extract out kvm-specific code to accel/kvm
Date: Wed, 16 Sep 2020 16:19:53 +0200
Message-Id: <20200916142004.27429-7-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916142004.27429-1-cfontana@suse.de>
References: <20200916142004.27429-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:39:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

register a "CpusAccel" interface for KVM as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[added const]
Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c    | 14 ++++++-
 accel/kvm/kvm-cpus.c   | 88 ++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/kvm-cpus.h   | 17 ++++++++
 accel/kvm/meson.build  |  5 ++-
 accel/stubs/kvm-stub.c |  3 +-
 include/sysemu/kvm.h   |  2 +-
 softmmu/cpus.c         | 77 ------------------------------------
 7 files changed, 124 insertions(+), 82 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus.c
 create mode 100644 accel/kvm/kvm-cpus.h

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..fbd82cb444 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -44,6 +44,9 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "sysemu/reset.h"
+#include "qemu/guest-random.h"
+#include "sysemu/hw_accel.h"
+#include "kvm-cpus.h"
 
 #include "hw/boards.h"
 
@@ -378,7 +381,7 @@ err:
     return ret;
 }
 
-int kvm_destroy_vcpu(CPUState *cpu)
+static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
     long mmap_size;
@@ -412,6 +415,14 @@ err:
     return ret;
 }
 
+void kvm_destroy_vcpu(CPUState *cpu)
+{
+    if (do_kvm_destroy_vcpu(cpu) < 0) {
+        error_report("kvm_destroy_vcpu failed");
+        exit(EXIT_FAILURE);
+    }
+}
+
 static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
 {
     struct KVMParkedVcpu *cpu;
@@ -2232,6 +2243,7 @@ static int kvm_init(MachineState *ms)
         assert(!ret);
     }
 
+    cpus_register_accel(&kvm_cpus);
     return 0;
 
 err:
diff --git a/accel/kvm/kvm-cpus.c b/accel/kvm/kvm-cpus.c
new file mode 100644
index 0000000000..a120601564
--- /dev/null
+++ b/accel/kvm/kvm-cpus.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU KVM support
+ *
+ * Copyright IBM, Corp. 2008
+ *           Red Hat, Inc. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Glauber Costa     <gcosta@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "sysemu/kvm_int.h"
+#include "sysemu/runstate.h"
+#include "sysemu/cpus.h"
+#include "qemu/guest-random.h"
+
+#include "kvm-cpus.h"
+
+static void *kvm_vcpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+
+    r = kvm_init_vcpu(cpu);
+    if (r < 0) {
+        error_report("kvm_init_vcpu failed: %s", strerror(-r));
+        exit(1);
+    }
+
+    kvm_init_cpu_signals(cpu);
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = kvm_cpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    kvm_destroy_vcpu(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void kvm_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, kvm_vcpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
+const CpusAccel kvm_cpus = {
+    .create_vcpu_thread = kvm_start_vcpu_thread,
+
+    .synchronize_post_reset = kvm_cpu_synchronize_post_reset,
+    .synchronize_post_init = kvm_cpu_synchronize_post_init,
+    .synchronize_state = kvm_cpu_synchronize_state,
+    .synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm,
+};
diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
new file mode 100644
index 0000000000..547fbee111
--- /dev/null
+++ b/accel/kvm/kvm-cpus.h
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
+#ifndef KVM_CPUS_H
+#define KVM_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern const CpusAccel kvm_cpus;
+
+#endif /* KVM_CPUS_H */
diff --git a/accel/kvm/meson.build b/accel/kvm/meson.build
index 4db2388e2f..7e9dafe24c 100644
--- a/accel/kvm/meson.build
+++ b/accel/kvm/meson.build
@@ -1,5 +1,8 @@
 kvm_ss = ss.source_set()
-kvm_ss.add(files('kvm-all.c'))
+kvm_ss.add(files(
+  'kvm-all.c',
+  'kvm-cpus.c',
+))
 kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
 
 specific_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df..69f8a842da 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -32,9 +32,8 @@ bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 
-int kvm_destroy_vcpu(CPUState *cpu)
+void kvm_destroy_vcpu(CPUState *cpu)
 {
-    return -ENOSYS;
 }
 
 int kvm_init_vcpu(CPUState *cpu)
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 5bbea53883..07937454d2 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -225,7 +225,7 @@ int kvm_has_intx_set_mask(void);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
-int kvm_destroy_vcpu(CPUState *cpu);
+void kvm_destroy_vcpu(CPUState *cpu);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index d1eddc65d0..fd5bd6d809 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -179,9 +179,6 @@ void cpu_synchronize_state(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_state) {
         cpus_accel->synchronize_state(cpu);
     }
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_state(cpu);
-    }
     if (hax_enabled()) {
         hax_cpu_synchronize_state(cpu);
     }
@@ -195,9 +192,6 @@ void cpu_synchronize_post_reset(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_reset) {
         cpus_accel->synchronize_post_reset(cpu);
     }
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_reset(cpu);
-    }
     if (hax_enabled()) {
         hax_cpu_synchronize_post_reset(cpu);
     }
@@ -211,9 +205,6 @@ void cpu_synchronize_post_init(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_post_init) {
         cpus_accel->synchronize_post_init(cpu);
     }
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_init(cpu);
-    }
     if (hax_enabled()) {
         hax_cpu_synchronize_post_init(cpu);
     }
@@ -227,9 +218,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
         cpus_accel->synchronize_pre_loadvm(cpu);
     }
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_pre_loadvm(cpu);
-    }
     if (hax_enabled()) {
         hax_cpu_synchronize_pre_loadvm(cpu);
     }
@@ -384,14 +372,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     do_run_on_cpu(cpu, func, data, &qemu_global_mutex);
 }
 
-static void qemu_kvm_destroy_vcpu(CPUState *cpu)
-{
-    if (kvm_destroy_vcpu(cpu) < 0) {
-        error_report("kvm_destroy_vcpu failed");
-        exit(EXIT_FAILURE);
-    }
-}
-
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
@@ -436,48 +416,6 @@ void qemu_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
-static void *qemu_kvm_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-    int r;
-
-    rcu_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
-    current_cpu = cpu;
-
-    r = kvm_init_vcpu(cpu);
-    if (r < 0) {
-        error_report("kvm_init_vcpu failed: %s", strerror(-r));
-        exit(1);
-    }
-
-    kvm_init_cpu_signals(cpu);
-
-    /* signal CPU creation */
-    cpu_thread_signal_created(cpu);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = kvm_cpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    qemu_kvm_destroy_vcpu(cpu);
-    cpu_thread_signal_destroyed(cpu);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
 static void *qemu_hax_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -801,19 +739,6 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 #endif
 }
 
-static void qemu_kvm_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static void qemu_hvf_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -875,8 +800,6 @@ void qemu_init_vcpu(CPUState *cpu)
     if (cpus_accel) {
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->create_vcpu_thread(cpu);
-    } else if (kvm_enabled()) {
-        qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
         qemu_hax_start_vcpu(cpu);
     } else if (hvf_enabled()) {
-- 
2.26.2


