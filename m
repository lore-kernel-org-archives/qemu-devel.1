Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7D206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7D206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYOc-00040o-AO
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIg-0003OF-2J
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIX-0003tu-7P
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 39497B536;
 Wed, 16 Sep 2020 14:20:34 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v8 12/17] cpus: add handle_interrupt to the CpusAccel interface
Date: Wed, 16 Sep 2020 16:19:59 +0200
Message-Id: <20200916142004.27429-13-cfontana@suse.de>
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

kvm: uses the generic handler
qtest: uses the generic handler
whpx: changed to use the generic handler (identical implementation)
hax: changed to use the generic handler (identical implementation)
hvf: changed to use the generic handler (identical implementation)
tcg: adapt tcg-cpus to point to the tcg-specific handler

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index ddeed98348..fa1208158f 100644
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
-        atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
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
index 3fa65311d9..ec7158b55e 100644
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
+        atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
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
index b89bf56a57..781f861093 100644
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
index 99dc33ffeb..249d7b4af5 100644
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
index f32ecb4bb9..7068666579 100644
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
index 8b6986c864..b3d17fbe04 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1413,15 +1413,6 @@ static void whpx_memory_init(void)
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
@@ -1576,7 +1567,6 @@ static int whpx_accel_init(MachineState *ms)
 
     whpx_memory_init();
 
-    cpu_interrupt_handler = whpx_handle_interrupt;
     cpus_register_accel(&whpx_cpus);
 
     printf("Windows Hypervisor Platform accelerator is operational\n");
-- 
2.26.2


