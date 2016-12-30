Received: from eggs.gnu.org ([2001:4830:134:3::10]:34547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszT-00007A-Nj
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszT-0008O5-2H
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMszS-0008Ns-S8
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:59 +0800
Message-Id: <1483088160-6714-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 7/8] intel-iommu: allow setup
 trigger mode for irte
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

IOAPIC interrupts need this. Let's be prepared.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
index a3ce678..0585248 100644
--- a/lib/x86/intel-iommu.c
+++ b/lib/x86/intel-iommu.c
@@ -250,13 +250,13 @@ static uint16_t vtd_intr_index_alloc(void)
 }
 
 static void vtd_setup_irte(struct pci_dev *dev, vtd_irte_t *irte,
-			   int vector, int dest_id)
+			   int vector, int dest_id, trigger_mode_t trigger)
 {
 	assert(sizeof(vtd_irte_t) == 16);
 	memset(irte, 0, sizeof(*irte));
 	irte->fault_disable = 1;
 	irte->dest_mode = 0;	 /* physical */
-	irte->trigger_mode = 0;	 /* edge */
+	irte->trigger_mode = trigger;
 	irte->delivery_mode = 0; /* fixed */
 	irte->irte_mode = 0;	 /* remapped */
 	irte->vector = vector;
@@ -301,7 +301,9 @@ bool vtd_setup_msi(struct pci_dev *dev, int vector, int dest_id)
 	assert(sizeof(vtd_msi_addr_t) == 8);
 	assert(sizeof(vtd_msi_data_t) == 4);
 
-	vtd_setup_irte(dev, irte + index, vector, dest_id);
+	/* Use edge irq as default */
+	vtd_setup_irte(dev, irte + index, vector,
+		       dest_id, TRIGGER_EDGE);
 
 	msi_addr.handle_15 = index >> 15 & 1;
 	msi_addr.shv = 0;
-- 
2.7.4
