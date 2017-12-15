Received: from eggs.gnu.org ([2001:4830:134:3::10]:53422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixS-0003iK-Ge
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixR-0004pE-7F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:34 +1100
Message-Id: <20171215055435.24204-24-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/24] spapr: Assume msi_nonbroken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

We conditionally adjust part of the guest device tree based on the
global msi_nonbroken flag.  However, the main machine type code
initializes msi_nonbroken to true and there's nothing that would set
it to false again.

So replace the test with an assert().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 42d6a2302a..4f354a8760 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -943,9 +943,8 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
                           RTAS_EVENT_SCAN_RATE));
 
-    if (msi_nonbroken) {
-        _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
-    }
+    g_assert(msi_nonbroken);
+    _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
 
     /*
      * According to PAPR, rtas ibm,os-term does not guarantee a return
-- 
2.14.3
