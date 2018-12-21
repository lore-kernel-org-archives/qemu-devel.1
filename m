Received: from eggs.gnu.org ([2001:4830:134:3::10]:59210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8mq-0004k9-Pd
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8mn-0004gp-H6
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:35:32 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:50017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8ml-0004XS-Gb
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:35:29 -0500
Received: from player795.ha.ovh.net (unknown [10.109.159.222])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C406D20BC57
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:35:25 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:35:09 +0100
Message-ID: <154535250941.862554.15763512831843902652.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 02/15] spapr: move spapr_create_phb() to core
 machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

This function is only used when creating the default PHB. Let's rename
it and move it to the core machine code for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              |   13 ++++++++++++-
 hw/ppc/spapr_pci.c          |   11 -----------
 include/hw/pci-host/spapr.h |    2 --
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8ea680fcde1e..1f17b5d01f4f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2551,6 +2551,17 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     }
 }
 
+static PCIHostState *spapr_create_default_phb(void)
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
 static void spapr_machine_init(MachineState *machine)
 {
@@ -2782,7 +2793,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Set up PCI */
     spapr_pci_rtas_init();
 
-    phb = spapr_create_phb(spapr, 0);
+    phb = spapr_create_default_phb();
 
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2374d55fc112..e59adbe706bb 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1979,17 +1979,6 @@ static const TypeInfo spapr_phb_info = {
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
index 7c66c3872f96..a65cfef16945 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
     return spapr_qirq(spapr, phb->lsi_table[pin].irq);
 }
 
-PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
-
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
                           uint32_t nr_msis);
 
