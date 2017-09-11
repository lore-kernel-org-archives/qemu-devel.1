Received: from eggs.gnu.org ([2001:4830:134:3::10]:42353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZi-0001RP-6r
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1drTZd-0005iv-Co
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1drTZd-0005ih-4I
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F897750EE
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 18:36:44 +0000 (UTC)
From: wexu@redhat.com
Date: Tue, 12 Sep 2017 02:56:30 +0800
Message-Id: <1505156192-18994-2-git-send-email-wexu@redhat.com>
In-Reply-To: <1505156192-18994-1-git-send-email-wexu@redhat.com>
References: <1505156192-18994-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [Patch 1/3] vfio: reusing address space for the same
 IOMMU group devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, Wei Xu <wexu@redhat.com>

From: Wei Xu <wexu@redhat.com>

Currently address space of a vfio device is selected by directly
looking up pci device IOMMU address space during realizing, this
usually works for most none separate address space targeted cases
since they are using the system address space, i.e. a q35 machine
without virtual IOMMU. Unfortunately, when it comes down to the case
having a virtual IOMMU(x86 vtd in this case) and two vfio devices in
the same IOMMU group, the virtual IOMMU(vtd) creates two separate
address space for each device, this breaks the minimum granularity for
vfio, and the device fails realizing by prompting 'group xxx used in
multiple address spaces'.

This patch is a helper looking up the same IOMMU device before
invoking creating an new address space for a device, thus fixes the issue.

As a side work for the all groups/devices loop, also it checks if the device
has been assigned to the guest twice before creating an extra group and
removing it later which is not necessary.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/vfio/common.c              | 28 ++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..63c3609 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "hw/vfio/pci.h"
 
 struct vfio_group_head vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -1183,6 +1184,33 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
+AddressSpace *vfio_lookup_as(int groupid, PCIDevice *pdev, Error **errp)
+{
+    VFIOGroup *group;
+    VFIODevice *vbasedev_iter;
+    VFIOPCIDevice *vdev, *vd;
+
+    vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+            if (strcmp(vbasedev_iter->name, vdev->vbasedev.name) == 0) {
+                error_setg(errp, "device is already attached");
+                return 0;
+            }
+
+            if (vbasedev_iter->group->groupid == groupid) {
+                vd = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+
+                if (vd->pdev.bus == pdev->bus) {
+                    return vbasedev_iter->group->container->space->as;
+                }
+            }
+        }
+    }
+
+    return pci_device_iommu_address_space(pdev);
+}
+
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 {
     VFIOGroup *group;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9..5b4827b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -157,6 +157,7 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
+AddressSpace *vfio_lookup_as(int groupid, PCIDevice *pdev, Error **errp);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
-- 
1.8.3.1
