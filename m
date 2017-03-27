Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1csOya-00066z-A6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1csOyX-0002aj-7f
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:04 -0400
Received: from [45.249.212.189] (port=2878 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1csOyW-0002Wm-Ns
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:01 -0400
References: <20170325111424.21752-1-herongguang.he@huawei.com>
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58D8BD6D.8080404@huawei.com>
Date: Mon, 27 Mar 2017 15:21:17 +0800
MIME-Version: 1.0
In-Reply-To: <20170325111424.21752-1-herongguang.he@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] KVM: pci-assign: do not map smm memory slot
 pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com

 From f6f0ee6831488bef7af841cb86f3d85a04848fe5 Mon Sep 17 00:00:00 2001
From: herongguang <herongguang.he@huawei.com>
Date: Mon, 27 Mar 2017 15:08:59 +0800
Subject: [PATCH] KVM: pci-assign: do not map smm memory slot pages
  in vt-d page table

or VM memory are not put thus leaked in kvm_iommu_unmap_memslots() when
destroy VM.

This is consistent with current vfio implementation.
---
  virt/kvm/kvm_main.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 482612b..9018d06 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1052,7 +1052,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
  	 * changes) is disallowed above, so any other attribute changes getting
  	 * here can be skipped.
  	 */
-	if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
+	if ((as_id == 0) && ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE))) {
  		r = kvm_iommu_map_pages(kvm, &new);
  		return r;
  	}
-- 
1.7.12.4

On 2017/3/25 19:14, herongguang wrote:
> or pages are not unmaped and freed
>
> Signed-off-by: herongguang <herongguang.he@huawei.com>
> ---
>   arch/x86/kvm/iommu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> Well, do we should change pci-assign to not map SMM slots instead? Like vfio.
>
> diff --git a/arch/x86/kvm/iommu.c b/arch/x86/kvm/iommu.c
> index b181426..5b931bb 100644
> --- a/arch/x86/kvm/iommu.c
> +++ b/arch/x86/kvm/iommu.c
> @@ -320,15 +320,17 @@ void kvm_iommu_unmap_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
>   static int kvm_iommu_unmap_memslots(struct kvm *kvm)
>   {
>   	int idx;
> -	struct kvm_memslots *slots;
> +	struct kvm_memslots *slots, *smm_slots;
>   	struct kvm_memory_slot *memslot;
>
>   	idx = srcu_read_lock(&kvm->srcu);
>   	slots = kvm_memslots(kvm);
> -
>   	kvm_for_each_memslot(memslot, slots)
>   		kvm_iommu_unmap_pages(kvm, memslot);
>
> +	smm_slots = __kvm_memslots(kvm, 1);
> +	kvm_for_each_memslot(memslot, smm_slots)
> +		kvm_iommu_unmap_pages(kvm, memslot);
>   	srcu_read_unlock(&kvm->srcu, idx);
>
>   	if (kvm->arch.iommu_noncoherent)
>
