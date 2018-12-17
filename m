Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYsxW-0002Wu-4I
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYsxQ-0004iU-Uq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:29:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gYsxQ-0004hY-KY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:29:16 -0500
Date: Mon, 17 Dec 2018 14:29:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181217142902.1ee007c1@Igors-MacBook-Pro.local>
In-Reply-To: <1544619939-18102-3-git-send-email-yu.c.zhang@linux.intel.com>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1544619939-18102-3-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 12 Dec 2018 21:05:39 +0800
Yu Zhang <yu.c.zhang@linux.intel.com> wrote:

> A 5-level paging capable VM may choose to use 57-bit IOVA address width.
> E.g. guest applications may prefer to use its VA as IOVA when performing
> VFIO map/unmap operations, to avoid the burden of managing the IOVA space.
> 
> This patch extends the current vIOMMU logic to cover the extended address
> width. When creating a VM with 5-level paging feature, one can choose to
> create a virtual VTD with 5-level paging capability, with configurations
> like "-device intel-iommu,x-aw-bits=57".
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c          | 53 ++++++++++++++++++++++++++++++++----------
>  hw/i386/intel_iommu_internal.h | 10 ++++++--
>  include/hw/i386/intel_iommu.h  |  1 +
>  3 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 0e88c63..871110c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -664,16 +664,16 @@ static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce,
>  
>  /*
>   * Rsvd field masks for spte:
> - *     Index [1] to [4] 4k pages
> - *     Index [5] to [8] large pages
> + *     Index [1] to [5] 4k pages
> + *     Index [6] to [10] large pages
>   */
> -static uint64_t vtd_paging_entry_rsvd_field[9];
> +static uint64_t vtd_paging_entry_rsvd_field[11];
>  
>  static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>  {
>      if (slpte & VTD_SL_PT_PAGE_SIZE_MASK) {
>          /* Maybe large page */
> -        return slpte & vtd_paging_entry_rsvd_field[level + 4];
> +        return slpte & vtd_paging_entry_rsvd_field[level + 5];
>      } else {
>          return slpte & vtd_paging_entry_rsvd_field[level];
>      }
> @@ -3127,6 +3127,8 @@ static void vtd_init(IntelIOMMUState *s)
>               VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
>      if (s->aw_bits == VTD_AW_48BIT) {
>          s->cap |= VTD_CAP_SAGAW_48bit;
> +    } else if (s->aw_bits == VTD_AW_57BIT) {
> +        s->cap |= VTD_CAP_SAGAW_57bit | VTD_CAP_SAGAW_48bit;
>      }
>      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
>      s->haw_bits = cpu->phys_bits;
> @@ -3139,10 +3141,12 @@ static void vtd_init(IntelIOMMUState *s)
>      vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->haw_bits);
>      vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->haw_bits);
>      vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->haw_bits);
> -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
> -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
> -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
> -    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_PAGE_L5_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[9] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
> +    vtd_paging_entry_rsvd_field[10] = VTD_SPTE_LPAGE_L5_RSVD_MASK(s->haw_bits);
>  
>      if (x86_iommu->intr_supported) {
>          s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
> @@ -3241,6 +3245,23 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>      return &vtd_as->as;
>  }
>  
> +static bool host_has_la57(void)
> +{
> +    uint32_t ecx, unused;
> +
> +    host_cpuid(7, 0, &unused, &unused, &ecx, &unused);
> +    return ecx & CPUID_7_0_ECX_LA57;
> +}
> +
> +static bool guest_has_la57(void)
> +{
> +    CPUState *cs = first_cpu;
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +
> +    return env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_LA57;
> +}
another direct access to CPU fields,
I'd suggest to set this value when iommu is created
i.e. add 'la57' property and set from iommu owner.

>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>  {
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> @@ -3267,11 +3288,19 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>          }
>      }
>  
> -    /* Currently only address widths supported are 39 and 48 bits */
> +    /* Currently address widths supported are 39, 48, and 57 bits */
>      if ((s->aw_bits != VTD_AW_39BIT) &&
> -        (s->aw_bits != VTD_AW_48BIT)) {
> -        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
> -                   VTD_AW_39BIT, VTD_AW_48BIT);
> +        (s->aw_bits != VTD_AW_48BIT) &&
> +        (s->aw_bits != VTD_AW_57BIT)) {
> +        error_setg(errp, "Supported values for x-aw-bits are: %d, %d, %d",
> +                   VTD_AW_39BIT, VTD_AW_48BIT, VTD_AW_57BIT);
> +        return false;
> +    }
> +
> +    if ((s->aw_bits == VTD_AW_57BIT) &&
> +        !(host_has_la57() && guest_has_la57())) {
Does iommu supposed to work in TCG mode?
If yes then why it should care about host_has_la57()?

> +        error_setg(errp, "Do not support 57-bit DMA address, unless both "
> +                         "host and guest are capable of 5-level paging");
>          return false;
>      }
>  
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index d084099..2b29b6f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -114,8 +114,8 @@
>                                       VTD_INTERRUPT_ADDR_FIRST + 1)
>  
>  /* The shift of source_id in the key of IOTLB hash table */
> -#define VTD_IOTLB_SID_SHIFT         36
> -#define VTD_IOTLB_LVL_SHIFT         52
> +#define VTD_IOTLB_SID_SHIFT         45
> +#define VTD_IOTLB_LVL_SHIFT         61
>  #define VTD_IOTLB_MAX_SIZE          1024    /* Max size of the hash table */
>  
>  /* IOTLB_REG */
> @@ -212,6 +212,8 @@
>  #define VTD_CAP_SAGAW_39bit         (0x2ULL << VTD_CAP_SAGAW_SHIFT)
>   /* 48-bit AGAW, 4-level page-table */
>  #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
> + /* 57-bit AGAW, 5-level page-table */
> +#define VTD_CAP_SAGAW_57bit         (0x8ULL << VTD_CAP_SAGAW_SHIFT)
>  
>  /* IQT_REG */
>  #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
> @@ -379,6 +381,8 @@ typedef union VTDInvDesc VTDInvDesc;
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +#define VTD_SPTE_PAGE_L5_RSVD_MASK(aw) \
> +        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
>          (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
> @@ -387,6 +391,8 @@ typedef union VTDInvDesc VTDInvDesc;
>          (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
>          (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> +#define VTD_SPTE_LPAGE_L5_RSVD_MASK(aw) \
> +        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>  
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 820451c..7474c4f 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -49,6 +49,7 @@
>  #define DMAR_REG_SIZE               0x230
>  #define VTD_AW_39BIT                39
>  #define VTD_AW_48BIT                48
> +#define VTD_AW_57BIT                57
>  #define VTD_ADDRESS_WIDTH           VTD_AW_39BIT
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>  
