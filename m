Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYc-0003Y9-IH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYb-00030A-3Q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYa-0002zp-QU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:17 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:39 +0200
Message-Id: <20170928203708.9376-2-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/30] s390x/tcg: turn INTERRUPT_EXT into a
 mask
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

External interrupts are currently all handled like floating external
interrupts, they are queued. Let's prepare for a split of floating
and local interrupts by turning INTERRUPT_EXT into a mask.

While we can have various floating external interrupts of one kind, there
is usually only one (or a fixed number) of the local external interrupts.

So turn INTERRUPT_EXT into a mask and properly indicate the kind of
external interrupt. Floating interrupts will have to moved out of
one CPU instance later once we have SMP support.

The only floating external interrupts used right now are SERVICE
interrupts, so let's use that name. Following patches will clean up
SERVICE interrupt injection.

This get's rid of the ugly special handling for cpu timer and clock
comparator interrupts. And we really only store the parameters as
defined by the PoP.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 13 ++++++----
 target/s390x/excp_helper.c | 63 +++++++++++++++++++++++-----------------------
 target/s390x/helper.c      | 12 ++-------
 target/s390x/internal.h    |  2 ++
 target/s390x/interrupt.c   | 18 ++++++++++++-
 5 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7e864c8478..e32f87a2f1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -404,11 +404,14 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
-#define INTERRUPT_EXT        (1 << 0)
-#define INTERRUPT_TOD        (1 << 1)
-#define INTERRUPT_CPUTIMER   (1 << 2)
-#define INTERRUPT_IO         (1 << 3)
-#define INTERRUPT_MCHK       (1 << 4)
+#define INTERRUPT_IO                     (1 << 0)
+#define INTERRUPT_MCHK                   (1 << 1)
+#define INTERRUPT_EXT_SERVICE            (1 << 2)
+#define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
+#define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
+#define INTERRUPT_EXT                    (INTERRUPT_EXT_SERVICE | \
+                                          INTERRUPT_EXT_CPU_TIMER | \
+                                          INTERRUPT_EXT_CLOCK_COMPARATOR)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index aa0cbf67ac..8521043bf2 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -246,29 +246,42 @@ static void do_ext_interrupt(CPUS390XState *env)
         cpu_abort(CPU(cpu), "Ext int w/o ext mask\n");
     }
 
-    if (env->ext_index < 0 || env->ext_index >= MAX_EXT_QUEUE) {
-        cpu_abort(CPU(cpu), "Ext queue overrun: %d\n", env->ext_index);
-    }
-
-    q = &env->ext_queue[env->ext_index];
     lowcore = cpu_map_lowcore(env);
 
-    lowcore->ext_int_code = cpu_to_be16(q->code);
-    lowcore->ext_params = cpu_to_be32(q->param);
-    lowcore->ext_params2 = cpu_to_be64(q->param64);
-    lowcore->external_old_psw.mask = cpu_to_be64(get_psw_mask(env));
-    lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
-    lowcore->cpu_addr = cpu_to_be16(env->core_id | VIRTIO_SUBCODE_64);
+    if (env->pending_int & INTERRUPT_EXT_CLOCK_COMPARATOR) {
+        lowcore->ext_int_code = cpu_to_be16(EXT_CLOCK_COMP);
+        lowcore->cpu_addr = 0;
+        env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
+    } else if (env->pending_int & INTERRUPT_EXT_CPU_TIMER) {
+        lowcore->ext_int_code = cpu_to_be16(EXT_CPU_TIMER);
+        lowcore->cpu_addr = 0;
+        env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
+    } else if (env->pending_int & INTERRUPT_EXT_SERVICE) {
+        g_assert(env->ext_index >= 0);
+        /*
+         * FIXME: floating IRQs should be considered by all CPUs and
+         *        shuld not get cleared by CPU reset.
+         */
+        q = &env->ext_queue[env->ext_index];
+        lowcore->ext_int_code = cpu_to_be16(q->code);
+        lowcore->ext_params = cpu_to_be32(q->param);
+        lowcore->ext_params2 = cpu_to_be64(q->param64);
+        lowcore->cpu_addr = cpu_to_be16(env->core_id | VIRTIO_SUBCODE_64);
+        env->ext_index--;
+        if (env->ext_index == -1) {
+            env->pending_int &= ~INTERRUPT_EXT_SERVICE;
+        }
+    } else {
+        g_assert_not_reached();
+    }
+
     mask = be64_to_cpu(lowcore->external_new_psw.mask);
     addr = be64_to_cpu(lowcore->external_new_psw.addr);
