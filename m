Received: from eggs.gnu.org ([2001:4830:134:3::10]:51953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1FCz-0004TH-JO
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1FCv-0004mo-Jn
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:45 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:57470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e1FCv-0004mT-Co
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 13:17:41 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 662EED69DE
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 19:17:40 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sun, 08 Oct 2017 19:17:37 +0200
Message-ID: <150748305796.11627.10934374526997902580.stgit@bahia.lan>
In-Reply-To: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
References: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/2] spapr_pci: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

QEMU currently crashes when the user tries to add a spapr-pci-host-bridge
on a non-pseries machine:

$ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=1
hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
Object 0x1003dacae60 is not an instance of type spapr-machine
Aborted (core dumped)

The same thing happens with the deprecated but still available child type
spapr-pci-vfio-host-bridge.

Fix both by using the SPAPR_MACHINE_NOASSERT() macro in papr_phb_realize().

Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - use new SPAPR_MACHINE_NOASSERT() macro
---
 hw/ppc/spapr_pci.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5049ced4e8b4..4d6a91ebb9c2 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
 
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    sPAPRMachineState *spapr = SPAPR_MACHINE_NOASSERT(qdev_get_machine());
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
@@ -1519,6 +1519,11 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     const unsigned windows_supported =
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
 
+    if (!spapr) {
+        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
+        return;
+    }
+
     if (sphb->index != (uint32_t)-1) {
         sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
         Error *local_err = NULL;
