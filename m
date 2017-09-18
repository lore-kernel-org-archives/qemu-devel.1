Received: from eggs.gnu.org ([2001:4830:134:3::10]:37386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTu-0006wT-Tw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTo-0007p4-M5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTo-0007oO-E0
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:51 +0200
Message-Id: <20170918160012.4317-7-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/27] s390x/tcg: injection of emergency
 signals and extarnal calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Preparation for new TCG SIGP code. Especially also prepare for
indicating that another external call is already pending.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  8 +++++++-
 target/s390x/excp_helper.c | 14 ++++++++++++++
 target/s390x/internal.h    |  2 ++
 target/s390x/interrupt.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d4e2aa2f24..857af21d06 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -132,6 +132,8 @@ struct CPUS390XState {
     MchkQueue mchk_queue[MAX_MCHK_QUEUE];
 
     int pending_int;
+    uint16_t external_call_addr;
+    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
     int ext_index;
     int io_index[8];
     int mchk_index;
@@ -405,9 +407,13 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define INTERRUPT_EXT_FLOATING           (1 << 2)
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
+#define INTERRUPT_EXTERNAL_CALL          (1 << 5)
+#define INTERRUPT_EMERGENCY_SIGNAL       (1 << 6)
 #define INTERRUPT_EXT                    (INTERRUPT_EXT_FLOATING | \
                                           INTERRUPT_EXT_CPU_TIMER | \
-                                          INTERRUPT_EXT_CLOCK_COMPARATOR)
+                                          INTERRUPT_EXT_CLOCK_COMPARATOR | \
+                                          INTERRUPT_EXTERNAL_CALL | \
+                                          INTERRUPT_EMERGENCY_SIGNAL)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 46d015f260..ff257ba72e 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -231,6 +231,7 @@ static void do_ext_interrupt(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
+    uint16_t cpu_addr;
     LowCore *lowcore;
     ExtQueue *q;
 
@@ -248,6 +249,19 @@ static void do_ext_interrupt(CPUS390XState *env)
         lowcore->ext_int_code = cpu_to_be16(EXT_CPU_TIMER);
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
+    } else if (env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) {
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
     } else if (env->pending_int | INTERRUPT_EXT_FLOATING) {
         g_assert(env->ext_index >= 0);
         /*
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index ae4b27a574..15743ec40f 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -350,6 +350,8 @@ void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
+void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
+int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 4ba33c49cb..462316be8e 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -91,6 +91,32 @@ void cpu_inject_cpu_timer(S390CPU *cpu)
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
2.13.5
