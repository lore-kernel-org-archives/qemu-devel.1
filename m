Received: from eggs.gnu.org ([2001:4830:134:3::10]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrf-0004Xw-D8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrY-0007Yd-IU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:15 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:53 +0100
Message-Id: <20180301130201.24666-20-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/27] qmp: expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Presently s390x is the only architecture not exposing specific
CPU information via QMP query-cpus. Upstream discussion has shown
that it could make sense to report the architecture specific CPU
state, e.g. to detect that a CPU has been stopped.

With this change the output of query-cpus will look like this on
s390:

   [
     {"arch": "s390", "current": true,
      "props": {"core-id": 0}, "cpu-state": "operating", "CPU": 0,
      "qom_path": "/machine/unattached/device[0]",
      "halted": false, "thread_id": 63115},
     {"arch": "s390", "current": false,
      "props": {"core-id": 1}, "cpu-state": "stopped", "CPU": 1,
      "qom_path": "/machine/unattached/device[1]",
      "halted": true, "thread_id": 63116}
   ]

This change doesn't add the s390-specific data to HMP 'info cpus'.
A follow-on patch will remove all architecture specific information
from there.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1518797321-28356-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 cpus.c                     |  6 ++++++
 hw/intc/s390_flic.c        |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  2 +-
 qapi-schema.json           | 28 +++++++++++++++++++++++++++-
 target/s390x/cpu.c         | 24 ++++++++++++------------
 target/s390x/cpu.h         |  7 ++-----
 target/s390x/kvm.c         |  8 ++++----
 target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
 8 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/cpus.c b/cpus.c
index f298b659f4..6006931d3a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2100,6 +2100,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_TRICORE)
         TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
         CPUTriCoreState *env = &tricore_cpu->env;
+#elif defined(TARGET_S390X)
+        S390CPU *s390_cpu = S390_CPU(cpu);
+        CPUS390XState *env = &s390_cpu->env;
 #endif
 
         cpu_synchronize_state(cpu);
@@ -2127,6 +2130,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_TRICORE)
         info->value->arch = CPU_INFO_ARCH_TRICORE;
         info->value->u.tricore.PC = env->PC;
+#elif defined(TARGET_S390X)
+        info->value->arch = CPU_INFO_ARCH_S390;
+        info->value->u.s390.cpu_state = env->cpu_state;
 #else
         info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a85a149c6d..5f8168f0f0 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -192,8 +192,8 @@ static void qemu_s390_flic_notify(uint32_t type)
         cs->interrupt_request |= CPU_INTERRUPT_HARD;
 
         /* ignore CPUs that are not sleeping */
-        if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING &&
-            s390_cpu_get_state(cpu) != CPU_STATE_LOAD) {
+        if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
+            s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD) {
             continue;
         }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4abbe89847..4d0c3deba6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -368,7 +368,7 @@ static void s390_machine_reset(void)
 
     /* all cpus are stopped - configure and start the ipl cpu only */
     s390_ipl_prepare_cpu(ipl_cpu);
-    s390_cpu_set_state(CPU_STATE_OPERATING, ipl_cpu);
+    s390_cpu_set_state(S390_CPU_STATE_OPERATING, ipl_cpu);
 }
 
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
diff --git a/qapi-schema.json b/qapi-schema.json
index 0262b9f20b..94d560ed13 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -410,10 +410,12 @@
 # An enumeration of cpu types that enable additional information during
 # @query-cpus.
 #
+# @s390: since 2.12
+#
 # Since: 2.6
 ##
 { 'enum': 'CpuInfoArch',
-  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
+  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'other' ] }
 
 ##
 # @CpuInfo:
@@ -452,6 +454,7 @@
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
+            's390': 'CpuInfoS390',
             'other': 'CpuInfoOther' } }
 
 ##
@@ -522,6 +525,29 @@
 { 'struct': 'CpuInfoOther', 'data': { } }
 
 ##
