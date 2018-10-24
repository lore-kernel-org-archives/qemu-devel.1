Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGIF-00062G-5w
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gFGID-000153-FW
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:21:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Oct 2018 12:19:30 +0200
Message-Id: <20181024101930.20674-8-david@redhat.com>
In-Reply-To: <20181024101930.20674-1-david@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/7] spapr_pci: route unplug via the hotplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

Preparation for multi-stage hotplug handlers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr_pci.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 58afa46204..64b8591023 100644
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
