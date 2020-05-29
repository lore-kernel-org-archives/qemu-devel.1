Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF84C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D07F2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D07F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jec0w-0003Sb-Dv
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jebyk-000064-Ql
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jebye-0002d8-TC
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:11:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9FFAAAC5F;
 Fri, 29 May 2020 10:10:58 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [RFC v4 4/4] cpus: extract out accel-specific code to each accel
Date: Fri, 29 May 2020 12:10:53 +0200
Message-Id: <20200529101053.4045-5-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200529101053.4045-1-cfontana@suse.de>
References: <20200529101053.4045-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 02:21:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

each accelerator registers a new "CpusAccel" interface
implementation on initialization, providing functions for
starting a vcpu, kicking a vcpu, and sychronizing state.

This way the code in cpus.c is now all general softmmu code,
nothing accelerator-specific anymore.

There is still some ifdeffery for WIN32 though.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 MAINTAINERS                   |   1 +
 accel/Makefile.objs           |   2 +-
 accel/kvm/Makefile.objs       |   2 +
 accel/kvm/kvm-all.c           |  15 +-
 accel/kvm/kvm-cpus.c          |  94 +++++
 accel/kvm/kvm-cpus.h          |  17 +
 accel/qtest/Makefile.objs     |   2 +
 accel/qtest/qtest-cpus.c      | 105 +++++
 accel/qtest/qtest-cpus.h      |  17 +
 accel/{ => qtest}/qtest.c     |   7 +
 accel/stubs/kvm-stub.c        |   3 +-
 accel/tcg/Makefile.objs       |   1 +
 accel/tcg/tcg-all.c           |  12 +-
 accel/tcg/tcg-cpus.c          | 523 ++++++++++++++++++++++++
 accel/tcg/tcg-cpus.h          |  17 +
 hw/core/cpu.c                 |   1 +
 include/sysemu/cpus.h         |  32 ++
 include/sysemu/hvf.h          |   1 -
 include/sysemu/hw_accel.h     |  57 +--
 include/sysemu/kvm.h          |   2 +-
 softmmu/cpus.c                | 910 ++++--------------------------------------
 stubs/Makefile.objs           |   1 +
 stubs/cpu-synchronize-state.c |  15 +
 target/i386/Makefile.objs     |   7 +-
 target/i386/hax-all.c         |   6 +-
 target/i386/hax-cpus.c        |  85 ++++
 target/i386/hax-cpus.h        |  17 +
 target/i386/hax-i386.h        |   2 +
 target/i386/hax-posix.c       |  12 +
 target/i386/hax-windows.c     |  20 +
 target/i386/hvf/Makefile.objs |   2 +-
 target/i386/hvf/hvf-cpus.c    | 141 +++++++
 target/i386/hvf/hvf-cpus.h    |  17 +
 target/i386/hvf/hvf.c         |   5 +-
 target/i386/whpx-all.c        |   3 +
 target/i386/whpx-cpus.c       |  96 +++++
 target/i386/whpx-cpus.h       |  17 +
 37 files changed, 1363 insertions(+), 904 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus.c
 create mode 100644 accel/kvm/kvm-cpus.h
 create mode 100644 accel/qtest/Makefile.objs
 create mode 100644 accel/qtest/qtest-cpus.c
 create mode 100644 accel/qtest/qtest-cpus.h
 rename accel/{ => qtest}/qtest.c (86%)
 create mode 100644 accel/tcg/tcg-cpus.c
 create mode 100644 accel/tcg/tcg-cpus.h
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 target/i386/hax-cpus.c
 create mode 100644 target/i386/hax-cpus.h
 create mode 100644 target/i386/hvf/hvf-cpus.c
 create mode 100644 target/i386/hvf/hvf-cpus.h
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 978bffacb4..39ecc05706 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,6 +426,7 @@ WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
 F: target/i386/whpx-all.c
+F: target/i386/whpx-cpus.c
 F: target/i386/whp-dispatch.h
 F: accel/stubs/whpx-stub.c
 F: include/sysemu/whpx.h
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 17e5ac6061..d604b54fdb 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-$(CONFIG_SOFTMMU) += accel.o
-obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
+obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest/
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
index fdfa481578..ce0f492b8d 100644
--- a/accel/kvm/Makefile.objs
+++ b/accel/kvm/Makefile.objs
@@ -1,2 +1,4 @@
 obj-y += kvm-all.o
+obj-y += kvm-cpus.o
+
 obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..0919f1697e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -45,6 +45,10 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "sysemu/reset.h"
+#include "qemu/guest-random.h"
+
+#include "sysemu/hw_accel.h"
+#include "kvm-cpus.h"
 
 #include "hw/boards.h"
 
@@ -329,7 +333,7 @@ err:
     return ret;
 }
 
-int kvm_destroy_vcpu(CPUState *cpu)
+static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
     long mmap_size;
@@ -363,6 +367,14 @@ err:
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
@@ -2146,6 +2158,7 @@ static int kvm_init(MachineState *ms)
         qemu_balloon_inhibit(true);
     }
 
+    cpus_register_accel(&kvm_cpus);
     return 0;
 
 err:
