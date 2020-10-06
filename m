Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E5BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426D520760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJqWGbwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426D520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhUJ-0007c4-8J
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ6-0002SR-FE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ4-0001OS-7B
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id f21so1823164wml.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yRG/T0HeJHZkMdsvaa0+J6i3DpCw+CAupvrmBr3TGJc=;
 b=mJqWGbwgcPiJs5iP9Ha8E6jHs60cGEftLKaEZ9L6hnAH38RZzU4gZ6PRE6suwfr07F
 Y7RShs3Rd9FxRFmRKDaV2o6SR/Slws4Beqsj72CadWlaGC36EdjOZE/Iorx4+S7GZ8TI
 +LlbGisO2pL/nfl+FV+aMLxlaGrdiD39/NFxkxn9EesUaXXIb9/0d/sIB3cgy9R9jEoH
 NRrOw5V9qJINwBiM1+WzWkfiaZRbTIpUVlHbGAieiUQjDbUS0DzVVFbqOq+PFy6oggcS
 0K7mPNbsSpNPMVRZkR3zi0foH5t7mQJPydzsvwOJeG6apaxDq1FEdphUMJcm6BG7q/3+
 AWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yRG/T0HeJHZkMdsvaa0+J6i3DpCw+CAupvrmBr3TGJc=;
 b=GHehzmVhYfff4ECZat9rQgJM9XA5pjtIFxDJ0t0jmJxPAi7vIbc2/z8gHXQyS2Bmg2
 4HIxmRYY3ZMBLFMUu0viqJmqsSml+VOtJ0y62fZMkXNoplHvqqIJVXD9ZoKOXl6ok1FA
 WJcHNttXUqKK9YH21Vo4EILOgA0VxpJxKA7rV5s+fJ6MkX5xfKNhLQyw/7RxTikXO0UU
 rx3OJl8zRijFihlvEbi9/d+0aNQXYU2MoOsfJ6sQWK4tFMD2HsJk60+5BmkFbZXQVPZC
 sQd0kCmuIP70MHMrkXrXEWvGP2XFwmLTw8mtWtpXeWwb2lxxYKaiAOUEiO9Pm3oja16/
 F/3Q==
X-Gm-Message-State: AOAM531cVMPcp60Ih11oWAXf+6dht3mubUlGZFEAR95lNorSpDIEfdQD
 IrlW6N/FlLIxJc95kCHXyKY7u6YqG88=
X-Google-Smtp-Source: ABdhPJwM0xZ+8QciUlLR5A1z8olDImdt3sFxNmLL/O6zMgElWc2M950/rrYQXkA4hvUkSPOl8pLwHA==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3117086wmj.3.1601969394437; 
 Tue, 06 Oct 2020 00:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/37] cpus: extract out hvf-specific code to target/i386/hvf/
Date: Tue,  6 Oct 2020 09:29:19 +0200
Message-Id: <20201006072947.487729-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x329.google.com
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

register a "CpusAccel" interface for HVF as well.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
[added const]
Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/cpus.c              |  66 ------------------
 target/i386/hvf/hvf-cpus.c  | 131 ++++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf-cpus.h  |  17 +++++
 target/i386/hvf/hvf.c       |   3 +
 target/i386/hvf/meson.build |   1 +
 5 files changed, 152 insertions(+), 66 deletions(-)
 create mode 100644 target/i386/hvf/hvf-cpus.c
 create mode 100644 target/i386/hvf/hvf-cpus.h

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 067dae12eb..adc20eb3de 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -33,7 +33,6 @@
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
-#include "sysemu/hvf.h"
 #include "exec/exec-all.h"
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
@@ -198,9 +197,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
         cpus_accel->synchronize_pre_loadvm(cpu);
     }
-    if (hvf_enabled()) {
-        hvf_cpu_synchronize_pre_loadvm(cpu);
-    }
 }
 
 int64_t cpus_get_virtual_clock(void)
@@ -390,48 +386,6 @@ void qemu_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
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
-    cpu_thread_signal_created(cpu);
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
-    cpu_thread_signal_destroyed(cpu);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
 void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -602,24 +556,6 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_lock_iothread();
 }
 
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
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 void cpus_register_accel(const CpusAccel *ca)
 {
     assert(ca != NULL);
@@ -647,8 +583,6 @@ void qemu_init_vcpu(CPUState *cpu)
     if (cpus_accel) {
         /* accelerator already implements the CpusAccel interface */
         cpus_accel->create_vcpu_thread(cpu);
-    } else if (hvf_enabled()) {
-        qemu_hvf_start_vcpu(cpu);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/hvf/hvf-cpus.c
new file mode 100644
index 0000000000..817b3d7452
--- /dev/null
+++ b/target/i386/hvf/hvf-cpus.c
@@ -0,0 +1,131 @@
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
+#include "target/i386/cpu.h"
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
+const CpusAccel hvf_cpus = {
+    .create_vcpu_thread = hvf_start_vcpu_thread,
+
+    .synchronize_post_reset = hvf_cpu_synchronize_post_reset,
+    .synchronize_post_init = hvf_cpu_synchronize_post_init,
+    .synchronize_state = hvf_cpu_synchronize_state,
+    .synchronize_pre_loadvm = hvf_cpu_synchronize_pre_loadvm,
+};
diff --git a/target/i386/hvf/hvf-cpus.h b/target/i386/hvf/hvf-cpus.h
new file mode 100644
index 0000000000..262e449fd6
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
+extern const CpusAccel hvf_cpus;
+
+#endif /* HVF_CPUS_H */
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d81f569aed..7ac6987c1b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -72,6 +72,8 @@
 #include "sysemu/accel.h"
 #include "target/i386/cpu.h"
 
+#include "hvf-cpus.h"
+
 HVFState *hvf_state;
 
 static void assert_hvf_ok(hv_return_t ret)
@@ -894,6 +896,7 @@ static int hvf_accel_init(MachineState *ms)
     hvf_state = s;
     cpu_interrupt_handler = hvf_handle_interrupt;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
+    cpus_register_accel(&hvf_cpus);
     return 0;
 }
 
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index c8a43717ee..409c9a3f14 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -1,5 +1,6 @@
 i386_softmmu_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
+  'hvf-cpus.c',
   'x86.c',
   'x86_cpuid.c',
   'x86_decode.c',
-- 
2.26.2



