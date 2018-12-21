Received: from eggs.gnu.org ([2001:4830:134:3::10]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8qF-0007rN-Bv
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8qC-00018g-4s
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:39:03 -0500
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:44534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8qB-000141-TB
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:39:00 -0500
Received: from player737.ha.ovh.net (unknown [10.109.160.5])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 43AB542E1C
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:38:54 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:38:38 +0100
Message-ID: <154535271886.862554.6726021603616372000.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 12/15] spapr_pci: provide node start offset via
 spapr_populate_pci_dt()
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
 hw/ppc/spapr.c              |    2 +-
 hw/ppc/spapr_pci.c          |    5 ++++-
 include/hw/pci-host/spapr.h |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4f9d11b14666..5c405a5fafca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1297,7 +1297,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
 
     QLIST_FOREACH(phb, &spapr->phbs, list) {
         ret = spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
-                                    spapr->irq->nr_msis);
+                                    spapr->irq->nr_msis, NULL);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 292dd95cbef9..5e7b40a8c910 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2140,7 +2140,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
-                          uint32_t nr_msis)
+                          uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
     gchar *nodename;
@@ -2195,6 +2195,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
     _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
+    if (node_offset) {
+        *node_offset = bus_off;
+    }
 
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 83d5075a6ef3..6ef8f141ea92 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -114,7 +114,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, void *fdt,
-                          uint32_t nr_msis);
+                          uint32_t nr_msis, int *node_offset);
 
 void spapr_pci_rtas_init(void);
 