diff --git a/accel/kvm/kvm-cpus.c b/accel/kvm/kvm-cpus.c
new file mode 100644
index 0000000000..ac6945a9e6
--- /dev/null
+++ b/accel/kvm/kvm-cpus.c
@@ -0,0 +1,94 @@
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
+static void kvm_kick_vcpu_thread(CPUState *cpu)
+{
+    cpus_kick_thread(cpu);
+}
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
+CpusAccel kvm_cpus = {
+    .create_vcpu_thread = kvm_start_vcpu_thread,
+    .kick_vcpu_thread = kvm_kick_vcpu_thread,
+
+    .synchronize_post_reset = kvm_cpu_synchronize_post_reset,
+    .synchronize_post_init = kvm_cpu_synchronize_post_init,
+    .synchronize_state = kvm_cpu_synchronize_state,
+    .synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm,
+};
diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
new file mode 100644
index 0000000000..62fbc911d9
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
+extern CpusAccel kvm_cpus;
+
+#endif /* KVM_CPUS_H */
diff --git a/accel/qtest/Makefile.objs b/accel/qtest/Makefile.objs
new file mode 100644
index 0000000000..627014200e
--- /dev/null
+++ b/accel/qtest/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y += qtest.o
+obj-y += qtest-cpus.o
diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
new file mode 100644
index 0000000000..4f7ace7fff
--- /dev/null
+++ b/accel/qtest/qtest-cpus.c
@@ -0,0 +1,105 @@
+/*
+ * QTest accelerator code
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/rcu.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "sysemu/accel.h"
+#include "sysemu/qtest.h"
+#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
+#include "qemu/guest-random.h"
+#include "qemu/main-loop.h"
+#include "hw/core/cpu.h"
+
+#include "qtest-cpus.h"
+
+static void qtest_cpu_synchronize_noop(CPUState *cpu)
+{
+}
+
+static void qtest_kick_vcpu_thread(CPUState *cpu)
+{
+    cpus_kick_thread(cpu);
+}
+
+static void *qtest_cpu_thread_fn(void *arg)
+{
+#ifdef _WIN32
+    error_report("qtest is not supported under Windows");
+    exit(1);
+#else
+    CPUState *cpu = arg;
+    sigset_t waitset;
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
+    sigemptyset(&waitset);
+    sigaddset(&waitset, SIG_IPI);
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        qemu_mutex_unlock_iothread();
+        do {
+            int sig;
+            r = sigwait(&waitset, &sig);
+        } while (r == -1 && (errno == EAGAIN || errno == EINTR));
+        if (r == -1) {
+            perror("sigwait");
+            exit(1);
+        }
+        qemu_mutex_lock_iothread();
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug);
+
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+#endif
+}
+
+static void qtest_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qtest_cpu_thread_fn, cpu,
+                       QEMU_THREAD_JOINABLE);
+}
+
+CpusAccel qtest_cpus = {
+    .create_vcpu_thread = qtest_start_vcpu_thread,
+    .kick_vcpu_thread = qtest_kick_vcpu_thread,
+
+    .synchronize_post_reset = qtest_cpu_synchronize_noop,
+    .synchronize_post_init = qtest_cpu_synchronize_noop,
+    .synchronize_state = qtest_cpu_synchronize_noop,
+    .synchronize_pre_loadvm = qtest_cpu_synchronize_noop,
+};
diff --git a/accel/qtest/qtest-cpus.h b/accel/qtest/qtest-cpus.h
new file mode 100644
index 0000000000..c1fab96b9e
--- /dev/null
+++ b/accel/qtest/qtest-cpus.h
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
+#ifndef QTEST_CPUS_H
+#define QTEST_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern CpusAccel qtest_cpus;
+
+#endif /* QTEST_CPUS_H */
diff --git a/accel/qtest.c b/accel/qtest/qtest.c
similarity index 86%
rename from accel/qtest.c
rename to accel/qtest/qtest.c
index 119d0f16a4..537e8b449c 100644
--- a/accel/qtest.c
+++ b/accel/qtest/qtest.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/rcu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -20,9 +21,15 @@
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
+#include "qemu/guest-random.h"
+#include "qemu/main-loop.h"
+#include "hw/core/cpu.h"
+
+#include "qtest-cpus.h"
 
 static int qtest_init_accel(MachineState *ms)
 {
+    cpus_register_accel(&qtest_cpus);
     return 0;
 }
 
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
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index a92f2c454b..ecf9aa582e 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-$(CONFIG_SOFTMMU) += tcg-cpus.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index e27385d051..3fd4bf2cab 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -24,19 +24,17 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/accel.h"
+#include "qemu-common.h"
 #include "sysemu/tcg.h"
-#include "qom/object.h"
-#include "cpu.h"
-#include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
-#include "qemu/main-loop.h"
 #include "tcg/tcg.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "qapi/qapi-builtin-visit.h"
 
+#include "tcg-cpus.h"
+
 typedef struct TCGState {
     AccelState parent_obj;
 
@@ -123,6 +121,8 @@ static void tcg_accel_instance_init(Object *obj)
     s->mttcg_enabled = default_mttcg_enabled();
 }
 
