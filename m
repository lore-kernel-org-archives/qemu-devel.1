Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD33D20738
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD33D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsoAo-00025r-2q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jso73-0003pH-Na
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:58:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jso6z-0007GR-VV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:58:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 20ED4AF0F;
 Tue,  7 Jul 2020 13:58:16 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC v2 5/6] cpus: extract out whpx-specific code to target/i386/
Date: Tue,  7 Jul 2020 15:58:07 +0200
Message-Id: <20200707135808.9241-6-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200707135808.9241-1-cfontana@suse.de>
References: <20200707135808.9241-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 23:42:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <cfontana@suse.de>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

register a "CpusAccel" interface for WHPX as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 MAINTAINERS               |  1 +
 softmmu/cpus.c            | 81 ---------------------------------------
 target/i386/Makefile.objs |  2 +-
 target/i386/whpx-all.c    |  3 ++
 target/i386/whpx-cpus.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/whpx-cpus.h   | 17 +++++++++
 6 files changed, 118 insertions(+), 82 deletions(-)
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 100b7489ea..a737eb70ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -427,6 +427,7 @@ WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
 F: target/i386/whpx-all.c
+F: target/i386/whpx-cpus.c
 F: target/i386/whp-dispatch.h
 F: accel/stubs/whpx-stub.c
 F: include/sysemu/whpx.h
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 091641bf18..ed9cd8ec72 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -34,7 +34,6 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
-#include "sysemu/whpx.h"
 #include "exec/exec-all.h"
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
@@ -191,9 +190,6 @@ void cpu_synchronize_state(CPUState *cpu)
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->synchronize_state(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_state(cpu);
-    }
 }
 
 void cpu_synchronize_post_reset(CPUState *cpu)
@@ -202,9 +198,6 @@ void cpu_synchronize_post_reset(CPUState *cpu)
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->synchronize_post_reset(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_reset(cpu);
-    }
 }
 
 void cpu_synchronize_post_init(CPUState *cpu)
@@ -213,9 +206,6 @@ void cpu_synchronize_post_init(CPUState *cpu)
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->synchronize_post_init(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_init(cpu);
-    }
 }
 
 void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -224,9 +214,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->synchronize_pre_loadvm(cpu);
     }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_pre_loadvm(cpu);
-    }
 }
 
 static int do_vm_stop(RunState state, bool send_stop)
@@ -438,48 +425,6 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
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
-    cpu_thread_signal_created(cpu);
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
-    cpu_thread_signal_destroyed(cpu);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
 void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -494,12 +439,6 @@ void cpus_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
-#else /* _WIN32 */
-    if (!qemu_cpu_is_self(cpu)) {
-        if (whpx_enabled()) {
-            whpx_vcpu_kick(cpu);
-        }
-    }
 #endif
 }
 
@@ -509,8 +448,6 @@ void qemu_cpu_kick(CPUState *cpu)
     if (cpus_accel) {
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->kick_vcpu_thread(cpu);
-    } else {
-        cpus_kick_thread(cpu);
     }
 }
 
@@ -675,22 +612,6 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
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
-
 void cpus_register_accel(CpusAccel *ca)
 {
     assert(ca != NULL);
@@ -719,8 +640,6 @@ void qemu_init_vcpu(CPUState *cpu)
         cpus_accel->create_vcpu_thread(cpu);
     } else if (hvf_enabled()) {
         qemu_hvf_start_vcpu(cpu);
-    } else if (whpx_enabled()) {
-        qemu_whpx_start_vcpu(cpu);
     } else {
         assert(0);
     }
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 3cd3e89298..8a086933bc 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -17,7 +17,7 @@ ifeq ($(CONFIG_POSIX),y)
 obj-$(CONFIG_HAX) += hax-posix.o
 endif
 obj-$(CONFIG_HVF) += hvf/
-obj-$(CONFIG_WHPX) += whpx-all.o
+obj-$(CONFIG_WHPX) += whpx-all.o whpx-cpus.o
 endif
 obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
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


