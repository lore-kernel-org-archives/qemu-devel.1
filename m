Received: from eggs.gnu.org ([209.51.188.92]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw932-00035U-Rz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw931-0008WB-Ne
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw931-0008Iq-FX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:19:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEKbe115215
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:54 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrkhk8yt5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:52 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:18:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:18:44 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059672420.1466090.15147504040270659866.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 14/17] spapr_pci: add ibm,
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
index a0e17694396a..03fc26985ab1 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2203,6 +2203,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
     sPAPRTCETable *tcet;
     PCIBus *bus = PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
+    sPAPRDRConnector *drc;
 
     /* Start populating the FDT */
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2269,6 +2270,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
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