+bool mttcg_enabled;
+
 static int tcg_init(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
@@ -130,6 +130,8 @@ static int tcg_init(MachineState *ms)
     tcg_exec_init(s->tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
     mttcg_enabled = s->mttcg_enabled;
+    cpus_register_accel(&tcg_cpus);
+
     return 0;
 }
 
diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
new file mode 100644
index 0000000000..9bede84d3e
--- /dev/null
+++ b/accel/tcg/tcg-cpus.c
@@ -0,0 +1,523 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/tcg.h"
+#include "sysemu/replay.h"
+#include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
+#include "exec/exec-all.h"
+
+#include "tcg-cpus.h"
+
+/* Kick all RR vCPUs */
+static void qemu_cpu_kick_rr_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
+}
+
+static void tcg_kick_vcpu_thread(CPUState *cpu)
+{
+    if (qemu_tcg_mttcg_enabled()) {
+        cpu_exit(cpu);
+    } else {
+        qemu_cpu_kick_rr_cpus();
+    }
+}
+
+/*
+ * TCG vCPU kick timer
+ *
+ * The kick timer is responsible for moving single threaded vCPU
+ * emulation on to the next vCPU. If more than one vCPU is running a
+ * timer event with force a cpu->exit so the next vCPU can get
+ * scheduled.
+ *
+ * The timer is removed if all vCPUs are idle and restarted again once
+ * idleness is complete.
+ */
+
+static QEMUTimer *tcg_kick_vcpu_timer;
+static CPUState *tcg_current_rr_cpu;
+
+#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
+
+static inline int64_t qemu_tcg_next_kick(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
+}
+
+/* Kick the currently round-robin scheduled vCPU to next */
+static void qemu_cpu_kick_rr_next_cpu(void)
+{
+    CPUState *cpu;
+    do {
+        cpu = atomic_mb_read(&tcg_current_rr_cpu);
+        if (cpu) {
+            cpu_exit(cpu);
+        }
+    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
+}
+
+static void kick_tcg_thread(void *opaque)
+{
+    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    qemu_cpu_kick_rr_next_cpu();
+}
+
+static void start_tcg_kick_timer(void)
+{
+    assert(!mttcg_enabled);
+    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           kick_tcg_thread, NULL);
+    }
+    if (tcg_kick_vcpu_timer && !timer_pending(tcg_kick_vcpu_timer)) {
+        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    }
+}
+
+static void stop_tcg_kick_timer(void)
+{
+    assert(!mttcg_enabled);
+    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
+        timer_del(tcg_kick_vcpu_timer);
+    }
+}
+
+static void qemu_tcg_destroy_vcpu(CPUState *cpu)
+{
+}
+
+static void qemu_tcg_rr_wait_io_event(void)
+{
+    CPUState *cpu;
+
+    while (all_cpu_threads_idle()) {
+        stop_tcg_kick_timer();
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
+    }
+
+    start_tcg_kick_timer();
+
+    CPU_FOREACH(cpu) {
+        qemu_wait_io_event_common(cpu);
+    }
+}
+
+static int64_t tcg_get_icount_limit(void)
+{
+    int64_t deadline;
+
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        /*
+         * Include all the timers, because they may need an attention.
+         * Too long CPU execution may create unnecessary delay in UI.
+         */
+        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                              QEMU_TIMER_ATTR_ALL);
+        /* Check realtime timers, because they help with input processing */
+        deadline = qemu_soonest_timeout(deadline,
+                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
+                                           QEMU_TIMER_ATTR_ALL));
+
+        /*
+         * Maintain prior (possibly buggy) behaviour where if no deadline
+         * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
+         * INT32_MAX nanoseconds ahead, we still use INT32_MAX
+         * nanoseconds.
+         */
+        if ((deadline < 0) || (deadline > INT32_MAX)) {
+            deadline = INT32_MAX;
+        }
+
+        return icount_round(deadline);
+    } else {
+        return replay_get_instructions();
+    }
+}
+
+static void handle_icount_deadline(void)
+{
+    assert(qemu_in_vcpu_thread());
+    if (icount_enabled()) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
+
+        if (deadline == 0) {
+            /* Wake up other AioContexts.  */
+            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+            qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
+        }
+    }
+}
+
+static void prepare_icount_for_run(CPUState *cpu)
+{
+    if (icount_enabled()) {
+        int insns_left;
+
+        /*
+         * These should always be cleared by process_icount_data after
+         * each vCPU execution. However u16.high can be raised
+         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
+         */
+        g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
+        g_assert(cpu->icount_extra == 0);
+
+        cpu->icount_budget = tcg_get_icount_limit();
+        insns_left = MIN(0xffff, cpu->icount_budget);
+        cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+        cpu->icount_extra = cpu->icount_budget - insns_left;
+
+        replay_mutex_lock();
+    }
+}
+
+static void process_icount_data(CPUState *cpu)
+{
+    if (icount_enabled()) {
+        /* Account for executed instructions */
+        icount_update(cpu);
+
+        /* Reset the counters */
+        cpu_neg(cpu)->icount_decr.u16.low = 0;
+        cpu->icount_extra = 0;
+        cpu->icount_budget = 0;
+
+        replay_account_executed_instructions();
+
+        replay_mutex_unlock();
+    }
+}
+
+static int tcg_cpu_exec(CPUState *cpu)
+{
+    int ret;
+#ifdef CONFIG_PROFILER
+    int64_t ti;
+#endif
+
+    assert(tcg_enabled());
+#ifdef CONFIG_PROFILER
+    ti = profile_getclock();
+#endif
+    cpu_exec_start(cpu);
+    ret = cpu_exec(cpu);
+    cpu_exec_end(cpu);
+#ifdef CONFIG_PROFILER
+    atomic_set(&tcg_ctx->prof.cpu_exec_time,
+               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
+#endif
+    return ret;
+}
+
+/*
+ * Destroy any remaining vCPUs which have been unplugged and have
+ * finished running
+ */
+static void deal_with_unplugged_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->unplug && !cpu_can_run(cpu)) {
+            qemu_tcg_destroy_vcpu(cpu);
+            cpu_thread_signal_destroyed(cpu);
+            break;
+        }
+    }
+}
+
+/*
+ * Single-threaded TCG
+ *
+ * In the single-threaded case each vCPU is simulated in turn. If
+ * there is more than a single vCPU we create a simple timer to kick
+ * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
+ * This is done explicitly rather than relying on side-effects
+ * elsewhere.
+ */
+
+static void *tcg_rr_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    assert(tcg_enabled());
+    rcu_register_thread();
+    tcg_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    /* wait for initial kick-off after machine start */
+    while (first_cpu->stopped) {
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
+
+        /* process any pending work */
+        CPU_FOREACH(cpu) {
+            current_cpu = cpu;
+            qemu_wait_io_event_common(cpu);
+        }
+    }
+
+    start_tcg_kick_timer();
+
+    cpu = first_cpu;
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    while (1) {
+        qemu_mutex_unlock_iothread();
+        replay_mutex_lock();
+        qemu_mutex_lock_iothread();
+        /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
+        icount_account_warp_timer();
+
+        /*
+         * Run the timers here.  This is much more efficient than
+         * waking up the I/O thread and waiting for completion.
+         */
+        handle_icount_deadline();
+
+        replay_mutex_unlock();
+
+        if (!cpu) {
+            cpu = first_cpu;
+        }
+
+        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+
+            atomic_mb_set(&tcg_current_rr_cpu, cpu);
+            current_cpu = cpu;
+
+            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
+                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
+
+            if (cpu_can_run(cpu)) {
+                int r;
+
+                qemu_mutex_unlock_iothread();
+                prepare_icount_for_run(cpu);
+
+                r = tcg_cpu_exec(cpu);
+
+                process_icount_data(cpu);
+                qemu_mutex_lock_iothread();
+
+                if (r == EXCP_DEBUG) {
+                    cpu_handle_guest_debug(cpu);
+                    break;
+                } else if (r == EXCP_ATOMIC) {
+                    qemu_mutex_unlock_iothread();
+                    cpu_exec_step_atomic(cpu);
+                    qemu_mutex_lock_iothread();
+                    break;
+                }
+            } else if (cpu->stop) {
+                if (cpu->unplug) {
+                    cpu = CPU_NEXT(cpu);
+                }
+                break;
+            }
+
+            cpu = CPU_NEXT(cpu);
+        } /* while (cpu && !cpu->exit_request).. */
+
+        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
+        atomic_set(&tcg_current_rr_cpu, NULL);
+
+        if (cpu && cpu->exit_request) {
+            atomic_mb_set(&cpu->exit_request, 0);
+        }
+
+        if (icount_enabled() && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
+             * in the main_loop, wake it up in order to start the warp timer.
+             */
+            qemu_notify_event();
+        }
+
+        qemu_tcg_rr_wait_io_event();
+        deal_with_unplugged_cpus();
+    }
+
+    rcu_unregister_thread();
+    return NULL;
+}
+
+/*
+ * Multi-threaded TCG
+ *
+ * In the multi-threaded case each vCPU has its own thread. The TLS
+ * variable current_cpu can be used deep in the code to find the
+ * current CPUState for a given thread.
+ */
+
+static void *tcg_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    assert(tcg_enabled());
+    g_assert(!icount_enabled());
+
+    rcu_register_thread();
+    tcg_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    do {
+        if (cpu_can_run(cpu)) {
+            int r;
+            qemu_mutex_unlock_iothread();
+            r = tcg_cpu_exec(cpu);
+            qemu_mutex_lock_iothread();
+            switch (r) {
+            case EXCP_DEBUG:
+                cpu_handle_guest_debug(cpu);
+                break;
+            case EXCP_HALTED:
+                /*
+                 * during start-up the vCPU is reset and the thread is
+                 * kicked several times. If we don't ensure we go back
+                 * to sleep in the halted state we won't cleanly
+                 * start-up when the vCPU is enabled.
+                 *
+                 * cpu->halted should ensure we sleep in wait_io_event
+                 */
+                g_assert(cpu->halted);
+                break;
+            case EXCP_ATOMIC:
+                qemu_mutex_unlock_iothread();
+                cpu_exec_step_atomic(cpu);
+                qemu_mutex_lock_iothread();
+            default:
+                /* Ignore everything else? */
+                break;
+            }
+        }
+
+        atomic_mb_set(&cpu->exit_request, 0);
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    qemu_tcg_destroy_vcpu(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void tcg_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+    static QemuCond *single_tcg_halt_cond;
+    static QemuThread *single_tcg_cpu_thread;
+    static int tcg_region_inited;
+
+    assert(tcg_enabled());
+    /*
+     * Initialize TCG regions--once. Now is a good time, because:
+     * (1) TCG's init context, prologue and target globals have been set up.
+     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
+     *     -accel flag is processed, so the check doesn't work then).
+     */
+    if (!tcg_region_inited) {
+        tcg_region_inited = 1;
+        tcg_region_init();
+    }
+
+    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
+        cpu->thread = g_malloc0(sizeof(QemuThread));
+        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+        qemu_cond_init(cpu->halt_cond);
+
+        if (qemu_tcg_mttcg_enabled()) {
+            /* create a thread per vCPU with TCG (MTTCG) */
+            parallel_cpus = true;
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
+                 cpu->cpu_index);
+
+            qemu_thread_create(cpu->thread, thread_name, tcg_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+        } else {
+            /* share a single thread for all cpus with TCG */
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+            qemu_thread_create(cpu->thread, thread_name,
+                               tcg_rr_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+            single_tcg_halt_cond = cpu->halt_cond;
+            single_tcg_cpu_thread = cpu->thread;
+        }
+#ifdef _WIN32
+        cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+    } else {
+        /* For non-MTTCG cases we share the thread */
+        cpu->thread = single_tcg_cpu_thread;
+        cpu->halt_cond = single_tcg_halt_cond;
+        cpu->thread_id = first_cpu->thread_id;
+        cpu->can_do_io = 1;
+        cpu->created = true;
+    }
+}
+
+static void tcg_cpu_synchronize_noop(CPUState *cpu)
+{
+}
+
+CpusAccel tcg_cpus = {
+    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .kick_vcpu_thread = tcg_kick_vcpu_thread,
+
+    .synchronize_post_reset = tcg_cpu_synchronize_noop,
+    .synchronize_post_init = tcg_cpu_synchronize_noop,
+    .synchronize_state = tcg_cpu_synchronize_noop,
+    .synchronize_pre_loadvm = tcg_cpu_synchronize_noop,
+};
diff --git a/accel/tcg/tcg-cpus.h b/accel/tcg/tcg-cpus.h
new file mode 100644
index 0000000000..af4be6a151
--- /dev/null
+++ b/accel/tcg/tcg-cpus.h
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
+#ifndef TCG_CPUS_H
+#define TCG_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern CpusAccel tcg_cpus;
+
+#endif /* TCG_CPUS_H */
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 5284d384fb..b601654a10 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
 #include "qemu/plugin.h"
+#include "sysemu/hw_accel.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 149de000a0..62b6f43e14 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -4,7 +4,39 @@
 #include "qemu/timer.h"
 
 /* cpus.c */
+
+/* CPU execution threads */
+
+typedef struct CpusAccel {
+    void (*create_vcpu_thread)(CPUState *cpu);
+    void (*kick_vcpu_thread)(CPUState *cpu);
+
+    void (*synchronize_post_reset)(CPUState *cpu);
+    void (*synchronize_post_init)(CPUState *cpu);
+    void (*synchronize_state)(CPUState *cpu);
+    void (*synchronize_pre_loadvm)(CPUState *cpu);
+} CpusAccel;
+
+/* register accel-specific cpus interface implementation */
+void cpus_register_accel(CpusAccel *i);
+
+/* interface available for cpus accelerator threads */
+
+/* For temporary buffers for forming a name */
+#define VCPU_THREAD_NAME_SIZE 16
+
+void cpus_kick_thread(CPUState *cpu);
+bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
+bool cpu_can_run(CPUState *cpu);
+void qemu_wait_io_event_common(CPUState *cpu);
+void qemu_wait_io_event(CPUState *cpu);
+void cpu_thread_signal_created(CPUState *cpu);
+void cpu_thread_signal_destroyed(CPUState *cpu);
+void cpu_handle_guest_debug(CPUState *cpu);
+
+/* end interface for cpus accelerator threads */
+
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d211e808e9..cdd4172b24 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -86,7 +86,6 @@ int hvf_smp_cpu_exec(CPUState *);
 void hvf_cpu_synchronize_state(CPUState *);
 void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
-void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
 
 void hvf_vcpu_destroy(CPUState *);
 void hvf_raise_event(CPUState *);
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 0ec2372477..336740e10a 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -1,5 +1,5 @@
 /*
- * QEMU Hardware accelertors support
+ * QEMU Hardware accelerators support
  *
  * Copyright 2016 Google, Inc.
  *
@@ -16,56 +16,9 @@
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
 
-static inline void cpu_synchronize_state(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_state(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_state(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_state(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_reset(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_reset(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_reset(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_reset(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_init(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_init(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_init(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_init(cpu);
-    }
-}
-
-static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_pre_loadvm(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_pre_loadvm(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_pre_loadvm(cpu);
-    }
-}
+void cpu_synchronize_state(CPUState *cpu);
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3b2250471c..3d84c940db 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -218,7 +218,7 @@ int kvm_has_intx_set_mask(void);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
-int kvm_destroy_vcpu(CPUState *cpu);
+void kvm_destroy_vcpu(CPUState *cpu);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 7e9f545be8..835708ce03 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -24,27 +24,19 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu/config-file.h"
-#include "qemu/cutils.h"
-#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
-#include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
-#include "sysemu/dma.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
-
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
 #include "sysemu/cpus.h"
@@ -87,7 +79,7 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
-static bool cpu_thread_is_idle(CPUState *cpu)
+bool cpu_thread_is_idle(CPUState *cpu)
 {
     if (cpu->stop || cpu->queued_work_first) {
         return false;
@@ -114,78 +106,6 @@ bool all_cpu_threads_idle(void)
     return true;
 }
 
-bool mttcg_enabled;
-
-/***********************************************************/
-/* TCG vCPU kick timer
- *
- * The kick timer is responsible for moving single threaded vCPU
- * emulation on to the next vCPU. If more than one vCPU is running a
- * timer event with force a cpu->exit so the next vCPU can get
- * scheduled.
- *
- * The timer is removed if all vCPUs are idle and restarted again once
- * idleness is complete.
- */
-
-static QEMUTimer *tcg_kick_vcpu_timer;
-static CPUState *tcg_current_rr_cpu;
-
-#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
-
-static inline int64_t qemu_tcg_next_kick(void)
-{
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
-}
-
-/* Kick the currently round-robin scheduled vCPU to next */
-static void qemu_cpu_kick_rr_next_cpu(void)
-{
-    CPUState *cpu;
-    do {
-        cpu = atomic_mb_read(&tcg_current_rr_cpu);
-        if (cpu) {
-            cpu_exit(cpu);
-        }
-    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
-}
-
-/* Kick all RR vCPUs */
-static void qemu_cpu_kick_rr_cpus(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
-    };
-}
-
-static void kick_tcg_thread(void *opaque)
-{
-    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_rr_next_cpu();
-}
-
-static void start_tcg_kick_timer(void)
-{
-    assert(!mttcg_enabled);
-    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
-        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                           kick_tcg_thread, NULL);
-    }
-    if (tcg_kick_vcpu_timer && !timer_pending(tcg_kick_vcpu_timer)) {
-        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    }
-}
-
-static void stop_tcg_kick_timer(void)
-{
-    assert(!mttcg_enabled);
-    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
-        timer_del(tcg_kick_vcpu_timer);
-    }
-}
-
 /***********************************************************/
 void hw_error(const char *fmt, ...)
 {
@@ -204,16 +124,20 @@ void hw_error(const char *fmt, ...)
     abort();
 }
 
