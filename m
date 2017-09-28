Received: from eggs.gnu.org ([2001:4830:134:3::10]:53319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYl-0003f2-82
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYj-000347-GZ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYj-00033t-7t
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:43 +0200
Message-Id: <20170928203708.9376-6-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/30] s390x/tcg: take care of external
 interrupt subclasses
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

We can now let go of INTERRUPT_EXT. When cr0 changes, we have to
revalidate if we now have a pending external interrupt, just like
when the PSW (or SYSTEM MASK only) changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
index 02849e41e6..fe68de5a77 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -248,7 +248,8 @@ static void do_ext_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
-    if (env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) {
+    if ((env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) &&
+        (env->cregs[0] & CR0_EMERGENCY_SIGNAL_SC)) {
         lowcore->ext_int_code = cpu_to_be16(EXT_EMERGENCY);
         cpu_addr = find_first_bit(env->emergency_signals, S390_MAX_CPUS);
         g_assert(cpu_addr < S390_MAX_CPUS);
@@ -257,19 +258,23 @@ static void do_ext_interrupt(CPUS390XState *env)
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
index 54eb400b0c..c1eaaea98b 100644
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
index 9ef95141f9..405d94b87d 100644
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
2.13.5
