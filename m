Received: from eggs.gnu.org ([209.51.188.92]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOjr-0007Dl-Gi
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOch-0002IX-09
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:55:44 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Jan 2019 20:55:19 +0100
Message-Id: <20190123195527.29575-2-david@redhat.com>
In-Reply-To: <20190123195527.29575-1-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFCv2 1/9] qdev: Let the
 hotplug_handler_unplug() caller delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

When unplugging a device, at one point the device will be destroyed
via object_unparent(). This will, one the one hand, unrealize the
removed device hierarchy, and on the other hand, destroy/free the
device hierarchy.

When chaining hotplug handlers, we want to overwrite a bus hotplug
handler by the machine hotplug handler, to be able to perform
some part of the plug/unplug and to forward the calls to the bus hotplug
handler.

For now, the bus hotplug handler would trigger an object_unparent(), not
allowing us to perform some unplug action on a device after we forwarded
the call to the bus hotplug handler. The device would be gone at that
point.

machine_unplug_handler(dev)
    /* eventually do unplug stuff */
    bus_unplug_handler(dev)
    /* dev is gone, we can't do more unplug stuff */

So move the object_unparent() to the original caller of the unplug. For
now, keep the unrealize() at the original places of the
object_unparent(). For implicitly chained hotplug handlers (e.g. pc
code calling acpi hotplug handlers), the object_unparent() has to be
done by the outermost caller. So when calling hotplug_handler_unplug()
from inside an unplug handler, nothing is to be done.

hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
    machine_unplug_handler(dev) {
        /* eventually do unplug stuff */
        bus_unplug_handler(dev) -> calls unrealize(dev)
        /* we can do more unplug stuff but device already unrealized */
    }
object_unparent(dev)

In the long run, every unplug action should be factored out of the
unrealize() function into the unplug handler (especially for PCI). Then
we can get rid of the additonal unrealize() calls and object_unparent()
will properly unrealize the device hierarchy after the device has been
unplugged.

hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
    machine_unplug_handler(dev) {
        /* eventually do unplug stuff */
        bus_unplug_handler(dev) -> only unplugs, does not unrealize
        /* we can do more unplug stuff */
    }
object_unparent(dev) -> will unrealize

The original approach was suggested by Igor Mammedov for the PCI
part, but I extended it to all hotplug handlers. I consider this one
step into the right direction.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/acpi/cpu.c            |  1 +
 hw/acpi/memory_hotplug.c |  1 +
 hw/acpi/pcihp.c          |  3 ++-
 hw/core/qdev.c           |  3 +--
 hw/i386/pc.c             |  5 ++---
 hw/pci/pcie.c            |  3 ++-
 hw/pci/shpc.c            |  3 ++-
 hw/ppc/spapr.c           |  4 ++--
 hw/ppc/spapr_pci.c       |  3 ++-
 hw/s390x/css-bridge.c    |  2 +-
 hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
 qdev-monitor.c           |  9 +++++++--
 12 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f10b190019..37703a8806 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -126,6 +126,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             dev = DEVICE(cdev->cpu);
             hotplug_ctrl = qdev_get_hotplug_handler(dev);
             hotplug_handler_unplug(hotplug_ctrl, dev, NULL);
+            object_unparent(OBJECT(dev));
         }
         break;
     case ACPI_CPU_CMD_OFFSET_WR:
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 921cad2c5e..297812d5f7 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -189,6 +189,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
                 error_free(local_err);
                 break;
             }
+            object_unparent(OBJECT(dev));
             trace_mhp_acpi_pc_dimm_deleted(mem_st->selector);
         }
         break;
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7bc7a72340..31b1a8fe58 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -174,6 +174,7 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
             if (!acpi_pcihp_pc_no_hotplug(s, dev)) {
                 hotplug_ctrl = qdev_get_hotplug_handler(qdev);
                 hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
+                object_unparent(OBJECT(qdev));
             }
         }
     }