+/*
+ * every accelerator is supposed to register this.
+ * Could be in the AccelClass instead, but ends up being too complicated
+ * to access in practice, and inefficient for each call of each method.
+ */
+static CpusAccel cpus_accel;
+
 void cpu_synchronize_all_states(void)
 {
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_synchronize_state(cpu);
-        /* TODO: move to cpu_synchronize_state() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_state(cpu);
-        }
+        assert(cpus_accel.synchronize_state != NULL);
+        cpus_accel.synchronize_state(cpu);
     }
 }
 
@@ -222,11 +146,8 @@ void cpu_synchronize_all_post_reset(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_synchronize_post_reset(cpu);
-        /* TODO: move to cpu_synchronize_post_reset() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_reset(cpu);
-        }
+        assert(cpus_accel.synchronize_post_reset != NULL);
+        cpus_accel.synchronize_post_reset(cpu);
     }
 }
 
@@ -235,11 +156,8 @@ void cpu_synchronize_all_post_init(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_synchronize_post_init(cpu);
-        /* TODO: move to cpu_synchronize_post_init() */
-        if (hvf_enabled()) {
-            hvf_cpu_synchronize_post_init(cpu);
-        }
+        assert(cpus_accel.synchronize_post_init != NULL);
+        cpus_accel.synchronize_post_init(cpu);
     }
 }
 
