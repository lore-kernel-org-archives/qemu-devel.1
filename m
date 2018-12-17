Received: from eggs.gnu.org ([2001:4830:134:3::10]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYsmV-0007wU-P3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:18:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYsmS-0002Zw-1J
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:17:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gYsmR-0002Yi-PA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:17:55 -0500
Date: Mon, 17 Dec 2018 14:17:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181217141740.16ccfaa1@Igors-MacBook-Pro.local>
In-Reply-To: <1544619939-18102-2-git-send-email-yu.c.zhang@linux.intel.com>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1544619939-18102-2-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] intel-iommu: differentiate host
 address width from IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>

On Wed, 12 Dec 2018 21:05:38 +0800
Yu Zhang <yu.c.zhang@linux.intel.com> wrote:

> Currently, vIOMMU is using the value of IOVA address width, instead of
> the host address width(HAW) to calculate the number of reserved bits in
> data structures such as root entries, context entries, and entries of
> DMA paging structures etc.
> 
> However values of IOVA address width and of the HAW may not equal. For
> example, a 48-bit IOVA can only be mapped to host addresses no wider than
> 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> in an invalid IOVA being accepted.
> 
> To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> whose value is initialized based on the maximum physical address set to
> guest CPU.

> Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> to clarify.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
[...]

> @@ -3100,6 +3104,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>  static void vtd_init(IntelIOMMUState *s)
>  {
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> +    CPUState *cs = first_cpu;
> +    X86CPU *cpu = X86_CPU(cs);
>  
>      memset(s->csr, 0, DMAR_REG_SIZE);
>      memset(s->wmask, 0, DMAR_REG_SIZE);
> @@ -3119,23 +3125,24 @@ static void vtd_init(IntelIOMMUState *s)
>      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
>               VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
> -    if (s->aw_bits == VTD_HOST_AW_48BIT) {
> +    if (s->aw_bits == VTD_AW_48BIT) {
>          s->cap |= VTD_CAP_SAGAW_48bit;
>      }
>      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> +    s->haw_bits = cpu->phys_bits;
Is it possible to avoid accessing CPU fields directly or cpu altogether
and set phys_bits when iommu is created?

Perhaps Eduardo
 can suggest better approach, since he's more familiar with phys_bits topic

>      /*
>       * Rsvd field masks for spte
>       */
>      vtd_paging_entry_rsvd_field[0] = ~0ULL;
> -    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> -    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
> +    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
>  
>      if (x86_iommu->intr_supported) {
>          s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
> @@ -3261,10 +3268,10 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>      }
>  
>      /* Currently only address widths supported are 39 and 48 bits */
> -    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
> -        (s->aw_bits != VTD_HOST_AW_48BIT)) {
> +    if ((s->aw_bits != VTD_AW_39BIT) &&
> +        (s->aw_bits != VTD_AW_48BIT)) {
>          error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
> -                   VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
> +                   VTD_AW_39BIT, VTD_AW_48BIT);
>          return false;
>      }
>  
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index ed4e758..820451c 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -47,9 +47,9 @@
>  #define VTD_SID_TO_DEVFN(sid)       ((sid) & 0xff)
>  
>  #define DMAR_REG_SIZE               0x230
> -#define VTD_HOST_AW_39BIT           39
> -#define VTD_HOST_AW_48BIT           48
> -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> +#define VTD_AW_39BIT                39
> +#define VTD_AW_48BIT                48
> +#define VTD_ADDRESS_WIDTH           VTD_AW_39BIT
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>  
>  #define DMAR_REPORT_F_INTR          (1)
> @@ -244,7 +244,8 @@ struct IntelIOMMUState {
>      bool intr_eime;                 /* Extended interrupt mode enabled */
>      OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>      bool buggy_eim;                 /* Force buggy EIM unless eim=off */
> -    uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> +    uint8_t aw_bits;                /* IOVA address width (in bits) */
> +    uint8_t haw_bits;               /* Hardware address width (in bits) */
>  
>      /*
>       * Protects IOMMU states in general.  Currently it protects the
