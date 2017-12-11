Received: from eggs.gnu.org ([2001:4830:134:3::10]:43629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORG-0004TP-T7
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORD-0007FR-Ps
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:10 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:31 +0100
Message-Id: <20171211134740.8235-7-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 06/15] s390x/flic: factor out
 injection of floating interrupts
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

Let the flic device handle it internally. This will allow us to later
on store floating interrupts in the flic for the TCG case.

This now also simplifies kvm.c. All that's left is the fallback
interface for floating interrupts, which is no triggered directly via
the flic in case anything goes wrong.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic.c          | 31 ++++++++++++++++++++
 hw/intc/s390_flic_kvm.c      | 63 ++++++++++++++++++++++++++++++++++++----
 include/hw/s390x/s390_flic.h |  5 ++++
 target/s390x/cpu.h           |  7 ++++-
 target/s390x/interrupt.c     | 42 +++++++++++----------------
 target/s390x/kvm-stub.c      | 13 ---------
 target/s390x/kvm.c           | 68 ++++----------------------------------------
 target/s390x/kvm_s390x.h     | 10 +------
 8 files changed, 123 insertions(+), 116 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index a78bdf1d90..8d521c415a 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -131,6 +131,34 @@ static int qemu_s390_inject_airq(S390FLICState *fs, uint8_t type,
     return 0;
 }
 
+static void qemu_s390_inject_service(S390FLICState *fs, uint32_t parm)
+{
+
+    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+
+    /* FIXME: don't inject into dummy CPU */
+    cpu_inject_service(dummy_cpu, parm);
+}
+
+static void qemu_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
+                                uint16_t subchannel_nr, uint32_t io_int_parm,
+                                uint32_t io_int_word)
+{
+    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+
+    /* FIXME: don't inject into dummy CPU */
+    cpu_inject_io(dummy_cpu, subchannel_id, subchannel_nr, io_int_parm,
+                  io_int_word);
+}
+
+static void qemu_s390_inject_crw_mchk(S390FLICState *fs)
+{
+    S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+
+    /* FIXME: don't inject into dummy CPU */
+    cpu_inject_crw_mchk(dummy_cpu);
+}
+
 static void qemu_s390_flic_reset(DeviceState *dev)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(dev);
@@ -172,6 +200,9 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->clear_io_irq = qemu_s390_clear_io_flic;
     fsc->modify_ais_mode = qemu_s390_modify_ais_mode;
     fsc->inject_airq = qemu_s390_inject_airq;
