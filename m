Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1365C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454F020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv3iKfQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454F020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhS1-0004Bk-47
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ2-0002K1-6O
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ0-0001NT-9J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id t9so3589513wrq.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=81nWIRLht3o1MJNlTnzMkrF2Tl977yTreL4rR+87628=;
 b=kv3iKfQbiLh1h7z2k/deAoQvq9EvZiFxHy0yfOiZoE0t/8PZbB0vFAe342oxDR1Sn+
 xr3y3glLuLqjjESOLlLJNViLHjI2R5z6n561cdT3jjB9RrHDzYXmat00i+TDL8+q6qFr
 6jZlrU9M9iPFxuEm8So5XBnECZXqS5Ti1oycfm5WfVmjFolx0F2n/XHTfQLF6FlFrQk7
 aHcROyH/qJL/DhfM2uGqeHLT8LAKMyC3OenGcrshkDWCj40BqMP+F14R6IfGk+OWzwdd
 ccP9ylw5GjRIGtSU0rx8CLHsfPwDyMmgw2Rz1RsPv81D4uWEn8ynxQ7eERuYgr6ZQPL9
 D1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=81nWIRLht3o1MJNlTnzMkrF2Tl977yTreL4rR+87628=;
 b=s0/6eHTIOcTZ9u+dUqy7/cf1beq3CfBwGpvZpLmGESTHEmMLiRtzL6pc7kPhPGhvnv
 +9wyWJZi+3ET4OEj1ixYbK33EUCgLIXzYUPrRvaFMm60oltGBM4m7BwSGwV2NUQJtPF/
 9sL7m9/03iqYIK08r0iIbfRSN/L97zBSQMCoCa5BqPbptLElHNwCJmjiepReN4bmwGUH
 pLCk461R6RToAArUf8I9K69iamj1WV2YyhPKZBEw3H87wwWiWRRqCbOwQMAECnVxOW5b
 7XV0D23R36C4rgFOED11Eio+Ce6mMtnMBeDRtfJa3Dh1KAv4qSeXDfBLn0/J6UqY6Jb3
 uDEg==
X-Gm-Message-State: AOAM5332gWUn0fYLuo31r/od/FJEm1k9wWaxVIvyBHSz87b/8QwyO5Iw
 msYs6coh72VcN5Itnwql50dEVtxQpvg=
X-Google-Smtp-Source: ABdhPJw3S2LjdDggMXzon2SPof4RZHpDO9+/G/LZeEq374kWepGhAexwl8t3klmA6af+iuOdWe7loQ==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr3161965wrj.287.1601969390678; 
 Tue, 06 Oct 2020 00:29:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/37] cpus: extract out qtest-specific code to accel/qtest
Date: Tue,  6 Oct 2020 09:29:15 +0200
Message-Id: <20201006072947.487729-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
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

register a "CpusAccel" interface for qtest as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index a59be84de6..ecc45dfac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2492,7 +2492,7 @@ M: Laurent Vivier <lvivier@redhat.com>
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
index 25f12e3ee9..b14b22161f 100644
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



