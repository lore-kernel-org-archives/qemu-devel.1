Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmi1-0001Oa-MO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhw-00041K-Vg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:37 -0500
Received: from mail.kernel.org ([198.145.29.136]:38536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhw-00040l-MT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:32 -0500
Date: Thu, 26 Jan 2017 18:15:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485447262-27014-8-git-send-email-mst@redhat.com>
References: <1485447262-27014-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485447262-27014-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/18] intel_iommu: fix and simplify size
 calculation in process_device_iotlb_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jason Wang <jasowang@redhat.com>

We don't use 1ULL which is wrong during size calculation. Fix it, and
while at it, switch to use cto64() and adds a comments to make it
simpler and easier to be understood.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
MST
