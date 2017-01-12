Received: from eggs.gnu.org ([2001:4830:134:3::10]:46509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-00032h-59
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006cG-LJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:56 +1100
Message-Id: <20170112020327.24882-37-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 36/67] ppc: Validate compatibility modes when
 setting
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

Current ppc_set_compat() will attempt to set any compatiblity mode
specified, regardless of whether it's available on the CPU.  The caller is
expected to make sure it is setting a possible mode, which is awkwward
because most of the information to make that decision is at the CPU level.

This begins to clean this up by introducing a ppc_check_compat() function
which will determine if a given compatiblity mode is supported on a CPU
(and also whether it lies within specified minimum and maximum compat
levels, which will be useful later).  It also contains an assertion that
the CPU has a "virtual hypervisor"[1], that is, that the guest isn't
permitted to execute hypervisor privilege code.  Without that, the guest
would own the PCR and so could override any mode set here.  Only machine
types which use a virtual hypervisor (i.e. 'pseries') should use
ppc_check_compat().

ppc_set_compat() is modified to validate the compatibility mode it is given
and fail if it's not available on this CPU.

[1] Or user-only mode, which also obviously doesn't allow access to the
hypervisor privileged PCR.  We don't use that now, but could in future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/compat.c | 41 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h    |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 66529a6..1059555 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -28,29 +28,37 @@
 typedef struct {
     uint32_t pvr;
     uint64_t pcr;
+    uint64_t pcr_level;
     int max_threads;
 } CompatInfo;
 
 static const CompatInfo compat_table[] = {
+    /*
+     * Ordered from oldest to newest - the code relies on this
+     */
     { /* POWER6, ISA2.05 */
         .pvr = CPU_POWERPC_LOGICAL_2_05,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05
                | PCR_TM_DIS | PCR_VSX_DIS,
+        .pcr_level = PCR_COMPAT_2_05,
         .max_threads = 2,
     },
     { /* POWER7, ISA2.06 */
         .pvr = CPU_POWERPC_LOGICAL_2_06,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     {
         .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
         .pcr = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
+        .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     { /* POWER8, ISA2.07 */
         .pvr = CPU_POWERPC_LOGICAL_2_07,
         .pcr = PCR_COMPAT_2_07,
+        .pcr_level = PCR_COMPAT_2_07,
         .max_threads = 8,
     },
 };
@@ -67,6 +75,35 @@ static const CompatInfo *compat_by_pvr(uint32_t pvr)
     return NULL;
 }
 
+bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
+                      uint32_t min_compat_pvr, uint32_t max_compat_pvr)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CompatInfo *compat = compat_by_pvr(compat_pvr);
+    const CompatInfo *min = compat_by_pvr(min_compat_pvr);
+    const CompatInfo *max = compat_by_pvr(max_compat_pvr);
+
+#if !defined(CONFIG_USER_ONLY)
+    g_assert(cpu->vhyp);
+#endif
+    g_assert(!min_compat_pvr || min);
+    g_assert(!max_compat_pvr || max);
+
+    if (!compat) {
+        /* Not a recognized logical PVR */
+        return false;
+    }
+    if ((min && (compat < min)) || (max && (compat > max))) {
+        /* Outside specified range */
+        return false;
+    }
+    if (!(pcc->pcr_supported & compat->pcr_level)) {
+        /* Not supported by this CPU */
+        return false;
+    }
+    return true;
+}
+
 void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 {
     const CompatInfo *compat = compat_by_pvr(compat_pvr);
@@ -79,6 +116,10 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
     } else if (!compat) {
         error_setg(errp, "Unknown compatibility PVR 0x%08"PRIx32, compat_pvr);
         return;
+    } else if (!ppc_check_compat(cpu, compat_pvr, 0, 0)) {
+        error_setg(errp, "Compatibility PVR 0x%08"PRIx32" not valid for CPU",
+                   compat_pvr);
+        return;
     } else {
         pcr = compat->pcr;
     }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cd76053..22842dd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1323,6 +1323,8 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
 
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
+bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
+                      uint32_t min_compat_pvr, uint32_t max_compat_pvr);
 void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 int ppc_compat_max_threads(PowerPCCPU *cpu);
 #endif /* defined(TARGET_PPC64) */
-- 
2.9.3
