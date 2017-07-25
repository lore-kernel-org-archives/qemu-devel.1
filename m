Received: from eggs.gnu.org ([2001:4830:134:3::10]:56521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46F-0000MS-TW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da46C-0000oi-UW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:28 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:45301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da46C-0000oJ-I9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:58:24 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0E0F711634A
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:58:23 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 19:58:15 +0200
Message-ID: <150100549536.27487.11322702271540744350.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 01/26] spapr: move spapr_create_phb()
 to core machine code
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

This function is only used when creating the default PHB. Let's rename
it and move it to the core machine code for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c              |   13 ++++++++++++-
 hw/ppc/spapr_pci.c          |   11 -----------
 include/hw/pci-host/spapr.h |    2 --
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2a3e53d5d58c..53969315ac24 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2142,6 +2142,17 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     g_free(type);
 }
 
+static PCIHostState *spapr_create_default_phb(sPAPRMachineState *spapr)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
+    qdev_prop_set_uint32(dev, "index", 0);
+    qdev_init_nofail(dev);
+
+    return PCI_HOST_BRIDGE(dev);
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void ppc_spapr_init(MachineState *machine)
 {
@@ -2374,7 +2385,7 @@ static void ppc_spapr_init(MachineState *machine)
     /* Set up PCI */
     spapr_pci_rtas_init();
 
-    phb = spapr_create_phb(spapr, 0);
+    phb = spapr_create_default_phb(spapr);
 
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d84abf1070a0..70a99a032267 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1982,17 +1982,6 @@ static const TypeInfo spapr_phb_info = {
     }
 };
 
-PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
-    qdev_prop_set_uint32(dev, "index", index);
-    qdev_init_nofail(dev);
-
-    return PCI_HOST_BRIDGE(dev);
-}
-
 typedef struct sPAPRFDT {
     void *fdt;
     int node_off;
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 38470b2f0e5c..5a4e9686d562 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
     return xics_get_qirq(XICS_FABRIC(spapr), phb->lsi_table[pin].irq);
 }
 
-PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
-
 int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           uint32_t xics_phandle,
                           void *fdt);
