Received: from eggs.gnu.org ([2001:4830:134:3::10]:40670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxP-0002MA-GH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxO-0007VJ-FY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:10 +1000
Message-Id: <20170711043917.1757-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/17] spapr: Use unplug_request for PCI hot
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

AIUI, ->unplug_request in the HotplugHandler is used for "soft"
unplug, where acknowledgement from the guest is required before
completing the unplug, whereas ->unplug is used for "hard" unplug
where qemu unilaterally removes the device, and the guest just has to
cope with its sudden absence.  For spapr we (correctly) use
->unplug_request for CPU and memory hot unplug but we use ->unplug for
PCI.

While I think it might be possible to support "hard" PCI unplug within
the PAPR model, that's not how it actually works now.  Although it's
called from ->unplug, the PCI unplug path will usually just mark the
device for removal, with completion of the unplug delayed until
userspace responds to the unplug notification. If the guest doesn't
respond as expected, that could delay the unplug completion arbitrarily
long.

To reflect that, change the PCI unplug path to be called from
->unplug_request.  We also rename spapr_phb_hot_plug_child() and
spapr_phb_hot_unplug_child() to spapr_pci_plug() and
spapr_pci_unplug_request() to more obviously reflect the callbacks they're
implementing.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 49c8db8..cc1588d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1388,8 +1388,8 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
     return spapr_drc_index(drc);
 }
 
-static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
-                                     DeviceState *plugged_dev, Error **errp)
+static void spapr_pci_plug(HotplugHandler *plug_handler,
+                           DeviceState *plugged_dev, Error **errp)
 {
     sPAPRPHBState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
@@ -1469,8 +1469,8 @@ out:
     }
 }
 
-static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
-                                       DeviceState *plugged_dev, Error **errp)
+static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
+                                     DeviceState *plugged_dev, Error **errp)
 {
     sPAPRPHBState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
@@ -1485,6 +1485,7 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
     }
 
     g_assert(drc);
+    g_assert(drc->dev == plugged_dev);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
     if (!drck->release_pending(drc)) {
@@ -1972,8 +1973,8 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     /* Supported by TYPE_SPAPR_MACHINE */
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    hp->plug = spapr_phb_hot_plug_child;
-    hp->unplug = spapr_phb_hot_unplug_child;
+    hp->plug = spapr_pci_plug;
+    hp->unplug_request = spapr_pci_unplug_request;
 }
 
 static const TypeInfo spapr_phb_info = {
-- 
2.9.4
