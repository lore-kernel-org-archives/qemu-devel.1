Received: from eggs.gnu.org ([209.51.188.92]:35511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3l-0008P9-Dt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3j-00018B-0g
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:56 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:23 -0500
Message-Id: <20190130004811.27372-26-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 25/73] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/intc/s390_flic.c        |  2 +-
 target/s390x/cpu.c         | 22 +++++++++++++++-------
 target/s390x/excp_helper.c |  2 +-
 target/s390x/kvm.c         |  2 +-
 target/s390x/sigp.c        |  8 ++++----
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f8168f0f0..bfb5cf1d07 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -198,7 +198,7 @@ static void qemu_s390_flic_notify(uint32_t type)
         }
 
         /* we always kick running CPUs for now, this is tricky */
-        if (cs->halted) {
+        if (cpu_halted(cs)) {
             /* don't check for subclasses, CPUs double check when waking up */
             if (type & FLIC_PENDING_SERVICE) {
                 if (!(cpu->env.psw.mask & PSW_MASK_EXT)) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 18ba7f85a5..4d70ba785c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -288,7 +288,7 @@ static void s390_cpu_initfn(Object *obj)
     CPUS390XState *env = &cpu->env;
 
     cs->env_ptr = env;
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
@@ -313,8 +313,8 @@ static void s390_cpu_finalize(Object *obj)
 #if !defined(CONFIG_USER_ONLY)
 static bool disabled_wait(CPUState *cpu)
 {
-    return cpu->halted && !(S390_CPU(cpu)->env.psw.mask &
-                            (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
+    return cpu_halted(cpu) && !(S390_CPU(cpu)->env.psw.mask &
+                                (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
 static unsigned s390_count_running_cpus(void)
@@ -340,10 +340,16 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_halt(cs->cpu_index);
 
-    if (!cs->halted) {
-        cs->halted = 1;
+    /*
+     * cpu_halted and cpu_halted_set acquire the cpu lock if it
+     * isn't already held, so acquire it first.
+     */
+    cpu_mutex_lock(cs);
+    if (!cpu_halted(cs)) {
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
+    cpu_mutex_unlock(cs);
 
     return s390_count_running_cpus();
 }
@@ -353,10 +359,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_unhalt(cs->cpu_index);
 
-    if (cs->halted) {
-        cs->halted = 0;
+    cpu_mutex_lock(cs);
+    if (cpu_halted(cs)) {
+        cpu_halted_set(cs, 0);
         cs->exception_index = -1;
     }
+    cpu_mutex_unlock(cs);
 }
 
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 2a33222f7e..d22c5b3ce5 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -461,7 +461,7 @@ try_deliver:
     if ((env->psw.mask & PSW_MASK_WAIT) || stopped) {
         /* don't trigger a cpu_loop_exit(), use an interrupt instead */
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
-    } else if (cs->halted) {
+    } else if (cpu_halted(cs)) {
         /* unhalt if we had a WAIT PSW somehwere in our injection chain */
         s390_cpu_unhalt(cpu);
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2ebf26adfe..ffb52888c0 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1005,7 +1005,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int s390_kvm_irq_to_interrupt(struct kvm_s390_irq *irq,
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c1f9245797..d410da797a 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -115,7 +115,7 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     }
 
     /* disabled wait - sleeping in user space */
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     } else {
         /* execute the stop function */
@@ -131,7 +131,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     /* disabled wait - sleeping in user space */
-    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cs->halted) {
+    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     }
 
@@ -313,7 +313,7 @@ static void sigp_cond_emergency(S390CPU *src_cpu, S390CPU *dst_cpu,
     }
 
     /* this looks racy, but these values are only used when STOPPED */
-    idle = CPU(dst_cpu)->halted;
+    idle = cpu_halted(CPU(dst_cpu));
     psw_addr = dst_cpu->env.psw.addr;
     psw_mask = dst_cpu->env.psw.mask;
     asn = si->param;
@@ -347,7 +347,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
     }
 
     /* If halted (which includes also STOPPED), it is not running */
-    if (CPU(dst_cpu)->halted) {
+    if (cpu_halted(CPU(dst_cpu))) {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
     } else {
         set_sigp_status(si, SIGP_STAT_NOT_RUNNING);
-- 
2.17.1
