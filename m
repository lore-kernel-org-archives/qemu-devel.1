Received: from eggs.gnu.org ([2001:4830:134:3::10]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ftE2e-0004d1-70
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ftE2b-00075z-0b
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:28 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:55762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ftE2a-0006zC-Os
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:24 -0400
Received: from player756.ha.ovh.net (unknown [10.109.143.146])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id BDC72F3378
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 17:30:15 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 24 Aug 2018 17:30:04 +0200
Message-ID: <153512460418.276612.14744411474887601809.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr_pci: fix potential NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Commit 2c88b098e76fd added a call to SPAPR_MACHINE_GET_CLASS(spapr) in
spapr_phb_realize() before we check spapr isn't NULL. This causes QEMU
to crash when starting a non-pseries machine with a sPAPR PHB.

This could be fixed by setting the smc variable after the null check,
but it seems more explicit to use a ternary operator to skip the call
to SPAPR_MACHINE_GET_CLASS() if spapr is NULL, since spapr_phb_realize()
will return immediately in this case.

This was reported by Coverity (CID 1395170 and 1395183).

Fixes: 2c88b098e76fde0c7fcc0476dd3f80ce58409505
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5cd676e4430d..6bcb4f419b6b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1559,7 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     sPAPRMachineState *spapr =
         (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    sPAPRMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
