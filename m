Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1crjfA-0000Nf-1m
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1crjf6-0008Ge-TJ
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:15:16 -0400
Received: from [45.249.212.187] (port=3015 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1crjf6-0008Bz-Fv
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:15:12 -0400
From: herongguang <herongguang.he@huawei.com>
Date: Sat, 25 Mar 2017 19:14:24 +0800
Message-ID: <20170325111424.21752-1-herongguang.he@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] KVM: unmap SMM memslots in vt-d table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, herongguang.he@huawei.com

or pages are not unmaped and freed

Signed-off-by: herongguang <herongguang.he@huawei.com>
---
 arch/x86/kvm/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Well, do we should change pci-assign to not map SMM slots instead? Like vfio.
 
diff --git a/arch/x86/kvm/iommu.c b/arch/x86/kvm/iommu.c
index b181426..5b931bb 100644
--- a/arch/x86/kvm/iommu.c
+++ b/arch/x86/kvm/iommu.c
@@ -320,15 +320,17 @@ void kvm_iommu_unmap_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
 static int kvm_iommu_unmap_memslots(struct kvm *kvm)
 {
 	int idx;
-	struct kvm_memslots *slots;
+	struct kvm_memslots *slots, *smm_slots;
 	struct kvm_memory_slot *memslot;
 
 	idx = srcu_read_lock(&kvm->srcu);
 	slots = kvm_memslots(kvm);
-
 	kvm_for_each_memslot(memslot, slots)
 		kvm_iommu_unmap_pages(kvm, memslot);
 
+	smm_slots = __kvm_memslots(kvm, 1);
+	kvm_for_each_memslot(memslot, smm_slots)
+		kvm_iommu_unmap_pages(kvm, memslot);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kvm->arch.iommu_noncoherent)
-- 
1.7.12.4
