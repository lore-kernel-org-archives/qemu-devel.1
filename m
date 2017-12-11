Received: from eggs.gnu.org ([2001:4830:134:3::10]:43716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORN-0004ah-2Z
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORK-0007QC-F0
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:17 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:33 +0100
Message-Id: <20171211134740.8235-9-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 08/15] s390x/flic: make floating
 interrupts on TCG actually floating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Move floating interrupt handling into the flic. Floating interrupts
will now be considered by all CPUs, not just CPU #0. While at it, convert
I/O interrupts to use a list and make sure we properly consider I/O
sub-classes in s390_cpu_has_io_int().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c          | 144 ++++++++++++++++++++++++++++++++++++++++---
 include/hw/s390x/s390_flic.h |  41 ++++++++++++
 target/s390x/cpu.c           |   8 ---
 target/s390x/cpu.h           |  22 -------
 target/s390x/excp_helper.c   |  97 ++++++++++-------------------
 target/s390x/interrupt.c     |  52 ++--------------
 6 files changed, 212 insertions(+), 152 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 8d521c415a..3a28bee90c 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -131,40 +131,153 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
     return 0;
 }
 
+static void qemu_s390_flic_notify(uint32_t type)
+{
+    CPUState *cs;
+
+    /*
+     * We have to make all CPUs see CPU_INTERRUPT_HARD, so they might
+     * consider it. TODO: don't kick/wakeup all VCPUs but try to be
+     * smarter (using the interrupt type).
+     */
+    CPU_FOREACH(cs) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+uint32_t qemu_s390_flic_dequeue_service(QEMUS390FLICState *flic)
+{
+    uint32_t tmp;
+
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(flic->pending & FLIC_PENDING_SERVICE);
+    tmp = flic->service_param;
+    flic->service_param = 0;
+    flic->pending &= ~FLIC_PENDING_SERVICE;
+
+    return tmp;
+}
+
+/* caller has to free the returned object */
+QEMUS390FlicIO *qemu_s390_flic_dequeue_io(QEMUS390FLICState *flic, uint64_t cr6)
+{
+    QEMUS390FlicIO *io;
+    uint8_t isc;
+
+    g_assert(qemu_mutex_iothread_locked());
+    if (!(flic->pending & CR6_TO_PENDING_IO(cr6))) {
+        return NULL;
+    }
+
+    for (isc = 0; isc < 8; isc++) {
+        if (QLIST_EMPTY(&flic->io[isc]) || !(cr6 & ISC_TO_ISC_BITS(isc))) {
+            continue;
+        }
+        io = QLIST_FIRST(&flic->io[isc]);
+        QLIST_REMOVE(io, next);
+
+        /* update our indicator bit */
+        if (QLIST_EMPTY(&flic->io[isc])) {
+            flic->pending &= ~ISC_TO_PENDING_IO(isc);
+        }
+        return io;
+    }
+
+    return NULL;
+}
+
+void qemu_s390_flic_dequeue_crw_mchk(QEMUS390FLICState *flic)
+{
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(flic->pending & FLIC_PENDING_MCHK_CR);
+    flic->pending &= ~FLIC_PENDING_MCHK_CR;
+}
+
 static void qemu_s390_inject_service(S390FLICState *fs, uint32_t parm)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
 
-    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    g_assert(qemu_mutex_iothread_locked());
+    /* multiplexing is good enough for sclp - kvm does it internally as well */
+    flic->service_param |= parm;
+    flic->pending |= FLIC_PENDING_SERVICE;
 
-    /* FIXME: don't inject into dummy CPU */
-    cpu_inject_service(dummy_cpu, parm);
+    qemu_s390_flic_notify(FLIC_PENDING_SERVICE);
 }
 
 static void qemu_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
                                 uint16_t subchannel_nr, uint32_t io_int_parm,
                                 uint32_t io_int_word)
 {
-    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    const uint8_t isc = IO_INT_WORD_ISC(io_int_word);
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+    QEMUS390FlicIO *io;
 
-    /* FIXME: don't inject into dummy CPU */
-    cpu_inject_io(dummy_cpu, subchannel_id, subchannel_nr, io_int_parm,
-                  io_int_word);
+    g_assert(qemu_mutex_iothread_locked());
+    io = g_new0(QEMUS390FlicIO, 1);
+    io->id = subchannel_id;
+    io->nr = subchannel_nr;
+    io->parm = io_int_parm;
+    io->word = io_int_word;
+
+    QLIST_INSERT_HEAD(&flic->io[isc], io, next);
+    flic->pending |= ISC_TO_PENDING_IO(isc);
+
+    qemu_s390_flic_notify(ISC_TO_PENDING_IO(isc));
 }
 
 static void qemu_s390_inject_crw_mchk(S390FLICState *fs)
 {
-    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(fs);
+
+    g_assert(qemu_mutex_iothread_locked());
+    flic->pending |= FLIC_PENDING_MCHK_CR;
+
+    qemu_s390_flic_notify(FLIC_PENDING_MCHK_CR);
+}
+
+bool qemu_s390_flic_has_service(QEMUS390FLICState *flic)
+{
+    /* called without lock via cc->has_work, will be validated under lock */
+    return !!(flic->pending & FLIC_PENDING_SERVICE);
+}
+
+bool qemu_s390_flic_has_io(QEMUS390FLICState *flic, uint64_t cr6)
+{
+    /* called without lock via cc->has_work, will be validated under lock */
+    return !!(flic->pending & CR6_TO_PENDING_IO(cr6));
+}
+
+bool qemu_s390_flic_has_crw_mchk(QEMUS390FLICState *flic)
+{
+    /* called without lock via cc->has_work, will be validated under lock */
+    return !!(flic->pending & FLIC_PENDING_MCHK_CR);
+}
 
