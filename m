Received: from eggs.gnu.org ([2001:4830:134:3::10]:58409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt0-00026g-85
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsz-0002pZ-AE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:37 +0200
Message-Id: <20171020115418.2050-6-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/46] s390x/tcg: injection of emergency signals
 and external calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Preparation for new TCG SIGP code. Especially also prepare for
indicating that another external call is already pending.

Take care of interrupt priority.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-4-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         |  8 +++++++-
 target/s390x/excp_helper.c | 16 +++++++++++++++-
 target/s390x/internal.h    |  2 ++
 target/s390x/interrupt.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7bea97a2d7..f0f5ff0359 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -126,6 +126,8 @@ struct CPUS390XState {
 
     int pending_int;
     uint32_t service_param;
+    uint16_t external_call_addr;
+    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
     int io_index[8];
     int mchk_index;
 
@@ -401,9 +403,13 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define INTERRUPT_EXT_SERVICE            (1 << 2)
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
+#define INTERRUPT_EXTERNAL_CALL          (1 << 5)
+#define INTERRUPT_EMERGENCY_SIGNAL       (1 << 6)
 #define INTERRUPT_EXT                    (INTERRUPT_EXT_SERVICE | \
                                           INTERRUPT_EXT_CPU_TIMER | \
-                                          INTERRUPT_EXT_CLOCK_COMPARATOR)
+                                          INTERRUPT_EXT_CLOCK_COMPARATOR | \
+                                          INTERRUPT_EXTERNAL_CALL | \
+                                          INTERRUPT_EMERGENCY_SIGNAL)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f5851069b5..44e9b2c6a6 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -240,6 +240,7 @@ static void do_ext_interrupt(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
+    uint16_t cpu_addr;
     LowCore *lowcore;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
@@ -248,7 +249,20 @@ static void do_ext_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
-    if (env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) {
+    if (env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) {
+        lowcore->ext_int_code = cpu_to_be16(EXT_EMERGENCY);
+        cpu_addr = find_first_bit(env->emergency_signals, S390_MAX_CPUS);
+        g_assert(cpu_addr < S390_MAX_CPUS);
+        lowcore->cpu_addr = cpu_to_be16(cpu_addr);
+        clear_bit(cpu_addr, env->emergency_signals);
+        if (bitmap_empty(env->emergency_signals, max_cpus)) {
+            env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
+        }
+    } else if (env->pending_int & INTERRUPT_EXTERNAL_CALL) {
+        lowcore->ext_int_code = cpu_to_be16(EXT_EXTERNAL_CALL);
+        lowcore->cpu_addr = cpu_to_be16(env->external_call_addr);
+        env->pending_int &= ~INTERRUPT_EXTERNAL_CALL;
+    } else if (env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) {
         lowcore->ext_int_code = cpu_to_be16(EXT_CLOCK_COMP);
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index eaa071a183..f67c2a1785 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -362,6 +362,8 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
+void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
+int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index edcc2e9d2d..bb7cc7f87f 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -81,6 +81,32 @@ void cpu_inject_cpu_timer(S390CPU *cpu)
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
+void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr)
+{
+    CPUS390XState *env = &cpu->env;
+
+    g_assert(src_cpu_addr < S390_MAX_CPUS);
+    set_bit(src_cpu_addr, env->emergency_signals);
+
+    env->pending_int |= INTERRUPT_EMERGENCY_SIGNAL;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+}
+
+int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr)
+{
+    CPUS390XState *env = &cpu->env;
+
+    g_assert(src_cpu_addr < S390_MAX_CPUS);
+    if (env->pending_int & INTERRUPT_EXTERNAL_CALL) {
+        return -EBUSY;
+    }
+    env->external_call_addr = src_cpu_addr;
+
+    env->pending_int |= INTERRUPT_EXTERNAL_CALL;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    return 0;
+}
+
 static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
                           uint16_t subchannel_number,
                           uint32_t io_int_parm, uint32_t io_int_word)
-- 
2.13.6
