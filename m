Received: from eggs.gnu.org ([2001:4830:134:3::10]:47767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH1F-0007GM-T1
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH1C-0000eV-MR
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH1C-0000du-D3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:23:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:24 +0200
Message-Id: <20170817092225.4264-10-david@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Let's do it just like the other architectures. Introduce kvm-stub.c
for stubs and kvm_s390x.h for the declarations.

Add a fake declaration of struct kvm_s390_irq so we don't need other
ugly CONFIG_KVM checks.

Change license to GPL2+ and keep copyright notice.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs |   1 +
 target/s390x/cpu.h         | 121 +--------------------------------------------
 target/s390x/kvm-stub.c    | 111 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm_s390x.h   |  51 +++++++++++++++++++
 4 files changed, 164 insertions(+), 120 deletions(-)
 create mode 100644 target/s390x/kvm-stub.c
 create mode 100644 target/s390x/kvm_s390x.h

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index f42cd1f..9615256 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_KVM) += kvm.o
+obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
 # build and run feature list generator
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 74d5b35..aeb730c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -41,6 +41,7 @@
 #include "exec/cpu-all.h"
 
 #include "fpu/softfloat.h"
+#include "kvm_s390x.h"
 
 #define NB_MMU_MODES 3
 #define TARGET_INSN_START_EXTRA_WORDS 1
@@ -213,8 +214,6 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
 extern const struct VMStateDescription vmstate_s390_cpu;
 #endif
 
-#include "sysemu/kvm.h"
-
 /* distinguish between 24 bit and 31 bit addressing */
 #define HIGH_ORDER_BIT 0x80000000
 
@@ -407,39 +406,6 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo,
 void s390_enable_css_support(S390CPU *cpu);
 int s390_virtio_hypercall(CPUS390XState *env);
 
-#ifdef CONFIG_KVM
-void kvm_s390_service_interrupt(uint32_t parm);
-void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
-void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
-int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
-void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
-int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
-                    int len, bool is_write);
-int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
-int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
-#else
-static inline void kvm_s390_service_interrupt(uint32_t parm)
-{
-}
-static inline int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    return -ENOSYS;
-}
-static inline int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
-{
-    return -ENOSYS;
-}
-static inline int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar,
-                                  void *hostbuf, int len, bool is_write)
-{
-    return -ENOSYS;
-}
-static inline void kvm_s390_access_exception(S390CPU *cpu, uint16_t code,
-                                             uint64_t te_code)
-{
-}
-#endif
-
 int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
 int s390_set_clock(uint8_t *tod_high, uint64_t *tod_low);
 
