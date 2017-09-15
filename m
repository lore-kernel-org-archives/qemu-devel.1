Received: from eggs.gnu.org ([2001:4830:134:3::10]:54133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006eD-Re
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003ND-PS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:21 +1000
Message-Id: <20170915035130.8354-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/18] spapr_pci: use the common _FDT() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

All other users in hw/ppc already consider an error when building
the FDT to be fatal, even on hotplug paths. There's no valid reason
for spapr_pci to behave differently. So let's used the common _FDT()
helper which terminates QEMU when libfdt fails.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6da73fe6bc..abb9f05e7b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -40,7 +40,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
-
+#include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_ids.h"
@@ -61,14 +61,6 @@
 #define RTAS_TYPE_MSI           1
 #define RTAS_TYPE_MSIX          2
 
-#define _FDT(exp) \
-    do { \
-        int ret = (exp);                                           \
-        if (ret < 0) {                                             \
-            return ret;                                            \
-        }                                                          \
-    } while (0)
-
 sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t buid)
 {
     sPAPRPHBState *sphb;
-- 
2.13.5
