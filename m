Received: from eggs.gnu.org ([2001:4830:134:3::10]:55780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvcb-0007FU-Ng
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvcX-0003Za-S0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:59:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35576
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvcX-0003Yj-Mk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:59:45 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-6-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <bc7b51fe-c210-76fd-8df1-66ba33e6769b@arm.com>
Date: Mon, 2 Jul 2018 10:59:38 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-6-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/20] kvm: arm/arm64: Fix
 stage2_flush_memslot for 4 level page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On 29/06/18 12:15, Suzuki K Poulose wrote:
> So far we have only supported 3 level page table with fixed IPA of 40bits.
> Fix stage2_flush_memslot() to accommodate for 4 level tables.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d90d79..061e6b3 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -379,7 +379,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>  	do {
>  		next = stage2_pgd_addr_end(addr, end);
> -		stage2_flush_puds(kvm, pgd, addr, next);
> +		if (!stage2_pgd_none(*pgd))
> +			stage2_flush_puds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> 

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
