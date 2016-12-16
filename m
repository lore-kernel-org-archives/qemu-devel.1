Received: from eggs.gnu.org ([2001:4830:134:3::10]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsj-0003n6-Tq
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzse-0007LB-LM
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:33 -0500
Received: from mail.kernel.org ([198.145.29.136]:48924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzse-0007KL-EW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:28 -0500
Date: Fri, 16 Dec 2016 23:17:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-8-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 7/9] i386: amd_iommu: fix MMIO register
 count and access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Azureyang <azureyang@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, stefanha@redhat.com

From: Prasad J Pandit <pjp@fedoraproject.org>

IOMMU MMIO registers are divided in two groups by their offsets.
Low offsets(<0x2000) registers are grouped into 'amdvi_mmio_low'
table and higher offsets(>=0x2000) registers are grouped into
'amdvi_mmio_high' table. No of registers in each table is given
by macro 'AMDVI_MMIO_REGS_LOW' and 'AMDVI_MMIO_REGS_HIGH' resp.
Values of these two macros were swapped, resulting in an OOB
access when reading 'amdvi_mmio_high' table. Correct these two
macros. Also read from 'amdvi_mmio_low' table for lower address.

Reported-by: Azureyang <azureyang@tencent.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 4 ++--
 hw/i386/amd_iommu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 884926e..0d3dc6a 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -49,8 +49,8 @@
 #define AMDVI_CAPAB_INIT_TYPE         (3 << 16)
 
 /* No. of used MMIO registers */
-#define AMDVI_MMIO_REGS_HIGH  8
-#define AMDVI_MMIO_REGS_LOW   7
+#define AMDVI_MMIO_REGS_HIGH  7
+#define AMDVI_MMIO_REGS_LOW   8
 
 /* MMIO registers */
 #define AMDVI_MMIO_DEVICE_TABLE       0x0000
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 47b79d9..e0732cc 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -562,7 +562,7 @@ static void amdvi_mmio_trace(hwaddr addr, unsigned size)
         trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
+        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
     }
 }
 
-- 
MST