+# @CpuS390State:
+#
+# An enumeration of cpu states that can be assumed by a virtual
+# S390 CPU
+#
+# Since: 2.12
+##
+{ 'enum': 'CpuS390State',
+  'prefix': 'S390_CPU_STATE',
+  'data': [ 'uninitialized', 'stopped', 'check-stop', 'operating', 'load' ] }
+
+##
+# @CpuInfoS390:
+#
+# Additional information about a virtual S390 CPU
+#
+# @cpu-state: the virtual CPU's state
+#
+# Since: 2.12
+##
+{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
+
+##
 # @query-cpus:
 #
 # Returns a list of information about each virtual CPU.
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3e1be56536..f02ed19c70 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -61,8 +61,8 @@ static bool s390_cpu_has_work(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
 
     /* STOPPED cpus can never wake up */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_LOAD &&
-        s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
         return false;
     }
 
@@ -80,7 +80,7 @@ static void s390_cpu_load_normal(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     cpu->env.psw.addr = ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
     cpu->env.psw.mask = PSW_MASK_32 | PSW_MASK_64;
-    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+    s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 #endif
 
@@ -95,7 +95,7 @@ static void s390_cpu_reset(CPUState *s)
     env->bpbc = false;
     scc->parent_reset(s);
     cpu->env.sigp_order = 0;
-    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 }
 
 /* S390CPUClass::initial_reset() */
@@ -138,7 +138,7 @@ static void s390_cpu_full_reset(CPUState *s)
 
     scc->parent_reset(s);
     cpu->env.sigp_order = 0;
-    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
     memset(env, 0, offsetof(CPUS390XState, end_reset_fields));
 
@@ -292,7 +292,7 @@ static void s390_cpu_initfn(Object *obj)
     env->tod_basetime = 0;
     env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
-    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
 }
 