-    /* FIXME: don't inject into dummy CPU */
-    cpu_inject_crw_mchk(dummy_cpu);
+bool qemu_s390_flic_has_any(QEMUS390FLICState *flic)
+{
+    g_assert(qemu_mutex_iothread_locked());
+    return !!flic->pending;
 }
 
 static void qemu_s390_flic_reset(DeviceState *dev)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(dev);
+    QEMUS390FlicIO *cur, *next;
+    int isc;
 
+    g_assert(qemu_mutex_iothread_locked());
     flic->simm = 0;
     flic->nimm = 0;
+    flic->pending = 0;
+
+    /* remove all pending io interrupts */
+    for (isc = 0; isc < 8; isc++) {
+        QLIST_FOREACH_SAFE(cur, &flic->io[isc], next, next) {
+            QLIST_REMOVE(cur, next);
+            g_free(cur);
+        }
+    }
 }
 
 bool ais_needed(void *opaque)
@@ -186,6 +299,16 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
     }
 };
 
+static void qemu_s390_flic_instance_init(Object *obj)
+{
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(obj);
+    int isc;
+
+    for (isc = 0; isc < 8; isc++) {
+        QLIST_INIT(&flic->io[isc]);
+    }
+}
+
 static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -237,6 +360,7 @@ static const TypeInfo qemu_s390_flic_info = {
     .name          = TYPE_QEMU_S390_FLIC,
     .parent        = TYPE_S390_FLIC_COMMON,
     .instance_size = sizeof(QEMUS390FLICState),
+    .instance_init = qemu_s390_flic_instance_init,
     .class_init    = qemu_s390_flic_class_init,
 };
 
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index d0538134b7..9be0b9ab11 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -16,6 +16,7 @@
 #include "hw/sysbus.h"
 #include "hw/s390x/adapter.h"
 #include "hw/virtio/virtio.h"
+#include "qemu/queue.h"
 
 /*
  * Reserve enough gsis to accommodate all virtio devices.
@@ -85,12 +86,52 @@ typedef struct S390FLICStateClass {
 #define SIC_IRQ_MODE_SINGLE 1
 #define AIS_MODE_MASK(isc) (0x80 >> isc)
 
+#define ISC_TO_PENDING_IO(_isc) (0x80 >> (_isc))
+#define CR6_TO_PENDING_IO(_cr6) (((_cr6) >> 24) & 0xff)
+
+/* the ISC bits are organized in a way that above makros work */
+#define FLIC_PENDING_IO_ISC7            (1 << 0)
+#define FLIC_PENDING_IO_ISC6            (1 << 1)
+#define FLIC_PENDING_IO_ISC5            (1 << 2)
+#define FLIC_PENDING_IO_ISC4            (1 << 3)
+#define FLIC_PENDING_IO_ISC3            (1 << 4)
+#define FLIC_PENDING_IO_ISC2            (1 << 5)
+#define FLIC_PENDING_IO_ISC1            (1 << 6)
+#define FLIC_PENDING_IO_ISC0            (1 << 7)
+#define FLIC_PENDING_SERVICE            (1 << 8)
+#define FLIC_PENDING_MCHK_CR            (1 << 9)
+
+#define FLIC_PENDING_IO (FLIC_PENDING_IO_ISC0 | FLIC_PENDING_IO_ISC1 | \
+                         FLIC_PENDING_IO_ISC2 | FLIC_PENDING_IO_ISC3 | \
+                         FLIC_PENDING_IO_ISC4 | FLIC_PENDING_IO_ISC5 | \
+                         FLIC_PENDING_IO_ISC6 | FLIC_PENDING_IO_ISC7)
+
+typedef struct QEMUS390FlicIO {
+    uint16_t id;
+    uint16_t nr;
+    uint32_t parm;
+    uint32_t word;
+    QLIST_ENTRY(QEMUS390FlicIO) next;
+} QEMUS390FlicIO;
+
 typedef struct QEMUS390FLICState {
     S390FLICState parent_obj;
+    uint32_t pending;
+    uint32_t service_param;
     uint8_t simm;
     uint8_t nimm;
+    QLIST_HEAD(, QEMUS390FlicIO) io[8];
 } QEMUS390FLICState;
 
