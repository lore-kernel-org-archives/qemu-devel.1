Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDu-0000NJ-D8
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDs-0002mZ-VY
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:14 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 20 Feb 2017 15:04:35 +1100
Message-Id: <1487563478-22265-8-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 07/10] target/ppc/POWER9: Add
 POWER9 mmu fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

Add a new mmu fault handler for the POWER9 cpu and add it as the handler
for the POWER9 cpu definition.

This handler checks if the guest is radix or hash based on the value in the
partition table entry and calls the correct fault handler accordingly.

The hash fault handling code has also been updated to check if the
partition is using segment tables.

Currently only legacy hash (no segment tables) is supported.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V2->V3:
- error_report on attempt to use segment tables instead of just LOG()
- Rename mmu.h -> mmu-book3s-v3.h
---
 target/ppc/mmu-book3s-v3.h  | 50 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.c     |  8 ++++++++
 target/ppc/mmu_helper.c     | 40 ++++++++++++++++++++++++++++++++++++
 target/ppc/translate_init.c |  3 ++-
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 target/ppc/mmu-book3s-v3.h

diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
new file mode 100644
index 0000000..9375921
--- /dev/null
+++ b/target/ppc/mmu-book3s-v3.h
@@ -0,0 +1,50 @@
+/*
+ *  PowerPC emulation generic mmu definitions for qemu.
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
index 3e17a9f..a581b50 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -27,6 +27,7 @@
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "exec/log.h"
+#include "mmu-book3s-v3.h"
 
 //#define DEBUG_SLB
 
@@ -767,6 +768,13 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
     /* 2. Translation is on, so look up the SLB */
     slb = slb_lookup(cpu, eaddr);
     if (!slb) {
+        /* No entry found, check if in-memory segment tables are in use */
+        if (ppc64_use_proc_tbl(cpu)) {
+            /* TODO - Unsupported */
+            error_report("Segment Table Support Unimplemented");
+            abort();
+        }
+        /* Segment still not found, generate the appropriate interrupt */
         if (rwx == 2) {
             cs->exception_index = POWERPC_EXCP_ISEG;
             env->error_code = 0;
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2911266..527123c 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -28,6 +28,8 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "helper_regs.h"
+#include "qemu/error-report.h"
+#include "mmu-book3s-v3.h"
 
 //#define DEBUG_MMU
 //#define DEBUG_BATS
@@ -1280,6 +1282,17 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
     case POWERPC_MMU_2_07a:
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
+                /* TODO - Unsupported */
+            } else {
+                dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
+                break;
+            }
+        }
 #endif
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
@@ -1421,6 +1434,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
+    case POWERPC_MMU_3_00:
+        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
+            /* TODO - Unsupported */
+        } else {
+            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
+                /* TODO - Unsupported */
+            } else {
+                return ppc_hash64_get_phys_page_debug(cpu, addr);
+            }
+        }
+        break;
 #endif
 
     case POWERPC_MMU_32B:
@@ -2907,3 +2931,19 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
                                retaddr);
     }
 }
+
+/******************************************************************************/
+
+/* ISA v3.00 (POWER9) Generic MMU Helpers */
+
+int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
+                              int mmu_idx)
+{
+    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
+        /* TODO - Unsupported */
+        error_report("Guest Radix Support Unimplemented");
+        abort();
+    } else { /* Guest uses hash */
+        return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
+    }
+}
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 32c1619..7661c21 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "mmu-book3s-v3.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -8898,7 +8899,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                     (1ull << MSR_LE);
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if defined(CONFIG_SOFTMMU)
-    pcc->handle_mmu_fault = ppc_hash64_handle_mmu_fault;
+    pcc->handle_mmu_fault = ppc64_v3_handle_mmu_fault;
     /* segment page size remain the same */
     pcc->sps = &POWER7_POWER8_sps;
 #endif
-- 
2.5.5
