Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ea5r1-00035j-0b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ea5qz-0001ot-RK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:07 -0500
Received: from mail-dm3nam03on070e.outbound.protection.outlook.com
	([2a01:111:f400:fe49::70e]:54637
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ea5qz-0001nM-MR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 15:23:05 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Fri, 12 Jan 2018 12:22:28 -0800
Message-Id: <1515788548-3570-5-git-send-email-juterry@microsoft.com>
In-Reply-To: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] Add the WHPX acceleration enlightenments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Implements the WHPX accelerator cpu enlightenments to actually use the whpx-all
accelerator on Windows platforms.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 cpus.c                    | 66 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/sysemu/hw_accel.h | 13 ++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index e8139de..48df958 100644
--- a/cpus.c
+++ b/cpus.c
@@ -38,6 +38,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
+#include "sysemu/whpx.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -1507,6 +1508,46 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void *qemu_whpx_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
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
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = whpx_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        while (cpu_thread_is_idle(cpu)) {
+            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        }
+        qemu_wait_io_event_common(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    whpx_destroy_vcpu(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    return NULL;
+}
+
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -1598,7 +1639,9 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
     }
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
-        if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
+        if (whpx_enabled()) {
+            whpx_vcpu_kick(cpu);
+        } else if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
             fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
                     __func__, GetLastError());
             exit(1);
@@ -1845,6 +1888,25 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
     }
 }
 
+static void qemu_whpx_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1883,6 +1945,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_hvf_start_vcpu(cpu);
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
+    } else if (whpx_enabled()) {
+        qemu_whpx_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 469ffda..d2ddfb5 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -14,6 +14,7 @@
 #include "qom/cpu.h"
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
+#include "sysemu/whpx.h"
 
 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -23,6 +24,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_state(cpu);
     }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_state(cpu);
+    }
 }
 
 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -33,6 +37,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_post_reset(cpu);
     }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_post_reset(cpu);
+    }
 }
 
 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -43,6 +50,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_post_init(cpu);
     }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_post_init(cpu);
+    }
 }
 
 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -53,6 +63,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (hax_enabled()) {
         hax_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_pre_loadvm(cpu);
+    }
 }
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f63eb3d..9fba146 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -986,7 +986,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
     X86CPU *cpu = x86_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    if (kvm_enabled()) {
+    if (kvm_enabled() || whpx_enabled()) {
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-- 
2.7.4