@@ -248,7 +166,8 @@ void cpu_synchronize_all_pre_loadvm(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_synchronize_pre_loadvm(cpu);
+        assert(cpus_accel.synchronize_pre_loadvm != NULL);
+        cpus_accel.synchronize_pre_loadvm(cpu);
     }
 }
 
@@ -280,7 +199,7 @@ int vm_shutdown(void)
     return do_vm_stop(RUN_STATE_SHUTDOWN, false);
 }
 
-static bool cpu_can_run(CPUState *cpu)
+bool cpu_can_run(CPUState *cpu)
 {
     if (cpu->stop) {
         return false;
@@ -291,7 +210,7 @@ static bool cpu_can_run(CPUState *cpu)
     return true;
 }
 
-static void cpu_handle_guest_debug(CPUState *cpu)
+void cpu_handle_guest_debug(CPUState *cpu)
 {
     gdb_set_stop_cpu(cpu);
     qemu_system_debug_request();
@@ -374,18 +293,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
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
-static void qemu_tcg_destroy_vcpu(CPUState *cpu)
-{
-}
-
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
@@ -397,7 +304,7 @@ static void qemu_cpu_stop(CPUState *cpu, bool exit)
     qemu_cond_broadcast(&qemu_pause_cond);
 }
 
-static void qemu_wait_io_event_common(CPUState *cpu)
+void qemu_wait_io_event_common(CPUState *cpu)
 {
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
@@ -406,23 +313,7 @@ static void qemu_wait_io_event_common(CPUState *cpu)
     process_queued_cpu_work(cpu);
 }
 
-static void qemu_tcg_rr_wait_io_event(void)
-{
-    CPUState *cpu;
-
-    while (all_cpu_threads_idle()) {
-        stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
-    }
-
-    start_tcg_kick_timer();
-
-    CPU_FOREACH(cpu) {
-        qemu_wait_io_event_common(cpu);
-    }
-}
-
-static void qemu_wait_io_event(CPUState *cpu)
+void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
@@ -438,7 +329,8 @@ static void qemu_wait_io_event(CPUState *cpu)
     }
 
 #ifdef _WIN32
-    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
+    /* Eat dummy APC queued by hax_kick_vcpu_thread */
+    /* NB!!! Should not this be if (hax_enabled)? Is this wrong for whpx? */
     if (!tcg_enabled()) {
         SleepEx(0, TRUE);
     }
