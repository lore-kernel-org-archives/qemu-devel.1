Received: from eggs.gnu.org ([2001:4830:134:3::10]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdN-0001BZ-Iu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdL-0000BW-Pk
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAdL-0000B6-HU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:51 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:59:12 +0100
Message-Id: <20170116165916.8575-29-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/32] kvm: move cpu synchronization code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincent Palatin <vpalatin@chromium.org>, Stefan Weil <sw@weilnetz.de>

From: Vincent Palatin <vpalatin@chromium.org>

Move the generic cpu_synchronize_ functions to the common hw_accel.h header,
in order to prepare for the addition of a second hardware accelerator.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Message-Id: <f5c3cffe8d520011df1c2e5437bb814989b48332.1484045952.git.vpalatin@chromium.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                      |  1 +
 gdbstub.c                   |  1 +
 hw/i386/kvm/apic.c          |  1 +
 hw/i386/kvmvapic.c          |  1 +
 hw/misc/vmport.c            |  2 +-
 hw/ppc/pnv_xscom.c          |  2 +-
 hw/ppc/ppce500_spin.c       |  4 ++--
 hw/ppc/spapr.c              |  2 +-
 hw/ppc/spapr_hcall.c        |  2 +-
 hw/s390x/s390-pci-inst.c    |  1 +
 include/sysemu/hw_accel.h   | 39 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h        | 23 -----------------------
 monitor.c                   |  2 +-
 qom/cpu.c                   |  2 +-
 target/arm/cpu.c            |  2 +-
 target/i386/helper.c        |  1 +
 target/i386/kvm.c           |  1 +
 target/ppc/kvm.c            |  2 +-
 target/ppc/mmu-hash64.c     |  2 +-
 target/ppc/translate_init.c |  2 +-
 target/s390x/gdbstub.c      |  1 +
 21 files changed, 59 insertions(+), 35 deletions(-)
 create mode 100644 include/sysemu/hw_accel.h

diff --git a/cpus.c b/cpus.c
index 5213351..fc78502 100644
--- a/cpus.c
+++ b/cpus.c
@@ -33,6 +33,7 @@
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
 #include "sysemu/dma.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
diff --git a/gdbstub.c b/gdbstub.c
index de62d26..de9b62b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -32,6 +32,7 @@
 #define MAX_PACKET_LENGTH 4096
 
 #include "qemu/sockets.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
 #include "exec/exec-all.h"
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index df5180b..1df6d26 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -14,6 +14,7 @@
 #include "cpu.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "target/i386/kvm_i386.h"
 
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index b30d1b9..2f767b6 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -14,6 +14,7 @@
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/vmport.c b/hw/misc/vmport.c
index c763811..be40930 100644
--- a/hw/misc/vmport.c
+++ b/hw/misc/vmport.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
 
 //#define VMPORT_DEBUG
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index b82af4f..38bc85f 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -20,7 +20,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index cf958a9..eb219ab 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -29,9 +29,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/sysemu.h"
 #include "e500.h"
 
 #define MAX_CPUS 32
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 208ef7b..a642e66 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -36,7 +36,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/cpus.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "migration/migration.h"
 #include "mmu-hash64.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9a9bedf..b2a8e48 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "cpu.h"
@@ -9,7 +10,6 @@
 #include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
-#include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0864d9b..4d0775c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -18,6 +18,7 @@
 #include "s390-pci-bus.h"
 #include "exec/memory-internal.h"
 #include "qemu/error-report.h"
+#include "sysemu/hw_accel.h"
 
 /* #define DEBUG_S390PCI_INST */
 #ifdef DEBUG_S390PCI_INST
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
new file mode 100644
index 0000000..03812cf
--- /dev/null
+++ b/include/sysemu/hw_accel.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU Hardware accelertors support
+ *
+ * Copyright 2016 Google, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_HW_ACCEL_H
+#define QEMU_HW_ACCEL_H
+
+#include "qom/cpu.h"
+#include "sysemu/hax.h"
+#include "sysemu/kvm.h"
+
+static inline void cpu_synchronize_state(CPUState *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_state(cpu);
+    }
+}
+
+static inline void cpu_synchronize_post_reset(CPUState *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_post_reset(cpu);
+    }
+}
+
+static inline void cpu_synchronize_post_init(CPUState *cpu)
+{
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_post_init(cpu);
+    }
+}
+
+#endif /* QEMU_HW_ACCEL_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index df67cc0..3045ee7 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -461,29 +461,6 @@ void kvm_cpu_synchronize_state(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 
-/* generic hooks - to be moved/refactored once there are more users */
-
-static inline void cpu_synchronize_state(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_state(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_reset(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_reset(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_init(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_init(cpu);
-    }
-}
-
 /**
  * kvm_irqchip_add_msi_route - Add MSI route for specific vector
  * @s:      KVM state
diff --git a/monitor.c b/monitor.c
index 0841d43..d38956f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -50,7 +50,7 @@
 #include "sysemu/balloon.h"
 #include "qemu/timer.h"
 #include "migration/migration.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "qemu/acl.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index 03d9190..2c5274f 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qom/cpu.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
 #include "qemu/log.h"
 #include "exec/log.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f5cb30a..f7f20d3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -31,7 +31,7 @@
 #endif
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 43e87dd..19b2656 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -24,6 +24,7 @@
 #include "kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
+#include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
 #include "hw/i386/apic_internal.h"
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8..e6c4f75 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -23,6 +23,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6c53a6d..ec92c64 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -26,7 +26,7 @@
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/numa.h"
 #include "kvm_ppc.h"
 #include "sysemu/cpus.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index fdb7a78..0efc8c6 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -23,7 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
-#include "sysemu/kvm.h"
+#include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "exec/log.h"
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 19ef250..b0c65b9 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -21,10 +21,10 @@
 #include "qemu/osdep.h"
 #include "disas/bfd.h"
 #include "exec/gdbstub.h"
-#include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/cpus.h"
+#include "sysemu/hw_accel.h"
 #include "cpu-models.h"
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 3d223de..3c652fb 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "qemu/bitops.h"
+#include "sysemu/hw_accel.h"
 
 int s390_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-- 
2.9.3
