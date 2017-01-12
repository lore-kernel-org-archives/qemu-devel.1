Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk7-00035e-5C
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk3-0006d1-50
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:54 +1100
Message-Id: <20170112020327.24882-35-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 34/67] ppc: Rewrite ppc_set_compat()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

This rewrites the ppc_set_compat() function so that instead of open coding
the various compatibility modes, it reads the relevant data from a table.
This is a first step in consolidating the information on compatibility
modes scattered across the code into a single place.

It also makes one change to the logic.  The old code masked the bits
to be set in the PCR (Processor Compatibility Register) by which bits
are valid on the host CPU.  This made no sense, since it was done
regardless of whether our guest CPU was the same as the host CPU or
not.  Furthermore, the actual PCR bits are only relevant for TCG[1] -
KVM instead uses the compatibility mode we tell it in
kvmppc_set_compat().  When using TCG host cpu information usually
isn't even present.

While we're at it, we put the new implementation in a new file to make the
enormous translate_init.c a little smaller.

[1] Actually it doesn't even do anything in TCG, but it will if / when we
    get to implementing compatibility mode logic at that level.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/Makefile.objs    |  2 +-
 target/ppc/compat.c         | 91 +++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h            |  6 ++-
 target/ppc/translate_init.c | 41 --------------------
 4 files changed, 97 insertions(+), 43 deletions(-)
 create mode 100644 target/ppc/compat.c

diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index e667e69..a8c7a30 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -2,7 +2,7 @@ obj-y += cpu-models.o
 obj-y += translate.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o
-obj-$(TARGET_PPC64) += mmu-hash64.o arch_dump.o
+obj-$(TARGET_PPC64) += mmu-hash64.o arch_dump.o compat.o
 endif
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
new file mode 100644
index 0000000..f3fd9c6
--- /dev/null
+++ b/target/ppc/compat.c
@@ -0,0 +1,91 @@
+/*
+ *  PowerPC CPU initialization for qemu.
+ *
+ *  Copyright 2016, David Gibson, Red Hat Inc. <dgibson@redhat.com>
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
+#include "sysemu/kvm.h"
+#include "kvm_ppc.h"
+#include "sysemu/cpus.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "cpu-models.h"
+
+typedef struct {
+    uint32_t pvr;
+    uint64_t pcr;
+} CompatInfo;
+
+static const CompatInfo compat_table[] = {
+    { /* POWER6, ISA2.05 */
+        .pvr = CPU_POWERPC_LOGICAL_2_05,
+        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
+               | PCR_TM_DIS | PCR_VSX_DIS,
+    },
+    { /* POWER7, ISA2.06 */
+        .pvr = CPU_POWERPC_LOGICAL_2_06,
+        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+    },
+    {
+        .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
+        .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+    },
+    { /* POWER8, ISA2.07 */
+        .pvr = CPU_POWERPC_LOGICAL_2_07,
+        .pcr = PCR_COMPAT_2_07,
+    },
+};
+
+static const CompatInfo *compat_by_pvr(uint32_t pvr)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(compat_table); i++) {
+        if (compat_table[i].pvr == pvr) {
+            return &compat_table[i];
+        }
+    }
+    return NULL;
+}
+
+void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
+{
+    const CompatInfo *compat = compat_by_pvr(compat_pvr);
+    CPUPPCState *env = &cpu->env;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    uint64_t pcr;
+
+    if (!compat_pvr) {
+        pcr = 0;
+    } else if (!compat) {
+        error_setg(errp, "Unknown compatibility PVR 0x%08"PRIx32, compat_pvr);
+        return;
+    } else {
+        pcr = compat->pcr;
+    }
+
+    cpu->compat_pvr = compat_pvr;
+    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
+
+    if (kvm_enabled()) {
+        int ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Unable to set CPU compatibility mode in KVM");
+        }
+    }
+}
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b62f775..c859547 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1252,7 +1252,6 @@ void ppc_store_msr (CPUPPCState *env, target_ulong value);
 void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
 int ppc_get_compat_smt_threads(PowerPCCPU *cpu);
 #if defined(TARGET_PPC64)
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 #endif
 
 /* Time-base and decrementer management */
@@ -1323,6 +1322,11 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
     return ifetch ? env->immu_idx : env->dmmu_idx;
 }
 
+/* Compatibility modes */
+#if defined(TARGET_PPC64)
+void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
+#endif /* defined(TARGET_PPC64) */
+
 #include "exec/cpu-all.h"
 
 /*****************************************************************************/
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 60552c1..abdb842 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9972,47 +9972,6 @@ int ppc_get_compat_smt_threads(PowerPCCPU *cpu)
     return ret;
 }
 
-#ifdef TARGET_PPC64
-void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
-{
-    int ret = 0;
-    CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *host_pcc;
-
-    cpu->compat_pvr = compat_pvr;
-
-    switch (compat_pvr) {
-    case CPU_POWERPC_LOGICAL_2_05:
-        env->spr[SPR_PCR] = PCR_TM_DIS | PCR_VSX_DIS | PCR_COMPAT_2_07 |
-                            PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
-        break;
-    case CPU_POWERPC_LOGICAL_2_06:
-    case CPU_POWERPC_LOGICAL_2_06_PLUS:
-        env->spr[SPR_PCR] = PCR_TM_DIS | PCR_COMPAT_2_07 | PCR_COMPAT_2_06;
-        break;
-    case CPU_POWERPC_LOGICAL_2_07:
-        env->spr[SPR_PCR] = PCR_COMPAT_2_07;
-        break;
-    default:
-        env->spr[SPR_PCR] = 0;
-        break;
-    }
-
-    host_pcc = kvm_ppc_get_host_cpu_class();
-    if (host_pcc) {
-        env->spr[SPR_PCR] &= host_pcc->pcr_mask;
-    }
-
-    if (kvm_enabled()) {
-        ret = kvmppc_set_compat(cpu, cpu->compat_pvr);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret,
-                             "Unable to set CPU compatibility mode in KVM");
-        }
-    }
-}
-#endif
-
 static gint ppc_cpu_compare_class_pvr(gconstpointer a, gconstpointer b)
 {
     ObjectClass *oc = (ObjectClass *)a;
-- 
2.9.3
