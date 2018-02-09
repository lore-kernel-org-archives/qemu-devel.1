Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wE-0001td-8k
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wC-0005xI-Sv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:46 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:00 +0100
Message-Id: <20180209092524.31348-6-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/29] s390x/tcg: simplify machine check handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We currently only support CRW machine checks. This is a preparation for
real floating interrupt support.

Get rid of the queue and handle it via the bit INTERRUPT_MCHK. We don't
rename it for now, as it will be soon gone (when moving crw machine checks
into the flic).

Please note that this is the same way also KVM handles it: only one
instance of a machine check can be pending at a time. So no need for a
queue.

While at it, make sure we try to deliver only if env->cregs[14]
actually indicates that CRWs are accepted.

Drop two unused defines on the way (we already have PSW_MASK_...).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c         |  2 --
 target/s390x/cpu.h         | 10 ----------
 target/s390x/excp_helper.c | 29 +++++------------------------
 target/s390x/interrupt.c   | 18 +++++++-----------
 4 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 979469dc3c..243804fbfc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -119,7 +119,6 @@ static void s390_cpu_initial_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
-    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
@@ -156,7 +155,6 @@ static void s390_cpu_full_reset(CPUState *s)
     for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
         env->io_index[i] = -1;
     }
-    env->mchk_index = -1;
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a1123ad621..f32a5ad6c9 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -54,10 +54,6 @@
 #define MMU_USER_IDX 0
 
 #define MAX_IO_QUEUE 16
-#define MAX_MCHK_QUEUE 16
-
-#define PSW_MCHK_MASK 0x0004000000000000
-#define PSW_IO_MASK 0x0200000000000000
 
 #define S390_MAX_CPUS 248
 
@@ -73,10 +69,6 @@ typedef struct IOIntQueue {
     uint32_t word;
 } IOIntQueue;
 
-typedef struct MchkQueue {
-    uint16_t type;
-} MchkQueue;
-
 struct CPUS390XState {
     uint64_t regs[16];     /* GP registers */
     /*
@@ -123,14 +115,12 @@ struct CPUS390XState {
     uint64_t cregs[16]; /* control registers */
 
     IOIntQueue io_queue[MAX_IO_QUEUE][8];
-    MchkQueue mchk_queue[MAX_MCHK_QUEUE];
 
     int pending_int;
     uint32_t service_param;
     uint16_t external_call_addr;
     DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
     int io_index[8];
-    int mchk_index;
 
     uint64_t ckc;
     uint64_t cputm;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 97caa7f418..0cbc4051d1 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -368,30 +368,16 @@ static void do_io_interrupt(CPUS390XState *env)
 
 static void do_mchk_interrupt(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
     LowCore *lowcore;
-    MchkQueue *q;
     int i;
 
-    if (!(env->psw.mask & PSW_MASK_MCHECK)) {
-        cpu_abort(CPU(cpu), "Machine check w/o mchk mask\n");
-    }
+    /* for now we only support channel report machine checks (floating) */
+    g_assert(env->psw.mask & PSW_MASK_MCHECK);
+    g_assert(env->cregs[14] & CR14_CHANNEL_REPORT_SC);
 
-    if (env->mchk_index < 0 || env->mchk_index >= MAX_MCHK_QUEUE) {
-        cpu_abort(CPU(cpu), "Mchk queue overrun: %d\n", env->mchk_index);
-    }
-
-    q = &env->mchk_queue[env->mchk_index];
-
-    if (q->type != 1) {
-        /* Don't know how to handle this... */
-        cpu_abort(CPU(cpu), "Unknown machine check type %d\n", q->type);
-    }
-    if (!(env->cregs[14] & (1 << 28))) {
-        /* CRW machine checks disabled */
-        return;
-    }
+    g_assert(env->pending_int & INTERRUPT_MCHK);
+    env->pending_int &= ~INTERRUPT_MCHK;
 
     lowcore = cpu_map_lowcore(env);
 
@@ -418,11 +404,6 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
     cpu_unmap_lowcore(lowcore);
 
-    env->mchk_index--;
-    if (env->mchk_index == -1) {
-        env->pending_int &= ~INTERRUPT_MCHK;
-    }
-
     DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
             env->psw.mask, env->psw.addr);
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 39c026b8b5..380222b394 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -162,16 +162,6 @@ static void cpu_inject_crw_mchk(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
 
-    if (env->mchk_index == MAX_MCHK_QUEUE - 1) {
-        /* ugh - can't queue anymore. Let's drop. */
-        return;
-    }
-
-    env->mchk_index++;
-    assert(env->mchk_index < MAX_MCHK_QUEUE);
-
-    env->mchk_queue[env->mchk_index].type = 1;
-
     env->pending_int |= INTERRUPT_MCHK;
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
@@ -225,7 +215,13 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
         return false;
     }
 
-    return env->pending_int & INTERRUPT_MCHK;
+    /* for now we only support channel report machine checks (floating) */
+    if ((env->pending_int & INTERRUPT_MCHK) &&
+        (env->cregs[14] & CR14_CHANNEL_REPORT_SC)) {
+        return true;
+    }
+
+    return false;
 }
 
 bool s390_cpu_has_ext_int(S390CPU *cpu)
-- 
2.13.6