+uint32_t qemu_s390_flic_dequeue_service(QEMUS390FLICState *flic);
+QEMUS390FlicIO *qemu_s390_flic_dequeue_io(QEMUS390FLICState *flic,
+                                          uint64_t cr6);
+void qemu_s390_flic_dequeue_crw_mchk(QEMUS390FLICState *flic);
+bool qemu_s390_flic_has_service(QEMUS390FLICState *flic);
+bool qemu_s390_flic_has_io(QEMUS390FLICState *fs, uint64_t cr6);
+bool qemu_s390_flic_has_crw_mchk(QEMUS390FLICState *flic);
+bool qemu_s390_flic_has_any(QEMUS390FLICState *flic);
+
 void s390_flic_init(void);
 
 S390FLICState *s390_get_flic(void);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index bb4fc0f879..1de7cc6c56 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -99,7 +99,6 @@ static void s390_cpu_initial_reset(CPUState *s)
 {
     S390CPU *cpu = S390_CPU(s);
     CPUS390XState *env = &cpu->env;
-    int i;
 
     s390_cpu_reset(s);
     /* initial reset does not clear everything! */
@@ -115,9 +114,6 @@ static void s390_cpu_initial_reset(CPUState *s)
     env->gbea = 1;
 
     env->pfault_token = -1UL;
-    for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
-        env->io_index[i] = -1;
-    }
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
@@ -135,7 +131,6 @@ static void s390_cpu_full_reset(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
-    int i;
 
     scc->parent_reset(s);
     cpu->env.sigp_order = 0;
@@ -151,9 +146,6 @@ static void s390_cpu_full_reset(CPUState *s)
     env->gbea = 1;
 
     env->pfault_token = -1UL;
-    for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
-        env->io_index[i] = -1;
-    }
 
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 9df851b1e8..2a37ef5050 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -53,8 +53,6 @@
 
 #define MMU_USER_IDX 0
 
-#define MAX_IO_QUEUE 16
-
 #define S390_MAX_CPUS 248
 
 typedef struct PSW {
@@ -62,13 +60,6 @@ typedef struct PSW {
     uint64_t addr;
 } PSW;
 
-typedef struct IOIntQueue {
-    uint16_t id;
-    uint16_t nr;
-    uint32_t parm;
-    uint32_t word;
-} IOIntQueue;
-
 struct CPUS390XState {
     uint64_t regs[16];     /* GP registers */
     /*
@@ -113,13 +104,9 @@ struct CPUS390XState {
 
     uint64_t cregs[16]; /* control registers */
 
-    IOIntQueue io_queue[MAX_IO_QUEUE][8];
-
     int pending_int;
-    uint32_t service_param;
     uint16_t external_call_addr;
     DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
-    int io_index[8];
 
     uint64_t ckc;
     uint64_t cputm;
@@ -398,9 +385,6 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
-#define INTERRUPT_IO                     (1 << 0)
-#define INTERRUPT_MCHK                   (1 << 1)
-#define INTERRUPT_EXT_SERVICE            (1 << 2)
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
@@ -740,12 +724,6 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
-/* FIXME: remove once we have proper floating interrupts in TCG */
-void cpu_inject_service(S390CPU *cpu, uint32_t param);
-void cpu_inject_crw_mchk(S390CPU *cpu);
-void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
-                   uint16_t subchannel_number, uint32_t io_int_parm,
-                   uint32_t io_int_word);
 
 /* mmu_helper.c */
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index eeffb49f63..24dfd0333b 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -29,6 +29,7 @@
 #include "exec/address-spaces.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "hw/s390x/s390_flic.h"
 #endif
 
 /* #define DEBUG_S390 */
@@ -237,6 +238,7 @@ static void do_svc_interrupt(CPUS390XState *env)
 
 static void do_ext_interrupt(CPUS390XState *env)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     S390CPU *cpu = s390_env_get_cpu(env);
     uint64_t mask, addr;
     uint16_t cpu_addr;
@@ -273,17 +275,14 @@ static void do_ext_interrupt(CPUS390XState *env)
         lowcore->ext_int_code = cpu_to_be16(EXT_CPU_TIMER);
         lowcore->cpu_addr = 0;
         env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
-    } else if ((env->pending_int & INTERRUPT_EXT_SERVICE) &&
+    } else if (qemu_s390_flic_has_service(flic) &&
                (env->cregs[0] & CR0_SERVICE_SC)) {
-        /*
-         * FIXME: floating IRQs should be considered by all CPUs and
-         *        shuld not get cleared by CPU reset.
-         */
+        uint32_t param;
+
+        param = qemu_s390_flic_dequeue_service(flic);
         lowcore->ext_int_code = cpu_to_be16(EXT_SERVICE);
-        lowcore->ext_params = cpu_to_be32(env->service_param);
+        lowcore->ext_params = cpu_to_be32(param);
         lowcore->cpu_addr = 0;
-        env->service_param = 0;
-        env->pending_int &= ~INTERRUPT_EXT_SERVICE;
     } else {
         g_assert_not_reached();
     }
