Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4Ak-0004W6-F5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4Ah-0004VM-Cj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:06 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:60606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da4Ah-0004U1-6c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:03 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DEC171151B3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:03:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:02:54 +0200
Message-ID: <150100577425.27487.12203768480364790462.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 23/26] spapr_pci: add ibm,
 my-drc-index property for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This is needed to denote a boot-time PHB as being hot-pluggable.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
- use phb->drc_id
---
 hw/ppc/spapr_pci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 79f10ff453d0..58406a1b7e93 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2160,6 +2160,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     sPAPRTCETable *tcet;
     PCIBus *bus = PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
+    sPAPRDRConnector *drc;
 
     /* Start populating the FDT */
     snprintf(nodename, FDT_NAME_MAX, "pci@%" PRIx64, phb->buid);
@@ -2229,6 +2230,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
                  tcet->liobn, tcet->bus_offset,
                  tcet->nb_table << tcet->page_shift);
 
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, phb->drc_id);
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
