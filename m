Received: from eggs.gnu.org ([2001:4830:134:3::10]:34531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszS-000077-AS
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszP-0008NL-9W
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMszP-0008N8-3e
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:39 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:58 +0800
Message-Id: <1483088160-6714-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 6/8] intel-iommu: use atomic ops
 for irte index alloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

To allow concurrent allocation of irte index. Meanwhile, move the IRTE
setup debug line into the alloc since vtd_setup_msi() might not be the
only one to dump this info in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/intel-iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
index 20b9240..a3ce678 100644
--- a/lib/x86/intel-iommu.c
+++ b/lib/x86/intel-iommu.c
@@ -13,6 +13,7 @@
 #include "intel-iommu.h"
 #include "libcflat.h"
 #include "pci.h"
+#include "atomic.h"
 
 /*
  * VT-d in QEMU currently only support 39 bits address width, which is
@@ -239,9 +240,13 @@ void vtd_map_range(uint16_t sid, iova_t iova, phys_addr_t pa, size_t size)
 
 static uint16_t vtd_intr_index_alloc(void)
 {
-	static int index_ctr = 0;
+	static volatile int index_ctr = 0;
+	int ctr;
+
 	assert(index_ctr < 65535);
-	return index_ctr++;
+	ctr = atomic_inc_fetch(&index_ctr);
+	printf("INTR: alloc IRTE index %d\n", ctr);
+	return ctr;
 }
 
 static void vtd_setup_irte(struct pci_dev *dev, vtd_irte_t *irte,
@@ -296,7 +301,6 @@ bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id)
 	assert(sizeof(vtd_msi_addr_t) == 8);
 	assert(sizeof(vtd_msi_data_t) == 4);
 
-	printf("INTR: setup IRTE index %d\n", index);
 	vtd_setup_irte(dev, irte + index, vector, dest_id);
 
 	msi_addr.handle_15 = index >> 15 & 1;
-- 
2.7.4
