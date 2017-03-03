Received: from eggs.gnu.org ([2001:4830:134:3::10]:44254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqW-00084Q-00
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqT-0001L0-JW
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:24:57 +1100
Message-Id: <20170303032507.16142-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/17] target/ppc/POWER9: Add POWER9 mmu fault
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add a new mmu fault handler for the POWER9 cpu and add it as the handler
for the POWER9 cpu definition.

This handler checks if the guest is radix or hash based on the value in the
partition table entry and calls the correct fault handler accordingly.

The hash fault handling code has also been updated to check if the
partition is using segment tables.

Currently only legacy hash (no segment tables) is supported.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/Makefile.objs    |  2 +-
 target/ppc/mmu-book3s-v3.c  | 37 +++++++++++++++++++++++++++++++++
 target/ppc/mmu-book3s-v3.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.c     |  8 ++++++++
 target/ppc/mmu_helper.c     | 15 ++++++++++++++
 target/ppc/translate_init.c |  3 ++-
 6 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 target/ppc/mmu-book3s-v3.c
 create mode 100644 target/ppc/mmu-book3s-v3.h

diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index 0057b31..f963777 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -3,7 +3,7 @@ obj-y += cpu.o
 obj-y += translate.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
-obj-$(TARGET_PPC64) += mmu-hash64.o compat.o
+obj-$(TARGET_PPC64) += mmu-hash64.o mmu-book3s-v3.o compat.o
 endif
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
new file mode 100644
index 0000000..005c963
--- /dev/null
+++ b/target/ppc/mmu-book3s-v3.c
@@ -0,0 +1,37 @@
+/*
+ *  PowerPC ISAV3 BookS emulation generic mmu helpers for qemu.
+ *
+ *  Copyright (c) 2017 Suraj Jitindar Singh, IBM Corporation
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "mmu-hash64.h"
+#include "mmu-book3s-v3.h"
+#include "qemu/error-report.h"
+
+int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                              int mmu_idx)
+{
+    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
+        /* TODO - Unsupported */
+        error_report("Guest Radix Support Unimplemented");
+        exit(1);
+    } else { /* Guest uses hash */
+        return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
+    }
+}
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
new file mode 100644
index 0000000..636f6ab
--- /dev/null
+++ b/target/ppc/mmu-book3s-v3.h
@@ -0,0 +1,50 @@
+/*
+ *  PowerPC ISAV3 BookS emulation generic mmu definitions for qemu.
+ *
+ *  Copyright (c) 2017 Suraj Jitindar Singh, IBM Corporation
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MMU_H
+#define MMU_H
+
+#ifndef CONFIG_USER_ONLY
+
+/* Partition Table Entry Fields */
+#define PATBE1_GR 0x8000000000000000
+
+#ifdef TARGET_PPC64
+
+static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
+{
+    return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
+}
+
+static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
+{
+    PPCVirtualHypervisorClass *vhc =
+        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+
+    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
+}
+
+int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                              int mmu_idx);
+
+#endif /* TARGET_PPC64 */
+
+#endif /* CONFIG_USER_ONLY */
+
+#endif /* MMU_H */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index d44f2bb..368ee60 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -28,6 +28,7 @@
 #include "mmu-hash64.h"
 #include "exec/log.h"
 #include "hw/hw.h"
+#include "mmu-book3s-v3.h"
 
 //#define DEBUG_SLB
 
@@ -726,6 +727,13 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
     /* 2. Translation is on, so look up the SLB */
     slb = slb_lookup(cpu, eaddr);
     if (!slb) {
+        /* No entry found, check if in-memory segment tables are in use */
+        if ((env->mmu_model & POWERPC_MMU_V3) && ppc64_use_proc_tbl(cpu)) {
+            /* TODO - Unsupported */
+            error_report("Segment Table Support Unimplemented");
+            exit(1);
+        }
+        /* Segment still not found, generate the appropriate interrupt */
         if (rwx == 2) {
             cs->exception_index = POWERPC_EXCP_ISEG;
             env->error_code = 0;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index a1af3d6..18a76d2 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -29,6 +29,7 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
+#include "mmu-book3s-v3.h"
 
 //#define DEBUG_MMU
 //#define DEBUG_BATS
@@ -1285,6 +1286,13 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
     case POWERPC_MMU_2_07a:
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
+            break;
+        }
 #endif
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
@@ -1426,6 +1434,13 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            return ppc_hash64_get_phys_page_debug(cpu, addr);
+        }
+        break;
 #endif
 
     case POWERPC_MMU_32B:
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 1a05ac3..dc2f8eb 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "mmu-book3s-v3.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -8910,7 +8911,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if defined(CONFIG_SOFTMMU)
-    pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
+    pcc->handle_mmu_fault = ppc64_v3_handle_mmu_fault;
     /* segment page size remain the same */
     pcc->sps = &POWER7_POWER8_sps;
 #endif
-- 
2.9.3
