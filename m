Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdWYO-0004I1-Ox
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdWYL-0006VD-PJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:25:32 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37333 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cdWYL-0006T2-9Z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 01:25:29 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 14 Feb 2017 09:25:23 +0300
Message-Id: <1487053524-18674-3-git-send-email-den@openvz.org>
In-Reply-To: <1487053524-18674-1-git-send-email-den@openvz.org>
References: <1487053524-18674-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v4 2/3] report guest crash information in
 GUEST_PANICKED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

it's not very convenient to use the crash-information property interface,
so provide a CPU class callback to get the guest crash information, and pass
that information in the event

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/misc/pvpanic.c       |  2 +-
 hw/ppc/spapr_rtas.c     |  3 ++-
 include/qom/cpu.h       | 10 ++++++++++
 include/sysemu/sysemu.h |  2 +-
 kvm-all.c               |  2 +-
 qapi/event.json         |  6 ++++--
 qom/cpu.c               | 11 +++++++++++
 target/i386/cpu.c       |  1 +
 target/s390x/kvm.c      |  4 ++--
 vl.c                    | 11 ++++++++---
 10 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 0ac1e6a..57da7f2 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -42,7 +42,7 @@ static void handle_event(int event)
     }
 
     if (event & PVPANIC_PANICKED) {
-        qemu_system_guest_panicked();
+        qemu_system_guest_panicked(NULL);
         return;
     }
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index bb19944..619f32c 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -334,7 +334,8 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
 {
     target_ulong ret = 0;
 
-    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, &error_abort);
+    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false, NULL,
+                                   &error_abort);
 
     rtas_st(rets, 0, ret);
 }
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ca4d0fb..f95a6c3 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -156,6 +156,7 @@ typedef struct CPUClass {
                            uint8_t *buf, int len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                        int flags);
+    GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
     void (*dump_statistics)(CPUState *cpu, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
@@ -469,6 +470,15 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque);
 
 /**
+ * cpu_get_crash_info:
+ * @cpu: The CPU to get crash information for
+ *
+ * Gets the previously saved crash information.
+ * Caller is responsible for freeing the data.
+ */
+GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
+
+/**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
  * @CPU_DUMP_FPU: dump FPU register state, not just integer
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4d50694..2c39bed 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -64,7 +64,7 @@ int qemu_shutdown_requested_get(void);
 int qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(bool report);
-void qemu_system_guest_panicked(void);
+void qemu_system_guest_panicked(GuestPanicInformation *info);
 size_t qemu_target_page_bits(void);
 
 void qemu_add_exit_notifier(Notifier *notify);
diff --git a/kvm-all.c b/kvm-all.c
index 64f46c8..0c94637 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2002,7 +2002,7 @@ int kvm_cpu_exec(CPUState *cpu)
             case KVM_SYSTEM_EVENT_CRASH:
                 kvm_cpu_synchronize_state(cpu);
                 qemu_mutex_lock_iothread();
-                qemu_system_guest_panicked();
+                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
                 qemu_mutex_unlock_iothread();
                 ret = 0;
                 break;
diff --git a/qapi/event.json b/qapi/event.json
index 7bf539b..970ff02 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -488,7 +488,9 @@
 #
 # @action: action that has been taken, currently always "pause"
 #
-# Since: 1.5
+# @info: optional information about a panic
+#
+# Since: 1.5 (@info since 2.9)
 #
 # Example:
 #
@@ -497,7 +499,7 @@
 #
 ##
 { 'event': 'GUEST_PANICKED',
-  'data': { 'action': 'GuestPanicAction' } }
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
 ##
 # @QUORUM_FAILURE:
diff --git a/qom/cpu.c b/qom/cpu.c
index d57faf3..5158f31 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -218,6 +218,17 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, int int_req)
     return false;
 }
 
+GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    GuestPanicInformation *res = NULL;
+
+    if (cc->get_crash_info) {
+        res = cc->get_crash_info(cpu);
+    }
+    return res;
+}
+
 void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                     int flags)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 71aa91f..fd7add2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3734,6 +3734,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = x86_cpu_do_interrupt;
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
     cc->dump_state = x86_cpu_dump_state;
+    cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
     cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
     cc->gdb_read_register = x86_cpu_gdb_read_register;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 6ed3876..2536780 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1864,7 +1864,7 @@ static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
                  str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
                  ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
     s390_cpu_halt(cpu);
-    qemu_system_guest_panicked();
+    qemu_system_guest_panicked(NULL);
 }
 
 static int handle_intercept(S390CPU *cpu)
@@ -1897,7 +1897,7 @@ static int handle_intercept(S390CPU *cpu)
                 if (is_special_wait_psw(cs)) {
                     qemu_system_shutdown_request();
                 } else {
-                    qemu_system_guest_panicked();
+                    qemu_system_guest_panicked(NULL);
                 }
             }
             r = EXCP_HALTED;
diff --git a/vl.c b/vl.c
index b4eaf03..d68254b 100644
--- a/vl.c
+++ b/vl.c
@@ -1707,18 +1707,23 @@ void qemu_system_reset(bool report)
     cpu_synchronize_all_post_reset();
 }
 
-void qemu_system_guest_panicked(void)
+void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     if (current_cpu) {
         current_cpu->crash_occurred = true;
     }
-    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, &error_abort);
+    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
+                                   !!info, info, &error_abort);
     vm_stop(RUN_STATE_GUEST_PANICKED);
     if (!no_shutdown) {
         qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
-                                       &error_abort);
+                                       !!info, info, &error_abort);
         qemu_system_shutdown_request();
     }
+
+    if (info) {
+        qapi_free_GuestPanicInformation(info);
+    }
 }
 
 void qemu_system_reset_request(void)
-- 
2.7.4