@@ -269,7 +270,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index d59071b8ed..278cc094ec 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -286,8 +286,7 @@ void qbus_reset_all_fn(void *opaque)
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
-    /* just zap it */
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 /*
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 450a144e3f..fd0cb29ba9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1998,8 +1998,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     }
 
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
-    object_unparent(OBJECT(dev));
-
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
  out:
     error_propagate(errp, local_err);
 }
@@ -2105,7 +2104,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = NULL;
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 
     /* decrement the number of CPUs */
     pcms->boot_cpus--;
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 230478faab..9b829c8434 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -450,7 +450,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp)
 {
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
@@ -458,6 +458,7 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
 
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
+    object_unparent(OBJECT(dev));
 }
 
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 45053b39b9..44620ad845 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -249,6 +249,7 @@ static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
             hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(affected_dev));
             hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
                                    &error_abort);
+            object_unparent(OBJECT(affected_dev));
         }
     }
 }
@@ -546,7 +547,7 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp)
 {
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0942f35bf8..9675024c8b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3450,7 +3450,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
 
@@ -3557,7 +3557,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
     assert(core_slot);
     core_slot->cpu = NULL;
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 static
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5cdc98513d..a2babde3da 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1373,6 +1373,7 @@ void spapr_phb_remove_pci_device_cb(DeviceState *dev)
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
 
     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+    object_unparent(OBJECT(dev));
 }
 
 static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
@@ -1495,7 +1496,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_handler,
      * an 'idle' state, as the device cleanup code expects.
      */
     pci_device_reset(PCI_DEVICE(plugged_dev));
-    object_unparent(OBJECT(plugged_dev));
+    object_property_set_bool(OBJECT(plugged_dev), false, "realized", NULL);
 }
 
 static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 1bd6c8b458..614c2a3b8b 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -51,7 +51,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
 
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0);
 
-    object_unparent(OBJECT(dev));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
 static void virtual_css_bus_reset(BusState *qbus)
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 6be4364fce..61a9fe4596 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -154,14 +154,17 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 
     /* Unplug the PCI device */
     if (pbdev->pdev) {
-        hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(pbdev->pdev));
-        hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev->pdev),
-                               &error_abort);
+        DeviceState *pdev = DEVICE(pbdev->pdev);
+
+        hotplug_ctrl = qdev_get_hotplug_handler(pdev);
+        hotplug_handler_unplug(hotplug_ctrl, pdev, &error_abort);
+        object_unparent(OBJECT(pdev));
     }
 
     /* Unplug the zPCI device */
     hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(pbdev));
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(pbdev), &error_abort);
+    object_unparent(OBJECT(pbdev));
 }
 
 void s390_pci_sclp_deconfigure(SCCB *sccb)
@@ -1019,7 +1022,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
         devfn = pci_dev->devfn;
-        object_unparent(OBJECT(pci_dev));
+        object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 
         s390_pci_msix_free(pbdev);
         s390_pci_iommu_free(s, bus, devfn);
@@ -1036,7 +1039,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        object_unparent(OBJECT(pbdev));
+        object_property_set_bool(OBJECT(dev), false, "realized", NULL);
     }
 }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 07147c63bf..7705acd6c7 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -862,6 +862,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     HotplugHandlerClass *hdc;
+    Error *local_err = NULL;
 
     if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
@@ -890,10 +891,14 @@ void qdev_unplug(DeviceState *dev, Error **errp)
      * otherwise just remove it synchronously */
     hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
     if (hdc->unplug_request) {
-        hotplug_handler_unplug_request(hotplug_ctrl, dev, errp);
+        hotplug_handler_unplug_request(hotplug_ctrl, dev, &local_err);
     } else {
-        hotplug_handler_unplug(hotplug_ctrl, dev, errp);
+        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
+        if (!local_err) {
+            object_unparent(OBJECT(dev));
+        }
     }
+    error_propagate(errp, local_err);
 }
 
 void qmp_device_del(const char *id, Error **errp)
-- 
2.17.2