+    fsc->inject_service = qemu_s390_inject_service;
+    fsc->inject_io = qemu_s390_inject_io;
+    fsc->inject_crw_mchk = qemu_s390_inject_crw_mchk;
 }
 
 static Property s390_flic_common_properties[] = {
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 0cb5feab0c..d277ffdd2e 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -111,14 +111,64 @@ static int flic_enqueue_irqs(void *buf, uint64_t len,
     return rc ? -errno : 0;
 }
 
-int kvm_s390_inject_flic(struct kvm_s390_irq *irq)
+static void kvm_s390_inject_flic(S390FLICState *fs, struct kvm_s390_irq *irq)
 {
-    static KVMS390FLICState *flic;
+    static bool use_flic = true;
+    int r;
+
+    if (use_flic) {
+        r = flic_enqueue_irqs(irq, sizeof(*irq), KVM_S390_FLIC(fs));
+        if (r == -ENOSYS) {
+            use_flic = false;
+        }
+        if (!r) {
+            return;
+        }
+    }
+    /* fallback to legacy KVM IOCTL in case FLIC fails */
+    kvm_s390_floating_interrupt_legacy(irq);
+}
+
+static void kvm_s390_inject_service(S390FLICState *fs, uint32_t parm)
+{
+        struct kvm_s390_irq irq = {
+        .type = KVM_S390_INT_SERVICE,
+        .u.ext.ext_params = parm,
+    };
+
+    kvm_s390_inject_flic(fs, &irq);
+}
 
-    if (unlikely(!flic)) {
-        flic = KVM_S390_FLIC(s390_get_flic());
+static void kvm_s390_inject_io(S390FLICState *fs, uint16_t subchannel_id,
+                               uint16_t subchannel_nr, uint32_t io_int_parm,
+                               uint32_t io_int_word)
+{
+    struct kvm_s390_irq irq = {
+        .u.io.subchannel_id = subchannel_id,
+        .u.io.subchannel_nr = subchannel_nr,
+        .u.io.io_int_parm = io_int_parm,
+        .u.io.io_int_word = io_int_word,
+    };
+
+    if (io_int_word & IO_INT_WORD_AI) {
+        irq.type = KVM_S390_INT_IO(1, 0, 0, 0);
+    } else {
+        irq.type = KVM_S390_INT_IO(0, (subchannel_id & 0xff00) >> 8,
+                                      (subchannel_id & 0x0006),
+                                      subchannel_nr);
     }
-    return flic_enqueue_irqs(irq, sizeof(*irq), flic);
+    kvm_s390_inject_flic(fs, &irq);
+}
+
+static void kvm_s390_inject_crw_mchk(S390FLICState *fs)
+{
+    struct kvm_s390_irq irq = {
+        .type = KVM_S390_MCHK,
+        .u.mchk.cr14 = CR14_CHANNEL_REPORT_SC,
+        .u.mchk.mcic = s390_build_validity_mcic() | MCIC_SC_CP,
+    };
+
+    kvm_s390_inject_flic(fs, &irq);
 }
 
 static int kvm_s390_clear_io_flic(S390FLICState *fs, uint16_t subchannel_id,
@@ -602,6 +652,9 @@ static void kvm_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->clear_io_irq = kvm_s390_clear_io_flic;
     fsc->modify_ais_mode = kvm_s390_modify_ais_mode;
     fsc->inject_airq = kvm_s390_inject_airq;
+    fsc->inject_service = kvm_s390_inject_service;
+    fsc->inject_io = kvm_s390_inject_io;
+    fsc->inject_crw_mchk = kvm_s390_inject_crw_mchk;
 }
 
 static const TypeInfo kvm_s390_flic_info = {
diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 5b00e936fa..d0538134b7 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -66,6 +66,11 @@ typedef struct S390FLICStateClass {
     int (*modify_ais_mode)(S390FLICState *fs, uint8_t isc, uint16_t mode);
     int (*inject_airq)(S390FLICState *fs, uint8_t type, uint8_t isc,
                        uint8_t flags);
+    void (*inject_service)(S390FLICState *fs, uint32_t parm);
+    void (*inject_io)(S390FLICState *fs, uint16_t subchannel_id,
+                      uint16_t subchannel_nr, uint32_t io_int_parm,
+                      uint32_t io_int_word);
+    void (*inject_crw_mchk)(S390FLICState *fs);
 } S390FLICStateClass;
 
 #define TYPE_KVM_S390_FLIC "s390-flic-kvm"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 85f4e6b758..9df851b1e8 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -740,7 +740,12 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
-
+/* FIXME: remove once we have proper floating interrupts in TCG */
+void cpu_inject_service(S390CPU *cpu, uint32_t param);
+void cpu_inject_crw_mchk(S390CPU *cpu);
+void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
+                   uint16_t subchannel_number, uint32_t io_int_parm,
+                   uint32_t io_int_word);
 
 /* mmu_helper.c */
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 380222b394..9fce176763 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -15,6 +15,9 @@
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/ioinst.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "hw/s390x/s390_flic.h"
+#endif
 
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
@@ -55,7 +58,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static void cpu_inject_service(S390CPU *cpu, uint32_t param)
+void cpu_inject_service(S390CPU *cpu, uint32_t param)
 {
     CPUS390XState *env = &cpu->env;
 
@@ -134,9 +137,9 @@ void cpu_inject_stop(S390CPU *cpu)
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
-static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
-                          uint16_t subchannel_number,
-                          uint32_t io_int_parm, uint32_t io_int_word)
+void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
+                   uint16_t subchannel_number, uint32_t io_int_parm,
+                   uint32_t io_int_word)
 {
     CPUS390XState *env = &cpu->env;
     int isc = IO_INT_WORD_ISC(io_int_word);
@@ -158,7 +161,7 @@ static void cpu_inject_io(S390CPU *cpu, uint16_t subchannel_id,
     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
 }
 
-static void cpu_inject_crw_mchk(S390CPU *cpu)
+void cpu_inject_crw_mchk(S390CPU *cpu)
 {
     CPUS390XState *env = &cpu->env;
 
@@ -173,38 +176,27 @@ static void cpu_inject_crw_mchk(S390CPU *cpu)
  */
 void s390_sclp_extint(uint32_t parm)
 {
-    if (kvm_enabled()) {
-        kvm_s390_service_interrupt(parm);
-    } else {
-        S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(OBJECT(fs));
 
-        cpu_inject_service(dummy_cpu, parm);
-    }
+    fsc->inject_service(fs, parm);
 }
 
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word)
 {
-    if (kvm_enabled()) {
-        kvm_s390_io_interrupt(subchannel_id, subchannel_nr, io_int_parm,
-                              io_int_word);
-    } else {
-        S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(OBJECT(fs));
 
-        cpu_inject_io(dummy_cpu, subchannel_id, subchannel_nr, io_int_parm,
-                      io_int_word);
-    }
+    fsc->inject_io(fs, subchannel_id, subchannel_nr, io_int_parm, io_int_word);
 }
 
 void s390_crw_mchk(void)
 {
-    if (kvm_enabled()) {
-        kvm_s390_crw_mchk();
-    } else {
-        S390CPU *dummy_cpu = s390_cpu_addr2state(0);
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(OBJECT(fs));
 
-        cpu_inject_crw_mchk(dummy_cpu);
-    }
+    fsc->inject_crw_mchk(fs);
 }
 
 bool s390_cpu_has_mcck_int(S390CPU *cpu)
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 6bae3e99d3..8cdcf83845 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -12,10 +12,6 @@
 #include "cpu.h"
 #include "kvm_s390x.h"
 
-void kvm_s390_service_interrupt(uint32_t parm)
-{
-}
-
 void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
 {
 }
@@ -30,15 +26,6 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
 {
 }
 
-void kvm_s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
-                           uint32_t io_int_parm, uint32_t io_int_word)
-{
-}
-
-void kvm_s390_crw_mchk(void)
-{
-}
-
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 {
     return -ENOSYS;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9b8b59f2a2..aeec1125e1 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1025,7 +1025,7 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq)
     inject_vcpu_irq_legacy(cs, irq);
 }
 
