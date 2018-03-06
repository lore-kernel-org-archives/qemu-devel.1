Received: from eggs.gnu.org ([2001:4830:134:3::10]:49213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3np-0001Pb-N3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3no-0004Ox-Gx
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:31 +1100
Message-Id: <20180306040154.3669-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/30] spapr: register dummy ICPs later
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

Some older machine types create more ICPs than needed. We hence
need to register up to xics_max_server_number() dummy ICPs to
accomodate the migration of these machine types.

Recent VSMT rework changed xics_max_server_number() to return

    DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads)

instead of

    DIV_ROUND_UP(max_cpus * kvmppc_smt_threads(), smp_threads);

The change is okay but it requires spapr->vsmt to be set, which
isn't the case with the current code. This causes the formula to
return zero and we don't create dummy ICPs. This breaks migration
of older guests as reported here:

    https://bugzilla.redhat.com/show_bug.cgi?id=1549087

The dummy ICP workaround doesn't really have a dependency on XICS
itself. But it does depend on proper VCPU id numbering and it must
be applied before creating vCPUs (ie, creating real ICPs). So this
patch moves the workaround to spapr_init_cpus(), which already
assumes VSMT to be set.

Fixes: 72194664c8a1 ("spapr: use spapr->vsmt to compute VCPU ids")
Reported-by: Lukas Doktor <ldoktor@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d6fd0e666e..3f1c5c5133 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -183,7 +183,6 @@ static int xics_max_server_number(sPAPRMachineState *spapr)
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
@@ -205,17 +204,6 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
             return;
         }
     }
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
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
@@ -2236,6 +2224,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *type = spapr_get_cpu_core_type(machine->cpu_type);
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr = smp_cpus / smp_threads;
@@ -2261,6 +2250,17 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
         boot_cores_nr = possible_cpus->len;
     }
 
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
     for (i = 0; i < possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
-- 
2.14.3
