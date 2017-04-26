Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7A-0002g6-Qs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K76-0002JK-Eq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:52653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K76-0002I6-4f
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:00 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:37 +0800
Message-Id: <1493201210-14357-8-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 07/20] VFIO: check notifier flag in
 region_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds flag check when unregistering MAP/UNMAP notifier in
region_del. MAP/UNMAP notifier would be unregistered when iommu
memory region is deleted. This is to avoid unregistering other
notifiers.

Peter Xu's intel_iommu enhancement series has introduced dynamic
switch of IOMMU region. If an assigned device switches to use "pt",
the IOMMU region would be deleted, thus the MAP/UNMAP notifier would
be unregistered. While for some cases, the other notifiers may still
wanted. e.g. if a user decides to use vSVM for the assigned device
after the switch, then the pasid table bind notifier is needed. The
newly added pasid table bind notifier would be unregistered in the
vfio_disconnect_container(). The link below would direct you to Peter's
dynamic switch patch.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg444462.html

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c      | 5 +++--
 include/exec/memory.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e270255..719de61 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -501,7 +501,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                            section->size);
         llend = int128_sub(llend, int128_one());
         iommu_notifier_init(&n, vfio_iommu_map_notify,
-                            IOMMU_NOTIFIER_ALL,
+                            IOMMU_NOTIFIER_MAP_UNMAP,
                             section->offset_within_region,
                             int128_get64(llend));
 
@@ -578,7 +578,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
             if (giommu->iommu == section->mr &&
-                giommu->n.start == section->offset_within_region) {
+                giommu->n.start == section->offset_within_region &&
+                giommu->n.notifier_flags & IOMMU_NOTIFIER_MAP_UNMAP) {
                 memory_region_unregister_iommu_notifier(giommu->iommu,
                                                         &giommu->n);
                 QLIST_REMOVE(giommu, giommu_next);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d2f24cc..7bd13ab 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -85,7 +85,7 @@ typedef enum {
     IOMMU_NOTIFIER_SVM_PASIDT_BIND = 0x4,
 } IOMMUNotifierFlag;
 
-#define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+#define IOMMU_NOTIFIER_MAP_UNMAP (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
 
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
-- 
1.9.1
