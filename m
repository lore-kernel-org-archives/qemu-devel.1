Received: from eggs.gnu.org ([2001:4830:134:3::10]:50834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOe-0008UF-8z
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOb-0007CO-Gz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:51 +1100
Message-Id: <20171017042152.29443-34-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 33/34] spapr_pci: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5049ced4e8..5a3122a9f9 100644
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
-- 
2.13.6
