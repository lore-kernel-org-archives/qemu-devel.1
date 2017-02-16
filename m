Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQc-0001lN-GY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQZ-0005GJ-E6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:58 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:39880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMQZ-0005G1-7t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:55 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id DA0702405F
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:48:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:30 +0100
Message-Id: <1487252865-12064-8-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/22] ppc/xics: use the QOM interface to
 get irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c              | 5 +++--
 hw/ppc/spapr_events.c       | 6 +++---
 hw/ppc/spapr_pci.c          | 2 +-
 include/hw/pci-host/spapr.h | 2 +-
 include/hw/ppc/spapr_vio.h  | 2 +-
 include/hw/ppc/xics.h       | 3 ++-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 39c442f70116..0ffdf09c5304 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -747,9 +747,10 @@ ICSState *xics_find_source(XICSState *xics, int irq)
     return NULL;
 }
=20
-qemu_irq xics_get_qirq(XICSState *xics, int irq)
+qemu_irq xics_get_qirq(XICSInterface *xi, int irq)
 {
-    ICSState *ics =3D xics_find_source(xics, irq);
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
+    ICSState *ics =3D xic->ics_get(xi, irq);
=20
     if (ics) {
         return ics->qirqs[irq - ics->offset];
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 38b4258a9be7..aa627dc13008 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -481,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
=20
     rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
=20
-    qemu_irq_pulse(xics_get_qirq(spapr->xics,
+    qemu_irq_pulse(xics_get_qirq(XICS_INTERFACE(spapr),
                                  rtas_event_log_to_irq(spapr,
                                                        RTAS_LOG_TYPE_EPO=
W)));
 }
@@ -574,7 +574,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
=20
     rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
=20
-    qemu_irq_pulse(xics_get_qirq(spapr->xics,
+    qemu_irq_pulse(xics_get_qirq(XICS_INTERFACE(spapr),
                                  rtas_event_log_to_irq(spapr,
                                                        RTAS_LOG_TYPE_HOT=
PLUG)));
 }
@@ -695,7 +695,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
                 spapr_event_sources_get_source(spapr->event_sources, i);
=20
             g_assert(source->enabled);
-            qemu_irq_pulse(xics_get_qirq(spapr->xics, source->irq));
+            qemu_irq_pulse(xics_get_qirq(XICS_INTERFACE(spapr), source->=
irq));
         }
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 01d5c92425ed..e52d6e993c9e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -736,7 +736,7 @@ static void spapr_msi_write(void *opaque, hwaddr addr=
,
=20
     trace_spapr_pci_msi_write(addr, data, irq);
=20
-    qemu_irq_pulse(xics_get_qirq(spapr->xics, irq));
+    qemu_irq_pulse(xics_get_qirq(XICS_INTERFACE(spapr), irq));
 }
=20
 static const MemoryRegionOps spapr_msi_ops =3D {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 092294ed5a65..bfd307be30ca 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -106,7 +106,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    return xics_get_qirq(spapr->xics, phb->lsi_table[pin].irq);
+    return xics_get_qirq(XICS_INTERFACE(spapr), phb->lsi_table[pin].irq)=
;
 }
=20
 PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index fc6f673ea086..1b04523b683d 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -87,7 +87,7 @@ static inline qemu_irq spapr_vio_qirq(VIOsPAPRDevice *d=
ev)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    return xics_get_qirq(spapr->xics, dev->irq);
+    return xics_get_qirq(XICS_INTERFACE(spapr), dev->irq);
 }
=20
 static inline bool spapr_vio_dma_valid(VIOsPAPRDevice *dev, uint64_t tad=
dr,
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 640603b3d76d..896fa5d87c1c 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -197,7 +197,8 @@ typedef struct XICSInterfaceClass {
=20
 #define XICS_IRQS_SPAPR               1024
=20
-qemu_irq xics_get_qirq(XICSState *icp, int irq);
+qemu_irq xics_get_qirq(XICSInterface *xi, int irq);
+
 int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)=
;
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
                            Error **errp);
--=20
2.7.4
