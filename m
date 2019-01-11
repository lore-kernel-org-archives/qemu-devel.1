Received: from eggs.gnu.org ([209.51.188.92]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3xu-0006Dz-8r
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gi3xq-0002cT-8f
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:03:42 -0500
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:39150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gi3xo-0002Wb-8n
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 16:03:36 -0500
Received: from player799.ha.ovh.net (unknown [10.109.143.246])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6B7DD1EE14D
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 22:03:31 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 11 Jan 2019 22:03:12 +0100
Message-ID: <154724059225.525985.4732492675250957133.stgit@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 08/13] spapr_pci: provide node start offset
 via spapr_populate_pci_dt()
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
index ef8984286587..ebb6fbbb2b69 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1297,7 +1297,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
 
     QLIST_FOREACH(phb, &spapr->phbs, list) {
         ret = spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
-                                    spapr->irq->nr_msis);
+                                    spapr->irq->nr_msis, NULL);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index be9e01d84eaf..d8a285cc291d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2130,7 +2130,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
-                          uint32_t nr_msis)
+                          uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
     gchar *nodename;
@@ -2185,6 +2185,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
     _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
+    if (node_offset) {
+        *node_offset = bus_off;
+    }
 
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 16f42d0c0254..caee5df4d52f 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -114,7 +114,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
-                          uint32_t nr_msis);
+                          uint32_t nr_msis, int *node_offset);
 
 void spapr_pci_rtas_init(void);
 
