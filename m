Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt2-000297-9E
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt1-0002tE-8m
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:48 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:38 +0200
Message-Id: <20171020115418.2050-7-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/46] s390x/tcg: rework checking for
 deliverable interrupts
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

Currently, enabling/disabling of interrupts is not really supported.

Let's improve interrupt handling code by explicitly checking for
deliverable interrupts only. This is the first step. Checking for
external interrupt subclasses will be done next.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-5-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c         |  8 +++++---
 target/s390x/excp_helper.c | 21 +++++++--------------
 target/s390x/internal.h    |  4 ++++
 target/s390x/interrupt.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 77d55c9e1e..b0517475fa 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -56,10 +56,12 @@ static void s390_cpu_set_pc(CPUState *cs, vaddr value)
 static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
-    CPUS390XState *env = &cpu->env;
 
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-           (env->psw.mask & PSW_MASK_EXT);
+    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+        return false;
+    }
+
+    return s390_cpu_has_int(cpu);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 44e9b2c6a6..050d5a61f1 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -435,24 +435,16 @@ void s390_cpu_do_interrupt(CPUState *cs)
 
     s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     /* handle machine checks */
-    if ((env->psw.mask & PSW_MASK_MCHECK) &&
-        (cs->exception_index == -1)) {
-        if (env->pending_int & INTERRUPT_MCHK) {
-            cs->exception_index = EXCP_MCHK;
-        }
+    if (cs->exception_index == -1 && s390_cpu_has_mcck_int(cpu)) {
+        cs->exception_index = EXCP_MCHK;
     }
     /* handle external interrupts */
-    if ((env->psw.mask & PSW_MASK_EXT) &&
-        cs->exception_index == -1 &&
-        (env->pending_int & INTERRUPT_EXT)) {
+    if (cs->exception_index == -1 && s390_cpu_has_ext_int(cpu)) {
         cs->exception_index = EXCP_EXT;
     }
     /* handle I/O interrupts */
-    if ((env->psw.mask & PSW_MASK_IO) &&
-        (cs->exception_index == -1)) {
-        if (env->pending_int & INTERRUPT_IO) {
-            cs->exception_index = EXCP_IO;
-        }
+    if (cs->exception_index == -1 && s390_cpu_has_io_int(cpu)) {
+        cs->exception_index = EXCP_IO;
     }
 
     switch (cs->exception_index) {
@@ -474,6 +466,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     }
     cs->exception_index = -1;
 
+    /* we might still have pending interrupts, but not deliverable */
     if (!env->pending_int) {
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
     }
@@ -490,7 +483,7 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
                the parent EXECUTE insn.  */
             return false;
         }
-        if (env->psw.mask & PSW_MASK_EXT) {
+        if (s390_cpu_has_int(cpu)) {
             s390_cpu_do_interrupt(cs);
             return true;
         }
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index f67c2a1785..e41fb2e38e 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -364,6 +364,10 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
 int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
+bool s390_cpu_has_io_int(S390CPU *cpu);
+bool s390_cpu_has_ext_int(S390CPU *cpu);
+bool s390_cpu_has_mcck_int(S390CPU *cpu);
+bool s390_cpu_has_int(S390CPU *cpu);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index bb7cc7f87f..0cb65a8c46 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -190,4 +190,50 @@ void s390_crw_mchk(void)
     }
 }
 
+bool s390_cpu_has_mcck_int(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    if (!(env->psw.mask & PSW_MASK_MCHECK)) {
+        return false;
+    }
+
+    return env->pending_int & INTERRUPT_MCHK;
+}
+
+bool s390_cpu_has_ext_int(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    if (!(env->psw.mask & PSW_MASK_EXT)) {
+        return false;
+    }
+
+    return env->pending_int & INTERRUPT_EXT;
+}
+
+bool s390_cpu_has_io_int(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    if (!(env->psw.mask & PSW_MASK_IO)) {
+        return false;
+    }
+
+    return env->pending_int & INTERRUPT_IO;
+}
 #endif
+
+bool s390_cpu_has_int(S390CPU *cpu)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!tcg_enabled()) {
+        return false;
+    }
+    return s390_cpu_has_mcck_int(cpu) ||
+           s390_cpu_has_ext_int(cpu) ||
+           s390_cpu_has_io_int(cpu);
+#else
+    return false;
+#endif
+}
-- 
2.13.6
