Received: from eggs.gnu.org ([2001:4830:134:3::10]:37984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUq-0007os-AO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUk-0008JR-ER
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUk-0008Iy-7B
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:02 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:08 +0200
Message-Id: <20170918160012.4317-24-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 23/27] s390x/tcg: implement STOP and RESET
 interrupts for TCG
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
 target/s390x/cpu.c         |  4 +++-
 target/s390x/cpu.h         |  4 ++++
 target/s390x/excp_helper.c | 18 +++++++++++++++++-
 target/s390x/helper.c      |  1 +
 target/s390x/interrupt.c   | 14 ++++++++++----
 target/s390x/sigp.c        |  1 +
 6 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9a01f591b6..9d20434075 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -65,7 +65,9 @@ static bool s390_cpu_has_work(CPUState *cs)
     }
 
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-           (env->psw.mask & PSW_MASK_EXT);
+            ((env->psw.mask & PSW_MASK_EXT) ||
+             env->pending_int & INTERRUPT_STOP ||
+             env->pending_int & INTERRUPT_RESTART);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 97d4abb6c0..fc1f622c52 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -399,6 +399,8 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
 #define EXCP_PGM 3 /* program interruption */
+#define EXCP_RESTART 4 /* restart interrupt */
+#define EXCP_STOP 5 /* stop interrupt */
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
@@ -409,6 +411,8 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
 #define INTERRUPT_EMERGENCY_SIGNAL       (1 << 6)
+#define INTERRUPT_RESTART                (1 << 7)
+#define INTERRUPT_STOP                   (1 << 8)
 #define INTERRUPT_EXT                    (INTERRUPT_EXT_FLOATING | \
                                           INTERRUPT_EXT_CPU_TIMER | \
                                           INTERRUPT_EXT_CLOCK_COMPARATOR | \
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 4dc30e056a..ce28708499 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -452,6 +452,14 @@ void s390_cpu_do_interrupt(CPUState *cs)
             cs->exception_index = EXCP_IO;
         }
     }
+    /* RESTART interrupt */
+    if (cs->exception_index == -1 && env->pending_int & INTERRUPT_RESTART) {
+        cs->exception_index = EXCP_RESTART;
+    }
+    /* STOP interrupt has least priority */
+    if (cs->exception_index == -1 && env->pending_int & INTERRUPT_STOP) {
+        cs->exception_index = EXCP_STOP;
+    }
 
     switch (cs->exception_index) {
     case EXCP_PGM:
@@ -469,6 +477,12 @@ void s390_cpu_do_interrupt(CPUState *cs)
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
     cs->exception_index = -1;
 
@@ -488,7 +502,9 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
                the parent EXECUTE insn.  */
             return false;
         }
-        if (env->psw.mask & PSW_MASK_EXT) {
+        if (env->psw.mask & PSW_MASK_EXT ||
+            env->pending_int & INTERRUPT_STOP ||
+            env->pending_int & INTERRUPT_RESTART) {
             s390_cpu_do_interrupt(cs);
             return true;
         }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 4d5a92c2ca..abda74d810 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -202,6 +202,7 @@ void do_restart_interrupt(CPUS390XState *env)
     addr = be64_to_cpu(lowcore->restart_new_psw.addr);
 
     cpu_unmap_lowcore(lowcore);
+    env->pending_int &= ~INTERRUPT_RESTART;
 
     load_psw(env, mask, addr);
 }
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index b1dc28c8dd..2f004ffe6d 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -119,22 +119,28 @@ int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr)
 
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
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index ce8fda9d01..521dcc75f3 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -498,6 +498,7 @@ void do_stop_interrupt(CPUS390XState *env)
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
     env->sigp_order = 0;
+    env->pending_int &= ~INTERRUPT_STOP;
 }
 
 void s390_init_sigp(void)
-- 
2.13.5
