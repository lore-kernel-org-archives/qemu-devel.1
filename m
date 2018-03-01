Received: from eggs.gnu.org ([2001:4830:134:3::10]:49094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLC-0006AG-7K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLB-0000ku-5X
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLA-0000kS-W5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:57 -0500
Date: Thu, 1 Mar 2018 18:45:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-4-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] intel-iommu: Accept 64-bit writes to
 FEADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Luis Lloret <luis_lloret@mentor.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Xen is doing this [1] and currently triggers an abort.

[1] http://xenbits.xenproject.org/gitweb/?p=xen.git;a=blob;f=xen/drivers/passthrough/vtd/iommu.c;h=daaed0abbdd06b6ba3d948ea103aadf02651e83c;hb=refs/heads/master#l1108

Reported-by: Luis Lloret <luis_lloret@mentor.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2e841cd..fb31de9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2129,8 +2129,15 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Address Register, 32-bit */
     case DMAR_FEADDR_REG:
-        assert(size == 4);
-        vtd_set_long(s, addr, val);
+        if (size == 4) {
+            vtd_set_long(s, addr, val);
+        } else {
+            /*
+             * While the register is 32-bit only, some guests (Xen...) write to
+             * it with 64-bit.
+             */
+            vtd_set_quad(s, addr, val);
+        }
         break;
 
     /* Fault Event Upper Address Register, 32-bit */
-- 
MST
