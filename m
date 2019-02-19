Received: from eggs.gnu.org ([209.51.188.92]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw928-0002Jd-Hs
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gw926-0007N0-8L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gw924-00075K-00
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:18:13 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JHEH91115996
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrmfgdeen-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:18:02 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 19 Feb 2019 17:17:59 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Feb 2019 18:17:53 +0100
In-Reply-To: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155059667346.1466090.326696113231137772.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v5 04/17] spapr/pci: Generate FDT fragment at
 configure connector time
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

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c          |    1 +
 hw/ppc/spapr_pci.c          |   19 ++++++++++++-------
 include/hw/pci-host/spapr.h |    4 +++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa26aa40be39..248eb8a93d6d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -691,6 +691,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
     drck->typename = "28";
     drck->drc_name_prefix = "C";
     drck->release = spapr_phb_remove_pci_device_cb;
+    drck->dt_populate = spapr_pci_dt_populate;
 }
 
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 60777b2355db..b22c9f57b2dd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1408,6 +1408,17 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
     return spapr_drc_index(drc);
 }
 
+int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp)
+{
+    HotplugHandler *plug_handler = qdev_get_hotplug_handler(drc->dev);
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(plug_handler);
+    PCIDevice *pdev = PCI_DEVICE(drc->dev);
+
+    *fdt_start_offset = spapr_create_pci_child_dt(sphb, pdev, fdt, 0);
+    return 0;
+}
+
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
@@ -1417,8 +1428,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     Error *local_err = NULL;
     PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
-    void *fdt = NULL;
-    int fdt_start_offset, fdt_size;
 
     /* if DR is disabled we don't need to do anything in the case of
      * hotplug or coldplug callbacks
@@ -1448,10 +1457,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
         goto out;
     }
 
-    fdt = create_device_tree(&fdt_size);
-    fdt_start_offset = spapr_create_pci_child_dt(phb, pdev, fdt, 0);
-
-    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset, &local_err);
+    spapr_drc_attach(drc, DEVICE(pdev), NULL, 0, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1483,7 +1489,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
 out:
     if (local_err) {
         error_propagate(errp, local_err);
-        g_free(fdt);
     }
 }
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 51d81c4b7ce8..f6e43f48fefa 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -121,8 +121,10 @@ sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t buid);
 PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
                               uint32_t config_addr);
 
-/* PCI release callback. */
+/* DRC callbacks */
 void spapr_phb_remove_pci_device_cb(DeviceState *dev);
+int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp);
 
 /* VFIO EEH hooks */
 #ifdef CONFIG_LINUX
