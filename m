Received: from eggs.gnu.org ([2001:4830:134:3::10]:58483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt5-0002CD-SF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt3-0002w5-3T
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:39 +0200
Message-Id: <20171020115418.2050-8-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/46] s390x/tcg: take care of external
 interrupt subclasses
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

We can now let go of INTERRUPT_EXT. When cr0 changes, we have to
revalidate if we now have a pending external interrupt, just like
when the PSW (or SYSTEM MASK only) changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-6-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         | 10 +++++-----
 target/s390x/excp_helper.c | 15 ++++++++++-----
 target/s390x/interrupt.c   | 32 +++++++++++++++++++++++++++++++-
 target/s390x/translate.c   |  6 ++++--
 4 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f0f5ff0359..6ae0c7dfc8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -345,6 +345,11 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 #define CR0_LOWPROT             0x0000000010000000ULL
 #define CR0_SECONDARY           0x0000000004000000ULL
 #define CR0_EDAT                0x0000000000800000ULL
+#define CR0_EMERGENCY_SIGNAL_SC 0x0000000000004000ULL
+#define CR0_EXTERNAL_CALL_SC    0x0000000000002000ULL
+#define CR0_CKC_SC              0x0000000000000800ULL
+#define CR0_CPU_TIMER_SC        0x0000000000000400ULL
+#define CR0_SERVICE_SC          0x0000000000000200ULL
 
 /* MMU */
 #define MMU_PRIMARY_IDX         0
@@ -405,11 +410,6 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
 #define INTERRUPT_EMERGENCY_SIGNAL       (1 << 6)
-#define INTERRUPT_EXT                    (INTERRUPT_EXT_SERVICE | \
-                                          INTERRUPT_EXT_CPU_TIMER | \
-                                          INTERRUPT_EXT_CLOCK_COMPARATOR | \
-                                          INTERRUPT_EXTERNAL_CALL | \
-                                          INTERRUPT_EMERGENCY_SIGNAL)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 050d5a61f1..11a85a665b 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -249,7 +249,8 @@ static void do_ext_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
-    if (env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) {
+    if ((env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) &&
+        (env->cregs[0] & CR0_EMERGENCY_SIGNAL_SC)) {
         lowcore->ext_int_code = cpu_to_be16(EXT_EMERGENCY);
         cpu_addr = find_first_bit(env->emergency_signals, S390_MAX_CPUS);
         g_assert(cpu_addr < S390_MAX_CPUS);
@@ -258,19 +259,23 @@ static void do_ext_interrupt(CPUS390XState *env)
         if (bitmap_empty(env->emergency_signals, max_cpus)) {
             env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
         }
-    } else if (env->pending_int & INTERRUPT_EXTERNAL_CALL) {
+    } else if ((env->pending_int & INTERRUPT_EXTERNAL_CALL) &&
+               (env->cregs[0] & CR0_EXTERNAL_CALL_SC)) {
         lowcore->ext_int_code = cpu_to_be16(EXT_EXTERNAL_CALL);
         lowcore->cpu_addr = cpu_to_be16(env->external_call_addr);
         env->pending_int &= ~INTERRUPT_EXTERNAL_CALL;
-    } else if (env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) {
+    } else if ((env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) &&
+               (env->cregs[0] & CR0_CKC_SC)) {
         lowcore->ext_int_code = cpu_to_be16(EXT_CLOCK_COMP);
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
-    } else if (env->pending_int & INTERRUPT_EXT_CPU_TIMER) {
+    } else if ((env->pending_int & INTERRUPT_EXT_CPU_TIMER) &&
+               (env->cregs[0] & CR0_CPU_TIMER_SC)) {
         lowcore->ext_int_code = cpu_to_be16(EXT_CPU_TIMER);
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
-    } else if (env->pending_int & INTERRUPT_EXT_SERVICE) {
+    } else if ((env->pending_int & INTERRUPT_EXT_SERVICE) &&
+               (env->cregs[0] & CR0_SERVICE_SC)) {
         /*
          * FIXME: floating IRQs should be considered by all CPUs and
          *        shuld not get cleared by CPU reset.
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 0cb65a8c46..83a0f194f8 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -209,7 +209,37 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
         return false;
     }
 
-    return env->pending_int & INTERRUPT_EXT;
+    if ((env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) &&
+        (env->cregs[0] & CR0_EMERGENCY_SIGNAL_SC)) {
+        return true;
+    }
+
+    if ((env->pending_int & INTERRUPT_EXTERNAL_CALL) &&
+        (env->cregs[0] & CR0_EXTERNAL_CALL_SC)) {
+        return true;
+    }
+
+    if ((env->pending_int & INTERRUPT_EXTERNAL_CALL) &&
+        (env->cregs[0] & CR0_EXTERNAL_CALL_SC)) {
+        return true;
+    }
+
+    if ((env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) &&
+        (env->cregs[0] & CR0_CKC_SC)) {
+        return true;
+    }
+
+    if ((env->pending_int & INTERRUPT_EXT_CPU_TIMER) &&
+        (env->cregs[0] & CR0_CPU_TIMER_SC)) {
+        return true;
+    }
+
+    if ((env->pending_int & INTERRUPT_EXT_SERVICE) &&
+        (env->cregs[0] & CR0_SERVICE_SC)) {
+        return true;
+    }
+
+    return false;
 }
 
 bool s390_cpu_has_io_int(S390CPU *cpu)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 165d2cac3e..8fa5772185 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2719,7 +2719,8 @@ static ExitStatus op_lctl(DisasContext *s, DisasOps *o)
     gen_helper_lctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
@@ -2730,7 +2731,8 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
-    return NO_EXIT;
+    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
+    return EXIT_PC_STALE_NOCHAIN;
 }
 
 static ExitStatus op_lra(DisasContext *s, DisasOps *o)
-- 
2.13.6
