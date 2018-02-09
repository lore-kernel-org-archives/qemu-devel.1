Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ek3Wi-0002EB-62
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ek3Wg-0004s3-VP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:55:20 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  9 Feb 2018 18:55:02 +1100
Message-Id: <20180209075503.16996-4-aik@ozlabs.ru>
In-Reply-To: <20180209075503.16996-1-aik@ozlabs.ru>
References: <20180209075503.16996-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v7 3/4] vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

At the moment we unconditionally avoid mapping MSIX data of a BAR and
emulate MSIX table in QEMU. However it is 1) not always necessary as
a platform may prodive a paravirt interface for MSIX configuration;
2) can affect the speed of MMIO access by emulating them in QEMU when
frequently accessed registers share same system page with MSIX data,
this is particularly a problem for systems with the page size bigger
than 4KB.

A new capability - VFIO_REGION_INFO_CAP_MSIX_MAPPABLE - has been added
to the kernel [1] which tells the userspace that mapping of the MSIX data
is possible now. This makes use of it so from now on QEMU tries mapping
the entire BAR as a whole and emulate MSIX on top of that.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a32295c612c57990d17fb0f41e7134394b2f35f6

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v7:
* test iova/llsize against pgmask in vfio_listener_region_add/del
* s/vfio_is_cap_present/vfio_has_region_cap/
* added comments here and there
* s/vdev->msix->table_bar/region-nr/
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 |  9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9..42dd2b0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
+bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 736f271..b99ae77 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1464,6 +1464,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
     return -ENODEV;
 }
 
+bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
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
index 879510c..ae9098d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1294,6 +1294,15 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
 
     /*
+     * If the host driver allows mapping of a MSIX data, we are going to
+     * do map the entire BAR and emulate MSIX table on top of that.
+     */
+    if (vfio_has_region_cap(&vdev->vbasedev, region->nr,
+                            VFIO_REGION_INFO_CAP_MSIX_MAPPABLE)) {
+        return;
+    }
+
+    /*
      * We expect to find a single mmap covering the whole BAR, anything else
      * means it's either unsupported or already setup.
      */
-- 
2.11.0
