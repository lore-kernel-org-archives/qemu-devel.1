Received: from eggs.gnu.org ([2001:4830:134:3::10]:50216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7Z-0006EO-NT
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWF7Y-00007t-OL
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:28:17 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue,  2 Jan 2018 16:28:04 +1100
Message-Id: <20180102052805.20498-3-aik@ozlabs.ru>
In-Reply-To: <20180102052805.20498-1-aik@ozlabs.ru>
References: <20180102052805.20498-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 2/3] vfio/spapr: Use iommu memory region's
 get_attr()
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

In order to enable TCE operations support in KVM, we have to inform
the KVM about VFIO groups being attached to specific LIOBNs. The KVM
already knows about VFIO groups, the only bit missing is which
in-kernel TCE table (the one with user visible TCEs) should update
the attached broups. There is an KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE
attribute of the VFIO KVM device which receives a groupfd/tablefd couple.

This uses a new memory_region_iommu_get_attr() helper to get the IOMMU fd
and calls KVM to establish the link.

As get_attr() is not implemented yet, this should cause no behavioural
change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/common.c     | 26 ++++++++++++++++++++++++++
 hw/vfio/trace-events |  1 +
 2 files changed, 27 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a..ebe28fe 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -457,6 +457,32 @@ static void vfio_listener_region_add(MemoryListener *listener,
         vfio_host_win_add(container, section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1, pgsize);
+#ifdef CONFIG_KVM
+        if (kvm_enabled()) {
+            VFIOGroup *group;
+            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+            struct kvm_vfio_spapr_tce param;
+            struct kvm_device_attr attr = {
+                .group = KVM_DEV_VFIO_GROUP,
+                .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+                .addr = (uint64_t)(unsigned long)&param,
+            };
+
+            if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
+                                              &param.tablefd)) {
+                QLIST_FOREACH(group, &container->group_list, container_next) {
+                    param.groupfd = group->fd;
+                    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                        error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
+                                     param.tablefd, param.groupfd,
+                                     strerror(errno));
+                        return;
+                    }
+                    trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+                }
+            }
+        }
+#endif
     }
 
     hostwin_found = false;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fae096c..3d34fe8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
+vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.11.0
