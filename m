Received: from eggs.gnu.org ([2001:4830:134:3::10]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJx-00016A-2R
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJs-0007aL-S1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:37 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:59105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJs-0007ZX-L9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:32 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 60140B3AA6
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:30:28 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:16 +0100
Message-Id: <1488205773-30436-10-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/26] ppc/xics: use the QOM interface to
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c              | 5 +++--
 hw/ppc/spapr_events.c       | 6 +++---
 hw/ppc/spapr_pci.c          | 2 +-
 include/hw/pci-host/spapr.h | 2 +-
 include/hw/ppc/spapr_vio.h  | 2 +-
 include/hw/ppc/xics.h       | 3 ++-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c6bfb610fd32..e3dbe63fc021 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -766,9 +766,10 @@ ICSState *xics_find_source(XICSState *xics, int irq)
     return NULL;
 }
=20
-qemu_irq xics_get_qirq(XICSState *xics, int irq)
+qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
 {
-    ICSState *ics =3D xics_find_source(xics, irq);
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
+    ICSState *ics =3D xic->ics_get(xi, irq);
=20
     if (ics) {
         return ics->qirqs[irq - ics->offset];
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 38b4258a9be7..24a5758e6243 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -481,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
=20
     rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
=20
-    qemu_irq_pulse(xics_get_qirq(spapr->xics,
+    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
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
+    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
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
+            qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr), source->irq=
));
         }
     }
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3f580a68be8e..701eb3fec94e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -737,7 +737,7 @@ static void spapr_msi_write(void *opaque, hwaddr addr=
,
=20
     trace_spapr_pci_msi_write(addr, data, irq);
=20
-    qemu_irq_pulse(xics_get_qirq(spapr->xics, irq));
+    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr), irq));
 }
=20
 static const MemoryRegionOps spapr_msi_ops =3D {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 092294ed5a65..dfa76143f305 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -106,7 +106,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    return xics_get_qirq(spapr->xics, phb->lsi_table[pin].irq);
+    return xics_get_qirq(XICS_FABRIC(spapr), phb->lsi_table[pin].irq);
 }
=20
 PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index fc6f673ea086..2e9685a5d900 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -87,7 +87,7 @@ static inline qemu_irq spapr_vio_qirq(VIOsPAPRDevice *d=
ev)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    return xics_get_qirq(spapr->xics, dev->irq);
+    return xics_get_qirq(XICS_FABRIC(spapr), dev->irq);
 }
=20
 static inline bool spapr_vio_dma_valid(VIOsPAPRDevice *dev, uint64_t tad=
dr,
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1161d5487b4f..094756dd75a0 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -198,7 +198,8 @@ typedef struct XICSFabricClass {
=20
 #define XICS_IRQS_SPAPR               1024
=20
-qemu_irq xics_get_qirq(XICSState *icp, int irq);
+qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
+
 int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)=
;
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
                            Error **errp);
--=20
2.7.4
