Received: from eggs.gnu.org ([2001:4830:134:3::10]:50050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEh-0005Us-CJ
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEe-00048h-IJ
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:24 +1000
Message-Id: <20180618035324.19907-29-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 28/28] spapr: fix xics_system_init() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 3d85885a1b1f3 tried to fix error handling, but it actually
went into the wrong direction by dropping the local Error *.

In the default KVM case, the rationale is to try the in-kernel XICS first,
and if not possible, to fallback to userland XICS. Passing errp everywhere
makes this fallback impossible if errp is &error_fatal (which happens to
be the case). And anyway, if the caller would pass a regular &local_err,
things would be worse: we could possibly pass an already set *errp to
error_setg() and crash, or return an error even in case of success.

So we definitely need a local Error * and only propagate it when we're
done with the fallback logic. This is what this patch does.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f59999daac..db0fb385d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -186,27 +186,33 @@ static int xics_max_server_number(sPAPRMachineState *spapr)
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+    Error *local_err = NULL;
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, errp)) {
+            !xics_kvm_init(spapr, &local_err)) {
             spapr->icp_type = TYPE_KVM_ICP;
-            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, errp);
+            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
+                                          &local_err);
         }
         if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_prepend(errp, "kernel_irqchip requested but unavailable: ");
-            return;
+            error_prepend(&local_err,
+                          "kernel_irqchip requested but unavailable: ");
+            goto error;
         }
+        error_free(local_err);
+        local_err = NULL;
     }
 
     if (!spapr->ics) {
         xics_spapr_init(spapr);
         spapr->icp_type = TYPE_ICP;
-        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
-        if (!spapr->ics) {
-            return;
-        }
+        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
+                                      &local_err);
     }
+
+error:
+    error_propagate(errp, local_err);
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
-- 
2.17.1
