Received: from eggs.gnu.org ([2001:4830:134:3::10]:60133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN8Mb-0005pt-Va
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN8MZ-0004E5-HQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:53:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 20 Jun 2017 09:53:32 +0800
Message-Id: <20170620015332.13874-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170620015332.13874-1-david@gibson.dropbear.id.au>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 5/5] spapr: Use unplug_request for PCI hot
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
respond as expected, that could delay the unplug completiong
arbitrarily long.

To reflect that, change the PCI unplug path to be called from
->unplug_request.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f2543ef..bda8938 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
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
@@ -1973,7 +1974,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hp->plug = spapr_phb_hot_plug_child;
-    hp->unplug = spapr_phb_hot_unplug_child;
+    hp->unplug_request = spapr_pci_unplug_request;
 }
 
 static const TypeInfo spapr_phb_info = {
-- 
2.9.4
