Received: from eggs.gnu.org ([2001:4830:134:3::10]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUSnT-00063W-Ba
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUSnO-0005LM-Cd
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUSnO-0005Kn-1D
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:35:34 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEB72BDD4
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:35:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 14:35:28 +0800
Message-Id: <1484894128-7871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] intel_iommu: fix and simplify size calculation
 in process_device_iotlb_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

We don't use 1ULL which is wrong during size calculation. Fix it, and
while at it, switch to use cto64() and adds a comments to make it
simpler and easier to be understood.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ec62239..3270fb9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1485,8 +1485,16 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         goto done;
     }
 
+    /* According to ATS spec table 2.4:
+     * S = 0, bits 15:12 = xxxx     range size: 4K
+     * S = 1, bits 15:12 = xxx0     range size: 8K
+     * S = 1, bits 15:12 = xx01     range size: 16K
+     * S = 1, bits 15:12 = x011     range size: 32K
+     * S = 1, bits 15:12 = 0111     range size: 64K
+     * ...
+     */
     if (size) {
-        sz = 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
+        sz = (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT);
         addr &= ~(sz - 1);
     } else {
         sz = VTD_PAGE_SIZE;
-- 
2.7.4
