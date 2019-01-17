Received: from eggs.gnu.org ([209.51.188.92]:37747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGy-00035U-9c
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGx-000193-Bw
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBGx-0000YS-0H
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHF6Q8052892
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2wxeg17t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:15:55 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:15:52 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:15:45 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774534523.1208625.1261705878255116413.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 12/19] spapr_pci: provide node start offset
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
index 83ec79caf48e..2c8d0c0e149c 100644
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
index e8c9dcaf2250..e85cb31e0447 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2139,7 +2139,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
-                          uint32_t nr_msis)
+                          uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
     gchar *nodename;
@@ -2194,6 +2194,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
     nodename = g_strdup_printf("pci@%" PRIx64, phb->buid);
     _FDT(bus_off = fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
+    if (node_offset) {
+        *node_offset = bus_off;
+    }
 
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 2ab75e28dbb5..e8ad1530d31d 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -114,7 +114,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 }
 
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
-                          uint32_t nr_msis);
+                          uint32_t nr_msis, int *node_offset);
 
 void spapr_pci_rtas_init(void);
 
