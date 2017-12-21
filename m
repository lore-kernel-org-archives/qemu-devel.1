Received: from eggs.gnu.org ([2001:4830:134:3::10]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qC-0007Y6-ON
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qB-0005Ol-Ef
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:56 -0500
Date: Thu, 21 Dec 2017 16:28:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-8-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/25] pci: Add pci_dev_bus_num() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-s390x@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org

From: David Gibson <david@gibson.dropbear.id.au>

A fair proportion of the users of pci_bus_num() want to get the bus
number on a specific device, so first have to look up the bus from the
device then call it.  This adds a helper to do that (since we're going
to make looking up the bus slightly more verbose).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/pci/pci.h        | 5 +++++
 include/hw/xen/xen_common.h | 8 ++++----
 hw/pci/pcie_aer.c           | 2 +-
 hw/s390x/s390-pci-bus.c     | 2 +-
 hw/scsi/megasas.c           | 2 +-
 hw/scsi/mptsas.c            | 2 +-
 hw/xen/xen_pt.c             | 6 +++---
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 870ebcf..e451235 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -436,6 +436,11 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
 PCIDevice *pci_vga_init(PCIBus *bus);
 
 int pci_bus_num(PCIBus *s);
+static inline int pci_dev_bus_num(const PCIDevice *dev)
+{
+    return pci_bus_num(dev->bus);
+}
+
 int pci_bus_numa_node(PCIBus *bus);
 void pci_for_each_device(PCIBus *bus, int bus_num,
                          void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 86c7f26..64a978e 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -542,10 +542,10 @@ static inline void xen_map_pcidev(domid_t dom,
         return;
     }
 
-    trace_xen_map_pcidev(ioservid, pci_bus_num(pci_dev->bus),
+    trace_xen_map_pcidev(ioservid, pci_dev_bus_num(pci_dev),
                          PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
     xendevicemodel_map_pcidev_to_ioreq_server(xen_dmod, dom, ioservid, 0,
-                                              pci_bus_num(pci_dev->bus),
+                                              pci_dev_bus_num(pci_dev),
                                               PCI_SLOT(pci_dev->devfn),
                                               PCI_FUNC(pci_dev->devfn));
 }
@@ -558,10 +558,10 @@ static inline void xen_unmap_pcidev(domid_t dom,
         return;
     }
 
-    trace_xen_unmap_pcidev(ioservid, pci_bus_num(pci_dev->bus),
+    trace_xen_unmap_pcidev(ioservid, pci_dev_bus_num(pci_dev),
                            PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
     xendevicemodel_unmap_pcidev_from_ioreq_server(xen_dmod, dom, ioservid, 0,
-                                                  pci_bus_num(pci_dev->bus),
+                                                  pci_dev_bus_num(pci_dev),
                                                   PCI_SLOT(pci_dev->devfn),
                                                   PCI_FUNC(pci_dev->devfn));
 }
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 9720074..21f896a 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -1025,7 +1025,7 @@ static int do_pcie_aer_inject_error(Monitor *mon,
     }
     details->id = id;
     details->root_bus = pci_root_bus_path(dev);
-    details->bus = pci_bus_num(dev->bus);
+    details->bus = pci_dev_bus_num(dev);
     details->devfn = dev->devfn;
 
     return 0;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 347329d..f64ad59 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -692,7 +692,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */
             dev->id = g_strdup_printf("auto_%02x:%02x.%01x",
-                                      pci_bus_num(pdev->bus),
+                                      pci_dev_bus_num(pdev),
                                       PCI_SLOT(pdev->devfn),
                                       PCI_FUNC(pdev->devfn));
         }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index d5eae62..3e38e9e 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2372,7 +2372,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     if (!s->sas_addr) {
         s->sas_addr = ((NAA_LOCALLY_ASSIGNED_ID << 24) |
                        IEEE_COMPANY_LOCALLY_ASSIGNED) << 36;
-        s->sas_addr |= (pci_bus_num(dev->bus) << 16);
+        s->sas_addr |= (pci_dev_bus_num(dev) << 16);
         s->sas_addr |= (PCI_SLOT(dev->devfn) << 8);
         s->sas_addr |= PCI_FUNC(dev->devfn);
     }
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index f6db1b0..3f061f3 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1312,7 +1312,7 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
     if (!s->sas_addr) {
         s->sas_addr = ((NAA_LOCALLY_ASSIGNED_ID << 24) |
                        IEEE_COMPANY_LOCALLY_ASSIGNED) << 36;
-        s->sas_addr |= (pci_bus_num(dev->bus) << 16);
+        s->sas_addr |= (pci_dev_bus_num(dev) << 16);
         s->sas_addr |= (PCI_SLOT(dev->devfn) << 8);
         s->sas_addr |= PCI_FUNC(dev->devfn);
     }
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9bba717..6236f0c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -73,7 +73,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
 
     va_start(ap, f);
     if (d) {
-        fprintf(stderr, "[%02x:%02x.%d] ", pci_bus_num(d->bus),
+        fprintf(stderr, "[%02x:%02x.%d] ", pci_dev_bus_num(d),
                 PCI_SLOT(d->devfn), PCI_FUNC(d->devfn));
     }
     vfprintf(stderr, f, ap);
@@ -711,7 +711,7 @@ static void xen_pt_destroy(PCIDevice *d) {
         intx = xen_pt_pci_intx(s);
         rc = xc_domain_unbind_pt_irq(xen_xc, xen_domid, machine_irq,
                                      PT_IRQ_TYPE_PCI,
-                                     pci_bus_num(d->bus),
+                                     pci_dev_bus_num(d),
                                      PCI_SLOT(s->dev.devfn),
                                      intx,
                                      0 /* isa_irq */);
@@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         uint8_t e_intx = xen_pt_pci_intx(s);
 
         rc = xc_domain_bind_pt_pci_irq(xen_xc, xen_domid, machine_irq,
-                                       pci_bus_num(d->bus),
+                                       pci_dev_bus_num(d),
                                        PCI_SLOT(d->devfn),
                                        e_intx);
         if (rc < 0) {
-- 
MST
