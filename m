Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1facrX-0002OX-34
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1facrT-0005c7-TR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:10:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1facrT-0005by-NI
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:10:03 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-18-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <160cc442-c493-486e-338b-41feca15595b@redhat.com>
Date: Wed, 4 Jul 2018 10:09:58 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-18-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/20] vgic: Add support for 52bit guest
 physical address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>, qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> Add support for handling 52bit guest physical address to the
> VGIC layer. So far we have limited the guest physical address
> to 48bits, by explicitly masking the upper bits. This patch
> removes the restriction. We do not have to check if the host
> supports 52bit as the gpa is always validated during an access.
> (e.g, kvm_{read/write}_guest, kvm_is_visible_gfn()).
> Also, the ITS table save-restore is also not affected with
> the enhancement. The DTE entries already store the bits[51:8]
> of the ITT_addr (with a 256byte alignment).
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> [ Macro clean ups, fix PROPBASER and PENDBASER accesses ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/irqchip/arm-gic-v3.h |  5 +++++
>  virt/kvm/arm/vgic/vgic-its.c       | 36 ++++++++++--------------------------
>  virt/kvm/arm/vgic/vgic-mmio-v3.c   |  2 --
>  3 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index cbb872c..bc4b95b 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -346,6 +346,8 @@
>  #define GITS_CBASER_RaWaWt	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWaWt)
>  #define GITS_CBASER_RaWaWb	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWaWb)
>  
> +#define GITS_CBASER_ADDRESS(cbaser)	((cbaser) & GENMASK_ULL(52, 12))
> +
>  #define GITS_BASER_NR_REGS		8
>  
>  #define GITS_BASER_VALID			(1ULL << 63)
> @@ -377,6 +379,9 @@
>  #define GITS_BASER_ENTRY_SIZE_MASK	GENMASK_ULL(52, 48)
>  #define GITS_BASER_PHYS_52_to_48(phys)					\
>  	(((phys) & GENMASK_ULL(47, 16)) | (((phys) >> 48) & 0xf) << 12)
> +#define GITS_BASER_ADDR_48_to_52(baser)					\
> +	(((baser) & GENMASK_ULL(47, 16)) | (((baser) >> 12) & 0xf) << 48)
only works if page_size = 64kB which is the case in vITS but as it is in
irqchip header, may be worth a comment?
> +
>  #define GITS_BASER_SHAREABILITY_SHIFT	(10)
>  #define GITS_BASER_InnerShareable					\
>  	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 4ed79c9..c6eb390 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -234,13 +234,6 @@ static struct its_ite *find_ite(struct vgic_its *its, u32 device_id,
>  	list_for_each_entry(dev, &(its)->device_list, dev_list) \
>  		list_for_each_entry(ite, &(dev)->itt_head, ite_list)
>  
> -/*
> - * We only implement 48 bits of PA at the moment, although the ITS
> - * supports more. Let's be restrictive here.
> - */
> -#define BASER_ADDRESS(x)	((x) & GENMASK_ULL(47, 16))
> -#define CBASER_ADDRESS(x)	((x) & GENMASK_ULL(47, 12))
> -
>  #define GIC_LPI_OFFSET 8192
>  
>  #define VITS_TYPER_IDBITS 16
> @@ -752,6 +745,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
>  {
>  	int l1_tbl_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
>  	u64 indirect_ptr, type = GITS_BASER_TYPE(baser);
> +	phys_addr_t base = GITS_BASER_ADDR_48_to_52(baser);
>  	int esz = GITS_BASER_ENTRY_SIZE(baser);
>  	int index;
>  	gfn_t gfn;
> @@ -776,7 +770,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
>  		if (id >= (l1_tbl_size / esz))
>  			return false;
>  
> -		addr = BASER_ADDRESS(baser) + id * esz;
> +		addr = base + id * esz;
>  		gfn = addr >> PAGE_SHIFT;
>  
>  		if (eaddr)
> @@ -791,7 +785,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
>  
>  	/* Each 1st level entry is represented by a 64-bit value. */
>  	if (kvm_read_guest_lock(its->dev->kvm,
> -			   BASER_ADDRESS(baser) + index * sizeof(indirect_ptr),
> +			   base + index * sizeof(indirect_ptr),
>  			   &indirect_ptr, sizeof(indirect_ptr)))
>  		return false;
>  
> @@ -801,11 +795,7 @@ static bool vgic_its_check_id(struct vgic_its *its, u64 baser, u32 id,
>  	if (!(indirect_ptr & BIT_ULL(63)))
>  		return false;
>  
> -	/*
> -	 * Mask the guest physical address and calculate the frame number.
> -	 * Any address beyond our supported 48 bits of PA will be caught
> -	 * by the actual check in the final step.
> -	 */
> +	/* Mask the guest physical address and calculate the frame number. */
>  	indirect_ptr &= GENMASK_ULL(51, 16);
>  
>  	/* Find the address of the actual entry */
> @@ -1297,9 +1287,6 @@ static u64 vgic_sanitise_its_baser(u64 reg)
>  				  GITS_BASER_OUTER_CACHEABILITY_SHIFT,
>  				  vgic_sanitise_outer_cacheability);
>  
> -	/* Bits 15:12 contain bits 51:48 of the PA, which we don't support. */
> -	reg &= ~GENMASK_ULL(15, 12);
> -
>  	/* We support only one (ITS) page size: 64K */
>  	reg = (reg & ~GITS_BASER_PAGE_SIZE_MASK) | GITS_BASER_PAGE_SIZE_64K;
>  
> @@ -1318,11 +1305,8 @@ static u64 vgic_sanitise_its_cbaser(u64 reg)
>  				  GITS_CBASER_OUTER_CACHEABILITY_SHIFT,
>  				  vgic_sanitise_outer_cacheability);
>  
> -	/*
> -	 * Sanitise the physical address to be 64k aligned.
> -	 * Also limit the physical addresses to 48 bits.
> -	 */
> -	reg &= ~(GENMASK_ULL(51, 48) | GENMASK_ULL(15, 12));
> +	/* Sanitise the physical address to be 64k aligned. */
> +	reg &= ~GENMASK_ULL(15, 12);
>  
>  	return reg;
>  }
> @@ -1368,7 +1352,7 @@ static void vgic_its_process_commands(struct kvm *kvm, struct vgic_its *its)
>  	if (!its->enabled)
>  		return;
>  
> -	cbaser = CBASER_ADDRESS(its->cbaser);
> +	cbaser = GITS_CBASER_ADDRESS(its->cbaser);
>  
>  	while (its->cwriter != its->creadr) {
>  		int ret = kvm_read_guest_lock(kvm, cbaser + its->creadr,
> @@ -2226,7 +2210,7 @@ static int vgic_its_restore_device_tables(struct vgic_its *its)
>  	if (!(baser & GITS_BASER_VALID))
>  		return 0;
>  
> -	l1_gpa = BASER_ADDRESS(baser);
> +	l1_gpa = GITS_BASER_ADDR_48_to_52(baser);
>  
>  	if (baser & GITS_BASER_INDIRECT) {
>  		l1_esz = GITS_LVL1_ENTRY_SIZE;
> @@ -2298,7 +2282,7 @@ static int vgic_its_save_collection_table(struct vgic_its *its)
>  {
>  	const struct vgic_its_abi *abi = vgic_its_get_abi(its);
>  	u64 baser = its->baser_coll_table;
> -	gpa_t gpa = BASER_ADDRESS(baser);
> +	gpa_t gpa = GITS_BASER_ADDR_48_to_52(baser);
>  	struct its_collection *collection;
>  	u64 val;
>  	size_t max_size, filled = 0;
> @@ -2347,7 +2331,7 @@ static int vgic_its_restore_collection_table(struct vgic_its *its)
>  	if (!(baser & GITS_BASER_VALID))
>  		return 0;
>  
> -	gpa = BASER_ADDRESS(baser);
> +	gpa = GITS_BASER_ADDR_48_to_52(baser);
>  
>  	max_size = GITS_BASER_NR_PAGES(baser) * SZ_64K;
>  
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 2877840..64647be 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -338,7 +338,6 @@ static u64 vgic_sanitise_pendbaser(u64 reg)
>  				  vgic_sanitise_outer_cacheability);
>  
>  	reg &= ~PENDBASER_RES0_MASK;
> -	reg &= ~GENMASK_ULL(51, 48);
>  
>  	return reg;
>  }
> @@ -356,7 +355,6 @@ static u64 vgic_sanitise_propbaser(u64 reg)
>  				  vgic_sanitise_outer_cacheability);
>  
>  	reg &= ~PROPBASER_RES0_MASK;
> -	reg &= ~GENMASK_ULL(51, 48);
>  	return reg;
>  }
>  
> 
Besides it looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
