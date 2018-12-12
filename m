Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0eI-0002qD-5U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0eC-0005jz-2O
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:46 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:16:23 +0100
Message-Id: <20181212091623.16950-12-david@redhat.com>
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
References: <20181212091623.16950-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/11] spapr_pci: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

Introduce and use the "unplug" callback.

This is a preparation for multi-stage hotplug handlers, whereby the bus
hotplug handler is overwritten by the machine hotplug handler. This handler
will then pass control to the bus hotplug handler. So to get this running
cleanly, we also have to make sure to go via the hotplug handler chain when
actually unplugging a device after an unplug request. Lookup the hotplug
handler and call "unplug".

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr_pci.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2374d55fc1..bfb02ee96b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1370,18 +1370,9 @@ static int spapr_create_pci_child_dt(sPAPRPHBState *phb, PCIDevice *dev,
 /* Callback to be called during DRC release. */
 void spapr_phb_remove_pci_device_cb(DeviceState *dev)
 {
-    /* some version guests do not wait for completion of a device
-     * cleanup (generally done asynchronously by the kernel) before
-     * signaling to QEMU that the device is safe, but instead sleep
-     * for some 'safe' period of time. unfortunately on a busy host
-     * this sleep isn't guaranteed to be long enough, resulting in
-     * bad things like IRQ lines being left asserted during final
-     * device removal. to deal with this we call reset just prior
-     * to finalizing the device, which will put the device back into
-     * an 'idle' state, as the device cleanup code expects.
-     */
-    pci_device_reset(PCI_DEVICE(dev));
-    object_unparent(OBJECT(dev));
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
@@ -1490,6 +1481,23 @@ out:
     }
 }
 
+static void spapr_pci_unplug(HotplugHandler *plug_handler,
+                             DeviceState *plugged_dev, Error **errp)
+{
+    /* some version guests do not wait for completion of a device
+     * cleanup (generally done asynchronously by the kernel) before
+     * signaling to QEMU that the device is safe, but instead sleep
+     * for some 'safe' period of time. unfortunately on a busy host
+     * this sleep isn't guaranteed to be long enough, resulting in
+     * bad things like IRQ lines being left asserted during final
+     * device removal. to deal with this we call reset just prior
+     * to finalizing the device, which will put the device back into
+     * an 'idle' state, as the device cleanup code expects.
+     */
+    pci_device_reset(PCI_DEVICE(plugged_dev));
+    object_unparent(OBJECT(plugged_dev));
+}
+
 static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
                                      DeviceState *plugged_dev, Error **errp)
 {
@@ -1965,6 +1973,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hp->plug = spapr_pci_plug;
+    hp->unplug = spapr_pci_unplug;
     hp->unplug_request = spapr_pci_unplug_request;
 }
 
-- 
2.17.2