@@ -303,71 +302,37 @@ static void do_ext_interrupt(CPUS390XState *env)
 
 static void do_io_interrupt(CPUS390XState *env)
 {
-    S390CPU *cpu = s390_env_get_cpu(env);
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    uint64_t mask, addr;
+    QEMUS390FlicIO *io;
     LowCore *lowcore;
-    IOIntQueue *q;
-    uint8_t isc;
-    int disable = 1;
-    int found = 0;
-
-    if (!(env->psw.mask & PSW_MASK_IO)) {
-        cpu_abort(CPU(cpu), "I/O int w/o I/O mask\n");
-    }
-
-    for (isc = 0; isc < ARRAY_SIZE(env->io_index); isc++) {
-        uint64_t isc_bits;
-
-        if (env->io_index[isc] < 0) {
-            continue;
-        }
-        if (env->io_index[isc] >= MAX_IO_QUEUE) {
-            cpu_abort(CPU(cpu), "I/O queue overrun for isc %d: %d\n",
-                      isc, env->io_index[isc]);
-        }
-
-        q = &env->io_queue[env->io_index[isc]][isc];
-        isc_bits = ISC_TO_ISC_BITS(IO_INT_WORD_ISC(q->word));
-        if (!(env->cregs[6] & isc_bits)) {
-            disable = 0;
-            continue;
-        }
-        if (!found) {
-            uint64_t mask, addr;
 
-            found = 1;
-            lowcore = cpu_map_lowcore(env);
+    g_assert(env->psw.mask & PSW_MASK_IO);
+    io = qemu_s390_flic_dequeue_io(flic, env->cregs[6]);
+    g_assert(io);
 
-            lowcore->subchannel_id = cpu_to_be16(q->id);
-            lowcore->subchannel_nr = cpu_to_be16(q->nr);
-            lowcore->io_int_parm = cpu_to_be32(q->parm);
-            lowcore->io_int_word = cpu_to_be32(q->word);
-            lowcore->io_old_psw.mask = cpu_to_be64(get_psw_mask(env));
-            lowcore->io_old_psw.addr = cpu_to_be64(env->psw.addr);
-            mask = be64_to_cpu(lowcore->io_new_psw.mask);
-            addr = be64_to_cpu(lowcore->io_new_psw.addr);
-
-            cpu_unmap_lowcore(lowcore);
-
-            env->io_index[isc]--;
+    lowcore = cpu_map_lowcore(env);
 
-            DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
-                    env->psw.mask, env->psw.addr);
-            load_psw(env, mask, addr);
-        }
-        if (env->io_index[isc] >= 0) {
-            disable = 0;
-        }
-        continue;
-    }
+    lowcore->subchannel_id = cpu_to_be16(io->id);
+    lowcore->subchannel_nr = cpu_to_be16(io->nr);
+    lowcore->io_int_parm = cpu_to_be32(io->parm);
+    lowcore->io_int_word = cpu_to_be32(io->word);
+    lowcore->io_old_psw.mask = cpu_to_be64(get_psw_mask(env));
+    lowcore->io_old_psw.addr = cpu_to_be64(env->psw.addr);
+    mask = be64_to_cpu(lowcore->io_new_psw.mask);
+    addr = be64_to_cpu(lowcore->io_new_psw.addr);
 