+    lowcore->external_old_psw.mask = cpu_to_be64(get_psw_mask(env));
+    lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
 
     cpu_unmap_lowcore(lowcore);
 
-    env->ext_index--;
-    if (env->ext_index == -1) {
-        env->pending_int &= ~INTERRUPT_EXT;
-    }
-
     DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
             env->psw.mask, env->psw.addr);
 
@@ -421,21 +434,9 @@ void s390_cpu_do_interrupt(CPUState *cs)
     }
     /* handle external interrupts */
     if ((env->psw.mask & PSW_MASK_EXT) &&
-        cs->exception_index == -1) {
-        if (env->pending_int & INTERRUPT_EXT) {
-            /* code is already in env */
-            cs->exception_index = EXCP_EXT;
-        } else if (env->pending_int & INTERRUPT_TOD) {
-            cpu_inject_ext(cpu, 0x1004, 0, 0);
-            cs->exception_index = EXCP_EXT;
-            env->pending_int &= ~INTERRUPT_EXT;
-            env->pending_int &= ~INTERRUPT_TOD;
-        } else if (env->pending_int & INTERRUPT_CPUTIMER) {
-            cpu_inject_ext(cpu, 0x1005, 0, 0);
-            cs->exception_index = EXCP_EXT;
-            env->pending_int &= ~INTERRUPT_EXT;
-            env->pending_int &= ~INTERRUPT_TOD;
-        }
+        cs->exception_index == -1 &&
+        (env->pending_int & INTERRUPT_EXT)) {
+        cs->exception_index = EXCP_EXT;
     }
     /* handle I/O interrupts */
     if ((env->psw.mask & PSW_MASK_IO) &&
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 97adbcc86d..e22b93258b 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -51,20 +51,12 @@
 #ifndef CONFIG_USER_ONLY
 void s390x_tod_timer(void *opaque)
 {
-    S390CPU *cpu = opaque;
-    CPUS390XState *env = &cpu->env;
-
-    env->pending_int |= INTERRUPT_TOD;
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    cpu_inject_clock_comparator((S390CPU *) opaque);
 }
 
 void s390x_cpu_timer(void *opaque)
 {
-    S390CPU *cpu = opaque;
-    CPUS390XState *env = &cpu->env;
-
-    env->pending_int |= INTERRUPT_CPUTIMER;
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+    cpu_inject_cpu_timer((S390CPU *) opaque);
 }
 #endif
 
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 14bf3ea5e2..4dda5cf2f1 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -362,6 +362,8 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64);
+void cpu_inject_clock_comparator(S390CPU *cpu);
+void cpu_inject_cpu_timer(S390CPU *cpu);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 058e219fe5..b9c30f86d7 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -71,7 +71,23 @@ void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
     env->ext_queue[env->ext_index].param = param;
     env->ext_queue[env->ext_index].param64 = param64;
 
-    env->pending_int |= INTERRUPT_EXT;
+    env->pending_int |= INTERRUPT_EXT_SERVICE;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+}
+
+void cpu_inject_clock_comparator(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    env->pending_int |= INTERRUPT_EXT_CLOCK_COMPARATOR;
+    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
+}
+
+void cpu_inject_cpu_timer(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+
+    env->pending_int |= INTERRUPT_EXT_CPU_TIMER;
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
-- 
2.13.5
