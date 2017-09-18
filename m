Received: from eggs.gnu.org ([2001:4830:134:3::10]:37345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTr-0006u7-Od
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTl-0007nr-L4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTl-0007nC-DW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:01 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:50 +0200
Message-Id: <20170918160012.4317-6-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/27] s390/tcg: turn INTERRUPT_EXT into a
 mask
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

External interrupts are currently all handled like floating external
interrupts, they are queued. Let's prepare for a split of floating
and local interrupts by turning INTERRUPT_EXT into a mask.

While we can have various floating external interrupts of one kind, there
is usually only one (or a fixed number) of the local external interrupts.

So turn INTERRUPT_EXT into a mask and properly indicate the kind of
external interrupt. Floating interrupts will have to moved out of
one CPU instance later once we have SMP support.

This get's rid of the ugly special handling for cpu timer and clock
comparator interrupts. And we really only store the parameters as
defined by the PoP.

We'll introduce external calls and emergency signals in the following
patches.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 13 ++++++----
 target/s390x/excp_helper.c | 65 ++++++++++++++++++++++++----------------------
 target/s390x/helper.c      | 12 ++-------
 target/s390x/internal.h    |  2 ++
 target/s390x/interrupt.c   | 18 ++++++++++++-
 5 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5f539b1057..d4e2aa2f24 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -400,11 +400,14 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
-#define INTERRUPT_EXT        (1 << 0)
-#define INTERRUPT_TOD        (1 << 1)
-#define INTERRUPT_CPUTIMER   (1 << 2)
-#define INTERRUPT_IO         (1 << 3)
-#define INTERRUPT_MCHK       (1 << 4)
+#define INTERRUPT_IO                     (1 << 0)
+#define INTERRUPT_MCHK                   (1 << 1)
+#define INTERRUPT_EXT_FLOATING           (1 << 2)
+#define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
+#define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
+#define INTERRUPT_EXT                    (INTERRUPT_EXT_FLOATING | \
+                                          INTERRUPT_EXT_CPU_TIMER | \
+                                          INTERRUPT_EXT_CLOCK_COMPARATOR)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 470cf8f5bc..46d015f260 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -238,29 +238,44 @@ static void do_ext_interrupt(CPUS390XState *env)
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
+    } else if (env->pending_int | INTERRUPT_EXT_FLOATING) {
+        g_assert(env->ext_index >= 0);
+        /*
+         * FIXME: floating IRQs should be considered by all CPUs and
+         *        shuld not get cleared by CPU reset.
+         */
+        q = &env->ext_queue[env->ext_index];
+        lowcore->ext_int_code = cpu_to_be16(q->code);
+        lowcore->ext_params = cpu_to_be32(q->param);
+        lowcore->ext_params2 = cpu_to_be64(q->param64);
+        lowcore->external_old_psw.mask = cpu_to_be64(get_psw_mask(env));
+        lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
+        lowcore->cpu_addr = cpu_to_be16(env->core_id | VIRTIO_SUBCODE_64);
+        env->ext_index--;
+        if (env->ext_index == -1) {
+            env->pending_int &= ~INTERRUPT_EXT_FLOATING;
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
 
@@ -413,21 +428,9 @@ void s390_cpu_do_interrupt(CPUState *cs)
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
index bc8f83129a..ae4b27a574 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -348,6 +348,8 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64);
+void cpu_inject_clock_comparator(S390CPU *cpu);
+void cpu_inject_cpu_timer(S390CPU *cpu);
 
 
 /* ioinst.c */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 058e219fe5..4ba33c49cb 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -71,7 +71,23 @@ void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
     env->ext_queue[env->ext_index].param = param;
     env->ext_queue[env->ext_index].param64 = param64;
 
-    env->pending_int |= INTERRUPT_EXT;
+    env->pending_int |= INTERRUPT_EXT_FLOATING;
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
