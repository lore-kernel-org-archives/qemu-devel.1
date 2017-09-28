Received: from eggs.gnu.org ([2001:4830:134:3::10]:53252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYe-0003Ye-89
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYd-00030y-16
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYc-00030Z-Oy
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:18 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:40 +0200
Message-Id: <20170928203708.9376-3-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/30] s390x/tcg: cleanup service interrupt
 injection
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

There are still some leftovers from old virtio interrupts in there.
Most importantly, we don't have to queue service interrupts anymore.
Just like KVM, we can simply multiplex the SCLP service interrupts and
avoid the queue.

Also, now only valid parametes/cpu_addr will be stored on service
interrupts.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c         |  2 --
 target/s390x/cpu.h         | 10 +---------
 target/s390x/excp_helper.c | 16 +++++-----------
 target/s390x/internal.h    |  2 --
 target/s390x/interrupt.c   | 18 ++++--------------
 5 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f42e28ea25..e240d99fe6 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -107,7 +107,6 @@ static void s390_cpu_initial_reset(CPUState *s)
     env->gbea = 1;
 
     env->pfault_token = -1UL;
-    env->ext_index = -1;
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
@@ -144,7 +143,6 @@ static void s390_cpu_full_reset(CPUState *s)
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
index 8521043bf2..8228104a49 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -240,7 +240,6 @@ static void do_ext_interrupt(CPUS390XState *env)
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
     LowCore *lowcore;
-    ExtQueue *q;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         cpu_abort(CPU(cpu), "Ext int w/o ext mask\n");
@@ -257,20 +256,15 @@ static void do_ext_interrupt(CPUS390XState *env)
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
index b9c30f86d7..cbc7b7696d 100644
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
+    /* multiplexing is good enough for sclp - also kvm does that internally */
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
2.13.5
