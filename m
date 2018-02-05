Received: from eggs.gnu.org ([2001:4830:134:3::10]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilwt-000151-PM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilwq-0003jZ-Mj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilwq-0003j9-DV
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F69F61D1D
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:56:59 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:56:58 -0700
Message-ID: <20180205185658.14391.12745.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 02/11] vfio/spapr: Use iommu memory region's
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c     |   27 +++++++++++++++++++++++++++
 hw/vfio/trace-events |    1 +
 2 files changed, 28 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a8b36b..ec41f93b7479 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -457,6 +457,33 @@ static void vfio_listener_region_add(MemoryListener *listener,
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
+                        error_report("vfio: failed to setup fd %d "
+                                     "for a group with fd %d: %s",
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
index fae096c0724f..3d34fe8a93f1 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
+vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
