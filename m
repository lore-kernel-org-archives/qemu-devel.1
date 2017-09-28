Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaF-0004yj-Bc
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfaB-0003e8-6P
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfaA-0003de-Tr
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:02 +0200
Message-Id: <20170928203708.9376-25-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/30] s390x/tcg: implement STOP and RESET
 interrupts for TCG
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

Implement them like KVM implements/handles them. Both can only be
triggered via SIGP instructions. RESET has (almos)the lowest priority if
the CPU is running, and the highest if the CPU is STOPPED. This is handled
in SIGP code already. On delivery, we only have to care about the
"CPU running" scenario.

STOP is defined to be delivered after all other interrupts have been
delivered. Therefore it has the actual lowest priority.

As both can wake up a CPU if sleeping, indicate them correctly to
external code (e.g. cpu_has_work()).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  4 ++++
 target/s390x/excp_helper.c | 16 +++++++++++++++-
 target/s390x/helper.c      |  1 +
 target/s390x/internal.h    |  2 ++
 target/s390x/interrupt.c   | 32 +++++++++++++++++++++++++++-----
 target/s390x/sigp.c        |  2 ++
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7f4f03f410..b684502900 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -400,6 +400,8 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
 #define EXCP_PGM 3 /* program interruption */
+#define EXCP_RESTART 4 /* restart interrupt */
+#define EXCP_STOP 5 /* stop interrupt */
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
@@ -410,6 +412,8 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
 #define INTERRUPT_EMERGENCY_SIGNAL       (1 << 6)
+#define INTERRUPT_RESTART                (1 << 7)
+#define INTERRUPT_STOP                   (1 << 8)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 1a0d0770a9..e04b670663 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -449,6 +449,14 @@ void s390_cpu_do_interrupt(CPUState *cs)
     if (cs->exception_index == -1 && s390_cpu_has_io_int(cpu)) {
         cs->exception_index = EXCP_IO;
     }
+    /* RESTART interrupt */
+    if (cs->exception_index == -1 && s390_cpu_has_restart_int(cpu)) {
+        cs->exception_index = EXCP_RESTART;
+    }
+    /* STOP interrupt has least priority */
+    if (cs->exception_index == -1 && s390_cpu_has_stop_int(cpu)) {
+        cs->exception_index = EXCP_STOP;
+    }
 
     switch (cs->exception_index) {
     case EXCP_PGM:
@@ -466,9 +474,15 @@ void s390_cpu_do_interrupt(CPUState *cs)
     case EXCP_MCHK:
         do_mchk_interrupt(env);
         break;
+    case EXCP_RESTART:
+        do_restart_interrupt(env);
+        break;
+    case EXCP_STOP:
+        do_stop_interrupt(env);
+        break;
     }
 
-    /* WAIT PSW during interrupt injection */
+    /* WAIT PSW during interrupt injection or STOP interrupt */
     if (cs->exception_index == EXCP_HLT) {
         /* don't trigger a cpu_loop_exit(), use an interrupt instead */
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 2505f3aec0..c41aa4c4ff 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -202,6 +202,7 @@ void do_restart_interrupt(CPUS390XState *env)
     addr = be64_to_cpu(lowcore->restart_new_psw.addr);
 
     cpu_unmap_lowcore(lowcore);
+    env->pending_int &= ~INTERRUPT_RESTART;
 
     load_psw(env, mask, addr);
 }
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 2c3fc3fce0..3aff54ada4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -372,6 +372,8 @@ bool s390_cpu_has_io_int(S390CPU *cpu);
 bool s390_cpu_has_ext_int(S390CPU *cpu);
 bool s390_cpu_has_mcck_int(S390CPU *cpu);
 bool s390_cpu_has_int(S390CPU *cpu);
+bool s390_cpu_has_restart_int(S390CPU *cpu);
+bool s390_cpu_has_stop_int(S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 64b3f519ef..f2ca881bed 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -109,22 +109,28 @@ int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr)
 
 void cpu_inject_restart(S390CPU *cpu)
 {
+    CPUS390XState *env = &cpu->env;
+
     if (kvm_enabled()) {
         kvm_s390_restart_interrupt(cpu);
         return;
     }
-    /* FIXME TCG */
-    g_assert_not_reached();
+
+    env->pending_int |= INTERRUPT_RESTART;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
 void cpu_inject_stop(S390CPU *cpu)
 {
+    CPUS390XState *env = &cpu->env;
+
     if (kvm_enabled()) {
         kvm_s390_stop_interrupt(cpu);
         return;
     }
-    /* FIXME TCG */
-    g_assert_not_reached();
+
+    env->pending_int |= INTERRUPT_STOP;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
 static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
@@ -272,6 +278,20 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
 
     return env->pending_int & INTERRUPT_IO;
 }
+
+bool s390_cpu_has_restart_int(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    return env->pending_int & INTERRUPT_RESTART;
+}
+
+bool s390_cpu_has_stop_int(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    return env->pending_int & INTERRUPT_STOP;
+}
 #endif
 
 bool s390_cpu_has_int(S390CPU *cpu)
@@ -282,7 +302,9 @@ bool s390_cpu_has_int(S390CPU *cpu)
     }
     return s390_cpu_has_mcck_int(cpu) ||
            s390_cpu_has_ext_int(cpu) ||
-           s390_cpu_has_io_int(cpu);
+           s390_cpu_has_io_int(cpu) ||
+           s390_cpu_has_restart_int(cpu) ||
+           s390_cpu_has_stop_int(cpu);
 #else
     return false;
 #endif
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ce8fda9d01..d70f5cb0ba 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -14,6 +14,7 @@
 #include "internal.h"
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
+#include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -498,6 +499,7 @@ void do_stop_interrupt(CPUS390XState *env)
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
     env->sigp_order = 0;
+    env->pending_int &= ~INTERRUPT_STOP;
 }
 
 void s390_init_sigp(void)
-- 
2.13.5
