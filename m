Received: from eggs.gnu.org ([209.51.188.92]:51267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkV-0003zZ-HV
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkU-0000P3-8B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCRkN-0008Ol-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x35GTAoC115703
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 12:30:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rpacwgkpp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 12:30:49 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 5 Apr 2019 17:30:47 +0100
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 Apr 2019 18:30:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH for-4.1 1/2] spapr_pci: Get rid of duplicate
 code for node name creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

According to the changelog of 298a971024534, SpaprPhbState::dtbusname was
introduced to "make it easier to relate the guest and qemu views of memory
to each other", hence its name.

Use it when creating the PHB node to avoid code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bba3a86dda6c..c70688a0dc23 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2153,7 +2153,6 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
                           uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
-    gchar *nodename;
     uint32_t bus_range[] = { cpu_to_be32(0), cpu_to_be32(0xff) };
     struct {
         uint32_t hi;
@@ -2204,9 +2203,7 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
     Error *errp = NULL;
 
     /* Start populating the FDT */
-    nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
-    _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(bus_off = fdt_add_subnode(fdt, 0, phb->dtbusname));
     if (node_offset) {
         *node_offset = bus_off;
     }
