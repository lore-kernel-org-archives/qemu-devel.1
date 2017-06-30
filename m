Received: from eggs.gnu.org ([2001:4830:134:3::10]:34336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0008S8-5y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRg-0007sC-1M
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:14 +1000
Message-Id: <20170630104632.27942-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/21] pseries: Move CPU compatibility property
 to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Server class POWER CPUs have a "compat" property, which is used to set the
backwards compatibility mode for the processor.  However, this only makes
sense for machine types which don't give the guest access to hypervisor
privilege - otherwise the compatibility level is under the guest's control.

To reflect this, this removes the CPU 'compat' property and instead
creates a 'max-cpu-compat' property on the pseries machine.  Strictly
speaking this breaks compatibility, but AFAIK the 'compat' option was
never (directly) used with -device or device_add.

The option was used with -cpu.  So, to maintain compatibility, this
patch adds a hack to the cpu option parsing to strip out any compat
options supplied with -cpu and set them on the machine property
instead of the now deprecated cpu property.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 hw/ppc/spapr.c              |   6 ++-
 hw/ppc/spapr_cpu_core.c     |  55 +++++++++++++++++++++++-
 hw/ppc/spapr_hcall.c        |   8 ++--
 include/hw/ppc/spapr.h      |  12 ++++--
 target/ppc/compat.c         | 102 ++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h            |   5 ++-
 target/ppc/translate_init.c |  86 +++++++++++--------------------------
 7 files changed, 201 insertions(+), 73 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ea44358..67d4c13 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2131,7 +2131,7 @@ static void ppc_spapr_init(MachineState *machine)
         machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
     }
 
-    ppc_cpu_parse_features(machine->cpu_model);
+    spapr_cpu_parse_features(spapr);
 
     spapr_init_cpus(spapr);
 
@@ -2503,6 +2503,10 @@ static void spapr_machine_initfn(Object *obj)
                                     " place of standard EPOW events when possible"
                                     " (required for memory hot-unplug support)",
                                     NULL);
+
+    ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
+                            "Maximum permitted CPU compatibility mode",
+                            &error_fatal);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9fb896b..97472fd 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -20,6 +20,57 @@
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
 
+void spapr_cpu_parse_features(sPAPRMachineState *spapr)
+{
+    /*
+     * Backwards compatibility hack:
+     *
+     *   CPUs had a "compat=" property which didn't make sense for
+     *   anything except pseries.  It was replaced by "max-cpu-compat"
+     *   machine option.  This supports old command lines like
+     *       -cpu POWER8,compat=power7
+     *   By stripping the compat option and applying it to the machine
+     *   before passing it on to the cpu level parser.
+     */
+    gchar **inpieces;
+    int i, j;
+    gchar *compat_str = NULL;
+
+    inpieces = g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
+
+    /* inpieces[0] is the actual model string */
+    i = 1;
+    j = 1;
+    while (inpieces[i]) {
+        if (g_str_has_prefix(inpieces[i], "compat=")) {
+            /* in case of multiple compat= options */
+            g_free(compat_str);
+            compat_str = inpieces[i];
+        } else {
+            j++;
+        }
+
+        i++;
+        /* Excise compat options from list */
+        inpieces[j] = inpieces[i];
+    }
+
+    if (compat_str) {
+        char *val = compat_str + strlen("compat=");
+        gchar *newprops = g_strjoinv(",", inpieces);
+
+        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
+                                &error_fatal);
+
+        ppc_cpu_parse_features(newprops);
+        g_free(newprops);
+    } else {
+        ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
+    }
+
+    g_strfreev(inpieces);
+}
+
 static void spapr_cpu_reset(void *opaque)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
@@ -67,10 +118,10 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     /* Enable PAPR mode in TCG or KVM */
     cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
 
-    if (cpu->max_compat) {
+    if (spapr->max_compat_pvr) {
         Error *local_err = NULL;
 
-        ppc_set_compat(cpu, cpu->max_compat, &local_err);
+        ppc_set_compat(cpu, spapr->max_compat_pvr, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aa1ffea..8624ce8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1045,11 +1045,11 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
     }
 }
 
-static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
-                              Error **errp)
+static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong *addr, Error **errp)
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
-    uint32_t max_compat = cpu->max_compat;
+    uint32_t max_compat = spapr->max_compat_pvr;
     uint32_t best_compat = 0;
     int i;
 
@@ -1105,7 +1105,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     bool guest_radix;
     Error *local_err = NULL;
 
