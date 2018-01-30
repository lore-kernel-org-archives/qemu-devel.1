Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1G-0006yD-NY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1F-0001jt-8T
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:55:38 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 30 Jan 2018 14:55:27 +1100
Message-Id: <20180130035527.47336-3-aik@ozlabs.ru>
In-Reply-To: <20180130035527.47336-1-aik@ozlabs.ru>
References: <20180130035527.47336-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 2/2] RFC: vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>

This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
which tells that a region with MSIX data can be mapped entirely, i.e.
the VFIO PCI driver won't prevent MSIX vectors area from being mapped.

With this change, all BARs are mapped in a single chunk and MSIX vectors
are emulated on top unless the machine requests not to by defining and
enabling a new "vfio-no-msix-emulation" property. At the moment only
sPAPR machine does so - it prohibits MSIX emulation and does not allow
enabling it as it does not define the "set" callback for the new property;
the new property also does not appear in "-machine pseries,help".

This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
for the new capability: https://www.spinics.net/lists/kvm/msg160282.html

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* rebased on top of 'p2p' proposed patch

v4:
* silenced dma map errors if unaligned mapping is attempted - they are going
to fail anyway

v3:
* vfio_listener_region_add() won't make qemu exit if failed on MMIO MR
---
 include/hw/vfio/vfio-common.h |  1 +
 linux-headers/linux/vfio.h    |  5 +++++
 hw/ppc/spapr.c                |  7 +++++++
 hw/vfio/common.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 | 10 ++++++++++
 5 files changed, 38 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8c7ba75..3ef9f8e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -172,6 +172,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
+bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4312e96..b45182e 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+/*
+ * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
+ */
+#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876b..6d333e2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2830,6 +2830,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
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
@@ -2911,6 +2916,8 @@ static void spapr_instance_init(Object *obj)
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this were"
                                     " the host's SMT mode", &error_abort);
+    object_property_add_bool(obj, "vfio-no-msix-emulation",
+                             spapr_get_msix_emulation, NULL, NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8aaed8d..18b98e8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1431,6 +1431,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
     return -ENODEV;
 }
 
+bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)
+{
+    struct vfio_region_info *info = NULL;
+    bool ret = false;
+
+    if (!vfio_get_region_info(vbasedev, region, &info)) {
+        if (vfio_get_region_info_cap(info, cap_type)) {
+            ret = true;
+        }
+        g_free(info);
+    }
+
+    return ret;
+}
+
 /*
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5b20620..87a186f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     off_t start, end;
     VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
 
+    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
+                            vdev->msix->table_bar)) {
+        return;
+    }
+
     /*
      * We expect to find a single mmap covering the whole BAR, anything else
      * means it's either unsupported or already setup.
@@ -1473,6 +1478,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      */
     memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
 
+    if (object_property_get_bool(OBJECT(qdev_get_machine()),
+                                 "vfio-no-msix-emulation", NULL)) {
+        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
+    }
+
     return 0;
 }
 
-- 
2.11.0
