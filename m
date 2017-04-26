Received: from eggs.gnu.org ([2001:4830:134:3::10]:50555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7W-0002yx-Di
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7R-0002Va-GW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:25915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7R-0002V7-5E
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:21 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:41 +0800
Message-Id: <1493201210-14357-12-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 11/20] intel_iommu: provide
 iommu_ops->record_device
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

This patch provides iommu_ops->record_device implementation for
intel_iommu. It records the host sid in the IntelIOMMUNotifierNode for
further virtualization usage. e.g. guest sid -> host sid translation
during propagating 1st level cache invalidation from guest to host.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         | 19 +++++++++++++++++++
 include/hw/i386/intel_iommu.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ba1e7eb..0c412d2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2407,6 +2407,24 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
     }
 }
 
+static void vtd_iommu_record_device(MemoryRegion *iommu,
+                                    void *device_info)
+{
+    VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    IntelIOMMUNotifierNode *node = NULL;
+    IntelIOMMUNotifierNode *next_node = NULL;
+    PCIHostDeviceAddress *host = (PCIHostDeviceAddress *) device_info;
+
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->vtd_as == vtd_as) {
+            node->host_sid = ((host->bus & 0xffUL) << 8)
+                           | ((host->slot & 0x1f) << 3)
+                           | (host->function & 0x7);
+        }
+    }
+}
+
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
     .version_id = 1,
@@ -2940,6 +2958,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->iommu_ops.translate = vtd_iommu_translate;
     s->iommu_ops.notify_flag_changed = vtd_iommu_notify_flag_changed;
     s->iommu_ops.replay = vtd_iommu_replay;
+    s->iommu_ops.record_device = vtd_iommu_record_device;
     s->root = 0;
     s->root_extended = false;
     s->dmar_enabled = false;
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 8981615..a4ce5c3 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -252,6 +252,7 @@ struct VTD_MSIMessage {
 
 struct IntelIOMMUNotifierNode {
     VTDAddressSpace *vtd_as;
+    uint16_t host_sid;
     QLIST_ENTRY(IntelIOMMUNotifierNode) next;
 };
 
-- 
1.9.1