@@ -446,540 +338,7 @@ static void qemu_wait_io_event(CPUState *cpu)
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
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
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
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-static void *qemu_dummy_cpu_thread_fn(void *arg)
-{
-#ifdef _WIN32
-    error_report("qtest is not supported under Windows");
-    exit(1);
-#else
-    CPUState *cpu = arg;
-    sigset_t waitset;
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
-    sigemptyset(&waitset);
-    sigaddset(&waitset, SIG_IPI);
-
-    /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        qemu_mutex_unlock_iothread();
-        do {
-            int sig;
-            r = sigwait(&waitset, &sig);
-        } while (r == -1 && (errno == EAGAIN || errno == EINTR));
-        if (r == -1) {
-            perror("sigwait");
-            exit(1);
-        }
-        qemu_mutex_lock_iothread();
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug);
-
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-#endif
-}
-
-static int64_t tcg_get_icount_limit(void)
-{
-    int64_t deadline;
-
-    if (replay_mode != REPLAY_MODE_PLAY) {
-        /*
-         * Include all the timers, because they may need an attention.
-         * Too long CPU execution may create unnecessary delay in UI.
-         */
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                              QEMU_TIMER_ATTR_ALL);
-        /* Check realtime timers, because they help with input processing */
-        deadline = qemu_soonest_timeout(deadline,
-                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
-                                           QEMU_TIMER_ATTR_ALL));
-
-        /* Maintain prior (possibly buggy) behaviour where if no deadline
-         * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
-         * INT32_MAX nanoseconds ahead, we still use INT32_MAX
-         * nanoseconds.
-         */
-        if ((deadline < 0) || (deadline > INT32_MAX)) {
-            deadline = INT32_MAX;
-        }
-
-        return icount_round(deadline);
-    } else {
-        return replay_get_instructions();
-    }
-}
-
-static void handle_icount_deadline(void)
-{
-    assert(qemu_in_vcpu_thread());
-    if (icount_enabled()) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
-
-        if (deadline == 0) {
-            /* Wake up other AioContexts.  */
-            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-            qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
-        }
-    }
-}
-
-static void prepare_icount_for_run(CPUState *cpu)
-{
-    if (icount_enabled()) {
-        int insns_left;
-
-        /* These should always be cleared by process_icount_data after
-         * each vCPU execution. However u16.high can be raised
-         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
-         */
-        g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
-        g_assert(cpu->icount_extra == 0);
-
-        cpu->icount_budget = tcg_get_icount_limit();
-        insns_left = MIN(0xffff, cpu->icount_budget);
-        cpu_neg(cpu)->icount_decr.u16.low = insns_left;
-        cpu->icount_extra = cpu->icount_budget - insns_left;
-
-        replay_mutex_lock();
-    }
-}
-
-static void process_icount_data(CPUState *cpu)
-{
-    if (icount_enabled()) {
-        /* Account for executed instructions */
-        icount_update(cpu);
-
-        /* Reset the counters */
-        cpu_neg(cpu)->icount_decr.u16.low = 0;
-        cpu->icount_extra = 0;
-        cpu->icount_budget = 0;
-
-        replay_account_executed_instructions();
-
-        replay_mutex_unlock();
-    }
-}
-
-
-static int tcg_cpu_exec(CPUState *cpu)
-{
-    int ret;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
-
-    assert(tcg_enabled());
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
-    cpu_exec_start(cpu);
-    ret = cpu_exec(cpu);
-    cpu_exec_end(cpu);
-#ifdef CONFIG_PROFILER
-    atomic_set(&tcg_ctx->prof.cpu_exec_time,
-               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
-#endif
-    return ret;
-}
-
-/* Destroy any remaining vCPUs which have been unplugged and have
- * finished running
- */
-static void deal_with_unplugged_cpus(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->unplug && !cpu_can_run(cpu)) {
-            qemu_tcg_destroy_vcpu(cpu);
-            cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
-            break;
-        }
-    }
-}
-
-/* Single-threaded TCG
- *
- * In the single-threaded case each vCPU is simulated in turn. If
- * there is more than a single vCPU we create a simple timer to kick
- * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
- * This is done explicitly rather than relying on side-effects
- * elsewhere.
- */
-
-static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    assert(tcg_enabled());
-    rcu_register_thread();
-    tcg_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
-    cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
-
-        /* process any pending work */
-        CPU_FOREACH(cpu) {
-            current_cpu = cpu;
-            qemu_wait_io_event_common(cpu);
-        }
-    }
-
-    start_tcg_kick_timer();
-
-    cpu = first_cpu;
-
-    /* process any pending work */
-    cpu->exit_request = 1;
-
-    while (1) {
-        qemu_mutex_unlock_iothread();
-        replay_mutex_lock();
-        qemu_mutex_lock_iothread();
-        /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
-        icount_account_warp_timer();
-
-        /* Run the timers here.  This is much more efficient than
-         * waking up the I/O thread and waiting for completion.
-         */
-        handle_icount_deadline();
-
-        replay_mutex_unlock();
-
-        if (!cpu) {
-            cpu = first_cpu;
-        }
-
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
-
-            atomic_mb_set(&tcg_current_rr_cpu, cpu);
-            current_cpu = cpu;
-
-            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
-                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
-
-            if (cpu_can_run(cpu)) {
-                int r;
-
-                qemu_mutex_unlock_iothread();
-                prepare_icount_for_run(cpu);
-
-                r = tcg_cpu_exec(cpu);
-
-                process_icount_data(cpu);
-                qemu_mutex_lock_iothread();
-
-                if (r == EXCP_DEBUG) {
-                    cpu_handle_guest_debug(cpu);
-                    break;
-                } else if (r == EXCP_ATOMIC) {
-                    qemu_mutex_unlock_iothread();
-                    cpu_exec_step_atomic(cpu);
-                    qemu_mutex_lock_iothread();
-                    break;
-                }
-            } else if (cpu->stop) {
-                if (cpu->unplug) {
-                    cpu = CPU_NEXT(cpu);
-                }
-                break;
-            }
-
-            cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
-
-        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
-        atomic_set(&tcg_current_rr_cpu, NULL);
-
-        if (cpu && cpu->exit_request) {
-            atomic_mb_set(&cpu->exit_request, 0);
-        }
-
-        if (icount_enabled() && all_cpu_threads_idle()) {
-            /*
-             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
-             * in the main_loop, wake it up in order to start the warp timer.
-             */
-            qemu_notify_event();
-        }
-
-        qemu_tcg_rr_wait_io_event();
-        deal_with_unplugged_cpus();
-    }
-
-    rcu_unregister_thread();
-    return NULL;
-}
-
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
-    cpu->created = true;
-    current_cpu = cpu;
-
-    hax_init_vcpu(cpu);
-    qemu_cond_signal(&qemu_cpu_cond);
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
-/* The HVF-specific vCPU thread function. This one should only run when the host
- * CPU supports the VMX "unrestricted guest" feature. */
-static void *qemu_hvf_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    int r;
-
-    assert(hvf_enabled());
-
-    rcu_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
-    current_cpu = cpu;
-
-    hvf_init_vcpu(cpu);
-
-    /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = hvf_vcpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-static void *qemu_whpx_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-    int r;
-
-    rcu_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-    cpu->thread_id = qemu_get_thread_id();
-    current_cpu = cpu;
-
-    r = whpx_init_vcpu(cpu);
-    if (r < 0) {
-        fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
-        exit(1);
-    }
-
-    /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = whpx_vcpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
-        }
-        qemu_wait_io_event_common(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-#ifdef _WIN32
-static void CALLBACK dummy_apc_func(ULONG_PTR unused)
-{
-}
-#endif
-
-/* Multi-threaded TCG
- *
- * In the multi-threaded case each vCPU has its own thread. The TLS
- * variable current_cpu can be used deep in the code to find the
- * current CPUState for a given thread.
- */
-
-static void *qemu_tcg_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    assert(tcg_enabled());
-    g_assert(!icount_enabled());
-
-    rcu_register_thread();
-    tcg_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
-    cpu->can_do_io = 1;
-    current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    /* process any pending work */
-    cpu->exit_request = 1;
-
-    do {
-        if (cpu_can_run(cpu)) {
-            int r;
-            qemu_mutex_unlock_iothread();
-            r = tcg_cpu_exec(cpu);
-            qemu_mutex_lock_iothread();
-            switch (r) {
-            case EXCP_DEBUG:
-                cpu_handle_guest_debug(cpu);
-                break;
-            case EXCP_HALTED:
-                /* during start-up the vCPU is reset and the thread is
-                 * kicked several times. If we don't ensure we go back
-                 * to sleep in the halted state we won't cleanly
-                 * start-up when the vCPU is enabled.
-                 *
-                 * cpu->halted should ensure we sleep in wait_io_event
-                 */
-                g_assert(cpu->halted);
-                break;
-            case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
-                cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
-            default:
-                /* Ignore everything else? */
-                break;
-            }
-        }
-
-        atomic_mb_set(&cpu->exit_request, 0);
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    qemu_tcg_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-static void qemu_cpu_kick_thread(CPUState *cpu)
+void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
     int err;
@@ -993,44 +352,20 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
-#else /* _WIN32 */
-    if (!qemu_cpu_is_self(cpu)) {
-        if (whpx_enabled()) {
-            whpx_vcpu_kick(cpu);
-        } else if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
-            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
-                    __func__, GetLastError());
-            exit(1);
-        }
-    }
 #endif
 }
 
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (tcg_enabled()) {
-        if (qemu_tcg_mttcg_enabled()) {
-            cpu_exit(cpu);
-        } else {
-            qemu_cpu_kick_rr_cpus();
-        }
-    } else {
-        if (hax_enabled()) {
-            /*
-             * FIXME: race condition with the exit_request check in
-             * hax_vcpu_hax_exec
-             */
-            cpu->exit_request = 1;
-        }
-        qemu_cpu_kick_thread(cpu);
-    }
+    assert(cpus_accel.kick_vcpu_thread != NULL);
+    cpus_accel.kick_vcpu_thread(cpu);
 }
 
 void qemu_cpu_kick_self(void)
 {
     assert(current_cpu);
-    qemu_cpu_kick_thread(current_cpu);
+    cpus_kick_thread(current_cpu);
 }
 
 bool qemu_cpu_is_self(CPUState *cpu)
