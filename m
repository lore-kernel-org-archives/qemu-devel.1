Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fuDC0-0001gh-C3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fuDBu-00021A-5b
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:48:12 -0400
Received: from thoth.sbs.de ([192.35.17.2]:40249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1fuDBm-0001xh-L5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:48:01 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <48ae78d8-58ec-8813-8680-6f407ea46041@siemens.com>
Date: Mon, 27 Aug 2018 10:47:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] kvm: x86: Fix kvm_arch_fixup_msi_route for
 remap-less case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Christopher Goldsworthy <christopher.goldsworthy@outlook.com>

The AMD IOMMU does not (yet) support interrupt remapping. But
kvm_arch_fixup_msi_route assumes that all implementations do and crashes
when the AMD IOMMU is used in KVM mode.

Fixes: 8b5ed7dffa1f ("intel_iommu: add support for split irqchip")
Reported-by: Christopher Goldsworthy <christopher.goldsworthy@outlook.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/i386/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9313602d3d..1fe3a73a10 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3677,6 +3677,10 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
         MSIMessage src, dst;
         X86IOMMUClass *class = X86_IOMMU_GET_CLASS(iommu);
 
+        if (!class->int_remap) {
+            return 0;
+        }
+
         src.address = route->u.msi.address_hi;
         src.address <<= VTD_MSI_ADDR_HI_SHIFT;
         src.address |= route->u.msi.address_lo;
-- 
2.16.4
