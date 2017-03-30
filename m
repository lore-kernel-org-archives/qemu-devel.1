Received: from eggs.gnu.org ([2001:4830:134:3::10]:50898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUV-0000nl-Du
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUU-0006Cb-HO
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:51 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 30 Mar 2017 23:47:06 +1100
Message-Id: <20170330124707.28142-5-aik@ozlabs.ru>
In-Reply-To: <20170330124707.28142-1-aik@ozlabs.ru>
References: <20170330124707.28142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 4/5] vfio/spapr: Add a notifier for
 PPC64 HV/PR KVM about new group attached to LIOBN
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

This implements a notification for a new IOMMU group attached to
sPAPR's logical IO bus (LIOBN) to enable in-kernel TCE acceleration.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 10 ++++++++++
 hw/vfio/spapr.c               | 32 ++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 4 files changed, 44 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7a4135ae6f..9662cb29a0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -175,6 +175,7 @@ extern const MemoryListener vfio_prereg_listener;
 int vfio_spapr_create_window(VFIOContainer *container,
                              MemoryRegionSection *section,
                              hwaddr *pgsize);
+int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd, int tablefd);
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e8188eb3d5..b94b29be15 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -440,6 +440,16 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
+#ifdef CONFIG_KVM
+        if (kvm_enabled()) {
+            VFIOGroup *group;
+
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                vfio_spapr_notify_kvm(vfio_kvm_device_fd, group->fd,
+                                      IOMMU_MEMORY_REGION(section->mr));
+            }
+        }
+#endif
         vfio_host_win_add(container, section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1, pgsize);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 551870d46b..bab808b837 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,8 +15,12 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
+#include "hw/ppc/spapr.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#ifdef CONFIG_KVM
+#include "linux/kvm.h"
+#endif
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
@@ -188,6 +192,34 @@ int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
+int vfio_spapr_notify_kvm(int vfio_kvm_device_fd, int groupfd,
+                          IOMMUMemoryRegion *iommumr)
+{
+#ifdef CONFIG_KVM
+    struct kvm_vfio_spapr_tce param = {
+        .groupfd = groupfd,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+    sPAPRIOMMUMemoryRegionClass *spmc =
+        SPAPR_IOMMU_MEMORY_REGION_GET_CLASS(iommumr);
+
+    param.tablefd = spmc->get_fd(iommumr);
+    if (param.tablefd != -1) {
+        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+            error_report("vfio: failed to setup fd %d for a group with fd %d: %s",
+                         param.tablefd, param.groupfd, strerror(errno));
+            return -errno;
+        }
+    }
+    trace_vfio_spapr_notify_kvm(groupfd, param.tablefd);
+#endif
+    return 0;
+}
+
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space)
 {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2561c6d31a..084a92f7c2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -123,3 +123,4 @@ vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"P
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
+vfio_spapr_notify_kvm(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.11.0
