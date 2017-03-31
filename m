Received: from eggs.gnu.org ([2001:4830:134:3::10]:39367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7z-0001fc-46
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7w-0007Db-19
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7v-0007DD-Pj
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:43 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:33 +0800
Message-Id: <1490945793-21276-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1490945793-21276-1-git-send-email-peterx@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 5/5] pci: move dma_as init back to bus
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

This patch partly reverted commit b86eacb ("hw/pci: delay
bus_master_enable_region initialization"). In that patch, we postponed
pci DMA address space initialization to support the new "-device"
interface for "intel-iommu" device. Now since we have vIOMMUs inited
back during machine init phase, we won't need this notifier mechanism
any more.

This brings us a benefit that all device realization will be able to
have a valid bus_master_as now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pci.c             | 21 +--------------------
 include/hw/pci/pci_bus.h |  2 --
 include/sysemu/sysemu.h  |  1 -
 vl.c                     |  5 -----
 4 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bd8043c..dd32ddf 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -94,25 +94,10 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
                                 &pci_dev->bus_master_enable_region);
 }
 
-static void pcibus_machine_done(Notifier *notifier, void *data)
-{
-    PCIBus *bus = container_of(notifier, PCIBus, machine_done);
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(bus->devices); ++i) {
-        if (bus->devices[i]) {
-            pci_init_bus_master(bus->devices[i]);
-        }
-    }
-}
-
 static void pci_bus_realize(BusState *qbus, Error **errp)
 {
     PCIBus *bus = PCI_BUS(qbus);
 
-    bus->machine_done.notify = pcibus_machine_done;
-    qemu_add_machine_init_done_notifier(&bus->machine_done);
-
     vmstate_register(NULL, -1, &vmstate_pcibus, bus);
 }
 
@@ -120,8 +105,6 @@ static void pci_bus_unrealize(BusState *qbus, Error **errp)
 {
     PCIBus *bus = PCI_BUS(qbus);
 
-    qemu_remove_machine_init_done_notifier(&bus->machine_done);
-
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
@@ -1004,9 +987,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
 
-    if (qdev_hotplug) {
-        pci_init_bus_master(pci_dev);
-    }
+    pci_init_bus_master(pci_dev);
     pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     pci_dev->irq_state = 0;
     pci_config_alloc(pci_dev);
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 5484a9b..403fec6 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -39,8 +39,6 @@ struct PCIBus {
        Keep a count of the number of devices with raised IRQs.  */
     int nirq;
     int *irq_count;
-
-    Notifier machine_done;
 };
 
 typedef struct PCIBridgeWindows PCIBridgeWindows;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..8b686b5 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -73,7 +73,6 @@ void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
 void qemu_add_machine_init_done_notifier(Notifier *notify);
-void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 int save_vmstate(Monitor *mon, const char *name);
diff --git a/vl.c b/vl.c
index b18bde7..3786a08 100644
--- a/vl.c
+++ b/vl.c
@@ -2660,11 +2660,6 @@ void qemu_add_machine_init_done_notifier(Notifier *notify)
     }
 }
 
-void qemu_remove_machine_init_done_notifier(Notifier *notify)
-{
-    notifier_remove(notify);
-}
-
 static void qemu_run_machine_init_done_notifiers(void)
 {
     notifier_list_notify(&machine_init_done_notifiers, NULL);
-- 
2.7.4
