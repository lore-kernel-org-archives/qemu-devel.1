Received: from eggs.gnu.org ([2001:4830:134:3::10]:35431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuV-0001bi-EY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuT-0005D1-0J
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:11 +1100
Message-Id: <20180216100617.25265-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/14] spapr: move VCPU calculation to core
 machine code
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

The VCPU ids are currently computed and assigned to each individual
CPU threads in spapr_cpu_core_realize(). But the numbering logic
of VCPU ids is actually a machine-level concept, and many places
in hw/ppc/spapr.c also have to compute VCPU ids out of CPU indexes.

The current formula used in spapr_cpu_core_realize() is:

    vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i

where:

    cc->core_id is a multiple of smp_threads
    cpu_index = cc->core_id + i
    0 <= i < smp_threads

So we have:

    cpu_index % smp_threads == i
    cc->core_id / smp_threads == cpu_index / smp_threads

hence:

    vcpu_id =
        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;

This formula was used before VSMT at the time VCPU ids where computed
at the target emulation level. It has the advantage of being useable
to derive a VPCU id out of a CPU index only. It is fitted for all the
places where the machine code has to compute a VCPU id.

This patch introduces an accessor to set the VCPU id in a PowerPCCPU object
using the above formula. It is a first step to consolidate all the VCPU id
logic in a single place.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          | 19 +++++++++++++++++++
 hw/ppc/spapr_cpu_core.c |  9 ++-------
 include/hw/ppc/spapr.h  |  1 +
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ea7429c92a..30cc48fd52 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3802,6 +3802,25 @@ int spapr_vcpu_id(PowerPCCPU *cpu)
     }
 }
 
+void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    int vcpu_id;
+
+    vcpu_id =
+        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
+
+    if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
+        error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
+        error_append_hint(errp, "Adjust the number of cpus to %d "
+                          "or try to raise the number of threads per core\n",
+                          vcpu_id * smp_threads / spapr->vsmt);
+        return;
+    }
+
+    cpu->vcpu_id = vcpu_id;
+}
+
 PowerPCCPU *spapr_find_cpu(int vcpu_id)
 {
     CPUState *cs;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 590d167b04..94afeb399e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -172,13 +172,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cs = CPU(obj);
         cpu = sc->threads[i] = POWERPC_CPU(obj);
         cs->cpu_index = cc->core_id + i;
-        cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
-        if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
-            error_setg(&local_err, "Can't create CPU with id %d in KVM",
-                       cpu->vcpu_id);
-            error_append_hint(&local_err, "Adjust the number of cpus to %d "
-                              "or try to raise the number of threads per core\n",
-                              cpu->vcpu_id * smp_threads / spapr->vsmt);
+        spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
+        if (local_err) {
             goto err;
         }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 62c077ac20..af19320d2f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -767,6 +767,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
 
 int spapr_vcpu_id(PowerPCCPU *cpu);
+void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
-- 
2.14.3
