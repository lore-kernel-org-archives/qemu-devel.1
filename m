Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabb-0001BX-Ix
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWabZ-0001yB-Mg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 23:24:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  3 Jan 2018 15:24:16 +1100
Message-Id: <20180103042419.14520-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180103042419.14520-1-david@gibson.dropbear.id.au>
References: <20180103042419.14520-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/15] spapr: Handle Decimal Floating Point
 (DFP) as an optional capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Decimal Floating Point has been available on POWER7 and later (server)
cpus.  However, it can be disabled on the hypervisor, meaning that it's
not available to guests.

We currently handle this by conditionally advertising DFP support in the
device tree depending on whether the guest CPU model supports it - which
can also depend on what's allowed in the host for -cpu host.  That can lead
to confusion on migration, since host properties are silently affecting
guest visible properties.

This patch handles it by treating it as an optional capability for the
pseries machine type.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |  7 ++++---
 hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 693dd6f7b3..e22888ba06 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -572,7 +572,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     /* Advertise DFP (Decimal Floating Point) if available
      *   0 / no property == no DFP
      *   1               == DFP available */
-    if (env->insns_flags2 & PPC2_DFP) {
+    if (spapr_has_cap(spapr, SPAPR_CAP_DFP)) {
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
     }
 
@@ -3834,7 +3834,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 28;
 
-    smc->default_caps = spapr_caps(SPAPR_CAP_VSX);
+    smc->default_caps = spapr_caps(SPAPR_CAP_VSX | SPAPR_CAP_DFP);
     spapr_caps_add_properties(smc, &error_abort);
 }
 
@@ -3916,7 +3916,8 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     spapr_machine_2_12_class_options(mc);
-    smc->default_caps = spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX);
+    smc->default_caps = spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX
+                                   | SPAPR_CAP_DFP);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7c855c67ad..9d070a306c 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -70,6 +70,16 @@ static void cap_vsx_allow(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
+static void cap_dfp_allow(sPAPRMachineState *spapr, Error **errp)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (!(env->insns_flags2 & PPC2_DFP)) {
+        error_setg(errp, "DFP support not available, try cap-dfp=off");
+    }
+}
+
 static sPAPRCapabilityInfo capability_table[] = {
     {
         .name = "htm",
@@ -85,6 +95,13 @@ static sPAPRCapabilityInfo capability_table[] = {
         .allow = cap_vsx_allow,
         /* TODO: add cap_vsx_disallow */
     },
+    {
+        .name = "dfp",
+        .description = "Allow Decimal Floating Point (DFP)",
+        .flag = SPAPR_CAP_DFP,
+        .allow = cap_dfp_allow,
+        /* TODO: add cap_dfp_disallow */
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -104,6 +121,7 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
                           0, spapr->max_compat_pvr)) {
         caps.mask &= ~SPAPR_CAP_VSX;
+        caps.mask &= ~SPAPR_CAP_DFP;
     }
 
     return caps;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 148a03d189..26ac17e641 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -62,6 +62,9 @@ typedef enum {
 /* Vector Scalar Extensions */
 #define SPAPR_CAP_VSX               0x0000000000000002ULL
 
+/* Decimal Floating Point */
+#define SPAPR_CAP_DFP               0x0000000000000004ULL
+
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
     uint64_t mask;
-- 
2.14.3