@@ -320,8 +320,8 @@ static unsigned s390_count_running_cpus(void)
 
     CPU_FOREACH(cpu) {
         uint8_t state = S390_CPU(cpu)->env.cpu_state;
-        if (state == CPU_STATE_OPERATING ||
-            state == CPU_STATE_LOAD) {
+        if (state == S390_CPU_STATE_OPERATING ||
+            state == S390_CPU_STATE_LOAD) {
             if (!disabled_wait(cpu)) {
                 nr_running++;
             }
@@ -360,13 +360,13 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
 
     switch (cpu_state) {
-    case CPU_STATE_STOPPED:
-    case CPU_STATE_CHECK_STOP:
+    case S390_CPU_STATE_STOPPED:
+    case S390_CPU_STATE_CHECK_STOP:
         /* halt the cpu for common infrastructure */
         s390_cpu_halt(cpu);
         break;
-    case CPU_STATE_OPERATING:
-    case CPU_STATE_LOAD:
+    case S390_CPU_STATE_OPERATING:
+    case S390_CPU_STATE_LOAD:
         /*
          * Starting a CPU with a PSW WAIT bit set:
          * KVM: handles this internally and triggers another WAIT exit.
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d4641663ef..802324b3e2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -141,12 +141,9 @@ struct CPUS390XState {
      * architectures, there is a difference between a halt and a stop on s390.
      * If all cpus are either stopped (including check stop) or in the disabled
      * wait state, the vm can be shut down.
+     * The acceptable cpu_state values are defined in the CpuInfoS390State
+     * enum.
      */
-#define CPU_STATE_UNINITIALIZED        0x00
-#define CPU_STATE_STOPPED              0x01
-#define CPU_STATE_CHECK_STOP           0x02
-#define CPU_STATE_OPERATING            0x03
-#define CPU_STATE_LOAD                 0x04
     uint8_t cpu_state;
 
     /* currently processed sigp order */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 83e4eaf45d..8ef509ece4 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1880,16 +1880,16 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
     }
 
     switch (cpu_state) {
-    case CPU_STATE_STOPPED:
+    case S390_CPU_STATE_STOPPED:
         mp_state.mp_state = KVM_MP_STATE_STOPPED;
         break;
-    case CPU_STATE_CHECK_STOP:
+    case S390_CPU_STATE_CHECK_STOP:
         mp_state.mp_state = KVM_MP_STATE_CHECK_STOP;
         break;
-    case CPU_STATE_OPERATING:
+    case S390_CPU_STATE_OPERATING:
         mp_state.mp_state = KVM_MP_STATE_OPERATING;
         break;
-    case CPU_STATE_LOAD:
+    case S390_CPU_STATE_LOAD:
         mp_state.mp_state = KVM_MP_STATE_LOAD;
         break;
     default:
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ac3f8e7dc2..5a7a9c4cfb 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -46,13 +46,13 @@ static void sigp_sense(S390CPU *dst_cpu, SigpInfo *si)
     }
 
     /* sensing without locks is racy, but it's the same for real hw */
-    if (state != CPU_STATE_STOPPED && !ext_call) {
+    if (state != S390_CPU_STATE_STOPPED && !ext_call) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
     } else {
         if (ext_call) {
             status |= SIGP_STAT_EXT_CALL_PENDING;
         }
-        if (state == CPU_STATE_STOPPED) {
+        if (state == S390_CPU_STATE_STOPPED) {
             status |= SIGP_STAT_STOPPED;
         }
         set_sigp_status(si, status);
@@ -94,12 +94,12 @@ static void sigp_start(CPUState *cs, run_on_cpu_data arg)
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
 
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_STOPPED) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
         return;
     }
 
-    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+    s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
@@ -108,14 +108,14 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     S390CPU *cpu = S390_CPU(cs);
     SigpInfo *si = arg.host_ptr;
 
-    if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
         return;
     }
 
     /* disabled wait - sleeping in user space */
     if (cs->halted) {
-        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+        s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     } else {
         /* execute the stop function */
         cpu->env.sigp_order = SIGP_STOP;
@@ -130,17 +130,17 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     /* disabled wait - sleeping in user space */
-    if (s390_cpu_get_state(cpu) == CPU_STATE_OPERATING && cs->halted) {
-        s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
+    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cs->halted) {
+        s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     }
 
     switch (s390_cpu_get_state(cpu)) {
-    case CPU_STATE_OPERATING:
+    case S390_CPU_STATE_OPERATING:
         cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
         cpu_inject_stop(cpu);
         /* store will be performed in do_stop_interrup() */
         break;
-    case CPU_STATE_STOPPED:
+    case S390_CPU_STATE_STOPPED:
         /* already stopped, just store the status */
         cpu_synchronize_state(cs);
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
@@ -156,7 +156,7 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
     uint32_t address = si->param & 0x7ffffe00u;
 
     /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_STOPPED) {
         set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
         return;
     }
@@ -186,7 +186,7 @@ static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
     }
 
     /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_STOPPED) {
         set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
         return;
     }
@@ -229,17 +229,17 @@ static void sigp_restart(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     switch (s390_cpu_get_state(cpu)) {
-    case CPU_STATE_STOPPED:
+    case S390_CPU_STATE_STOPPED:
         /* the restart irq has to be delivered prior to any other pending irq */
         cpu_synchronize_state(cs);
         /*
          * Set OPERATING (and unhalting) before loading the restart PSW.
          * load_psw() will then properly halt the CPU again if necessary (TCG).
          */
-        s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
+        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
         do_restart_interrupt(&cpu->env);
         break;
-    case CPU_STATE_OPERATING:
+    case S390_CPU_STATE_OPERATING:
         cpu_inject_restart(cpu);
         break;
     }
@@ -285,7 +285,7 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     }
 
     /* cpu has to be stopped */
-    if (s390_cpu_get_state(cpu) != CPU_STATE_STOPPED) {
+    if (s390_cpu_get_state(cpu) != S390_CPU_STATE_STOPPED) {
         set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
         return;
     }
@@ -318,7 +318,7 @@ static void sigp_cond_emergency(S390CPU *src_cpu, S390CPU *dst_cpu,
     p_asn = dst_cpu->env.cregs[4] & 0xffff;  /* Primary ASN */
     s_asn = dst_cpu->env.cregs[3] & 0xffff;  /* Secondary ASN */
 
-    if (s390_cpu_get_state(dst_cpu) != CPU_STATE_STOPPED ||
+    if (s390_cpu_get_state(dst_cpu) != S390_CPU_STATE_STOPPED ||
         (psw_mask & psw_int_mask) != psw_int_mask ||
         (idle && psw_addr != 0) ||
         (!idle && (asn == p_asn || asn == s_asn))) {
@@ -435,7 +435,7 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
         if (cur_cpu == cpu) {
             continue;
         }
-        if (s390_cpu_get_state(cur_cpu) != CPU_STATE_STOPPED) {
+        if (s390_cpu_get_state(cur_cpu) != S390_CPU_STATE_STOPPED) {
             all_stopped = false;
         }
     }
@@ -492,7 +492,7 @@ void do_stop_interrupt(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
 
-    if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) == 0) {
+    if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
     if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
-- 
2.13.6
