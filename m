Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELp-00047r-MT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAELl-0002Km-RU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:45 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:42137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAELl-0002Ju-K4
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:39:41 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 8A7EF1FBBB
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:39:40 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 15 May 2017 13:39:36 +0200
Message-ID: <149484837602.20089.6188552126304330653.stgit@bahia.lan>
In-Reply-To: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/6] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

The xics_system_init() function passes its errp argument to xics_kvm_init().
If the call fails and the user requested in-kernel irqchip, it then ends up
passing a NULL Error * to error_reportf_err() and the error message is
silently dropped.

Passing an errp argument is generally wrong, unless you really just need
to convey an error to the caller.

This patch converts xics_system_init() to *only* pass a pointer to its own
Error * and then to propagate it with error_propagate(), as recommended
in error.h.

The local_err name is used for consistency with the rest of the code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f477d7b8a210..44f7dc7f40e9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -121,29 +121,32 @@ static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+    Error *local_err = NULL;
 
     if (kvm_enabled()) {
-        Error *err = NULL;
-
         if (machine_kernel_irqchip_allowed(machine) &&
-            !xics_kvm_init(spapr, errp)) {
+            !xics_kvm_init(spapr, &local_err)) {
             spapr->icp_type = TYPE_KVM_ICP;
-            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, &err);
+            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
+                                          &local_err);
         }
         if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_reportf_err(err,
+            error_reportf_err(local_err,
                               "kernel_irqchip requested but unavailable: ");
             exit(EXIT_FAILURE);
         } else {
-            error_free(err);
+            error_free(local_err);
         }
     }
 
     if (!spapr->ics) {
         xics_spapr_init(spapr);
         spapr->icp_type = TYPE_ICP;
-        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
+        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
+                                      &local_err);
     }
+
+    error_propagate(errp, local_err);
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
