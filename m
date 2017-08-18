Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difi3-0002ke-TT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhz-0007VX-U2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhz-0007V8-KK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:52 +0200
Message-Id: <20170818114353.13455-18-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 17/18] s390x/kvm: move KVM
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
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Let's do it just like the other architectures. Introduce kvm-stub.c
for stubs and kvm_s390x.h for the declarations.

Change license to GPL2+ and keep copyright notice.

As we are dropping the sysemu/kvm.h include from cpu.h, fix up includes.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic_kvm.c      |   1 +
 hw/s390x/s390-stattrib-kvm.c |   1 +
 include/hw/s390x/css.h       |   1 +
 target/s390x/Makefile.objs   |   1 +
 target/s390x/cpu.c           |   2 +
 target/s390x/cpu.h           | 119 -------------------------------------------
 target/s390x/cpu_models.c    |   2 +
 target/s390x/interrupt.c     |   1 +
 target/s390x/kvm-stub.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c           |   1 +
 target/s390x/kvm_s390x.h     |  47 +++++++++++++++++
 target/s390x/machine.c       |   1 +
 target/s390x/mmu_helper.c    |   1 +
 13 files changed, 170 insertions(+), 119 deletions(-)
 create mode 100644 target/s390x/kvm-stub.c
 create mode 100644 target/s390x/kvm_s390x.h

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index be3fd00..7ead17a 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "kvm_s390x.h"
 #include <sys/ioctl.h>
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index ff3f89f..ed95d13 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "exec/ram_addr.h"
 #include "cpu.h"
+#include "kvm_s390x.h"
 
 Object *kvm_s390_stattrib_create(void)
 {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 5c5fe6b..a4cc358 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -16,6 +16,7 @@
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
+#include "sysemu/kvm.h"
 
 /* Channel subsystem constants. */
 #define MAX_DEVNO 65535
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
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c538a95..7267b60 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -27,6 +27,8 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
+#include "kvm_s390x.h"
+#include "sysemu/kvm.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 77b2977..464db3e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -213,8 +213,6 @@ static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
 extern const struct VMStateDescription vmstate_s390_cpu;
 #endif
 
-#include "sysemu/kvm.h"
-
 /* distinguish between 24 bit and 31 bit addressing */
 #define HIGH_ORDER_BIT 0x80000000
 
@@ -407,39 +405,6 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo,
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
 
@@ -704,90 +669,6 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
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
-int kvm_s390_get_memslot_count(void);
-int kvm_s390_cmma_active(void);
-void kvm_s390_cmma_reset(void);
-int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
-void kvm_s390_reset_vcpu(S390CPU *cpu);
-int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
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
-static inline int kvm_s390_get_memslot_count(void)
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
-static inline int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
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
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2ce9157..18cbf91 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -13,6 +13,8 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
+#include "kvm_s390x.h"
+#include "sysemu/kvm.h"
 #include "gen-features.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 119ca74..058e219 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "kvm_s390x.h"
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
new file mode 100644
index 0000000..261e1cd
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
+int kvm_s390_get_memslot_count(void)
+{
+  return MAX_AVAIL_SLOTS;
+}
+
+void kvm_s390_reset_vcpu(S390CPU *cpu)
+{
+}
+
+int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
+{
+    return 0;
+}
+
+void kvm_s390_crypto_reset(void)
+{
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 89cffa8..3b80693 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -30,6 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
+#include "kvm_s390x.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
new file mode 100644
index 0000000..2d594bd
--- /dev/null
+++ b/target/s390x/kvm_s390x.h
@@ -0,0 +1,47 @@
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
+struct kvm_s390_irq;
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
+int kvm_s390_get_memslot_count(void);
+int kvm_s390_cmma_active(void);
+void kvm_s390_cmma_reset(void);
+void kvm_s390_reset_vcpu(S390CPU *cpu);
+int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
+void kvm_s390_crypto_reset(void);
+
+/* implemented outside of target/s390x/ */
+int kvm_s390_inject_flic(struct kvm_s390_irq *irq);
+
+#endif /* KVM_S390X_H */
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 592db6b..097a147 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "cpu.h"
 #include "internal.h"
+#include "kvm_s390x.h"
 #include "sysemu/kvm.h"
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 09fe5bb..b528c59 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -20,6 +20,7 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "internal.h"
+#include "kvm_s390x.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/s390x/storage-keys.h"
-- 
2.9.4
