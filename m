Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFk-00084g-5b
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFi-0003S5-L0
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 May 2017 15:45:21 +1000
Message-Id: <20170518054522.13141-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170518054522.13141-1-david@gibson.dropbear.id.au>
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/3] pseries: Restore PVR negotiation logic for
 pre-2.9 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

"pseries" guests go through a hypervisor<->guest feature negotiation during
early boot.  Part of this is finding a CPU compatibility mode which works
for both.

In 152ef80 "pseries: Rewrite CAS PVR compatibility logic" this logic was
changed to strongly prefer architecture defined CPU compatibility modes,
rather than CPU "raw" modes.  However, this change was made universally,
which introduces a guest visible change for the previously existing machine
types (pseries-2.8 and earlier).  That's never supposed to happen.

This corrects the behaviour, reverting to the old PVR negotiation logic
for machine types prior to pseries-2.9.

Fixes: 152ef803ceb1959e2380a1da7736b935b109222e
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c         |  3 ++
 hw/ppc/spapr_hcall.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 35dceb0..ad8ddf2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3313,9 +3313,12 @@ static void spapr_machine_2_8_instance_options(MachineState *machine)
 
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_9_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
     mc->numa_mem_align_shift = 23;
+    smc->pre_2_9_cas_pvr = true;
 }
 
 DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 77d2d66..a790da7 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1044,6 +1044,89 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
     }
 }
 
+/*
+ * Old logic for PVR negotiation, used old <2.9 machine types for
+ * compatibility with old qemu versions
+ */
+#define get_compat_level(cpuver) (                  \
+        ((cpuver) == CPU_POWERPC_LOGICAL_2_05) ? 2050 : \
+        ((cpuver) == CPU_POWERPC_LOGICAL_2_06) ? 2060 :  \
+        ((cpuver) == CPU_POWERPC_LOGICAL_2_06_PLUS) ? 2061 :    \
+        ((cpuver) == CPU_POWERPC_LOGICAL_2_07) ? 2070 : 0)
+
+static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
+                                  unsigned max_lvl, unsigned *compat_lvl,
+                                  unsigned *compat_pvr)
+{
+    unsigned lvl = get_compat_level(pvr);
+    bool is205, is206, is207;
+
+    if (!lvl) {
+        return;
+    }
+
+    /* If it is a logical PVR, try to determine the highest level */
+    is205 = (pcc->pcr_supported & PCR_COMPAT_2_05) &&
+        (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_05));
+    is206 = (pcc->pcr_supported & PCR_COMPAT_2_06) &&
+        ((lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06)) ||
+         (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_06_PLUS)));
+    is207 = (pcc->pcr_supported & PCR_COMPAT_2_07) &&
+        (lvl == get_compat_level(CPU_POWERPC_LOGICAL_2_07));
+
+    if (is205 || is206 || is207) {
+        if (!max_lvl) {
+            /* User did not set the level, choose the highest */
+            if (*compat_lvl <= lvl) {
+                *compat_lvl = lvl;
+                *compat_pvr = pvr;
+            }
+        } else if (max_lvl >= lvl) {
+            /* User chose the level, don't set higher than this */
+            *compat_lvl = lvl;
+            *compat_pvr = pvr;
+        }
+    }
+}
+
+static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *cpu, target_ulong *addr,
+                                      Error **errp)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int counter;
+    unsigned max_lvl = get_compat_level(cpu->max_compat);
+    bool cpu_match = false;
+    unsigned compat_lvl = 0, compat_pvr = 0;
+
+    for (counter = 0; counter < 512; ++counter) {
+        uint32_t pvr, pvr_mask;
+
+        pvr_mask = ldl_be_phys(&address_space_memory, *addr);
+        pvr = ldl_be_phys(&address_space_memory, *addr + 4);
+        *addr += 8;
+
+        if (~pvr_mask & pvr) {
+            break; /* Terminator record */
+        }
+
+        trace_spapr_cas_pvr_try(pvr);
+        if (!max_lvl &&
+            ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask))) {
+            cpu_match = true;
+            compat_pvr = 0;
+        } else if (pvr == cpu->compat_pvr) {
+            cpu_match = true;
+            compat_pvr = cpu->compat_pvr;
+        } else if (!cpu_match) {
+            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compat_pvr);
+        }
+    }
+
+    trace_spapr_cas_pvr(cpu->compat_pvr, cpu_match, compat_pvr);
+
+    return compat_pvr;
+}
+
 static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
                               Error **errp)
 {
@@ -1096,6 +1179,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                                                   target_ulong opcode,
                                                   target_ulong *args)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     /* Working address in data buffer */
     target_ulong addr = ppc64_phys_to_real(args[0]);
     target_ulong ov_table;
@@ -1104,7 +1188,11 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     bool guest_radix;
     Error *local_err = NULL;
 
-    cas_pvr = cas_check_pvr(cpu, &addr, &local_err);
+    if (smc->pre_2_9_cas_pvr) {
+        cas_pvr = cas_check_pvr_pre_2_9(cpu, &addr, &local_err);
+    } else {
+        cas_pvr = cas_check_pvr(cpu, &addr, &local_err);
+    }
     if (local_err) {
         error_report_err(local_err);
         return H_HARDWARE;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 93c4cfc..f875dc4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -52,6 +52,7 @@ struct sPAPRMachineClass {
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
+    bool pre_2_9_cas_pvr;      /* Use old logic for PVR compat negotiation */
     const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
-- 
2.9.4
