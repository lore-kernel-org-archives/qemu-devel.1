Received: from eggs.gnu.org ([2001:4830:134:3::10]:35601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz42-0002ps-0m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz3z-0006Um-DJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:18 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  5 Oct 2017 16:50:36 +1100
Message-Id: <20171005055037.7767-2-aik@ozlabs.ru>
In-Reply-To: <20171005055037.7767-1-aik@ozlabs.ru>
References: <20171005055037.7767-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 1/2] memory/iommu/vfio: Define
 add_vfio_group() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The new callback will be called when a new VFIO IOMMU group is added.

This should cause no behavioral change, the next patch will.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This could be at the higher level - in MemoryRegionOps, makes sense?

---
 include/exec/memory.h |  4 ++++
 hw/vfio/common.c      | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f87..64e0b4fc96 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -210,6 +210,10 @@ typedef struct IOMMUMemoryRegionClass {
                                 IOMMUNotifierFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
+
+    /* Notifies IOMMUMR about attached VFIO IOMMU group */
+    void (*add_vfio_group)(IOMMUMemoryRegion *iommu_mr, int vfio_kvm_fd,
+                           int groupfd);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..9e861e0393 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -481,6 +481,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
 
+#ifdef CONFIG_KVM
+        if (kvm_enabled()) {
+            VFIOGroup *group;
+            IOMMUMemoryRegionClass *imrc =
+                IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                if (imrc->add_vfio_group) {
+                    imrc->add_vfio_group(iommu_mr, vfio_kvm_device_fd,
+                                         group->fd);
+                }
+            }
+        }
+#endif
+
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
-- 
2.11.0
