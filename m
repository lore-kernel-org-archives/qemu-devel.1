Received: from eggs.gnu.org ([2001:4830:134:3::10]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9XR-00018q-R0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9XP-0007py-Sd
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:29:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Dec 2017 15:29:36 +1100
Message-Id: <20171219042942.29297-9-david@gibson.dropbear.id.au>
In-Reply-To: <20171219042942.29297-1-david@gibson.dropbear.id.au>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/14] spapr: Treat Hardware Transactional
 Memory (HTM) as an optional capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

This adds an spapr capability bit for Hardware Transactional Memory.  It is
enabled by default for pseries-2.11 and earlier machine types. with POWER8
or later CPUs (as it must be, since earlier qemu versions would implicitly
allow it).  However it is disabled by default for the latest pseries-2.12
machine type.

This means that with the latest machine type, HTM will not be available,
regardless of CPU, unless it is explicitly enabled on the command line.
That change is made on the basis that:

 * This way running with -M pseries,accel=tcg will start with whatever cpu
   and will provide the same guest visible model as with accel=kvm.
     - More specifically, this means existing make check tests don't have
       to be modified to use cap-htm=off in order to run with TCG

 * We hope to add a new "HTM without suspend" feature in the not too
   distant future which could work on both POWER8 and POWER9 cpus, and
   could be enabled by default.

 * Best guesses suggest that future POWER cpus may well only support the
   HTM-without-suspend model, not the (frankly, horribly overcomplicated)
   POWER8 style HTM with suspend.

 * Anecdotal evidence suggests problems with HTM being enabled when it
   wasn't wanted are more common than being missing when it was.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         | 15 ++++++++++-----
 hw/ppc/spapr_caps.c    | 29 ++++++++++++++++++++++++++++-
 include/hw/ppc/spapr.h |  3 +++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d472baef8d..f8fee8ebcf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -253,7 +253,9 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 }
 
 /* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(PowerPCCPU *cpu, void *fdt, int offset,
+static void spapr_populate_pa_features(sPAPRMachineState *spapr,
+                                       PowerPCCPU *cpu,
+                                       void *fdt, int offset,
                                        bool legacy_guest)
 {
     CPUPPCState *env = &cpu->env;
@@ -318,7 +320,7 @@ static void spapr_populate_pa_features(PowerPCCPU *cpu, void *fdt, int offset,
          */
         pa_features[3] |= 0x20;
     }
-    if (kvmppc_has_cap_htm() && pa_size > 24) {
+    if (spapr_has_cap(spapr, SPAPR_CAP_HTM) && pa_size > 24) {
         pa_features[24] |= 0x80;    /* Transactional memory support */
     }
     if (legacy_guest && pa_size > 40) {
@@ -384,8 +386,8 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
             return ret;
         }
 
-        spapr_populate_pa_features(cpu, fdt, offset,
-                                         spapr->cas_legacy_guest_workaround);
+        spapr_populate_pa_features(spapr, cpu, fdt, offset,
+                                   spapr->cas_legacy_guest_workaround);
     }
     return ret;
 }
@@ -579,7 +581,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
 
-    spapr_populate_pa_features(cpu, fdt, offset, false);
+    spapr_populate_pa_features(spapr, cpu, fdt, offset, false);
 
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
@@ -3903,7 +3905,10 @@ static void spapr_machine_2_11_instance_options(MachineState *machine)
 
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_12_class_options(mc);
+    smc->default_caps = spapr_caps(SPAPR_CAP_HTM);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 968ba7b857..3b35b91a5b 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -24,6 +24,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "sysemu/hw_accel.h"
+#include "target/ppc/cpu.h"
+#include "cpu-models.h"
+#include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
 
@@ -40,18 +44,41 @@ typedef struct sPAPRCapabilityInfo {
     void (*disallow)(sPAPRMachineState *spapr, Error **errp);
 } sPAPRCapabilityInfo;
 
+static void cap_htm_allow(sPAPRMachineState *spapr, Error **errp)
+{
+    if (tcg_enabled()) {
+        error_setg(errp,
+                   "No Transactional Memory support in TCG, try cap-htm=off");
+    } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
+        error_setg(errp,
+"KVM implementation does not support Transactional Memory, try cap-htm=off"
+            );
+    }
+}
+
 static sPAPRCapabilityInfo capability_table[] = {
+    {
+        .name = "htm",
+        .description = "Allow Hardware Transactional Memory (HTM)",
+        .flag = SPAPR_CAP_HTM,
+        .allow = cap_htm_allow,
+        /* TODO: add cap_htm_disallow */
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
                                                CPUState *cs)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
     sPAPRCapabilities caps;
 
     caps = smc->default_caps;
 
-    /* TODO: clamp according to cpu model */
+    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
+                          0, spapr->max_compat_pvr)) {
+        caps.mask &= ~SPAPR_CAP_HTM;
+    }
 
     return caps;
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5569caf1d4..dc64f4ebcb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -54,6 +54,9 @@ typedef enum {
  * Capabilities
  */
 
+/* Hardware Transactional Memory */
+#define SPAPR_CAP_HTM               0x0000000000000001ULL
+
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
     uint64_t mask;
-- 
2.14.3
