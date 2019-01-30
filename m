Received: from eggs.gnu.org ([209.51.188.92]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goetT-0003i1-NB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 20:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goetS-0000ja-Ci
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 20:42:23 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 30 Jan 2019 12:42:16 +1100
Message-Id: <20190130014216.98287-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr: Drop unused parameters from fdt
 building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

spapr_load_rtas() handles now RTAS address and size information in the FDT
so drop them from spapr_build_fdt().

While we are here, fix a small typo.

Fixes: 2cac78c12ade9 "pseries: Consolidate RTAS loading"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a217c7f..fa12723 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
     }
 }
 
-static void *spapr_build_fdt(sPAPRMachineState *spapr,
-                             hwaddr rtas_addr,
-                             hwaddr rtas_size)
+static void *spapr_build_fdt(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
 
     /*
      * We place the device tree and RTAS just below either the top of the RMA,
-     * or just below 2GB, whichever is lowere, so that it can be
+     * or just below 2GB, whichever is lower, so that it can be
      * processed with 32-bit real mode code if necessary
      */
     rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
     rtas_addr = rtas_limit - RTAS_MAX_SIZE;
     fdt_addr = rtas_addr - FDT_MAX_SIZE;
 
-    fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
+    fdt = spapr_build_fdt(spapr);
 
     spapr_load_rtas(spapr, fdt, rtas_addr);
 
-- 
2.17.1
