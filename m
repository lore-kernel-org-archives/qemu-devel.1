Received: from eggs.gnu.org ([2001:4830:134:3::10]:59336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza2-0001dD-Or
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza1-00023Z-PA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:07 +1000
Message-Id: <20180427092126.24812-31-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 30/49] spapr: drop useless dynamic sysbus device
 sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Since commit 7da79a167aa11, the machine class init function registers
dynamic sysbus device types it supports. Passing an unsupported device
type on the command line causes QEMU to exit with an error message
just after machine init.

It is hence not needed to do the same sanity check at machine reset.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fc86ba6934..d35a88ca80 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1440,21 +1440,6 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
     }
 }
 
-static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
-{
-    bool matched = false;
-
-    if (object_dynamic_cast(OBJECT(sbdev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
-        matched = true;
-    }
-
-    if (!matched) {
-        error_report("Device %s is not supported by this machine yet.",
-                     qdev_fw_name(DEVICE(sbdev)));
-        exit(1);
-    }
-}
-
 static int spapr_reset_drcs(Object *child, void *opaque)
 {
     sPAPRDRConnector *drc =
@@ -1478,9 +1463,6 @@ static void spapr_machine_reset(void)
     void *fdt;
     int rc;
 
-    /* Check for unknown sysbus devices */
-    foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
-
     spapr_caps_reset(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
-- 
2.14.3
