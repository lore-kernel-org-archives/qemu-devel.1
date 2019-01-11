Received: from eggs.gnu.org ([209.51.188.92]:50522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3yC-0006SN-JM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3yA-0002oN-RP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:04:00 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:38191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3yA-0002lk-0Q
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:03:58 -0500
Received: from player698.ha.ovh.net (unknown [10.109.143.183])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 328D3E7B6F
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:03:55 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:03:36 +0100
Message-ID: <154724061631.525985.17693829495178769590.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 09/13] spapr_pci: add ibm,
 my-drc-index property for PHB hotplug
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

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This is needed to denote a boot-time PHB as being hot-pluggable.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d8a285cc291d..f2b9066ecabe 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2180,6 +2180,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
     sPAPRTCETable *tcet;
     PCIBus *bus = PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
+    sPAPRDRConnector *drc;
 
     /* Start populating the FDT */
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2246,6 +2247,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
                  tcet->liobn, tcet->bus_offset,
                  tcet->nb_table << tcet->page_shift);
 
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, phb->index);
+    if (drc) {
+        uint32_t drc_index = cpu_to_be32(spapr_drc_index(drc));
+
+        _FDT(fdt_setprop(fdt, bus_off, "ibm,my-drc-index", &drc_index,
+                         sizeof(drc_index)));
+    }
+
     /* Walk the bridges and program the bus numbers*/
     spapr_phb_pci_enumerate(phb);
     _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
