Received: from eggs.gnu.org ([2001:4830:134:3::10]:50450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqO7-0006FX-Dd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqO6-0004X3-Fb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqO6-0004Wb-8K
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97EE5804EB
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:19:09 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:19:09 -0600
Message-ID: <20180313201909.2327.86152.stgit@gimli.home>
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 11/11] ppc/spapr,
 vfio: Turn off MSIX emulation for VFIO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds a possibility for the platform to tell VFIO not to emulate MSIX
so MMIO memory regions do not get split into chunks in flatview and
the entire page can be registered as a KVM memory slot and make direct
MMIO access possible for the guest.

This enables the entire MSIX BAR mapping to the guest for the pseries
platform in order to achieve the maximum MMIO preformance for certain
devices.

Tested on:
LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/ppc/spapr.c |    7 +++++++
 hw/vfio/pci.c  |   13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7e1c85856622..032d03423f97 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2855,6 +2855,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
     spapr->use_hotplug_event_source = value;
 }
 
+static bool spapr_get_msix_emulation(Object *obj, Error **errp)
+{
+    return true;
+}
+
 static char *spapr_get_resize_hpt(Object *obj, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -2936,6 +2941,8 @@ static void spapr_instance_init(Object *obj)
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this were"
                                     " the host's SMT mode", &error_abort);
+    object_property_add_bool(obj, "vfio-no-msix-emulation",
+                             spapr_get_msix_emulation, NULL, NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 02974f4eb976..b9bc6cd31084 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1581,6 +1581,19 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      */
     memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
 
+    /*
+     * The emulated machine may provide a paravirt interface for MSIX setup
+     * so it is not strictly necessary to emulate MSIX here. This becomes
+     * helpful when frequently accessed MMIO registers are located in
+     * subpages adjacent to the MSIX table but the MSIX data containing page
+     * cannot be mapped because of a host page size bigger than the MSIX table
+     * alignment.
+     */
+    if (object_property_get_bool(OBJECT(qdev_get_machine()),
+                                 "vfio-no-msix-emulation", NULL)) {
+        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
+    }
+
     return 0;
 }
 
