Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F11BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069B5206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069B5206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYOm-0004Q2-47
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIO-0003Ae-3G
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIC-0003pI-S9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 16A32B3DA;
 Wed, 16 Sep 2020 14:20:28 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v8 05/17] cpus: extract out qtest-specific code to accel/qtest
Date: Wed, 16 Sep 2020 16:19:52 +0200
Message-Id: <20200916142004.27429-6-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916142004.27429-1-cfontana@suse.de>
References: <20200916142004.27429-1-cfontana@suse.de>
MIME-Version: 1.0
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

register a "CpusAccel" interface for qtest as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS               |  2 +-
 accel/meson.build         |  2 +-
 accel/qtest/meson.build   |  7 +++
 accel/qtest/qtest-cpus.c  | 91 +++++++++++++++++++++++++++++++++++++++
 accel/qtest/qtest-cpus.h  | 17 ++++++++
 accel/{ => qtest}/qtest.c |  7 +++
 softmmu/cpus.c            | 64 +--------------------------
 7 files changed, 125 insertions(+), 65 deletions(-)
 create mode 100644 accel/qtest/meson.build
 create mode 100644 accel/qtest/qtest-cpus.c
 create mode 100644 accel/qtest/qtest-cpus.h
 rename accel/{ => qtest}/qtest.c (86%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dbca9e67c6..8b3159a4af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2470,7 +2470,7 @@ M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: softmmu/qtest.c
-F: accel/qtest.c
+F: accel/qtest/
 F: tests/qtest/
 X: tests/qtest/bios-tables-test-allowed-diff.h
 
diff --git a/accel/meson.build b/accel/meson.build
index 26c503e480..bb00d0fd13 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,6 +1,6 @@
 softmmu_ss.add(files('accel.c'))
-specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: files('qtest.c'))
 
+subdir('qtest')
 subdir('kvm')
 subdir('tcg')
 subdir('xen')
diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
new file mode 100644
index 0000000000..e477cb2ae2
--- /dev/null
+++ b/accel/qtest/meson.build
@@ -0,0 +1,7 @@
+qtest_ss = ss.source_set()
+qtest_ss.add(files(
+  'qtest.c',
+  'qtest-cpus.c',
+))
+
+specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: qtest_ss)
diff --git a/accel/qtest/qtest-cpus.c b/accel/qtest/qtest-cpus.c
new file mode 100644
index 0000000000..7c5399ed9d
--- /dev/null
+++ b/accel/qtest/qtest-cpus.c
@@ -0,0 +1,91 @@
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
+const CpusAccel qtest_cpus = {
+    .create_vcpu_thread = qtest_start_vcpu_thread,
+    .get_virtual_clock = qtest_get_virtual_clock,
+};
diff --git a/accel/qtest/qtest-cpus.h b/accel/qtest/qtest-cpus.h
new file mode 100644
index 0000000000..739519a472
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
+extern const CpusAccel qtest_cpus;
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
 
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 7fd6e7c3b7..d1eddc65d0 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -40,7 +40,6 @@
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
 #include "sysemu/cpus.h"
-#include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/bitmap.h"
@@ -247,9 +246,6 @@ int64_t cpus_get_virtual_clock(void)
     if (cpus_accel && cpus_accel->get_virtual_clock) {
         return cpus_accel->get_virtual_clock();
     }
-    if (qtest_enabled()) { /* for qtest_clock_warp */
-        return qtest_get_virtual_clock();
-    }
     return cpu_get_clock();
 }
 
@@ -482,51 +478,6 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
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
-    cpu_thread_signal_created(cpu);
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
 static void *qemu_hax_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -904,19 +855,6 @@ void cpus_register_accel(const CpusAccel *ca)
     cpus_accel = ca;
 }
 
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
-}
-
 void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -946,7 +884,7 @@ void qemu_init_vcpu(CPUState *cpu)
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
     } else {
-        qemu_dummy_start_vcpu(cpu);
+        g_assert_not_reached();
     }
 
     while (!cpu->created) {
-- 
2.26.2


