Received: from eggs.gnu.org ([2001:4830:134:3::10]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2gNN-0007Wl-FT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2gNJ-0002A0-9o
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:25 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2gNI-00028u-Op
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:30:21 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 514F286210
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 18:30:19 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 12 Oct 2017 18:30:14 +0200
Message-ID: <150782581468.2204.675461686446925339.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 1/2] spapr_pci: fail gracefully with
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

QEMU currently crashes when the user tries to add an spapr-pci-host-bridge
on a non-pseries machine:

$ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=1
hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
Object 0x1003dacae60 is not an instance of type spapr-machine
Aborted (core dumped)

The same thing happens with the deprecated but still available child type
spapr-pci-vfio-host-bridge.

Fix both by checking the machine type with object_dynamic_cast().

Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
v3: - make opencoded call to object_dynamic_cast()
    - add detailed comment
---
 hw/ppc/spapr_pci.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5049ced4e8b4..5a3122a9f9f9 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1507,7 +1507,12 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
 
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
+     * tries to add a sPAPR PHB to a non-pseries machine.
+     */
+    sPAPRMachineState *spapr =
+        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+                                                  TYPE_SPAPR_MACHINE);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
@@ -1519,6 +1524,11 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
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
