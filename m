Received: from eggs.gnu.org ([2001:4830:134:3::10]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qY-0007qL-FA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qU-0005cp-Sl
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:18 -0500
Date: Thu, 21 Dec 2017 16:28:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-9-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/25] pci: Eliminate redundant PCIDevice::bus
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

From: David Gibson <david@gibson.dropbear.id.au>

The bus pointer in PCIDevice is basically redundant with QOM information.
It's always initialized to the qdev_get_parent_bus(), the only difference
is the type.

Therefore this patch eliminates the field, instead creating a pci_get_bus()
helper to do the type mangling to derive it conveniently from the QOM
Device object underneath.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/pci/pci.h                |  9 +++--
 hw/acpi/pcihp.c                     |  4 +-
 hw/acpi/piix4.c                     |  7 ++--
 hw/i386/xen/xen_platform.c          | 12 +++---
 hw/isa/lpc_ich9.c                   | 10 ++---
 hw/net/vmxnet3.c                    |  2 +-
 hw/pci-bridge/pci_expander_bridge.c | 17 +++++----
 hw/pci-host/piix.c                  | 10 ++---
 hw/pci-host/versatile.c             |  2 +-
 hw/pci/pci.c                        | 76 +++++++++++++++++++------------------
 hw/pci/pci_bridge.c                 |  6 +--
 hw/pci/pcie.c                       |  5 ++-
 hw/pci/pcie_aer.c                   |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/s390x/s390-pci-bus.c             |  8 ++--
 hw/scsi/vmw_pvscsi.c                |  2 +-
 hw/usb/hcd-xhci.c                   |  2 +-
 hw/vfio/pci.c                       | 10 ++---
 hw/virtio/virtio-pci.c              |  4 +-
 hw/xen/xen_pt.c                     |  4 +-
 20 files changed, 102 insertions(+), 92 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e451235..597ffb7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -285,7 +285,6 @@ struct PCIDevice {
     uint8_t *used;
 
     /* the following fields are read only */
-    PCIBus *bus;
     int32_t devfn;
     /* Cached device to fetch requester ID from, to avoid the PCI
      * tree walking every time we invoke PCI request (e.g.,
@@ -435,10 +434,14 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
 
 PCIDevice *pci_vga_init(PCIBus *bus);
 
+static inline PCIBus *pci_get_bus(const PCIDevice *dev)
+{
+    return PCI_BUS(qdev_get_parent_bus(DEVICE(dev)));
+}
 int pci_bus_num(PCIBus *s);
 static inline int pci_dev_bus_num(const PCIDevice *dev)
 {
-    return pci_bus_num(dev->bus);
+    return pci_bus_num(pci_get_bus(dev));
 }
 
 int pci_bus_numa_node(PCIBus *bus);
@@ -745,7 +748,7 @@ static inline uint32_t pci_config_size(const PCIDevice *d)
 
 static inline uint16_t pci_get_bdf(PCIDevice *dev)
 {
-    return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
+    return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
 uint16_t pci_requester_id(PCIDevice *dev);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7da51c0..91c82fd 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -223,7 +223,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
-    int bsel = acpi_pcihp_get_bsel(pdev->bus);
+    int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");
@@ -246,7 +246,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
-    int bsel = acpi_pcihp_get_bsel(pdev->bus);
+    int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a0fb1ce..8b70345 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -460,9 +460,9 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 
     if (s->use_acpi_pci_hotplug) {
-        pci_for_each_bus(d->bus, piix4_update_bus_hotplug, s);
+        pci_for_each_bus(pci_get_bus(d), piix4_update_bus_hotplug, s);
     } else {
-        piix4_update_bus_hotplug(d->bus, s);
+        piix4_update_bus_hotplug(pci_get_bus(d), s);
     }
 }
 
@@ -535,7 +535,8 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_ready);
     qemu_register_reset(piix4_reset, s);
 
-    piix4_acpi_system_hot_add_init(pci_address_space_io(dev), dev->bus, s);
+    piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
+                                   pci_get_bus(dev), s);
 
     piix4_pm_add_propeties(s);
 }
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 056b87d..9ab5483 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -186,11 +186,11 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
         if (val & (UNPLUG_IDE_SCSI_DISKS | UNPLUG_AUX_IDE_DISKS |
                    UNPLUG_NVME_DISKS)) {
             DPRINTF("unplug disks\n");
-            pci_unplug_disks(pci_dev->bus, val);
+            pci_unplug_disks(pci_get_bus(pci_dev), val);
         }
         if (val & UNPLUG_ALL_NICS) {
             DPRINTF("unplug nics\n");
-            pci_unplug_nics(pci_dev->bus);
+            pci_unplug_nics(pci_get_bus(pci_dev));
         }
         break;
     }
@@ -372,17 +372,17 @@ static void xen_platform_ioport_writeb(void *opaque, hwaddr addr,
              * If VMDP was to control both disk and LAN it would use 4.
              * If it controlled just disk or just LAN, it would use 8 below.
              */
-            pci_unplug_disks(pci_dev->bus, UNPLUG_IDE_SCSI_DISKS);
-            pci_unplug_nics(pci_dev->bus);
+            pci_unplug_disks(pci_get_bus(pci_dev), UNPLUG_IDE_SCSI_DISKS);
+            pci_unplug_nics(pci_get_bus(pci_dev));
         }
         break;
     case 8:
         switch (val) {
         case 1:
-            pci_unplug_disks(pci_dev->bus, UNPLUG_IDE_SCSI_DISKS);
+            pci_unplug_disks(pci_get_bus(pci_dev), UNPLUG_IDE_SCSI_DISKS);
             break;
         case 2:
-            pci_unplug_nics(pci_dev->bus);
+            pci_unplug_nics(pci_get_bus(pci_dev));
             break;
         default:
             log_writeb(s, (uint32_t)val);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ec3c9f7..adcf077 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -162,7 +162,7 @@ static void ich9_cc_write(void *opaque, hwaddr addr,
 
     ich9_cc_addr_len(&addr, &len);
     memcpy(lpc->chip_config + addr, &val, len);
-    pci_bus_fire_intx_routing_notifier(lpc->d.bus);
+    pci_bus_fire_intx_routing_notifier(pci_get_bus(&lpc->d));
     ich9_cc_update(lpc);
 }
 
@@ -218,7 +218,7 @@ static void ich9_lpc_update_pic(ICH9LPCState *lpc, int gsi)
         int tmp_dis;
         ich9_lpc_pic_irq(lpc, i, &tmp_irq, &tmp_dis);
         if (!tmp_dis && tmp_irq == gsi) {
-            pic_level |= pci_bus_get_irq_level(lpc->d.bus, i);
+            pic_level |= pci_bus_get_irq_level(pci_get_bus(&lpc->d), i);
         }
     }
     if (gsi == lpc->sci_gsi) {
@@ -246,7 +246,7 @@ static void ich9_lpc_update_apic(ICH9LPCState *lpc, int gsi)
 
     assert(gsi >= ICH9_LPC_PIC_NUM_PINS);
 
-    level |= pci_bus_get_irq_level(lpc->d.bus, ich9_gsi_to_pirq(gsi));
+    level |= pci_bus_get_irq_level(pci_get_bus(&lpc->d), ich9_gsi_to_pirq(gsi));
     if (gsi == lpc->sci_gsi) {
         level |= lpc->sci_level;
     }
@@ -524,10 +524,10 @@ static void ich9_lpc_config_write(PCIDevice *d,
         ich9_lpc_rcba_update(lpc, rcba_old);
     }
     if (ranges_overlap(addr, len, ICH9_LPC_PIRQA_ROUT, 4)) {
-        pci_bus_fire_intx_routing_notifier(lpc->d.bus);
+        pci_bus_fire_intx_routing_notifier(pci_get_bus(&lpc->d));
     }
     if (ranges_overlap(addr, len, ICH9_LPC_PIRQE_ROUT, 4)) {
-        pci_bus_fire_intx_routing_notifier(lpc->d.bus);
+        pci_bus_fire_intx_routing_notifier(pci_get_bus(&lpc->d));
     }
     if (ranges_overlap(addr, len, ICH9_LPC_GEN_PMCON_1, 8)) {
         ich9_lpc_pmcon_update(lpc);
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index b8404cb..0654d59 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2356,7 +2356,7 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
     vmxnet3_net_init(s);
 
     if (pci_is_express(pci_dev)) {
-        if (pci_bus_is_express(pci_dev->bus)) {
+        if (pci_bus_is_express(pci_get_bus(pci_dev))) {
             pcie_endpoint_cap_init(pci_dev, VMXNET3_EXP_EP_OFFSET);
         }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index b2fa829..2a81eec 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -52,7 +52,8 @@ typedef struct PXBDev {
 
 static PXBDev *convert_to_pxb(PCIDevice *dev)
 {
-    return pci_bus_is_express(dev->bus) ? PXB_PCIE_DEV(dev) : PXB_DEV(dev);
+    return pci_bus_is_express(pci_get_bus(dev))
+        ? PXB_PCIE_DEV(dev) : PXB_DEV(dev);
 }
 
 static GList *pxb_dev_list;
@@ -166,7 +167,7 @@ static const TypeInfo pxb_host_info = {
  */
 static void pxb_register_bus(PCIDevice *dev, PCIBus *pxb_bus, Error **errp)
 {
-    PCIBus *bus = dev->bus;
+    PCIBus *bus = pci_get_bus(dev);
     int pxb_bus_num = pci_bus_num(pxb_bus);
 
     if (bus->parent_dev) {
@@ -180,12 +181,12 @@ static void pxb_register_bus(PCIDevice *dev, PCIBus *pxb_bus, Error **errp)
             return;
         }
     }
-    QLIST_INSERT_HEAD(&dev->bus->child, pxb_bus, sibling);
+    QLIST_INSERT_HEAD(&pci_get_bus(dev)->child, pxb_bus, sibling);
 }
 
 static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
 {
-    PCIDevice *pxb = pci_dev->bus->parent_dev;
+    PCIDevice *pxb = pci_get_bus(pci_dev)->parent_dev;
 
     /*
      * The bios does not index the pxb slot number when
@@ -240,8 +241,8 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     }
 
     bus->parent_dev = dev;
-    bus->address_space_mem = dev->bus->address_space_mem;
-    bus->address_space_io = dev->bus->address_space_io;
+    bus->address_space_mem = pci_get_bus(dev)->address_space_mem;
+    bus->address_space_io = pci_get_bus(dev)->address_space_io;
     bus->map_irq = pxb_map_irq_fn;
 
     PCI_HOST_BRIDGE(ds)->bus = bus;
@@ -272,7 +273,7 @@ err_register_bus:
 
 static void pxb_dev_realize(PCIDevice *dev, Error **errp)
 {
-    if (pci_bus_is_express(dev->bus)) {
+    if (pci_bus_is_express(pci_get_bus(dev))) {
         error_setg(errp, "pxb devices cannot reside on a PCIe bus");
         return;
     }
@@ -324,7 +325,7 @@ static const TypeInfo pxb_dev_info = {
 
 static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
 {
-    if (!pci_bus_is_express(dev->bus)) {
+    if (!pci_bus_is_express(pci_get_bus(dev))) {
         error_setg(errp, "pxb-pcie devices cannot reside on a PCI bus");
         return;
     }
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index cf90701..effe3db 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -512,12 +512,12 @@ static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 /* irq routing is changed. so rebuild bitmap */
 static void piix3_update_irq_levels(PIIX3State *piix3)
 {
+    PCIBus *bus = pci_get_bus(&piix3->dev);
     int pirq;
 
     piix3->pic_levels = 0;
     for (pirq = 0; pirq < PIIX_NUM_PIRQS; pirq++) {
-        piix3_set_irq_level(piix3, pirq,
-                            pci_bus_get_irq_level(piix3->dev.bus, pirq));
+        piix3_set_irq_level(piix3, pirq, pci_bus_get_irq_level(bus, pirq));
     }
 }
 
@@ -529,7 +529,7 @@ static void piix3_write_config(PCIDevice *dev,
         PIIX3State *piix3 = PIIX3_PCI_DEVICE(dev);
         int pic_irq;
 
-        pci_bus_fire_intx_routing_notifier(piix3->dev.bus);
+        pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
         piix3_update_irq_levels(piix3);
         for (pic_irq = 0; pic_irq < PIIX_NUM_PIC_IRQS; pic_irq++) {
             piix3_set_irq_pic(piix3, pic_irq);
@@ -601,7 +601,7 @@ static int piix3_post_load(void *opaque, int version_id)
     piix3->pic_levels = 0;
     for (pirq = 0; pirq < PIIX_NUM_PIRQS; pirq++) {
         piix3_set_irq_level_internal(piix3, pirq,
-                            pci_bus_get_irq_level(piix3->dev.bus, pirq));
+            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), pirq));
     }
     return 0;
 }
@@ -613,7 +613,7 @@ static int piix3_pre_save(void *opaque)
 
     for (i = 0; i < ARRAY_SIZE(piix3->pci_irq_levels_vmstate); i++) {
         piix3->pci_irq_levels_vmstate[i] =
-            pci_bus_get_irq_level(piix3->dev.bus, i);
+            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), i);
     }
 
     return 0;
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 8803ada..d0b02bd 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -311,7 +311,7 @@ static const MemoryRegionOps pci_vpb_config_ops = {
 
 static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
 {
-    PCIVPBState *s = container_of(d->bus, PCIVPBState, pci_bus);
+    PCIVPBState *s = container_of(pci_get_bus(d), PCIVPBState, pci_bus);
 
     if (s->irq_mapping == PCI_VPB_IRQMAP_BROKEN) {
         /* Legacy broken IRQ mapping for compatibility with old and
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 232e7da..567be1b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -222,7 +222,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
 {
     PCIBus *bus;
     for (;;) {
-        bus = pci_dev->bus;
+        bus = pci_get_bus(pci_dev);
         irq_num = bus->map_irq(pci_dev, irq_num);
         if (bus->set_irq)
             break;
@@ -349,13 +349,13 @@ PCIBus *pci_find_primary_bus(void)
 
 PCIBus *pci_device_root_bus(const PCIDevice *d)
 {
-    PCIBus *bus = d->bus;
+    PCIBus *bus = pci_get_bus(d);
 
     while (!pci_bus_is_root(bus)) {
         d = bus->parent_dev;
         assert(d != NULL);
 
-        bus = d->bus;
+        bus = pci_get_bus(d);
     }
 
     return bus;
@@ -882,7 +882,7 @@ static void pci_config_free(PCIDevice *pci_dev)
 
 static void do_pci_unregister_device(PCIDevice *pci_dev)
 {
-    pci_dev->bus->devices[pci_dev->devfn] = NULL;
+    pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
     pci_config_free(pci_dev);
 
     if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {
@@ -903,7 +903,7 @@ static uint16_t pci_req_id_cache_extract(PCIReqIDCache *cache)
         result = pci_get_bdf(cache->dev);
         break;
     case PCI_REQ_ID_SECONDARY_BUS:
-        bus_n = pci_bus_num(cache->dev->bus);
+        bus_n = pci_dev_bus_num(cache->dev);
         result = PCI_BUILD_BDF(bus_n, 0);
         break;
     default:
@@ -933,9 +933,9 @@ static PCIReqIDCache pci_req_id_cache_get(PCIDevice *dev)
         .type = PCI_REQ_ID_BDF,
     };
 
-    while (!pci_bus_is_root(dev->bus)) {
+    while (!pci_bus_is_root(pci_get_bus(dev))) {
         /* We are under PCI/PCIe bridges */
-        parent = dev->bus->parent_dev;
+        parent = pci_get_bus(dev)->parent_dev;
         if (pci_is_express(parent)) {
             if (pcie_cap_get_type(parent) == PCI_EXP_TYPE_PCI_BRIDGE) {
                 /* When we pass through PCIe-to-PCI/PCIX bridges, we
@@ -978,7 +978,7 @@ static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
 }
 
 /* -1 for devfn means auto assign */
-static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
+static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                                          const char *name, int devfn,
                                          Error **errp)
 {
@@ -987,8 +987,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     PCIConfigWriteFunc *config_write = pc->config_write;
     Error *local_err = NULL;
     DeviceState *dev = DEVICE(pci_dev);
+    PCIBus *bus = pci_get_bus(pci_dev);
 
-    pci_dev->bus = bus;
     /* Only pci bridges can be attached to extra PCI root buses */
     if (pci_bus_is_root(bus) && bus->parent_dev && !pc->is_bridge) {
         error_setg(errp,
@@ -1142,8 +1142,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     r->type = type;
     r->memory = memory;
     r->address_space = type & PCI_BASE_ADDRESS_SPACE_IO
-                        ? pci_dev->bus->address_space_io
-                        : pci_dev->bus->address_space_mem;
+                        ? pci_get_bus(pci_dev)->address_space_io
+                        : pci_get_bus(pci_dev)->address_space_mem;
 
     wmask = ~(size - 1);
     if (region_num == PCI_ROM_SLOT) {
@@ -1185,21 +1185,23 @@ static void pci_update_vga(PCIDevice *pci_dev)
 void pci_register_vga(PCIDevice *pci_dev, MemoryRegion *mem,
                       MemoryRegion *io_lo, MemoryRegion *io_hi)
 {
+    PCIBus *bus = pci_get_bus(pci_dev);
+
     assert(!pci_dev->has_vga);
 
     assert(memory_region_size(mem) == QEMU_PCI_VGA_MEM_SIZE);
     pci_dev->vga_regions[QEMU_PCI_VGA_MEM] = mem;
-    memory_region_add_subregion_overlap(pci_dev->bus->address_space_mem,
+    memory_region_add_subregion_overlap(bus->address_space_mem,
                                         QEMU_PCI_VGA_MEM_BASE, mem, 1);
 
     assert(memory_region_size(io_lo) == QEMU_PCI_VGA_IO_LO_SIZE);
     pci_dev->vga_regions[QEMU_PCI_VGA_IO_LO] = io_lo;
-    memory_region_add_subregion_overlap(pci_dev->bus->address_space_io,
+    memory_region_add_subregion_overlap(bus->address_space_io,
                                         QEMU_PCI_VGA_IO_LO_BASE, io_lo, 1);
 
     assert(memory_region_size(io_hi) == QEMU_PCI_VGA_IO_HI_SIZE);
     pci_dev->vga_regions[QEMU_PCI_VGA_IO_HI] = io_hi;
-    memory_region_add_subregion_overlap(pci_dev->bus->address_space_io,
+    memory_region_add_subregion_overlap(bus->address_space_io,
                                         QEMU_PCI_VGA_IO_HI_BASE, io_hi, 1);
     pci_dev->has_vga = true;
 
@@ -1208,15 +1210,17 @@ void pci_register_vga(PCIDevice *pci_dev, MemoryRegion *mem,
 
 void pci_unregister_vga(PCIDevice *pci_dev)
 {
+    PCIBus *bus = pci_get_bus(pci_dev);
+
     if (!pci_dev->has_vga) {
         return;
     }
 
-    memory_region_del_subregion(pci_dev->bus->address_space_mem,
+    memory_region_del_subregion(bus->address_space_mem,
                                 pci_dev->vga_regions[QEMU_PCI_VGA_MEM]);
-    memory_region_del_subregion(pci_dev->bus->address_space_io,
+    memory_region_del_subregion(bus->address_space_io,
                                 pci_dev->vga_regions[QEMU_PCI_VGA_IO_LO]);
-    memory_region_del_subregion(pci_dev->bus->address_space_io,
+    memory_region_del_subregion(bus->address_space_io,
                                 pci_dev->vga_regions[QEMU_PCI_VGA_IO_HI]);
     pci_dev->has_vga = false;
 }
@@ -1319,7 +1323,7 @@ static void pci_update_mappings(PCIDevice *d)
 
         /* now do the real mapping */
         if (r->addr != PCI_BAR_UNMAPPED) {
-            trace_pci_update_mappings_del(d, pci_bus_num(d->bus),
+            trace_pci_update_mappings_del(d, pci_dev_bus_num(d),
                                           PCI_SLOT(d->devfn),
                                           PCI_FUNC(d->devfn),
                                           i, r->addr, r->size);
@@ -1327,7 +1331,7 @@ static void pci_update_mappings(PCIDevice *d)
         }
         r->addr = new_addr;
         if (r->addr != PCI_BAR_UNMAPPED) {
-            trace_pci_update_mappings_add(d, pci_bus_num(d->bus),
+            trace_pci_update_mappings_add(d, pci_dev_bus_num(d),
                                           PCI_SLOT(d->devfn),
                                           PCI_FUNC(d->devfn),
                                           i, r->addr, r->size);
@@ -1446,9 +1450,9 @@ PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin)
     PCIBus *bus;
 
     do {
-         bus = dev->bus;
-         pin = bus->map_irq(dev, pin);
-         dev = bus->parent_dev;
+        bus = pci_get_bus(dev);
+        pin = bus->map_irq(dev, pin);
+        dev = bus->parent_dev;
     } while (dev);
 
     if (!bus->route_intx_to_irq) {
@@ -2018,7 +2022,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     PCIDevice *pci_dev = (PCIDevice *)qdev;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     Error *local_err = NULL;
-    PCIBus *bus;
     bool is_default_rom;
 
     /* initialize cap_present for pci_is_express() and pci_config_size() */
@@ -2026,8 +2029,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
-    bus = PCI_BUS(qdev_get_parent_bus(qdev));
-    pci_dev = do_pci_register_device(pci_dev, bus,
+    pci_dev = do_pci_register_device(pci_dev,
                                      object_get_typename(OBJECT(qdev)),
                                      pci_dev->devfn, errp);
     if (pci_dev == NULL)
@@ -2320,7 +2322,7 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
                 error_setg(errp, "%s:%02x:%02x.%x "
                            "Attempt to add PCI capability %x at offset "
                            "%x overlaps existing capability %x at offset %x",
-                           pci_root_bus_path(pdev), pci_bus_num(pdev->bus),
+                           pci_root_bus_path(pdev), pci_dev_bus_num(pdev),
                            PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
                            cap_id, offset, overlapping_cap, i);
                 return -EINVAL;
@@ -2384,7 +2386,7 @@ static void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 
     monitor_printf(mon, "%*sclass %s, addr %02x:%02x.%x, "
                    "pci id %04x:%04x (sub %04x:%04x)\n",
-                   indent, "", ctxt, pci_bus_num(d->bus),
+                   indent, "", ctxt, pci_dev_bus_num(d),
                    PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
                    pci_get_word(d->config + PCI_VENDOR_ID),
                    pci_get_word(d->config + PCI_DEVICE_ID),
@@ -2467,7 +2469,7 @@ static char *pcibus_get_dev_path(DeviceState *dev)
 
     /* Calculate # of slots on path between device and root. */;
     slot_depth = 0;
-    for (t = d; t; t = t->bus->parent_dev) {
+    for (t = d; t; t = pci_get_bus(t)->parent_dev) {
         ++slot_depth;
     }
 
@@ -2482,7 +2484,7 @@ static char *pcibus_get_dev_path(DeviceState *dev)
     /* Fill in slot numbers. We walk up from device to root, so need to print
      * them in the reverse order, last to first. */
     p = path + path_len;
-    for (t = d; t; t = t->bus->parent_dev) {
+    for (t = d; t; t = pci_get_bus(t)->parent_dev) {
         p -= slot_len;
         s = snprintf(slot, sizeof slot, ":%02x.%x",
                      PCI_SLOT(t->devfn), PCI_FUNC(t->devfn));
@@ -2530,12 +2532,12 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
 
 MemoryRegion *pci_address_space(PCIDevice *dev)
 {
-    return dev->bus->address_space_mem;
+    return pci_get_bus(dev)->address_space_mem;
 }
 
 MemoryRegion *pci_address_space_io(PCIDevice *dev)
 {
-    return dev->bus->address_space_io;
+    return pci_get_bus(dev)->address_space_io;
 }
 
 static void pci_device_class_init(ObjectClass *klass, void *data)
@@ -2563,11 +2565,11 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
-    PCIBus *bus = PCI_BUS(dev->bus);
+    PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
 
     while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
-        iommu_bus = PCI_BUS(iommu_bus->parent_dev->bus);
+        iommu_bus = pci_get_bus(iommu_bus->parent_dev);
     }
     if (iommu_bus && iommu_bus->iommu_fn) {
         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
@@ -2638,7 +2640,7 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range)
 
 static bool pcie_has_upstream_port(PCIDevice *dev)
 {
-    PCIDevice *parent_dev = pci_bridge_get_device(dev->bus);
+    PCIDevice *parent_dev = pci_bridge_get_device(pci_get_bus(dev));
 
     /* Device associated with an upstream port.
      * As there are several types of these, it's easier to check the
@@ -2654,12 +2656,14 @@ static bool pcie_has_upstream_port(PCIDevice *dev)
 
 PCIDevice *pci_get_function_0(PCIDevice *pci_dev)
 {
+    PCIBus *bus = pci_get_bus(pci_dev);
+
     if(pcie_has_upstream_port(pci_dev)) {
         /* With an upstream PCIe port, we only support 1 device at slot 0 */
-        return pci_dev->bus->devices[0];
+        return bus->devices[0];
     } else {
         /* Other bus types might support multiple devices at slots 0-31 */
-        return pci_dev->bus->devices[PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 0)];
+        return bus->devices[PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 0)];
     }
 }
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index a47d257..b2e50c3 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -183,7 +183,7 @@ static void pci_bridge_init_vga_aliases(PCIBridge *br, PCIBus *parent,
 static PCIBridgeWindows *pci_bridge_region_init(PCIBridge *br)
 {
     PCIDevice *pd = PCI_DEVICE(br);
-    PCIBus *parent = pd->bus;
+    PCIBus *parent = pci_get_bus(pd);
     PCIBridgeWindows *w = g_new(PCIBridgeWindows, 1);
     uint16_t cmd = pci_get_word(pd->config + PCI_COMMAND);
 
@@ -214,7 +214,7 @@ static PCIBridgeWindows *pci_bridge_region_init(PCIBridge *br)
 static void pci_bridge_region_del(PCIBridge *br, PCIBridgeWindows *w)
 {
     PCIDevice *pd = PCI_DEVICE(br);
-    PCIBus *parent = pd->bus;
+    PCIBus *parent = pci_get_bus(pd);
 
     memory_region_del_subregion(parent->address_space_io, &w->alias_io);
     memory_region_del_subregion(parent->address_space_mem, &w->alias_mem);
@@ -339,7 +339,7 @@ void pci_bridge_reset(DeviceState *qdev)
 /* default qdev initialization function for PCI-to-PCI bridge */
 void pci_bridge_initfn(PCIDevice *dev, const char *typename)
 {
-    PCIBus *parent = dev->bus;
+    PCIBus *parent = pci_get_bus(dev);
     PCIBridge *br = PCI_BRIDGE(dev);
     PCIBus *sec_bus = &br->sec_bus;
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 32191f2..6c91bd4 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -155,7 +155,8 @@ pcie_endpoint_cap_common_init(PCIDevice *dev, uint8_t offset, uint8_t cap_size)
      * a regular Endpoint type is exposed on a root complex.  These
      * should instead be Root Complex Integrated Endpoints.
      */
-    if (pci_bus_is_express(dev->bus) && pci_bus_is_root(dev->bus)) {
+    if (pci_bus_is_express(pci_get_bus(dev))
+        && pci_bus_is_root(pci_get_bus(dev))) {
         type = PCI_EXP_TYPE_RC_END;
     }
 
@@ -369,7 +370,7 @@ void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
     uint8_t *exp_cap;
     PCIDevice *pci_dev = PCI_DEVICE(dev);
-    PCIBus *bus = pci_dev->bus;
+    PCIBus *bus = pci_get_bus(pci_dev);
 
     pcie_cap_slot_hotplug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, errp);
 
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 21f896a..b009be7 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -409,7 +409,7 @@ static void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
              */
             return;
         }
-        dev = pci_bridge_get_device(dev->bus);
+        dev = pci_bridge_get_device(pci_get_bus(dev));
     }
 }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9262682..f38be2f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -505,7 +505,7 @@ static void rtas_ibm_get_config_addr_info2(PowerPCCPU *cpu,
             goto param_error_exit;
         }
 
-        rtas_st(rets, 1, (pci_bus_num(pdev->bus) << 16) + 1);
+        rtas_st(rets, 1, (pci_bus_num(pci_get_bus(pdev)) << 16) + 1);
         break;
     case RTAS_GET_PE_MODE:
         rtas_st(rets, 1, RTAS_PE_MODE_SHARED);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f64ad59..7d9c65e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -680,10 +680,10 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
             s->bus_no += 1;
             pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_no, 1);
             do {
-                pdev = pdev->bus->parent_dev;
+                pdev = pci_get_bus(pdev)->parent_dev;
                 pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
                                          s->bus_no, 1);
-            } while (pdev->bus && pci_bus_num(pdev->bus));
+            } while (pci_get_bus(pdev) && pci_dev_bus_num(pdev));
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
@@ -713,7 +713,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         }
 
         pbdev->pdev = pdev;
-        pbdev->iommu = s390_pci_get_iommu(s, pdev->bus, pdev->devfn);
+        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
 
@@ -807,7 +807,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
 
     s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                  pbdev->fh, pbdev->fid);
-    bus = pci_dev->bus;
+    bus = pci_get_bus(pci_dev);
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
     s390_pci_msix_free(pbdev);
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d564e5c..27749c0 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1133,7 +1133,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
 
     pvscsi_init_msi(s);
 
-    if (pci_is_express(pci_dev) && pci_bus_is_express(pci_dev->bus)) {
+    if (pci_is_express(pci_dev) && pci_bus_is_express(pci_get_bus(pci_dev))) {
         pcie_endpoint_cap_init(pci_dev, PVSCSI_EXP_EP_OFFSET);
     }
 
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index af3a9d8..228e82b 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3416,7 +3416,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &xhci->mem);
 
-    if (pci_bus_is_express(dev->bus) ||
+    if (pci_bus_is_express(pci_get_bus(dev)) ||
         xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
         ret = pcie_endpoint_cap_init(dev, 0xa0);
         assert(ret > 0);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee3..2c71295 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1654,8 +1654,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
         return -EINVAL;
     }
 
-    if (!pci_bus_is_express(vdev->pdev.bus)) {
-        PCIBus *bus = vdev->pdev.bus;
+    if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
+        PCIBus *bus = pci_get_bus(&vdev->pdev);
         PCIDevice *bridge;
 
         /*
@@ -1680,14 +1680,14 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
          */
         while (!pci_bus_is_root(bus)) {
             bridge = pci_bridge_get_device(bus);
-            bus = bridge->bus;
+            bus = pci_get_bus(bridge);
         }
 
         if (pci_bus_is_express(bus)) {
             return 0;
         }
 
-    } else if (pci_bus_is_root(vdev->pdev.bus)) {
+    } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
         /*
          * On a Root Complex bus Endpoints become Root Complex Integrated
          * Endpoints, which changes the type and clears the LNK & LNK2 fields.
@@ -1890,7 +1890,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     uint8_t *config;
 
     /* Only add extended caps if we have them and the guest can see them */
-    if (!pci_is_express(pdev) || !pci_bus_is_express(pdev->bus) ||
+    if (!pci_is_express(pdev) || !pci_bus_is_express(pci_get_bus(pdev)) ||
         !pci_get_long(pdev->config + PCI_CONFIG_SPACE_SIZE)) {
         return;
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e92837c..42b31fb 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1708,8 +1708,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(pci_dev);
-    bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
-                     !pci_bus_is_root(pci_dev->bus);
+    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
+                     !pci_bus_is_root(pci_get_bus(pci_dev));
 
     if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 6236f0c..752b6f6 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -602,7 +602,7 @@ static void xen_pt_region_update(XenPCIPassthroughState *s,
     }
 
     args.type = d->io_regions[bar].type;
-    pci_for_each_device(d->bus, pci_bus_num(d->bus),
+    pci_for_each_device(pci_get_bus(d), pci_dev_bus_num(d),
                         xen_pt_check_bar_overlap, &args);
     if (args.rc) {
         XEN_PT_WARN(d, "Region: %d (addr: %#"FMT_PCIBUS
@@ -695,7 +695,7 @@ xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
     PCIDevice *d = &s->dev;
 
     gpu_dev_id = dev->device_id;
-    igd_passthrough_isa_bridge_create(d->bus, gpu_dev_id);
+    igd_passthrough_isa_bridge_create(pci_get_bus(d), gpu_dev_id);
 }
 
 /* destroy. */
-- 
MST
