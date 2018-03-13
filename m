Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqO2-0006Bo-0E
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqO0-0004T5-T1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqO0-0004SJ-KP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:19:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 015503A181
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:19:04 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:19:01 -0600
Message-ID: <20180313201901.2327.51191.stgit@gimli.home>
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 10/11] vfio-pci: Allow mmap of MSIX BAR
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

At the moment we unconditionally avoid mapping MSIX data of a BAR and
emulate MSIX table in QEMU. However it is 1) not always necessary as
a platform may provide a paravirt interface for MSIX configuration;
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c              |   15 +++++++++++++++
 hw/vfio/pci.c                 |    9 +++++++++
 include/hw/vfio/vfio-common.h |    1 +
 3 files changed, 25 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 07c03d78b666..5e8471621800 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1471,6 +1471,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
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
index b9d2c12b8273..02974f4eb976 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1294,6 +1294,15 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     off_t start, end;
     VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
 
+    /*
+     * If the host driver allows mapping of a MSIX data, we are going to
+     * do map the entire BAR and emulate MSIX table on top of that.
+     */
+    if (vfio_has_region_cap(&vdev->vbasedev, region->nr,
+                            VFIO_REGION_INFO_CAP_MSIX_MAPPABLE)) {
+        return;
+    }
+
     /*
      * We expect to find a single mmap covering the whole BAR, anything else
      * means it's either unsupported or already setup.
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c5efa32750e7..d9360148e6a7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -193,6 +193,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info);
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
+bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 #endif
 extern const MemoryListener vfio_prereg_listener;
 
