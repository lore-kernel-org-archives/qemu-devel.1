Received: from eggs.gnu.org ([209.51.188.92]:42662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sean.j.christopherson@intel.com>) id 1gk9qu-0002Qb-8C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sean.j.christopherson@intel.com>) id 1gk9qr-00063L-LX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:51081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
	id 1gk9qr-0005gM-Bq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:45:05 -0500
Date: Thu, 17 Jan 2019 07:44:54 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID: <20190117154454.GA22169@linux.intel.com>
References: <1547733331-16140-1-git-send-email-ann.zhuangyanying@huawei.com>
	<1547733331-16140-2-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547733331-16140-2-git-send-email-ann.zhuangyanying@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] KVM: MMU: correct the behavior of
 mmu_spte_update_no_track
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: xiaoguangrong@tencent.com, pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, liu.jinsong@huawei.com

On Thu, Jan 17, 2019 at 01:55:28PM +0000, Zhuangyanying wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Current behavior of mmu_spte_update_no_track() does not match
> the name of _no_track() as actually the A/D bits are tracked
> and returned to the caller

Sentences should be terminated with periods.

> This patch introduces the real _no_track() function to update

"This patch" is redundant, e.g. simply state "Introduce ...".

> the spte regardless of A/D bits and rename the original function
> to _track()

The function also avoids __update_clear_spte_slow(), i.e. AFAICT it
doesn't guarantee volatile bits will be preserved.  I assume this is
intentional, but it'd be nice to explain why this is ok.

> The _no_track() function will be used by later patches to update
> upper spte which need not care of A/D bits indeed

The _no_track() variant is already used (by mmu_spte_age()), I don't
see any point in having this blurb on the changelog, e.g. it led me
to incorrectly think an unused function was being introduced.

> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  arch/x86/kvm/mmu.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index ce770b4..eeb3bac 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -731,10 +731,29 @@ static void mmu_spte_set(u64 *sptep, u64 new_spte)
>  }
>  
>  /*
> - * Update the SPTE (excluding the PFN), but do not track changes in its
> + * Update the SPTE (excluding the PFN) regardless of accessed/dirty
> + * status which is used to update the upper level spte.
> + */
> +static void mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
> +{
> +	u64 old_spte = *sptep;

No need to snapshot the old spte since it's not being returned.

> +	WARN_ON(!is_shadow_present_pte(new_spte));
> +
> +	if (!is_shadow_present_pte(old_spte)) {
> +		mmu_spte_set(sptep, new_spte);
> +		return;

Similarly, this is more complex than it needs to be, e.g. the function
can be simplified to:

static void mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
{
	WARN_ON(!is_shadow_present_pte(new_spte));

	if (!is_shadow_present_pte(*sptep))
		mmu_spte_set(sptep, new_spte);
	else
		__update_clear_spte_fast(sptep, new_spte);
}

> +	}
> +
> +	__update_clear_spte_fast(sptep, new_spte);
> +}
> +
> +/*
> + * Update the SPTE (excluding the PFN), the original value is
> + * returned, based on it, the caller can track changes of its
>   * accessed/dirty status.
>   */
> -static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
> +static u64 mmu_spte_update_track(u64 *sptep, u64 new_spte)
>  {
>  	u64 old_spte = *sptep;
>  
> @@ -769,7 +788,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
>  static bool mmu_spte_update(u64 *sptep, u64 new_spte)
>  {
>  	bool flush = false;
> -	u64 old_spte = mmu_spte_update_no_track(sptep, new_spte);
> +	u64 old_spte = mmu_spte_update_track(sptep, new_spte);
>  
>  	if (!is_shadow_present_pte(old_spte))
>  		return false;
> -- 
> 1.8.3.1
> 
> 
