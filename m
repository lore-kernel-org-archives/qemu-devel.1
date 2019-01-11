Received: from eggs.gnu.org ([209.51.188.92]:49456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3vR-0004Sl-L4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3vQ-0001Nh-Ej
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:09 -0500
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:47747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3vQ-0001LF-7r
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:01:08 -0500
Received: from player159.ha.ovh.net (unknown [10.109.146.163])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A48BC45B00
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:01:06 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:00:46 +0100
Message-ID: <154724044676.525985.4801504682864299114.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 02/13] spapr: Rename xics to intc in
 interrupt controller agnostic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

All this code is used with both the XICS and XIVE interrupt controllers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c              |    6 +++---
 hw/ppc/spapr_events.c       |    2 +-
 hw/ppc/spapr_pci.c          |    6 +++---
 hw/ppc/spapr_vio.c          |    2 +-
 include/hw/pci-host/spapr.h |    2 +-
 include/hw/ppc/spapr.h      |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 83081defde4e..26f8e55cc25e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,7 +96,7 @@
 
 #define MIN_RMA_SLOF            128UL
 
-#define PHANDLE_XICP            0x00001111
+#define PHANDLE_INTC            0x00001111
 
 /* These two functions implement the VCPU id numbering: one to compute them
  * all and one to identify thread 0 of a VCORE. Any change to the first one
@@ -1276,7 +1276,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
 
     /* /interrupt controller */
     spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
-                          PHANDLE_XICP);
+                          PHANDLE_INTC);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -1296,7 +1296,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     }
 
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret = spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
+        ret = spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
                                     spapr->irq->nr_msis);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 32719a1b72d0..d4e75211954d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -282,7 +282,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *fdt)
             continue;
         }
 
-        spapr_dt_xics_irq(interrupts, source->irq, false);
+        spapr_dt_intc_irq(interrupts, source->irq, false);
 
         _FDT(node_offset = fdt_add_subnode(fdt, event_sources, source_name));
         _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b74f2632ecc6..24f95a400623 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2066,7 +2066,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
 
 }
 
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
+int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
                           uint32_t nr_msis)
 {
     int bus_off, i, j, ret;
@@ -2164,8 +2164,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
             irqmap[1] = 0;
             irqmap[2] = 0;
             irqmap[3] = cpu_to_be32(j+1);
-            irqmap[4] = cpu_to_be32(xics_phandle);
-            spapr_dt_xics_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, true);
+            irqmap[4] = cpu_to_be32(intc_phandle);
+            spapr_dt_intc_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, true);
         }
     }
     /* Write interrupt map */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7e8a9ad09337..cfd9849d8dfb 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -158,7 +158,7 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
     if (dev->irq) {
         uint32_t ints_prop[2];
 
-        spapr_dt_xics_irq(ints_prop, dev->irq, false);
+        spapr_dt_intc_irq(ints_prop, dev->irq, false);
         ret = fdt_setprop(fdt, node_off, "interrupts", ints_prop,
                           sizeof(ints_prop));
         if (ret < 0) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 4eb3a2ce3eb8..e0e683c32469 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -113,7 +113,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
     return spapr_qirq(spapr, phb->lsi_table[pin].irq);
 }
 
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
+int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
                           uint32_t nr_msis);
 
 void spapr_pci_rtas_init(void);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9e01a5a12e4a..7193ce094689 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -682,7 +682,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *fdt, hwaddr addr);
  * "interrupt-controller" node has its "#interrupt-cells" property set to 2 (ie,
  * VIO devices, RTAS event sources and PHBs).
  */
-static inline void spapr_dt_xics_irq(uint32_t *intspec, int irq, bool is_lsi)
+static inline void spapr_dt_intc_irq(uint32_t *intspec, int irq, bool is_lsi)
 {
     intspec[0] = cpu_to_be32(irq);
     intspec[1] = is_lsi ? cpu_to_be32(1) : 0;