@@ -1080,6 +415,21 @@ void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
     qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
 }
 
+/* signal CPU creation */
+void cpu_thread_signal_created(CPUState *cpu)
+{
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+}
+
+/* signal CPU destruction */
+void cpu_thread_signal_destroyed(CPUState *cpu)
+{
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+}
+
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
@@ -1155,140 +505,18 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_lock_iothread();
 }
 
-/* For temporary buffers for forming a name */
-#define VCPU_THREAD_NAME_SIZE 16
-
-static void qemu_tcg_init_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-    static QemuCond *single_tcg_halt_cond;
-    static QemuThread *single_tcg_cpu_thread;
-    static int tcg_region_inited;
-
-    assert(tcg_enabled());
-    /*
-     * Initialize TCG regions--once. Now is a good time, because:
-     * (1) TCG's init context, prologue and target globals have been set up.
-     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
-     *     -accel flag is processed, so the check doesn't work then).
-     */
-    if (!tcg_region_inited) {
-        tcg_region_inited = 1;
-        tcg_region_init();
-    }
-
-    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-        cpu->thread = g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-        qemu_cond_init(cpu->halt_cond);
-
-        if (qemu_tcg_mttcg_enabled()) {
-            /* create a thread per vCPU with TCG (MTTCG) */
-            parallel_cpus = true;
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-                 cpu->cpu_index);
-
-            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
-
-        } else {
-            /* share a single thread for all cpus with TCG */
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
-
-            single_tcg_halt_cond = cpu->halt_cond;
-            single_tcg_cpu_thread = cpu->thread;
-        }
-#ifdef _WIN32
-        cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
-    } else {
-        /* For non-MTTCG cases we share the thread */
-        cpu->thread = single_tcg_cpu_thread;
-        cpu->halt_cond = single_tcg_halt_cond;
-        cpu->thread_id = first_cpu->thread_id;
-        cpu->can_do_io = 1;
-        cpu->created = true;
-    }
-}
-
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
-static void qemu_kvm_start_vcpu(CPUState *cpu)
+void cpus_register_accel(CpusAccel *i)
 {
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
-static void qemu_hvf_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /* HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode. */
-    assert(hvf_enabled());
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
+    assert(i != NULL);
+    assert(i->create_vcpu_thread != NULL);
+    assert(i->kick_vcpu_thread != NULL);
 
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
-static void qemu_whpx_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
-}
+    assert(i->synchronize_post_reset != NULL);
+    assert(i->synchronize_post_init != NULL);
+    assert(i->synchronize_state != NULL);
+    assert(i->synchronize_pre_loadvm != NULL);
 
-static void qemu_dummy_start_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    cpu->thread = g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-    qemu_cond_init(cpu->halt_cond);
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+    cpus_accel = *i;
 }
 
 void qemu_init_vcpu(CPUState *cpu)
@@ -1308,19 +536,8 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    if (kvm_enabled()) {
-        qemu_kvm_start_vcpu(cpu);
-    } else if (hax_enabled()) {
-        qemu_hax_start_vcpu(cpu);
-    } else if (hvf_enabled()) {
-        qemu_hvf_start_vcpu(cpu);
-    } else if (tcg_enabled()) {
-        qemu_tcg_init_vcpu(cpu);
-    } else if (whpx_enabled()) {
-        qemu_whpx_start_vcpu(cpu);
-    } else {
-        qemu_dummy_start_vcpu(cpu);
-    }
+    assert(cpus_accel.create_vcpu_thread != NULL);
+    cpus_accel.create_vcpu_thread(cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
@@ -1498,3 +715,26 @@ void qmp_inject_nmi(Error **errp)
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
 }
 
+void cpu_synchronize_state(CPUState *cpu)
+{
+    assert(cpus_accel.synchronize_state != NULL);
+    cpus_accel.synchronize_state(cpu);
+}
+
+void cpu_synchronize_post_reset(CPUState *cpu)
+{
+    assert(cpus_accel.synchronize_post_reset != NULL);
+    cpus_accel.synchronize_post_reset(cpu);
+}
+
+void cpu_synchronize_post_init(CPUState *cpu)
+{
+    assert(cpus_accel.synchronize_post_init != NULL);
+    cpus_accel.synchronize_post_init(cpu);
+}
+
+void cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    assert(cpus_accel.synchronize_pre_loadvm != NULL);
+    cpus_accel.synchronize_pre_loadvm(cpu);
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 238d6f8e9f..0256c8cdcd 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -45,4 +45,5 @@ stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
 stub-obj-y += fw_cfg.o
+stub-obj-y += cpu-synchronize-state.o
 stub-obj-$(CONFIG_SOFTMMU) += semihost.o
diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
new file mode 100644
index 0000000000..3112fe439d
--- /dev/null
+++ b/stubs/cpu-synchronize-state.c
@@ -0,0 +1,15 @@
+#include "qemu/osdep.h"
+#include "sysemu/hw_accel.h"
+
+void cpu_synchronize_state(CPUState *cpu)
+{
+}
+void cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+void cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+void cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..8a086933bc 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -9,14 +9,15 @@ obj-y += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_HYPERV) += hyperv.o
 obj-$(call lnot,$(CONFIG_HYPERV)) += hyperv-stub.o
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-cpus.o
 ifeq ($(CONFIG_WIN32),y)
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
+obj-$(CONFIG_HAX) += hax-windows.o
 endif
 ifeq ($(CONFIG_POSIX),y)
-obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
+obj-$(CONFIG_HAX) += hax-posix.o
 endif
 obj-$(CONFIG_HVF) += hvf/
