Received: from eggs.gnu.org ([2001:4830:134:3::10]:41964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw1Yd-0004Fc-8I
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw1Ya-0002iG-1c
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw1YZ-0002i6-SM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:10:11 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu,  6 Apr 2017 15:08:41 +0800
Message-Id: <1491462524-1617-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1491462524-1617-1-git-send-email-peterx@redhat.com>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 6/9] intel_iommu: use the correct memory
 region for device IOTLB notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jason Wang <jasowang@redhat.com>

We have a specific memory region for DMAR now, so it's wrong to
trigger the notifier with the root region.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 22d8226..2412df4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1457,7 +1457,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
     entry.translated_addr = 0;
-    memory_region_notify_iommu(entry.target_as->root, entry);
+    memory_region_notify_iommu(&vtd_dev_as->iommu, entry);
 
 done:
     return true;
-- 
2.7.4
