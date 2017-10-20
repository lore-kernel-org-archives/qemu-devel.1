Received: from eggs.gnu.org ([2001:4830:134:3::10]:58380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsy-00025X-HQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsx-0002na-F0
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:44 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:36 +0200
Message-Id: <20171020115418.2050-5-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/46] s390x/tcg: cleanup service interrupt
 injection
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

There are still some leftovers from old virtio interrupts in there.
Most importantly, we don't have to queue service interrupts anymore.
Just like KVM, we can simply multiplex the SCLP service interrupts and
avoid the queue.

Also, now only valid parameters/cpu_addr will be stored on service
interrupts.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-3-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c         |  2 --
 target/s390x/cpu.h         | 10 +---------
 target/s390x/excp_helper.c | 16 +++++-----------
 target/s390x/internal.h    |  2 --
 target/s390x/interrupt.c   | 18 ++++--------------
 5 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3fdf9bae70..77d55c9e1e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -107,7 +107,6 @@ static void s390_cpu_initial_reset(CPUState *s)
     env->gbea = 1;
 
     env->pfault_token = -1UL;
-    env->ext_index = -1;
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
@@ -145,7 +144,6 @@ static void s390_cpu_full_reset(CPUState *s)
     env->gbea = 1;
 
     env->pfault_token = -1UL;
-    env->ext_index = -1;
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e32f87a2f1..7bea97a2d7 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -53,7 +53,6 @@
 
 #define MMU_USER_IDX 0
 
-#define MAX_EXT_QUEUE 16
 #define MAX_IO_QUEUE 16
 #define MAX_MCHK_QUEUE 16
 
@@ -67,12 +66,6 @@ typedef struct PSW {
     uint64_t addr;
 } PSW;
 
-typedef struct ExtQueue {
-    uint32_t code;
-    uint32_t param;
-    uint32_t param64;
-} ExtQueue;
-
 typedef struct IOIntQueue {
     uint16_t id;
     uint16_t nr;
@@ -128,12 +121,11 @@ struct CPUS390XState {
 
     uint64_t cregs[16]; /* control registers */
 
-    ExtQueue ext_queue[MAX_EXT_QUEUE];
     IOIntQueue io_queue[MAX_IO_QUEUE][8];
     MchkQueue mchk_queue[MAX_MCHK_QUEUE];
 
     int pending_int;
-    int ext_index;
+    uint32_t service_param;
     int io_index[8];
     int mchk_index;
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index b58486b98b..f5851069b5 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -241,7 +241,6 @@ static void do_ext_interrupt(CPUS390XState *env)
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
     LowCore *lowcore;
-    ExtQueue *q;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         cpu_abort(CPU(cpu), "Ext int w/o ext mask\n");
@@ -258,20 +257,15 @@ static void do_ext_interrupt(CPUS390XState *env)
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
     } else if (env->pending_int & INTERRUPT_EXT_SERVICE) {
-        g_assert(env->ext_index >= 0);
         /*
          * FIXME: floating IRQs should be considered by all CPUs and
          *        shuld not get cleared by CPU reset.
          */
-        q = &env->ext_queue[env->ext_index];
-        lowcore->ext_int_code = cpu_to_be16(q->code);
-        lowcore->ext_params = cpu_to_be32(q->param);
-        lowcore->ext_params2 = cpu_to_be64(q->param64);
-        lowcore->cpu_addr = cpu_to_be16(env->core_id | VIRTIO_SUBCODE_64);
-        env->ext_index--;
-        if (env->ext_index == -1) {
-            env->pending_int &= ~INTERRUPT_EXT_SERVICE;
-        }
+        lowcore->ext_int_code = cpu_to_be16(EXT_SERVICE);
+        lowcore->ext_params = cpu_to_be32(env->service_param);
+        lowcore->cpu_addr = 0;
+        env->service_param = 0;
+        env->pending_int &= ~INTERRUPT_EXT_SERVICE;
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 4dda5cf2f1..eaa071a183 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -360,8 +360,6 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 
 /* interrupt.c */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
-void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
-                    uint64_t param64);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index b9c30f86d7..edcc2e9d2d 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -54,22 +54,12 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
-                    uint64_t param64)
+static void cpu_inject_service(S390CPU *cpu, uint32_t param)
 {
     CPUS390XState *env = &cpu->env;
 
-    if (env->ext_index == MAX_EXT_QUEUE - 1) {
-        /* ugh - can't queue anymore. Let's drop. */
-        return;
-    }
-
-    env->ext_index++;
-    assert(env->ext_index < MAX_EXT_QUEUE);
-
-    env->ext_queue[env->ext_index].code = code;
-    env->ext_queue[env->ext_index].param = param;
-    env->ext_queue[env->ext_index].param64 = param64;
+    /* multiplexing is good enough for sclp - kvm does it internally as well*/
+    env->service_param |= param;
 
     env->pending_int |= INTERRUPT_EXT_SERVICE;
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
@@ -145,7 +135,7 @@ void s390_sclp_extint(uint32_t parm)
     } else {
         S390CPU *dummy_cpu = s390_cpu_addr2state(0);
 
-        cpu_inject_ext(dummy_cpu, EXT_SERVICE, parm, 0);
+        cpu_inject_service(dummy_cpu, parm);
     }
 }
 
-- 
2.13.6
