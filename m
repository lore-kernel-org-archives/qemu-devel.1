Received: from eggs.gnu.org ([2001:4830:134:3::10]:58327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4AY-0004Ju-0S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4AU-0004KZ-UM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:54 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:49771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da4AU-0004JJ-NU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:02:50 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3A620114B8D
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:02:49 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:02:41 +0200
Message-ID: <150100576156.27487.15628232978800114846.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 22/26] spapr_pci: provide node start
 offset via spapr_populate_pci_dt()
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

PHB hotplug re-uses PHB device tree generation code and passes
it to a guest via RTAS. Doing this requires knowledge of where
exactly in the device tree the node describing the PHB begins.

Provide this via a new optional pointer that can be used to
store the PHB node's start offset.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
---
 hw/ppc/spapr.c              |    2 +-
 hw/ppc/spapr_pci.c          |    6 +++++-
 include/hw/pci-host/spapr.h |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 632040f35ecc..1a6cd4efeb97 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1098,7 +1098,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     }
 
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret = spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
+        ret = spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, NULL);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b73e099e0285..79f10ff453d0 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2109,7 +2109,8 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           uint32_t xics_phandle,
-                          void *fdt)
+                          void *fdt,
+                          int *node_offset)
 {
     int bus_off, i, j, ret;
     char nodename[FDT_NAME_MAX];
@@ -2166,6 +2167,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     if (bus_off < 0) {
         return bus_off;
     }
+    if (node_offset) {
+        *node_offset = bus_off;
+    }
 
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 31bae68167f2..7837fb0b1110 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -115,7 +115,8 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           uint32_t xics_phandle,
-                          void *fdt);
+                          void *fdt,
+                          int *node_offset);
 
 void spapr_pci_rtas_init(void);
 