-    cas_pvr = cas_check_pvr(cpu, &addr, &local_err);
+    cas_pvr = cas_check_pvr(spapr, cpu, &addr, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return H_HARDWARE;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f973b02..2ddb052 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -86,16 +86,19 @@ struct sPAPRMachineState {
     uint64_t rtc_offset; /* Now used only during incoming migration */
     struct PPCTimebase tb;
     bool has_graphics;
-    sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
-    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
-    bool cas_reboot;
-    bool cas_legacy_guest_workaround;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
     bool use_hotplug_event_source;
     sPAPREventSource *event_sources;
 
+    /* ibm,client-architecture-support option negotiation */
+    bool cas_reboot;
+    bool cas_legacy_guest_workaround;
+    sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
+    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
+    uint32_t max_compat_pvr;
+
     /* Migration state */
     int htab_save_index;
     bool htab_first_pass;
@@ -635,6 +638,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
                                             uint32_t count, uint32_t index);
 void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
+void spapr_cpu_parse_features(sPAPRMachineState *spapr);
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index e8ec1e1..f1b67fa 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -24,9 +24,11 @@
 #include "sysemu/cpus.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "cpu-models.h"
 
 typedef struct {
+    const char *name;
     uint32_t pvr;
     uint64_t pcr;
     uint64_t pcr_level;
@@ -38,6 +40,7 @@ static const CompatInfo compat_table[] = {
      * Ordered from oldest to newest - the code relies on this
      */
     { /* POWER6, ISA2.05 */
+        .name = "power6",
         .pvr = CPU_POWERPC_LOGICAL_2_05,
         .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
                PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
@@ -45,24 +48,28 @@ static const CompatInfo compat_table[] = {
         .max_threads = 2,
     },
     { /* POWER7, ISA2.06 */
+        .name = "power7",
         .pvr = CPU_POWERPC_LOGICAL_2_06,
         .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     {
+        .name = "power7+",
         .pvr = CPU_POWERPC_LOGICAL_2_06_PLUS,
         .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_TM_DIS,
         .pcr_level = PCR_COMPAT_2_06,
         .max_threads = 4,
     },
     { /* POWER8, ISA2.07 */
+        .name = "power8",
         .pvr = CPU_POWERPC_LOGICAL_2_07,
         .pcr = PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
         .pcr_level = PCR_COMPAT_2_07,
         .max_threads = 8,
     },
     { /* POWER9, ISA3.00 */
+        .name = "power9",
         .pvr = CPU_POWERPC_LOGICAL_3_00,
         .pcr = PCR_COMPAT_3_00,
         .pcr_level = PCR_COMPAT_3_00,
@@ -189,3 +196,98 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
 
     return n_threads;
 }
+
+static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint32_t compat_pvr = *((uint32_t *)opaque);
+    const char *value;
+
+    if (!compat_pvr) {
+        value = "";
+    } else {
+        const CompatInfo *compat = compat_by_pvr(compat_pvr);
+
+        g_assert(compat);
+
+        value = compat->name;
+    }
+
+    visit_type_str(v, name, (char **)&value, errp);
+}
+
+static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    Error *local_err = NULL;
+    char *value;
+    uint32_t compat_pvr;
+
+    visit_type_str(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (strcmp(value, "") == 0) {
+        compat_pvr = 0;
+    } else {
+        int i;
+        const CompatInfo *compat = NULL;
+
+        for (i = 0; i < ARRAY_SIZE(compat_table); i++) {
+            if (strcmp(value, compat_table[i].name) == 0) {
+                compat = &compat_table[i];
+                break;
+
+            }
+        }
+
+        if (!compat) {
+            error_setg(errp, "Invalid compatibility mode \"%s\"", value);
+            goto out;
+        }
+        compat_pvr = compat->pvr;
+    }
+
+    *((uint32_t *)opaque) = compat_pvr;
+
+out:
+    g_free(value);
+}
+
+void ppc_compat_add_property(Object *obj, const char *name,
+                             uint32_t *compat_pvr, const char *basedesc,
+                             Error **errp)
+{
+    Error *local_err = NULL;
+    gchar *namesv[ARRAY_SIZE(compat_table) + 1];
+    gchar *names, *desc;
+    int i;
+
+    object_property_add(obj, name, "string",
+                        ppc_compat_prop_get, ppc_compat_prop_set, NULL,
+                        compat_pvr, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(compat_table); i++) {
+        /*
+         * Have to discard const here, because g_strjoinv() takes
+         * (gchar **), not (const gchar **) :(
+         */
+        namesv[i] = (gchar *)compat_table[i].name;
+    }
+    namesv[ARRAY_SIZE(compat_table)] = NULL;
+
+    names = g_strjoinv(", ", namesv);
+    desc = g_strdup_printf("%s. Valid values are %s.", basedesc, names);
+    object_property_set_description(obj, name, desc, &local_err);
+
+    g_free(names);
+    g_free(desc);
+
+out:
+    error_propagate(errp, local_err);
+}
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d10808d..09393e6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1189,7 +1189,6 @@ typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
  * PowerPCCPU:
  * @env: #CPUPPCState
  * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
- * @max_compat: Maximal supported logical PVR from the command line
  * @compat_pvr: Current logical PVR, zero if in "raw" mode
  *
  * A PowerPC CPU.
@@ -1201,7 +1200,6 @@ struct PowerPCCPU {
 
     CPUPPCState env;
     int cpu_dt_id;
-    uint32_t max_compat;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
@@ -1375,6 +1373,9 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_threads(PowerPCCPU *cpu);
+void ppc_compat_add_property(Object *obj, const char *name,
+                             uint32_t *compat_pvr, const char *basedesc,
+                             Error **errp);
 #endif /* defined(TARGET_PPC64) */
 
 #include "exec/cpu-all.h"
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab2..e837cd2 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
 #include "mmu-book3s-v3.h"
+#include "sysemu/qtest.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -8413,73 +8414,38 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x10000;
 }
 
-static void powerpc_get_compat(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    char *value = (char *)"";
-    Property *prop = opaque;
-    uint32_t *max_compat = qdev_get_prop_ptr(DEVICE(obj), prop);
-
-    switch (*max_compat) {
-    case CPU_POWERPC_LOGICAL_2_05:
-        value = (char *)"power6";
-        break;
-    case CPU_POWERPC_LOGICAL_2_06:
-        value = (char *)"power7";
-        break;
-    case CPU_POWERPC_LOGICAL_2_07:
-        value = (char *)"power8";
-        break;
-    case 0:
-        break;
-    default:
-        error_report("Internal error: compat is set to %x", *max_compat);
-        abort();
-        break;
-    }
-
-    visit_type_str(v, name, &value, errp);
-}
-
-static void powerpc_set_compat(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+/*
+ * The CPU used to have a "compat" property which set the
+ * compatibility mode PVR.  However, this was conceptually broken - it
+ * only makes sense on the pseries machine type (otherwise the guest
+ * owns the PCR and can control the compatibility mode itself).  It's
+ * been replaced with the 'max-cpu-compat' property on the pseries
+ * machine type.  For backwards compatibility, pseries specially
+ * parses the -cpu parameter and converts old compat= parameters into
+ * the appropriate machine parameters.  This stub implementation of
+ * the parameter catches any uses on explicitly created CPUs.
+ */
+static void getset_compat_deprecated(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
 {
-    Error *error = NULL;
-    char *value = NULL;
-    Property *prop = opaque;
-    uint32_t *max_compat = qdev_get_prop_ptr(DEVICE(obj), prop);
-
-    visit_type_str(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-
-    if (strcmp(value, "power6") == 0) {
-        *max_compat = CPU_POWERPC_LOGICAL_2_05;
-    } else if (strcmp(value, "power7") == 0) {
-        *max_compat = CPU_POWERPC_LOGICAL_2_06;
-    } else if (strcmp(value, "power8") == 0) {
-        *max_compat = CPU_POWERPC_LOGICAL_2_07;
-    } else {
-        error_setg(errp, "Invalid compatibility mode \"%s\"", value);
+    if (!qtest_enabled()) {
+        error_report("CPU 'compat' property is deprecated and has no effect; "
+                     "use max-cpu-compat machine property instead");
     }
-
-    g_free(value);
+    visit_type_null(v, name, NULL);
 }
 
-static PropertyInfo powerpc_compat_propinfo = {
+static PropertyInfo ppc_compat_deprecated_propinfo = {
     .name = "str",
-    .description = "compatibility mode, power6/power7/power8",
-    .get = powerpc_get_compat,
-    .set = powerpc_set_compat,
+    .description = "compatibility mode (deprecated)",
+    .get = getset_compat_deprecated,
+    .set = getset_compat_deprecated,
 };
-
-#define DEFINE_PROP_POWERPC_COMPAT(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, powerpc_compat_propinfo, uint32_t)
-
 static Property powerpc_servercpu_properties[] = {
-    DEFINE_PROP_POWERPC_COMPAT("compat", PowerPCCPU, max_compat),
+    {
+        .name = "compat",
+        .info = &ppc_compat_deprecated_propinfo,
+    },
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
