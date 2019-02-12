Received: from eggs.gnu.org ([209.51.188.92]:41078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtRXu-0002M8-FW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtRXn-0000CT-NX
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:27:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtRXh-00007J-04
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:27:43 -0500
Date: Tue, 12 Feb 2019 14:27:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190212062728.GK1011@xz-x1>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC v1 2/3] intel_iommu: add 256 bits qi_desc
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Wed, Jan 30, 2019 at 01:09:12PM +0800, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> Per Intel(R) VT-d 3.0, the qi_desc is 256 bits in Scalable
> Mode. This patch adds emulation of 256bits qi_desc.
> 
> [Yi Sun is co-developer to rebase and refine the patch.]
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>

Same here; I think you should have your s-o-b last. ;)

> ---
>  hw/i386/intel_iommu.c          | 182 +++++++++++++++++++++++++----------------
>  hw/i386/intel_iommu_internal.h |   8 +-
>  include/hw/i386/intel_iommu.h  |   1 +
>  3 files changed, 116 insertions(+), 75 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 396ac8e..3664a00 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -38,6 +38,7 @@
>  #include "trace.h"
>  
>  #define vtd_devfn_check(devfn) ((devfn & VTD_DEVFN_CHECK_MASK) ? true : false)
> +#define vtd_ecap_smts(s) ((s)->ecap & VTD_ECAP_SMTS)

I'd prefer capital letters for macros.  Your call.

>  
>  /* context entry operations */
>  #define vtd_get_ce_size(s, ce) \
> @@ -65,6 +66,9 @@
>  #define vtd_pe_get_slpt_base(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_SLPTPTR)
>  #define vtd_pe_get_domain_id(pe) VTD_SM_PASID_ENTRY_DID((pe)->val[1])
>  
> +/* invalidation desc */
> +#define vtd_get_inv_desc_width(s) ((s)->iq_dw ? 32 : 16)

Nit: I'll prefer dropping all the "get" wordings in these macros to be
"vtd_inv_desc_width" since that "get" doesn't help much on
understanding its meanings.  But it's personal preference too.

And since you've already have the iq_dw variable - why not store the
width directly into it?  An uint8_t would suffice.

> +
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
> @@ -1759,6 +1763,11 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
>      s->root_scalable = s->root & VTD_RTADDR_SMT;
>      s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
>  
> +    /* if Scalable mode is not enabled, enforce iq_dw to be 16 byte */
> +    if (!s->root_scalable) {
> +        s->iq_dw = 0;

This is ok but I feel it a bit awkward to change IQ setup specifically
in root table setup.  You can simply do this:

- in vtd_init(), always set iq_dw=16.  This will cover system resets
  or IOMMU device reset, then

- only update iq_dw to 32 in vtd_mem_write() where guest specified

> +    }
> +
>      trace_vtd_reg_dmar_root(s->root, s->root_extended);
>  }
>  
> @@ -2052,7 +2061,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
>      if (en) {
>          s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
>          /* 2^(x+8) entries */
> -        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
> +        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8 - (s->iq_dw ? 1 : 0));
>          s->qi_enabled = true;
>          trace_vtd_inv_qi_setup(s->iq, s->iq_size);
>          /* Ok - report back to driver */
> @@ -2219,54 +2228,66 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
>  }
>  
>  /* Fetch an Invalidation Descriptor from the Invalidation Queue */
> -static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
> +static bool vtd_get_inv_desc(IntelIOMMUState *s,
>                               VTDInvDesc *inv_desc)
>  {
> -    dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
> -    if (dma_memory_read(&address_space_memory, addr, inv_desc,
> -        sizeof(*inv_desc))) {
> -        error_report_once("Read INV DESC failed");
> -        inv_desc->lo = 0;
> -        inv_desc->hi = 0;
> +    dma_addr_t base_addr = s->iq;
> +    uint32_t offset = s->iq_head;
> +    uint32_t dw = vtd_get_inv_desc_width(s);
> +    dma_addr_t addr = base_addr + offset * dw;
> +
> +    /* init */
> +    inv_desc->val[0] = 0;
> +    inv_desc->val[1] = 0;
> +    inv_desc->val[2] = 0;
> +    inv_desc->val[3] = 0;

No need?

> +
> +    if (dma_memory_read(&address_space_memory, addr, inv_desc, dw)) {
> +        error_report_once("Read INV DESC failed.");
>          return false;
>      }
> -    inv_desc->lo = le64_to_cpu(inv_desc->lo);
> -    inv_desc->hi = le64_to_cpu(inv_desc->hi);
> +    inv_desc->val[0] = le64_to_cpu(inv_desc->val[0]);
> +    inv_desc->val[1] = le64_to_cpu(inv_desc->val[1]);
> +    inv_desc->val[2] = le64_to_cpu(inv_desc->val[2]);
> +    inv_desc->val[3] = le64_to_cpu(inv_desc->val[3]);

Similar comments here on VTDInvDesc - you can keep the hi/lo fields,
but instead you can define the val[4] into the union too.  Then:

  if (dw == 16) {
    inv_desc->lo = ...
    inv_desc->hi = ...
  } else {
    inv_desc->val[0] = ...
    inv_desc->val[1] = ...
    inv_desc->val[2] = ...
    inv_desc->val[3] = ...
  }

Then this patch can be greatly simplified too since you don't need to
switch VTDInvDesc.{lo|hi} to val[0|1].

[...]

> @@ -2525,7 +2558,7 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
>  {
>      uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
>  
> -    s->iq_tail = VTD_IQT_QT(val);
> +    s->iq_tail = VTD_IQT_QT(s->iq_dw, val);

You can check against bit 4 when iq_dw==32 and report error otherwise.
That's explicitly mentioned by the spec (chap 10.4.22).

>      trace_vtd_inv_qi_tail(s->iq_tail);
>  
>      if (s->qi_enabled && !(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {

[...]


Regards,

-- 
Peter Xu