-    if (disable) {
-        env->pending_int &= ~INTERRUPT_IO;
-    }
+    cpu_unmap_lowcore(lowcore);
+    g_free(io);
 
+    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__, env->psw.mask,
+            env->psw.addr);
+    load_psw(env, mask, addr);
 }
 
 static void do_mchk_interrupt(CPUS390XState *env)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     uint64_t mask, addr;
     LowCore *lowcore;
     int i;
@@ -376,8 +341,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
     g_assert(env->psw.mask & PSW_MASK_MCHECK);
     g_assert(env->cregs[14] & CR0_SERVICE_SC);
 
-    g_assert(env->pending_int & INTERRUPT_MCHK);
-    env->pending_int &= ~INTERRUPT_MCHK;
+    qemu_s390_flic_dequeue_crw_mchk(flic);
 
     lowcore = cpu_map_lowcore(env);
 
@@ -412,6 +376,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
 void s390_cpu_do_interrupt(CPUState *cs)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
@@ -474,7 +439,7 @@ try_deliver:
     cs->exception_index = -1;
 
     /* we might still have pending interrupts, but not deliverable */
-    if (!env->pending_int) {
+    if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
     }
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 9fce176763..5f6d3c81cf 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -58,17 +58,6 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void cpu_inject_service(S390CPU *cpu, uint32_t param)
-{
-    CPUS390XState *env = &cpu->env;
-
-    /* multiplexing is good enough for sclp - kvm does it internally as well*/
-    env->service_param |= param;
-
-    env->pending_int |= INTERRUPT_EXT_SERVICE;
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-}
-
 void cpu_inject_clock_comparator(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
@@ -137,38 +126,6 @@ void cpu_inject_stop(S390CPU *cpu)
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
-void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
-                   uint16_t subchannel_number, uint32_t io_int_parm,
-                   uint32_t io_int_word)
-{
-    CPUS390XState *env = &cpu->env;
-    int isc = IO_INT_WORD_ISC(io_int_word);
-
-    if (env->io_index[isc] == MAX_IO_QUEUE - 1) {
-        /* ugh - can't queue anymore. Let's drop. */
-        return;
-    }
-
-    env->io_index[isc]++;
-    assert(env->io_index[isc] < MAX_IO_QUEUE);
-
-    env->io_queue[env->io_index[isc]][isc].id = subchannel_id;
-    env->io_queue[env->io_index[isc]][isc].nr = subchannel_number;
-    env->io_queue[env->io_index[isc]][isc].parm = io_int_parm;
-    env->io_queue[env->io_index[isc]][isc].word = io_int_word;
-
-    env->pending_int |= INTERRUPT_IO;
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-}
-
-void cpu_inject_crw_mchk(S390CPU *cpu)
-{
-    CPUS390XState *env = &cpu->env;
-
-    env->pending_int |= INTERRUPT_MCHK;
-    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
-}
-
 /*
  * All of the following interrupts are floating, i.e. not per-vcpu.
  * We just need a dummy cpustate in order to be able to inject in the
@@ -201,6 +158,7 @@ void s390_crw_mchk(void)
 
 bool s390_cpu_has_mcck_int(S390CPU *cpu)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
@@ -208,7 +166,7 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
     }
 
     /* for now we only support channel report machine checks (floating) */
-    if ((env->pending_int & INTERRUPT_MCHK) &&
+    if (qemu_s390_flic_has_crw_mchk(flic) &&
         (env->cregs[14] & CR14_CHANNEL_REPORT_SC)) {
         return true;
     }
@@ -218,6 +176,7 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
 
 bool s390_cpu_has_ext_int(S390CPU *cpu)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
@@ -249,7 +208,7 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
         return true;
     }
 
-    if ((env->pending_int & INTERRUPT_EXT_SERVICE) &&
+    if (qemu_s390_flic_has_service(flic) &&
         (env->cregs[0] & CR0_SERVICE_SC)) {
         return true;
     }
@@ -259,13 +218,14 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
 
 bool s390_cpu_has_io_int(S390CPU *cpu)
 {
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
     CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
         return false;
     }
 
-    return env->pending_int & INTERRUPT_IO;
+    return qemu_s390_flic_has_io(flic, env->cregs[6]);
 }
 
 bool s390_cpu_has_restart_int(S390CPU *cpu)
-- 
2.14.3
