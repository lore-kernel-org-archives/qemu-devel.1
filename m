Received: from eggs.gnu.org ([2001:4830:134:3::10]:53135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnK-0005a5-Nx
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnG-0000Ag-17
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:7359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLnF-00006Y-Om
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:33 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:33:27 +0800
Message-Id: <1519900415-30314-5-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 04/12] vfio/pci: add notify framework based
 on IOMMUSVAContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch introduces a notify framework for IOMMUSVAContext.sva_notifiers.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c              | 1 +
 include/hw/vfio/vfio-common.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 06277d2..1cc96df 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1019,6 +1019,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     QLIST_INIT(&container->giommu_mr_list);
     QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&container->gsva_ctx_list);
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 702a085..4c16b4c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "hw/core/pasid.h"
 
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "
@@ -88,6 +89,7 @@ typedef struct VFIOContainer {
      * future
      */
     QLIST_HEAD(, VFIOGuestIOMMUMR) giommu_mr_list;
+    QLIST_HEAD(, VFIOGuestIOMMUSVAContext) gsva_ctx_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_ENTRY(VFIOContainer) next;
@@ -101,6 +103,13 @@ typedef struct VFIOGuestIOMMUMR {
     QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
 } VFIOGuestIOMMUMR;
 
+typedef struct VFIOGuestIOMMUSVAContext {
+    VFIOContainer *container;
+    IOMMUSVAContext *sva_ctx;
+    IOMMUSVANotifier n;
+    QLIST_ENTRY(VFIOGuestIOMMUSVAContext) gsva_ctx_next;
+} VFIOGuestIOMMUSVAContext;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
-- 
1.9.1