-static void __kvm_s390_floating_interrupt(struct kvm_s390_irq *irq)
+void kvm_s390_floating_interrupt_legacy(struct kvm_s390_irq *irq)
 {
     struct kvm_s390_interrupt kvmint = {};
     int r;
@@ -1043,33 +1043,6 @@ static void __kvm_s390_floating_interrupt(struct kvm_s390_irq *irq)
     }
 }
 
-void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq)
-{
-    static bool use_flic = true;
-    int r;
-
-    if (use_flic) {
-        r = kvm_s390_inject_flic(irq);
-        if (r == -ENOSYS) {
-            use_flic = false;
-        }
-        if (!r) {
-            return;
-        }
-    }
-    __kvm_s390_floating_interrupt(irq);
-}
-
-void kvm_s390_service_interrupt(uint32_t parm)
-{
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_INT_SERVICE,
-        .u.ext.ext_params = parm,
-    };
-
-    kvm_s390_floating_interrupt(&irq);
-}
-
 void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
 {
     struct kvm_s390_irq irq = {
@@ -1681,10 +1654,10 @@ static int handle_tsch(S390CPU *cpu)
          * If an I/O interrupt had been dequeued, we have to reinject it.
          */
         if (run->s390_tsch.dequeued) {
-            kvm_s390_io_interrupt(run->s390_tsch.subchannel_id,
-                                  run->s390_tsch.subchannel_nr,
-                                  run->s390_tsch.io_int_parm,
-                                  run->s390_tsch.io_int_word);
+            s390_io_interrupt(run->s390_tsch.subchannel_id,
+                              run->s390_tsch.subchannel_nr,
+                              run->s390_tsch.io_int_parm,
+                              run->s390_tsch.io_int_word);
         }
         ret = 0;
     }
@@ -1831,37 +1804,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cpu)
     return true;
 }
 
-void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                           uint16_t subchannel_nr, uint32_t io_int_parm,
-                           uint32_t io_int_word)
-{
-    struct kvm_s390_irq irq = {
-        .u.io.subchannel_id = subchannel_id,
-        .u.io.subchannel_nr = subchannel_nr,
-        .u.io.io_int_parm = io_int_parm,
-        .u.io.io_int_word = io_int_word,
-    };
-
-    if (io_int_word & IO_INT_WORD_AI) {
-        irq.type = KVM_S390_INT_IO(1, 0, 0, 0);
-    } else {
-        irq.type = KVM_S390_INT_IO(0, (subchannel_id & 0xff00) >> 8,
-                                      (subchannel_id & 0x0006),
-                                      subchannel_nr);
-    }
-    kvm_s390_floating_interrupt(&irq);
-}
-
-void kvm_s390_crw_mchk(void)
-{
-    struct kvm_s390_irq irq = {
-        .type = KVM_S390_MCHK,
-        .u.mchk.cr14 = CR14_CHANNEL_REPORT_SC,
-        .u.mchk.mcic = s390_build_validity_mcic() | MCIC_SC_CP,
-    };
-    kvm_s390_floating_interrupt(&irq);
-}
-
 void kvm_s390_enable_css_support(S390CPU *cpu)
 {
     int r;
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 79b35946f3..7a3b862eea 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -12,17 +12,12 @@
 
 struct kvm_s390_irq;
 
-void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
-void kvm_s390_service_interrupt(uint32_t parm);
+void kvm_s390_floating_interrupt_legacy(struct kvm_s390_irq *irq);
 void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
 void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
 int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
                     int len, bool is_write);
 void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
-void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                           uint16_t subchannel_nr, uint32_t io_int_parm,
-                           uint32_t io_int_word);
-void kvm_s390_crw_mchk(void);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
@@ -44,7 +39,4 @@ void kvm_s390_crypto_reset(void);
 void kvm_s390_restart_interrupt(S390CPU *cpu);
 void kvm_s390_stop_interrupt(S390CPU *cpu);
 
-/* implemented outside of target/s390x/ */
-int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-
 #endif /* KVM_S390X_H */
-- 
2.14.3
