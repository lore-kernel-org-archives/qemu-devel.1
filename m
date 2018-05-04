Received: from eggs.gnu.org ([2001:4830:134:3::10]:43367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETkw-00069T-Mj
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fETku-0007Xy-Us
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:59:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  4 May 2018 15:59:30 +1000
Message-Id: <20180504055930.3786-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180504055930.3786-1-david@gibson.dropbear.id.au>
References: <20180504055930.3786-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/17] spapr: don't advertise radix GTSE if
 max-compat-cpu < power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

On a POWER9 host, if a guest runs in pre POWER9 compat mode, it necessarily
uses the hash MMU mode. In this case, we shouldn't advertise radix GTSE in
the ibm,arch-vec-5-platform-support DT property as the current code does.
The first reason is that it doesn't make sense, and the second one is that
causes the CAS-negotiated options subsection to be migrated. This breaks
backward migration to QEMU 2.7 and older versions on POWER8 hosts:

qemu-system-ppc64: error while loading state for instance 0x0 of device
 'spapr'
qemu-system-ppc64: load of migration failed: No such file or directory

This patch hence initialize CPUs a bit earlier so that we can check the
requested compat mode, and don't set OV5_MMU_RADIX_GTSE for power8 and
older.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 19997f66c0..32ab3c43b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2512,6 +2512,7 @@ static void spapr_machine_init(MachineState *machine)
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err = NULL;
+    PowerPCCPU *first_ppc_cpu;
 
     msi_nonbroken = true;
 
@@ -2592,11 +2593,6 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
-    if (!kvm_enabled() || kvmppc_has_cap_mmu_radix()) {
-        /* KVM and TCG always allow GTSE with radix... */
-        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
-    }
-    /* ... but not with hash (currently). */
 
     /* advertise support for dedicated HP event source to guests */
     if (spapr->use_hotplug_event_source) {
@@ -2614,6 +2610,15 @@ static void spapr_machine_init(MachineState *machine)
     /* init CPUs */
     spapr_init_cpus(spapr);
 
+    first_ppc_cpu = POWERPC_CPU(first_cpu);
+    if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
+        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                         spapr->max_compat_pvr)) {
+        /* KVM and TCG always allow GTSE with radix... */
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
+    }
+    /* ... but not with hash (currently). */
+
     if (kvm_enabled()) {
         /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel devices */
         kvmppc_enable_logical_ci_hcalls();
-- 
2.17.0
