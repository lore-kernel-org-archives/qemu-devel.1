Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7s-00041F-2g
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7r-000641-4p
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cpo7q-00063t-VD
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:55 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2017 11:36:38 +0800
Message-Id: <1489980999-5965-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH fixup 1/2] intel_iommu: use the correct memory
 region for device IOTLB notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

We have a specific memory region for DMAR now, so it's wrong to
trigger the notifier with the root region.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9b1ba1b..bc95304 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1709,7 +1709,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
     entry.translated_addr = 0;
-    memory_region_notify_iommu(entry.target_as->root, entry);
+    memory_region_notify_iommu(&vtd_dev_as->iommu, entry);
 
 done:
     return true;
-- 
2.7.4