@@ -706,91 +672,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 
-#ifdef CONFIG_KVM
-void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
-void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                           uint16_t subchannel_nr, uint32_t io_int_parm,
-                           uint32_t io_int_word);
-void kvm_s390_crw_mchk(void);
-void kvm_s390_enable_css_support(S390CPU *cpu);
-int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
-                                    int vq, bool assign);
-int kvm_s390_cpu_restart(S390CPU *cpu);
-int kvm_s390_get_memslot_count(KVMState *s);
-int kvm_s390_cmma_active(void);
-void kvm_s390_cmma_reset(void);
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
-void kvm_s390_reset_vcpu(S390CPU *cpu);
-int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
-void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
-int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
-int kvm_s390_get_ri(void);
-int kvm_s390_get_gs(void);
-void kvm_s390_crypto_reset(void);
-#else
-static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
-{
-}
-static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
-                                        uint16_t subchannel_nr,
-                                        uint32_t io_int_parm,
-                                        uint32_t io_int_word)
-{
-}
-static inline void kvm_s390_crw_mchk(void)
-{
-}
-static inline void kvm_s390_enable_css_support(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier,
-                                                  uint32_t sch, int vq,
-                                                  bool assign)
-{
-    return -ENOSYS;
-}
-static inline int kvm_s390_cpu_restart(S390CPU *cpu)
-{
-    return -ENOSYS;
-}
-static inline void kvm_s390_cmma_reset(void)
-{
-}
-static inline int kvm_s390_get_memslot_count(KVMState *s)
-{
-  return MAX_AVAIL_SLOTS;
-}
-static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
-{
-    return -ENOSYS;
-}
-static inline void kvm_s390_reset_vcpu(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit,
-                                         uint64_t *hw_limit)
-{
-    return 0;
-}
-static inline void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
-{
-}
-static inline int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
-{
-    return 0;
-}
-static inline int kvm_s390_get_ri(void)
-{
-    return 0;
-}
-static inline int kvm_s390_get_gs(void)
-{
-    return 0;
-}
-static inline void kvm_s390_crypto_reset(void)
-{
-}
-#endif
 
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
 void s390_cmma_reset(void);
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
new file mode 100644
index 0000000..29a89ba
--- /dev/null
+++ b/target/s390x/kvm-stub.c
@@ -0,0 +1,111 @@
+/*
+ * QEMU KVM support -- s390x specific function stubs.
+ *
+ * Copyright (c) 2009 Ulrich Hecht
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "kvm_s390x.h"
+
+void kvm_s390_service_interrupt(uint32_t parm)
+{
+}
+
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
+{
+}
+
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write)
+{
+    return -ENOSYS;
+}
+
+void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
+{
+}
+
+void kvm_s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
+                           uint32_t io_int_parm, uint32_t io_int_word)
+{
+}
+
+void kvm_s390_crw_mchk(void)
+{
+}
+
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    return -ENOSYS;
+}
+
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
+{
+}
+
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
+{
+    return 0;
+}
+
+int kvm_s390_get_ri(void)
+{
+    return 0;
+}
+
+int kvm_s390_get_gs(void)
+{
+    return 0;
+}
+
+int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+
+int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_low)
+{
+    return -ENOSYS;
+}
+
+void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+}
+
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign)
+{
+    return -ENOSYS;
+}
+
+int kvm_s390_cpu_restart(S390CPU *cpu)
+{
+    return -ENOSYS;
+}
+
+void kvm_s390_cmma_reset(void)
+{
+}
+
+int kvm_s390_get_memslot_count(KVMState *s)
+{
+  return MAX_AVAIL_SLOTS;
+}
+
+void kvm_s390_reset_vcpu(S390CPU *cpu)
+{
+}
+
+int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit)
+{
+    return 0;
+}
+
+void kvm_s390_crypto_reset(void)
+{
+}
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
new file mode 100644
index 0000000..35db28c
--- /dev/null
+++ b/target/s390x/kvm_s390x.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU KVM support -- s390x specific functions.
+ *
+ * Copyright (c) 2009 Ulrich Hecht
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef KVM_S390X_H
+#define KVM_S390X_H
+
+#include "sysemu/kvm.h"
+
+#ifndef CONFIG_KVM
+struct kvm_s390_irq {};
+#endif /* CONFIG_KVM */
+
+void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
+void kvm_s390_service_interrupt(uint32_t parm);
+void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write);
+void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
+void kvm_s390_io_interrupt(uint16_t subchannel_id,
+                           uint16_t subchannel_nr, uint32_t io_int_parm,
+                           uint32_t io_int_word);
+void kvm_s390_crw_mchk(void);
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
+int kvm_s390_get_ri(void);
+int kvm_s390_get_gs(void);
+int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
+int kvm_s390_set_clock(uint8_t *tod_high, uint64_t *tod_clock);
+void kvm_s390_enable_css_support(S390CPU *cpu);
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign);
+int kvm_s390_cpu_restart(S390CPU *cpu);
+int kvm_s390_get_memslot_count(KVMState *s);
+int kvm_s390_cmma_active(void);
+void kvm_s390_cmma_reset(void);
+void kvm_s390_reset_vcpu(S390CPU *cpu);
+int kvm_s390_set_mem_limit(KVMState *s, uint64_t new_limit, uint64_t *hw_limit);
+void kvm_s390_crypto_reset(void);
+
+/* implemented outside of target/s390x/ */
+int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
+
+#endif /* KVM_S390X_H */
-- 
2.9.4
