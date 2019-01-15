Received: from eggs.gnu.org ([209.51.188.92]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY9J-0007p7-JL
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY9I-0001xH-Ht
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:29:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjY9G-0001tV-FE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:29:35 -0500
References: <1547281259-26180-1-git-send-email-ann.zhuangyanying@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <efed13f8-86f5-9dc5-3827-9f05a94c7989@redhat.com>
Date: Wed, 16 Jan 2019 00:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <1547281259-26180-1-git-send-email-ann.zhuangyanying@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] KVM: MMU: fast cleanup D bit based on fast
 write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>, xiaoguangrong.eric@gmail.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, liu.jinsong@huawei.com

On 12/01/19 09:20, Zhuangyanying wrote:
> From: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> 
> Recently I tested live-migration with large-memory guests, find vcpu may hang for a long time while starting migration, such as 9s for 2048G(linux-4.20.1+qemu-3.1.0).
> The reason is memory_global_dirty_log_start() taking too long, and the vcpu is waiting for BQL. The page-by-page D bit clearup is the main time consumption.
> I think that the idea of "KVM: MMU: fast write protect" by xiaoguangrong, especially the function kvm_mmu_write_protect_all_pages(), is very helpful.
> After a little modifcation, on his patch, can solve this problem, 9s to 0.5s.
> 
> At the begining of live migration, write protection is only applied to the top-level SPTE. Then the write from vm trigger the EPT violation, with for_each_shadow_entry write protection is performed at dirct_map.
> Finally the Dirty bit of the target page(at level 1 page table) is cleared, and the dirty page tracking is started. Of coure, the page where GPA is located is marked dirty when mmu_set_spte.
> A similar implementation on xen, just emt instead of write protection.
> 
> What do you think about this solution?

What tree does this patch apply to?

Paolo

> ---
>  mmu.c | 5 ++++-
>  vmx.c | 3 +--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mmu.c b/mmu.c
> index b079d74..f49d316 100755
> --- a/mmu.c
> +++ b/mmu.c
> @@ -3210,7 +3210,10 @@ static bool mmu_load_shadow_page(struct kvm *kvm, struct kvm_mmu_page *sp)
>  			break;
>  
>                  if (is_last_spte(spte, sp->role.level)) {
> -			flush |= spte_write_protect(sptep, false);
> +			if (sp->role.level == PT_PAGE_TABLE_LEVEL)
> +				flush |= spte_clear_dirty(sptep);
> +			else
> +				flush |= spte_write_protect(sptep, false);
>  			continue;
>                  }
>  
> diff --git a/vmx.c b/vmx.c
> index 95784bc..7ec717f 100755
> --- a/vmx.c
> +++ b/vmx.c
> @@ -14421,8 +14421,7 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
>  static void vmx_slot_enable_log_dirty(struct kvm *kvm,
>  				     struct kvm_memory_slot *slot)
>  {
> -	kvm_mmu_slot_leaf_clear_dirty(kvm, slot);
> -	kvm_mmu_slot_largepage_remove_write_access(kvm, slot);
> +	kvm_mmu_write_protect_all_pages(kvm, true);
>  }
>  
>  static void vmx_slot_disable_log_dirty(struct kvm *kvm,
> 
