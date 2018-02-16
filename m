Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuY-0001eO-24
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuT-0005Ey-ME
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:33 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:10 +1100
Message-Id: <20180216100617.25265-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/14] spapr: use spapr->vsmt to compute VCPU ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, surajjs@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Since the introduction of VSMT in 2.11, the spacing of VCPU ids
between cores is controllable through a machine property instead
of being only dictated by the SMT mode of the host:

    cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i

Until recently, the machine code would try to change the SMT mode
of the host to be equal to VSMT or exit. This allowed the rest of
the code to assume that kvmppc_smt_threads() == spapr->vsmt is
always true.

Recent commit "8904e5a75005 spapr: Adjust default VSMT value for
better migration compatibility" relaxed the rule. If the VSMT
mode cannot be set in KVM for some reasons, but the requested
CPU topology is compatible with the current SMT mode, then we
let the guest run with  kvmppc_smt_threads() != spapr->vsmt.

This breaks quite a few places in the code, in particular when
calculating DRC indexes.

This is what happens on a POWER host with subcores-per-core=2 (ie,
supports up to SMT4) when passing the following topology:

    -smp threads=4,maxcpus=16 \
    -device host-spapr-cpu-core,core-id=4,id=core1 \
    -device host-spapr-cpu-core,core-id=8,id=core2

qemu-system-ppc64: warning: Failed to set KVM's VSMT mode to 8 (errno -22)

This is expected since KVM is limited to SMT4, but the guest is started
anyway because this topology can run on SMT4 even with a VSMT8 spacing.

But when we look at the DT, things get nastier:

cpus {
        ...
        ibm,drc-indexes = <0x4 0x10000000 0x10000004 0x10000008 0x1000000c>;

This means that we have the following association:

 CPU core device |     DRC    | VCPU id
-----------------+------------+---------
   boot core     | 0x10000000 | 0
   core1         | 0x10000004 | 4
   core2         | 0x10000008 | 8
   core3         | 0x1000000c | 12

But since the spacing of VCPU ids is 8, the DRC for core1 points to a
VCPU that doesn't exist, the DRC for core2 points to the first VCPU of
core1 and and so on...

        ...

        PowerPC,POWER8@0 {
                ...
                ibm,my-drc-index = <0x10000000>;
                ...
        };

        PowerPC,POWER8@8 {
                ...
                ibm,my-drc-index = <0x10000008>;
                ...
        };

        PowerPC,POWER8@10 {
                ...

No ibm,my-drc-index property for this core since 0x10000010 doesn't
exist in ibm,drc-indexes above.

                ...
        };
};

...

interrupt-controller {
        ...
        ibm,interrupt-server-ranges = <0x0 0x10>;

With a spacing of 8, the highest VCPU id for the given topology should be:
        16 * 8 / 4 = 32 and not 16

        ...
        linux,phandle = <0x7e7323b8>;
        interrupt-controller;
};

And CPU hot-plug/unplug is broken:

(qemu) device_del core1
pseries-hotplug-cpu: Cannot find CPU (drc index 10000004) to remove

(qemu) device_del core2
cpu 4 (hwid 8) Ready to die...
cpu 5 (hwid 9) Ready to die...
cpu 6 (hwid 10) Ready to die...
cpu 7 (hwid 11) Ready to die...

These are the VCPU ids of core1 actually

(qemu) device_add host-spapr-cpu-core,core-id=12,id=core3
(qemu) device_del core3
pseries-hotplug-cpu: Cannot find CPU (drc index 1000000c) to remove

This patches all the code in hw/ppc/spapr.c to assume the VSMT
spacing when manipulating VCPU ids.

Fixes: 8904e5a75005
Signed-off-by: Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9f29434819..ea7429c92a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -160,9 +160,9 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int i)
                        (void *)(uintptr_t) i);
 }
 
-static inline int xics_max_server_number(void)
+static int xics_max_server_number(sPAPRMachineState *spapr)
 {
-    return DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);
+    return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
 }
 
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
@@ -194,7 +194,7 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
     if (smc->pre_2_10_has_unused_icps) {
         int i;
 
-        for (i = 0; i < xics_max_server_number(); i++) {
+        for (i = 0; i < xics_max_server_number(spapr); i++) {
             /* Dummy entries get deregistered when real ICPState objects
              * are registered during CPU core hotplug.
              */
@@ -337,7 +337,6 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
     int ret = 0, offset, cpus_offset;
     CPUState *cs;
     char cpu_model[32];
-    int smt = kvmppc_smt_threads();
     uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
 
     CPU_FOREACH(cs) {
@@ -346,7 +345,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
         int index = spapr_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
 
-        if ((index % smt) != 0) {
+        if (index % spapr->vsmt != 0) {
             continue;
         }
 
@@ -614,7 +613,6 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
     CPUState *cs;
     int cpus_offset;
     char *nodename;
-    int smt = kvmppc_smt_threads();
 
     cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
     _FDT(cpus_offset);
@@ -632,7 +630,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
-        if ((index % smt) != 0) {
+        if (index % spapr->vsmt != 0) {
             continue;
         }
 
@@ -1131,7 +1129,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2224,7 +2222,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *type = spapr_get_cpu_core_type(machine->cpu_type);
-    int smt = kvmppc_smt_threads();
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr = smp_cpus / smp_threads;
     int i;
@@ -2254,7 +2251,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 
         if (mc->has_hotpluggable_cpus) {
             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                   (core_id / smp_threads) * smt);
+                                   (core_id / smp_threads) * spapr->vsmt);
         }
 
         if (i < boot_cores_nr) {
@@ -3281,10 +3278,10 @@ static
 void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
+    sPAPRMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     int index;
     sPAPRDRConnector *drc;
     CPUCore *cc = CPU_CORE(dev);
-    int smt = kvmppc_smt_threads();
 
     if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index)) {
         error_setg(errp, "Unable to find CPU core with core-id: %d",
@@ -3296,7 +3293,7 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
     g_assert(drc);
 
     spapr_drc_detach(drc);
@@ -3315,7 +3312,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUState *cs = CPU(core->threads[0]);
     sPAPRDRConnector *drc;
     Error *local_err = NULL;
-    int smt = kvmppc_smt_threads();
     CPUArchId *core_slot;
     int index;
     bool hotplugged = spapr_drc_hotplugged(dev);
@@ -3326,7 +3322,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                    cc->core_id);
         return;
     }
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * spapr->vsmt);
 
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
-- 
2.14.3
