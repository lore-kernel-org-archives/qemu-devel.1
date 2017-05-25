Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoQ-0006VY-7c
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoP-0007UU-5q
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:24 +1000
Message-Id: <20170525035132.24268-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/18] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

If the user explicitely asked for kernel-irqchip support and "xics-kvm"
initialization fails, we shouldn't fallback to emulated "xics" as we
do now. It is also awkward to print an error message when we have an
errp pointer argument.

Let's use the errp argument to report the error and let the caller decide.
This simplifies the code as we don't need a local Error * here.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c912eaa..c92d269 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -128,18 +128,14 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
 
     if (kvm_enabled()) {
-        Error *err = NULL;
-
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, errp)) {
             spapr->icp_type = TYPE_KVM_ICP;
-            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, &err);
+            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, errp);
         }
         if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_reportf_err(err,
-                              "kernel_irqchip requested but unavailable: ");
-        } else {
-            error_free(err);
+            error_prepend(errp, "kernel_irqchip requested but unavailable: ");
+            return;
         }
     }
 
@@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
         xics_spapr_init(spapr);
         spapr->icp_type = TYPE_ICP;
         spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
+        if (!spapr->ics) {
+            return;
+        }
     }
 }
 
-- 
2.9.4