-obj-$(CONFIG_WHPX) += whpx-all.o
+obj-$(CONFIG_WHPX) += whpx-all.o whpx-cpus.o
 endif
 obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index f9c83fff25..ae68c99e1f 100644
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
@@ -361,6 +362,9 @@ static int hax_accel_init(MachineState *ms)
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
index 0000000000..69a4162939
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
+CpusAccel hax_cpus = {
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
index 0000000000..ac3cf1f8ae
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
+extern CpusAccel hax_cpus;
+
+#endif /* HAX_CPUS_H */
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 54e9d8b057..667139c7af 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -61,6 +61,8 @@ int hax_inject_interrupt(CPUArchState *env, int vector);
 struct hax_vm *hax_vm_create(struct hax_state *hax);
 int hax_vcpu_run(struct hax_vcpu_state *vcpu);
 int hax_vcpu_create(int id);
+void hax_kick_vcpu_thread(CPUState *cpu);
+
 int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
                         int set);
 int hax_sync_msr(CPUArchState *env, struct hax_msr_data *msrs, int set);
diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 3bad89f133..ea956ddfc1 100644
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
diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
index 927b86bc67..af9f7dcfc1 100644
--- a/target/i386/hvf/Makefile.objs
+++ b/target/i386/hvf/Makefile.objs
@@ -1,2 +1,2 @@
-obj-y += hvf.o
+obj-y += hvf.o hvf-cpus.o
 obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/hvf/hvf-cpus.c
new file mode 100644
index 0000000000..e68845d21a
--- /dev/null
+++ b/target/i386/hvf/hvf-cpus.c
@@ -0,0 +1,141 @@
+/*
+ * Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ * Copyright 2011 Intel Corporation
+ * Copyright 2016 Veertu, Inc.
+ * Copyright 2017 The Android Open Source Project
+ *
+ * QEMU Hypervisor.framework support
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contain code under public domain from the hvdos project:
+ * https://github.com/mist64/hvdos
+ *
+ * Parts Copyright (c) 2011 NetApp, Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY NETAPP, INC ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL NETAPP, INC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "sysemu/hvf.h"
+#include "sysemu/runstate.h"
+#include "sysemu/cpus.h"
+#include "qemu/guest-random.h"
+
+#include "hvf-cpus.h"
+
+/*
+ * The HVF-specific vCPU thread function. This one should only run when the host
+ * CPU supports the VMX "unrestricted guest" feature.
+ */
+static void *hvf_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    int r;
+
+    assert(hvf_enabled());
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+
+    hvf_init_vcpu(cpu);
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = hvf_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    hvf_vcpu_destroy(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void hvf_kick_vcpu_thread(CPUState *cpu)
+{
+    cpus_kick_thread(cpu);
+}
+
+static void hvf_cpu_synchronize_noop(CPUState *cpu)
+{
+}
+
+static void hvf_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    /*
+     * HVF currently does not support TCG, and only runs in
+     * unrestricted-guest mode.
+     */
+    assert(hvf_enabled());
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
+CpusAccel hvf_cpus = {
+    .create_vcpu_thread = hvf_start_vcpu_thread,
+    .kick_vcpu_thread = hvf_kick_vcpu_thread,
+
+    .synchronize_post_reset = hvf_cpu_synchronize_noop,
+    .synchronize_post_init = hvf_cpu_synchronize_noop,
+    .synchronize_state = hvf_cpu_synchronize_noop,
+    .synchronize_pre_loadvm = hvf_cpu_synchronize_noop,
+};
diff --git a/target/i386/hvf/hvf-cpus.h b/target/i386/hvf/hvf-cpus.h
new file mode 100644
index 0000000000..b66f4889b0
--- /dev/null
+++ b/target/i386/hvf/hvf-cpus.h
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
+#ifndef HVF_CPUS_H
+#define HVF_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern CpusAccel hvf_cpus;
+
+#endif /* HVF_CPUS_H */
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d72543dc31..8065bf7525 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -72,6 +72,8 @@
 #include "sysemu/accel.h"
 #include "target/i386/cpu.h"
 
+#include "hvf-cpus.h"
+
 HVFState *hvf_state;
 
 static void assert_hvf_ok(hv_return_t ret)
@@ -312,7 +314,7 @@ void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
     run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
 }
 
-void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
+static void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     CPUState *cpu_state = cpu;
     hvf_put_registers(cpu_state);
@@ -979,6 +981,7 @@ static int hvf_accel_init(MachineState *ms)
     hvf_state = s;
     cpu_interrupt_handler = hvf_handle_interrupt;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
+    cpus_register_accel(&hvf_cpus);
     return 0;
 }
 
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index c78baac6df..8b6986c864 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -24,6 +24,8 @@
 #include "migration/blocker.h"
 #include "whp-dispatch.h"
 
+#include "whpx-cpus.h"
+
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
@@ -1575,6 +1577,7 @@ static int whpx_accel_init(MachineState *ms)
     whpx_memory_init();
 
     cpu_interrupt_handler = whpx_handle_interrupt;
+    cpus_register_accel(&whpx_cpus);
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
diff --git a/target/i386/whpx-cpus.c b/target/i386/whpx-cpus.c
new file mode 100644
index 0000000000..3a0b69f771
--- /dev/null
+++ b/target/i386/whpx-cpus.c
@@ -0,0 +1,96 @@
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX)
+ *
+ * Copyright Microsoft Corp. 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/kvm_int.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu/guest-random.h"
+
+#include "sysemu/whpx.h"
+#include "whpx-cpus.h"
+
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
+
+static void *whpx_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+
+    r = whpx_init_vcpu(cpu);
+    if (r < 0) {
+        fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
+        exit(1);
+    }
+
+    /* signal CPU creation */
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = whpx_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        while (cpu_thread_is_idle(cpu)) {
+            qemu_cond_wait_iothread(cpu->halt_cond);
+        }
+        qemu_wait_io_event_common(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    whpx_destroy_vcpu(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void whpx_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+}
+
+static void whpx_kick_vcpu_thread(CPUState *cpu)
+{
+    if (!qemu_cpu_is_self(cpu)) {
+        whpx_vcpu_kick(cpu);
+    }
+}
+
+CpusAccel whpx_cpus = {
+    .create_vcpu_thread = whpx_start_vcpu_thread,
+    .kick_vcpu_thread = whpx_kick_vcpu_thread,
+
+    .synchronize_post_reset = whpx_cpu_synchronize_post_reset,
+    .synchronize_post_init = whpx_cpu_synchronize_post_init,
+    .synchronize_state = whpx_cpu_synchronize_state,
+    .synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm,
+};
diff --git a/target/i386/whpx-cpus.h b/target/i386/whpx-cpus.h
new file mode 100644
index 0000000000..60b7be3735
--- /dev/null
+++ b/target/i386/whpx-cpus.h
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
+#ifndef WHPX_CPUS_H
+#define WHPX_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern CpusAccel whpx_cpus;
+
+#endif /* WHPX_CPUS_H */
-- 
2.16.4


