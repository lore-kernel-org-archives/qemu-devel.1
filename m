Received: from eggs.gnu.org ([2001:4830:134:3::10]:49242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nq-0001QJ-DK
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3no-0004Pc-Vg
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:32 +1100
Message-Id: <20180306040154.3669-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/30] spapr: harden code that depends on VSMT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

VSMT must be set in order to compute VCPU ids. This means that the
following functions must not be called before spapr_set_vsmt_mode()
was called:
- spapr_vcpu_id()
- spapr_is_thread0_in_vcore()
- xics_max_server_number()

We had a recent regression where the latter would be called before VSMT
was set, and broke migration of some old machine types. This patch
adds assert() in the above functions to avoid problems in the future.

Also, since VSMT is really a CPU related thing, spapr_set_vsmt_mode() is
now called from spapr_init_cpus(), just before the first VSMT user.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 144 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 75 insertions(+), 69 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3f1c5c5133..1c2703cb6b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -105,12 +105,14 @@
  */
 static int spapr_vcpu_id(sPAPRMachineState *spapr, int cpu_index)
 {
+    assert(spapr->vsmt);
     return
         (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
 }
 static bool spapr_is_thread0_in_vcore(sPAPRMachineState *spapr,
                                       PowerPCCPU *cpu)
 {
+    assert(spapr->vsmt);
     return spapr_get_vcpu_id(cpu) % spapr->vsmt == 0;
 }
 
@@ -177,6 +179,7 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int i)
 
 static int xics_max_server_number(sPAPRMachineState *spapr)
 {
+    assert(spapr->vsmt);
     return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
 }
 
@@ -2220,73 +2223,6 @@ static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
     return &ms->possible_cpus->cpus[index];
 }
 
-static void spapr_init_cpus(sPAPRMachineState *spapr)
-{
-    MachineState *machine = MACHINE(spapr);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
-    const char *type = spapr_get_cpu_core_type(machine->cpu_type);
-    const CPUArchIdList *possible_cpus;
-    int boot_cores_nr = smp_cpus / smp_threads;
-    int i;
-
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
-    if (mc->has_hotpluggable_cpus) {
-        if (smp_cpus % smp_threads) {
-            error_report("smp_cpus (%u) must be multiple of threads (%u)",
-                         smp_cpus, smp_threads);
-            exit(1);
-        }
-        if (max_cpus % smp_threads) {
-            error_report("max_cpus (%u) must be multiple of threads (%u)",
-                         max_cpus, smp_threads);
-            exit(1);
-        }
-    } else {
-        if (max_cpus != smp_cpus) {
-            error_report("This machine version does not support CPU hotplug");
-            exit(1);
-        }
-        boot_cores_nr = possible_cpus->len;
-    }
-
-    if (smc->pre_2_10_has_unused_icps) {
-        int i;
-
-        for (i = 0; i < xics_max_server_number(spapr); i++) {
-            /* Dummy entries get deregistered when real ICPState objects
-             * are registered during CPU core hotplug.
-             */
-            pre_2_10_vmstate_register_dummy_icp(i);
-        }
-    }
-
-    for (i = 0; i < possible_cpus->len; i++) {
-        int core_id = i * smp_threads;
-
-        if (mc->has_hotpluggable_cpus) {
-            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                   spapr_vcpu_id(spapr, core_id));
-        }
-
-        if (i < boot_cores_nr) {
-            Object *core  = object_new(type);
-            int nr_threads = smp_threads;
-
-            /* Handle the partially filled core for older machine types */
-            if ((i + 1) * smp_threads >= smp_cpus) {
-                nr_threads = smp_cpus - i * smp_threads;
-            }
-
-            object_property_set_int(core, nr_threads, "nr-threads",
-                                    &error_fatal);
-            object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
-                                    &error_fatal);
-            object_property_set_bool(core, true, "realized", &error_fatal);
-        }
-    }
-}
-
 static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
 {
     Error *local_err = NULL;
@@ -2359,6 +2295,78 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void spapr_init_cpus(sPAPRMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    const char *type = spapr_get_cpu_core_type(machine->cpu_type);
+    const CPUArchIdList *possible_cpus;
+    int boot_cores_nr = smp_cpus / smp_threads;
+    int i;
+
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    if (mc->has_hotpluggable_cpus) {
+        if (smp_cpus % smp_threads) {
+            error_report("smp_cpus (%u) must be multiple of threads (%u)",
+                         smp_cpus, smp_threads);
+            exit(1);
+        }
+        if (max_cpus % smp_threads) {
+            error_report("max_cpus (%u) must be multiple of threads (%u)",
+                         max_cpus, smp_threads);
+            exit(1);
+        }
+    } else {
+        if (max_cpus != smp_cpus) {
+            error_report("This machine version does not support CPU hotplug");
+            exit(1);
+        }
+        boot_cores_nr = possible_cpus->len;
+    }
+
+    /* VSMT must be set in order to be able to compute VCPU ids, ie to
+     * call xics_max_server_number() or spapr_vcpu_id().
+     */
+    spapr_set_vsmt_mode(spapr, &error_fatal);
+
+    if (smc->pre_2_10_has_unused_icps) {
+        int i;
+
+        for (i = 0; i < xics_max_server_number(spapr); i++) {
+            /* Dummy entries get deregistered when real ICPState objects
+             * are registered during CPU core hotplug.
+             */
+            pre_2_10_vmstate_register_dummy_icp(i);
+        }
+    }
+
+    for (i = 0; i < possible_cpus->len; i++) {
+        int core_id = i * smp_threads;
+
+        if (mc->has_hotpluggable_cpus) {
+            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
+                                   spapr_vcpu_id(spapr, core_id));
+        }
+
+        if (i < boot_cores_nr) {
+            Object *core  = object_new(type);
+            int nr_threads = smp_threads;
+
+            /* Handle the partially filled core for older machine types */
+            if ((i + 1) * smp_threads >= smp_cpus) {
+                nr_threads = smp_cpus - i * smp_threads;
+            }
+
+            object_property_set_int(core, nr_threads, "nr-threads",
+                                    &error_fatal);
+            object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
+                                    &error_fatal);
+            object_property_set_bool(core, true, "realized", &error_fatal);
+        }
+    }
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
@@ -2486,8 +2494,6 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     /* init CPUs */
-    spapr_set_vsmt_mode(spapr, &error_fatal);
-
     spapr_init_cpus(spapr);
 
     if (kvm_enabled()) {
-- 
2.14.3
