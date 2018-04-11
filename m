Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6HFh-0006Az-QP
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6HFb-0004tU-VQ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:01:37 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:53633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f6HFb-0004sZ-PT
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:01:31 -0400
Received: from player758.ha.ovh.net (unknown [10.109.108.107])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A6C8EACD0F
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 17:01:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 11 Apr 2018 17:01:20 +0200
Message-ID: <152345888086.82965.6686500865958674552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-2.13] spapr: drop useless dynamic sysbus
 device sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

Since commit 7da79a167aa11, the machine class init function registers
dynamic sysbus device types it supports. Passing an unsupported device
type on the command line causes QEMU to exit with an error message
just after machine init.

It is hence not needed to do the same sanity check at machine reset.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3ffadd6ac7ce..637e50e6d10b 100644
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
