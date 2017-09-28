Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYg-0003aS-9L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYf-000327-6A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYe-00031h-TK
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:41 +0200
Message-Id: <20170928203708.9376-4-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/30] s390x/tcg: injection of emergency
 signals and external calls
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Preparation for new TCG SIGP code. Especially also prepare for
indicating that another external call is already pending.

Take care of interrupt priority.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
index 8228104a49..bffcf7f39e 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -239,6 +239,7 @@ static void do_ext_interrupt(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
+    uint16_t cpu_addr;
     LowCore *lowcore;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
@@ -247,7 +248,20 @@ static void do_ext_interrupt(CPUS390XState *env)
 
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
index cbc7b7696d..afd311c1e1 100644
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
2.13.5
