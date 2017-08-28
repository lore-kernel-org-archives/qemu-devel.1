Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Ix-0004rl-Mk
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Iv-00010K-CJ
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:31 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dm9Iv-0000zz-71
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:29 -0400
Received: by mail-vk0-x244.google.com with SMTP id z187so1877393vkd.4
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:57:29 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 27 Aug 2017 20:56:43 -0500
Message-Id: <20170828015654.2530-4-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH 03/14] hvf: add conditional macros around hvf
 code in cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This commit surrounds the hvf parts of cpus.c with conditional macros so
that they are rightly ignored on other platforms.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 cpus.c               | 147 +++++++++++++++++++++++++++++++++++----------------
 include/sysemu/hvf.h |   5 +-
 2 files changed, 105 insertions(+), 47 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2cd9dfa5d..6754ce17cc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -37,6 +37,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
+#include "sysemu/hvf.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -81,6 +82,9 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* For temporary buffers for forming a name */
+#define VCPU_THREAD_NAME_SIZE 16
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -900,6 +904,11 @@ void cpu_synchronize_all_states(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_state(cpu);
+#ifdef CONFIG_HVF
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_state(cpu);
+        }
+#endif
     }
 }
 
@@ -909,6 +918,11 @@ void cpu_synchronize_all_post_reset(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_reset(cpu);
+#ifdef CONFIG_HVF
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_reset(cpu);
+        }
+#endif
     }
 }
 
@@ -918,6 +932,11 @@ void cpu_synchronize_all_post_init(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_init(cpu);
+#ifdef CONFIG_HVF
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_init(cpu);
+        }
+#endif
     }
 }
 
@@ -1098,6 +1117,80 @@ static void qemu_kvm_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
+#ifdef CONFIG_HVF
+static void qemu_hvf_wait_io_event(CPUState *cpu)
+{
+    while (cpu_thread_is_idle(cpu)) {
+        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+    }
+    qemu_wait_io_event_common(cpu);
+}
+
+/* The HVF-specific vCPU thread function. This one should only run when the host
+ * CPU supports the VMX "unrestricted guest" feature. */
+static void *qemu_hvf_cpu_thread_fn(void *arg)
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
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = hvf_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_hvf_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    hvf_vcpu_destroy(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    return NULL;
+}
+
+static void qemu_hvf_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    /* HVF currently does not support TCG, and only runs in
+     * unrestricted-guest mode. */
+    assert(hvf_enabled());
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
+}
+
+#endif
+
 static void *qemu_kvm_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -1434,48 +1527,6 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     return NULL;
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
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
-
-    do {
-        if (cpu_can_run(cpu)) {
-            r = hvf_vcpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
-                cpu_handle_guest_debug(cpu);
-            }
-        }
-        qemu_hvf_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    return NULL;
-}
-
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -1564,6 +1615,11 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
+#ifdef CONFIG_HVF
+    if (hvf_enabled()) {
+        cpu_exit(cpu);
+    }
+#endif
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
         if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
@@ -1698,9 +1754,6 @@ void cpu_remove_sync(CPUState *cpu)
     }
 }
 
-/* For temporary buffers for forming a name */
-#define VCPU_THREAD_NAME_SIZE 16
-
 static void qemu_tcg_init_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1816,6 +1869,10 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
         qemu_hax_start_vcpu(cpu);
+#ifdef CONFIG_HVF
+    } else if (hvf_enabled()) {
+        qemu_hvf_start_vcpu(cpu);
+#endif
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
     } else {
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index b96bd5e8ba..5e2b5f8f76 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -20,10 +20,12 @@
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 #include "sysemu/accel.h"
+
+#ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 #include <Hypervisor/hv_error.h>
-
+#endif
 
 typedef struct hvf_slot {
     uint64_t start;
@@ -85,7 +87,6 @@ void __hvf_cpu_synchronize_state(CPUState *, run_on_cpu_data);
 void __hvf_cpu_synchronize_post_reset(CPUState *, run_on_cpu_data);
 void vmx_update_tpr(CPUState *);
 void update_apic_tpr(CPUState *);
-int apic_get_highest_priority_irr(DeviceState *);
 int hvf_put_registers(CPUState *);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
-- 
2.14.1
