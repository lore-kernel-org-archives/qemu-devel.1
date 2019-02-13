Received: from eggs.gnu.org ([209.51.188.92]:41297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gtpMh-0002CV-RU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gtpBU-0002C8-1L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:42:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gtpBS-0002A8-9W
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:42:19 -0500
Date: Wed, 13 Feb 2019 15:38:55 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190213073855.GE16968@yi.y.sun>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-2-git-send-email-yi.y.sun@linux.intel.com>
	<20190211101213.GF1011@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211101213.GF1011@xz-x1>
Subject: Re: [Qemu-devel] [RFC v1 1/3] intel_iommu: scalable mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-02-11 18:12:13, Peter Xu wrote:
> On Wed, Jan 30, 2019 at 01:09:11PM +0800, Yi Sun wrote:
> > From: "Liu, Yi L" <yi.l.liu@intel.com>
> > 
> > Intel(R) VT-d 3.0 spec introduces scalable mode address translation to
> > replace extended context mode. This patch extends current emulator to
> > support Scalable Mode which includes root table, context table and new
> > pasid table format change. Now intel_iommu emulates both legacy mode
> > and scalable mode (with legacy-equivalent capability set).
> > 
> > The key points are below:
> > 1. Extend root table operations to support both legacy mode and scalable
> >    mode.
> > 2. Extend context table operations to support both legacy mode and
> >    scalable mode.
> > 3. Add pasid tabled operations to support scalable mode.
> 
> (this patch looks generally good to me, but I've got some trivial
>  comments below...)
> 
Thank you!

> > 
> > [Yi Sun is co-developer to contribute much to refine the whole commit.]
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> 
> I think you should have your signed-off-by to be the latter one since
> you are the one who processed the patch last (and who posted it).
> 
Got it, thanks!

> > ---
> >  hw/i386/intel_iommu.c          | 528 ++++++++++++++++++++++++++++++++++-------
> >  hw/i386/intel_iommu_internal.h |  43 +++-
> >  hw/i386/trace-events           |   2 +-
> >  include/hw/i386/intel_iommu.h  |  16 +-
> >  4 files changed, 498 insertions(+), 91 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 8b72735..396ac8e 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -37,6 +37,34 @@
> >  #include "kvm_i386.h"
> >  #include "trace.h"
> >  
> > +#define vtd_devfn_check(devfn) ((devfn & VTD_DEVFN_CHECK_MASK) ? true : false)
> 
> "vtd_devfn_check(devfn)" is merely as long as "devfn &
> VTD_DEVFN_CHECK_MASK", isn't it? :)
> 
> I would just drop the macro.
> 
There are two places to call this macro. Is that valuable to keep it?

> > +
> > +/* context entry operations */
> > +#define vtd_get_ce_size(s, ce) \
> > +    (((s)->root_scalable) ? \
> > +     VTD_CTX_ENTRY_SM_SIZE : VTD_CTX_ENTRY_LECY_SIZE)
> 
> "ce" is not used.  Also, if a macro is only used once, I'd just embed
> it in the function.  This one is only used in
> vtd_get_context_entry_from_root().
> 
Yes, I will drop this.

> > +#define vtd_ce_get_domain_id(ce) VTD_CONTEXT_ENTRY_DID((ce)->val[1])
> 
> Is this correct for scalable mode?  Section 9.4, Figure 9-34, it says
> ce->val[1] has RID_PASID in bits 64-83 rather than domain ID.
> 
This is for legacy context entry but not scalable-mode context entry.

> > +#define vtd_ce_get_rid2pasid(ce) \
> > +    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
> > +#define vtd_ce_get_pasid_dir_table(ce) \
> > +    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
> > +
> > +/* pasid operations */
> > +#define vtd_pdire_get_pasidt_base(pdire) \
> > +    ((pdire)->val & VTD_PASID_TABLE_BASE_ADDR_MASK)
> > +#define vtd_get_pasid_dir_entry_size() VTD_PASID_DIR_ENTRY_SIZE
> > +#define vtd_get_pasid_entry_size() VTD_PASID_ENTRY_SIZE
> > +#define vtd_get_pasid_dir_index(pasid) VTD_PASID_DIR_INDEX(pasid)
> > +#define vtd_get_pasid_table_index(pasid) VTD_PASID_TABLE_INDEX(pasid)
> 
> These macros seem useless.  Please use the existing ones, they are
> good enough AFAICT.  Also, please use capital letters for macro
> definitions so that format will be matched with existing codes.  The
> capital issue is there for the whole series, please adjust them
> accordingly.  I'll stop here on commenting anything about macros...
> 
Ok, I will adjust macro names.

> > +
> > +/* pe operations */
> > +#define vtd_pe_get_type(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> > +#define vtd_pe_get_level(pe) (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
> > +#define vtd_pe_get_agaw(pe) \
> > +    (30 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9)
> > +#define vtd_pe_get_slpt_base(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_SLPTPTR)
> > +#define vtd_pe_get_domain_id(pe) VTD_SM_PASID_ENTRY_DID((pe)->val[1])
> > +
> >  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
> >  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> >  
> > @@ -512,9 +540,15 @@ static void vtd_generate_completion_event(IntelIOMMUState *s)
> >      }
> >  }
> >  
> > -static inline bool vtd_root_entry_present(VTDRootEntry *root)
> > +static inline bool vtd_root_entry_present(IntelIOMMUState *s,
> > +                                          VTDRootEntry *re,
> > +                                          uint8_t devfn)
> >  {
> > -    return root->val & VTD_ROOT_ENTRY_P;
> > +    if (s->root_scalable && vtd_devfn_check(devfn)) {
> > +        return re->hi & VTD_ROOT_ENTRY_P;
> > +    }
> > +
> > +    return re->lo & VTD_ROOT_ENTRY_P;
> >  }
> >  
> >  static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
> > @@ -524,36 +558,64 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
> >  
> >      addr = s->root + index * sizeof(*re);
> >      if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
> > -        re->val = 0;
> > +        re->lo = 0;
> >          return -VTD_FR_ROOT_TABLE_INV;
> >      }
> > -    re->val = le64_to_cpu(re->val);
> > +    re->lo = le64_to_cpu(re->lo);
> > +    if (s->root_scalable) {
> > +        re->hi = le64_to_cpu(re->hi);
> 
> Maybe simply make it unconditional - legacy mode has re->hi defined
> too, though they are all zeros.
> 
That is good.

> > +    }
> >      return 0;
> >  }
> >  
> > -static inline bool vtd_ce_present(VTDContextEntry *context)
> > +static inline bool vtd_ce_present(VTDContextEntry *ce)
> > +{
> > +    return ce->val[0] & VTD_CONTEXT_ENTRY_P;
> > +}
> > +
> > +static inline dma_addr_t vtd_get_context_base(IntelIOMMUState *s,
> > +                                              VTDRootEntry *re,
> > +                                              uint8_t *index)
> >  {
> > -    return context->lo & VTD_CONTEXT_ENTRY_P;
> > +    if (s->root_scalable && vtd_devfn_check(*index)) {
> > +        *index = *index & (~VTD_DEVFN_CHECK_MASK);
> 
> Operating on *index is a bit tricky... if this function is only used
> once in vtd_get_context_entry_from_root() then how about squash it
> there?
> 
Ok, I think that would be fine.

> > +        return re->hi & VTD_ROOT_ENTRY_CTP;
> > +    }
> > +
> > +    return re->lo & VTD_ROOT_ENTRY_CTP;
> >  }
> >  
> > -static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
> > +static void vtd_context_entry_format(IntelIOMMUState *s,
> > +                                     VTDContextEntry *ce)
> > +{
> > +    ce->val[0] = le64_to_cpu(ce->val[0]);
> > +    ce->val[1] = le64_to_cpu(ce->val[1]);
> > +    if (s->root_scalable) {
> > +        ce->val[2] = le64_to_cpu(ce->val[2]);
> > +        ce->val[3] = le64_to_cpu(ce->val[3]);
> > +    }
> > +}
> 
> Only used once.  Squash into caller?  Itself does not make much sense.
> 
Sure.

[...]

> > +static inline int vtd_get_pasid_entry(IntelIOMMUState *s,
> > +                                      uint32_t pasid,
> > +                                      VTDPASIDDirEntry *pdire,
> > +                                      VTDPASIDEntry *pe)
> > +{
> > +    uint32_t index;
> > +    dma_addr_t addr, entry_size;
> > +    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > +
> > +    index = vtd_get_pasid_table_index(pasid);
> > +    entry_size = vtd_get_pasid_entry_size();
> > +    addr = vtd_pdire_get_pasidt_base(pdire);
> > +    addr = addr + index * entry_size;
> > +    if (dma_memory_read(&address_space_memory, addr, pe, entry_size)) {
> > +        memset(pe->val, 0, sizeof(pe->val));
> 
> No need (like all the rest of the places)?
> 
Read the deeper codes, pe will not be contaminated. So, I will remove
the memset.

> > +        return -VTD_FR_PASID_TABLE_INV;
> > +    }
> > +
> > +    /* Do translation type check */
> > +    if (!vtd_pe_type_check(x86_iommu, pe)) {
> > +        return -VTD_FR_PASID_TABLE_INV;
> > +    }
> > +
> > +    if (!vtd_is_level_supported(s, vtd_pe_get_level(pe))) {
> > +        return -VTD_FR_PASID_TABLE_INV;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
[...]

> >  /* Return true if check passed, otherwise false */
> > -static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
> > +static inline bool vtd_ce_type_check(IntelIOMMUState *s,
> > +                                     X86IOMMUState *x86_iommu,
> >                                       VTDContextEntry *ce)
> 
> No need to pass it again.  Simply:
> 
>     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> 
> Or use INTEL_IOMMU_DEVICE() for the reverse.
> 
That is good. Then, I don't need add IntelIOMMUState parameter.

> >  {
> > +    if (s->root_scalable) {
> > +        /*
> > +         * Translation Type locates in context entry only when VTD is in
> > +         * legacy mode. For scalable mode, need to return true to avoid
> > +         * unnecessary fault.
> > +         */
> > +        return true;
> > +    }
> > +
> >      switch (vtd_ce_get_type(ce)) {
> >      case VTD_CONTEXT_TT_MULTI_LEVEL:
> >          /* Always supported */
> > @@ -639,7 +876,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
> >          }
> >          break;
> >      default:
> > -        /* Unknwon type */
> > +        /* Unknown type */
> >          error_report_once("%s: unknown ce type: %"PRIu32, __func__,
> >                            vtd_ce_get_type(ce));
> >          return false;
> > @@ -647,21 +884,36 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
> >      return true;
> >  }
> >  
[...]

> > @@ -1065,10 +1395,10 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
> >          .notify_unmap = true,
> >          .aw = s->aw_bits,
> >          .as = vtd_as,
> > -        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->hi),
> > +        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->val[1]),
> 
> So here for scalable mode the domain ID will be in the pasid table
> entries rather than context entries, so probably more changes
> required.
> 
Yes, I should call vtd_get_domain_id(). Thanks!

> >      };
> >  
> > -    return vtd_page_walk(ce, addr, addr + size, &info);
> > +    return vtd_page_walk(s, ce, addr, addr + size, &info);
> >  }
> >  
> >  static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> > @@ -1103,35 +1433,24 @@ static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> >  }
> >  
> >  /*
> > - * Fetch translation type for specific device. Returns <0 if error
> > - * happens, otherwise return the shifted type to check against
> > - * VTD_CONTEXT_TT_*.
> > + * Check if specific device is configed to bypass address
> > + * translation for DMA requests. In Scalable Mode, bypass
> > + * 1st-level translation or 2nd-level translation, it depends
> > + * on PGTT setting.
> >   */
> > -static int vtd_dev_get_trans_type(VTDAddressSpace *as)
> > +static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
> >  {
> >      IntelIOMMUState *s;
> >      VTDContextEntry ce;
> > +    VTDPASIDEntry pe;
> >      int ret;
> >  
> > -    s = as->iommu_state;
> > +    assert(as);
> >  
> > +    s = as->iommu_state;
> >      ret = vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
> >                                     as->devfn, &ce);
> >      if (ret) {
> > -        return ret;
> > -    }
> > -
> > -    return vtd_ce_get_type(&ce);
> > -}
> > -
> > -static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
> > -{
> > -    int ret;
> > -
> > -    assert(as);
> > -
> > -    ret = vtd_dev_get_trans_type(as);
> > -    if (ret < 0) {
> >          /*
> >           * Possibly failed to parse the context entry for some reason
> >           * (e.g., during init, or any guest configuration errors on
> > @@ -1141,7 +1460,25 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
> >          return false;
> >      }
> >  
> > -    return ret == VTD_CONTEXT_TT_PASS_THROUGH;
> > +    if (s->root_scalable) {
> > +        vtd_ce_get_rid2pasid_entry(s, &ce, &pe);
> 
> Better check error code too, then return false if error detected.
> 
Ok, thanks!

> > +        return (vtd_pe_get_type(&pe) == VTD_SM_PASID_ENTRY_PT);
> > +    }
> > +
> > +    return (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> > +}
> > +
> > +static inline uint16_t vtd_get_domain_id(IntelIOMMUState *s,
> > +                                         VTDContextEntry *ce)
> > +{
> > +    VTDPASIDEntry pe;
> > +
> > +    if (s->root_scalable) {
> > +        vtd_ce_get_rid2pasid_entry(s, ce, &pe);
> > +        return vtd_pe_get_domain_id(&pe);
> > +    }
> > +
> > +    return vtd_ce_get_domain_id(ce);
> >  }
> >  
> >  /* Return whether the device is using IOMMU translation. */
> > @@ -1317,14 +1654,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
> >  
> >      /* Try to fetch context-entry from cache first */
> >      if (cc_entry->context_cache_gen == s->context_cache_gen) {
> > -        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
> > -                               cc_entry->context_entry.lo,
> > +        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.val[1],
> > +                               cc_entry->context_entry.val[0],
> >                                 cc_entry->context_cache_gen);
> >          ce = cc_entry->context_entry;
> > -        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
> > +        is_fpd_set = ce.val[0] & VTD_CONTEXT_ENTRY_FPD;
> 
> The spec says this bit as: "Enables or disables recording/reporting of
> non-recoverable faults found in this Scalable-Mode context-entry",
> then should I assume that this bit has higher priority than the PASID
> table FPD bits?  If so, below you'll also need to change this:
> 
> > +        if (s->root_scalable) {
> 
> to:
> 
>   if (!is_fpd_set && s->root_scalable) {
>     // explicitly clear is_fpd_set again
>     is_fpd_set = false;
>     ...
> 
> Otherwise the per-PASID FPD can overwrite the per context entry SPD,
> or you could also be using the old per context value as per pasid
> value?
> 
Oh, yes, thanks for the finding!

> > +            ret_fr = vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set);
> > +            if (ret_fr) {
> > +                ret_fr = -ret_fr;
> > +                if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
> > +                    trace_vtd_fault_disabled();
> > +                } else {
> > +                    vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
> > +                }
> > +                goto error;
> > +            }
> > +        }
> >      } else {
> >          ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> > -        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
> > +        is_fpd_set = ce.val[0] & VTD_CONTEXT_ENTRY_FPD;
> > +        if (!ret_fr && s->root_scalable) {
> 
> Similar question here like above.
> 
Thanks!

> > +            ret_fr = vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set);
> > +        }
> >          if (ret_fr) {
> >              ret_fr = -ret_fr;
> >              if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
> > @@ -1335,7 +1687,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
> >              goto error;
> >          }
> >          /* Update context-cache */
> > -        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
> > +        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.val[1], ce.val[0],
> >                                    cc_entry->context_cache_gen,
> >                                    s->context_cache_gen);
> >          cc_entry->context_entry = ce;
> > @@ -1367,7 +1719,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
> >          return true;
> >      }
> >  
> > -    ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
> > +    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
> >                                 &reads, &writes, s->aw_bits);
> >      if (ret_fr) {
> >          ret_fr = -ret_fr;
> > @@ -1381,7 +1733,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
> >  
> >      page_mask = vtd_slpt_level_page_mask(level);
> >      access_flags = IOMMU_ACCESS_FLAG(reads, writes);
> > -    vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
> > +    vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce), addr, slpte,
> >                       access_flags, level);
> >  out:
> >      vtd_iommu_unlock(s);
> > @@ -1404,6 +1756,7 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
> >  {
> >      s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
> >      s->root_extended = s->root & VTD_RTADDR_RTT;
> > +    s->root_scalable = s->root & VTD_RTADDR_SMT;
> 
> Note that although you haven't declared support for scalable mode in
> device capabilities, a customized guest OS could have already set
> root_scalable=true here if it wants and it can start to play with
> these codes.  I think it's probably fine if the code is strong enough,
> just want to make sure whether this is what you want.
> 
A good point. Then, I would like to move it into patch 3 and even add a
protection by checking if "scalable-mode" is on.

> >      s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
> >  
> >      trace_vtd_reg_dmar_root(s->root, s->root_extended);
> > @@ -1573,7 +1926,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
> >      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> >          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> >                                        vtd_as->devfn, &ce) &&
> > -            domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
> > +            domain_id == vtd_get_domain_id(s, &ce)) {
> >              vtd_sync_shadow_page_table(vtd_as);
> >          }
> >      }
[...]

> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index 00e9edb..02674f9 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -172,6 +172,7 @@
> >  
> >  /* RTADDR_REG */
> >  #define VTD_RTADDR_RTT              (1ULL << 11)
> > +#define VTD_RTADDR_SMT              (1ULL << 10)
> >  #define VTD_RTADDR_ADDR_MASK(aw)    (VTD_HAW_MASK(aw) ^ 0xfffULL)
> >  
> >  /* IRTA_REG */
> > @@ -294,6 +295,8 @@ typedef enum VTDFaultReason {
> >                                    * request while disabled */
> >      VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
> >  
> > +    VTD_FR_PASID_TABLE_INV = 0x58,
> 
> Simple comment is welcomed; all the rest error definitions have
> comments.
> 
Ok, will add it.

> > +
> >      /* This is not a normal fault reason. We use this to indicate some faults
> >       * that are not referenced by the VT-d specification.
> >       * Fault event with such reason should not be recorded.
> > @@ -411,8 +414,8 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
> >  #define VTD_PAGE_MASK_1G            (~((1ULL << VTD_PAGE_SHIFT_1G) - 1))
> >  
> >  struct VTDRootEntry {
> > -    uint64_t val;
> > -    uint64_t rsvd;
> > +    uint64_t lo;
> > +    uint64_t hi;
> >  };
> >  typedef struct VTDRootEntry VTDRootEntry;
> >  
> > @@ -423,6 +426,10 @@ typedef struct VTDRootEntry VTDRootEntry;
> >  #define VTD_ROOT_ENTRY_NR           (VTD_PAGE_SIZE / sizeof(VTDRootEntry))
> >  #define VTD_ROOT_ENTRY_RSVD(aw)     (0xffeULL | ~VTD_HAW_MASK(aw))
> >  
> > +#define VTD_ROOT_ENTRY_SIZE         16
> 
> This is never used?
> 
Will remove it.

> > +
> > +#define VTD_DEVFN_CHECK_MASK        0x80
> > +
> >  /* Masks for struct VTDContextEntry */
> >  /* lo */
> >  #define VTD_CONTEXT_ENTRY_P         (1ULL << 0)
> > @@ -441,6 +448,38 @@ typedef struct VTDRootEntry VTDRootEntry;
> >  
> >  #define VTD_CONTEXT_ENTRY_NR        (VTD_PAGE_SIZE / sizeof(VTDContextEntry))
> >  
> > +#define VTD_CTX_ENTRY_LECY_SIZE     16
> 
> LEGACY?  Then the next can spell out SCALABLE too.
> 
Ok, thanks!

[...]

> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > index a321cc9..ff13ff27 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -66,11 +66,12 @@ typedef struct VTDIOTLBEntry VTDIOTLBEntry;
> >  typedef struct VTDBus VTDBus;
> >  typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
> >  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
> > +typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
> > +typedef struct VTDPASIDEntry VTDPASIDEntry;
> >  
> >  /* Context-Entry */
> >  struct VTDContextEntry {
> > -    uint64_t lo;
> > -    uint64_t hi;
> > +    uint64_t val[4];
> 
> You can actually make it an enum, two benefits:
> 
Thanks for the suggestion! DYM 'union'?

> - you don't ever need to touch any existing valid usages of lo/hi
>   vars (though you've already done it...), and
> 
> - people won't get confused when they only see the legacy definition
>   of context entry (which is only 128bits long, so this 256bits
>   defintion could be confusing)
> 
> >  };
> >  
> >  struct VTDContextCacheEntry {
> > @@ -81,6 +82,16 @@ struct VTDContextCacheEntry {
> >      struct VTDContextEntry context_entry;
> >  };
> >  
> > +/* PASID Directory Entry */
> > +struct VTDPASIDDirEntry {
> > +    uint64_t val;
> > +};
> > +
> > +/* PASID Table Entry */
> > +struct VTDPASIDEntry {
> > +    uint64_t val[8];
> > +};
> > +
> >  struct VTDAddressSpace {
> >      PCIBus *bus;
> >      uint8_t devfn;
> > @@ -212,6 +223,7 @@ struct IntelIOMMUState {
> >  
> >      dma_addr_t root;                /* Current root table pointer */
> >      bool root_extended;             /* Type of root table (extended or not) */
> > +    bool root_scalable;             /* Type of root table (scalable or not) */
> >      bool dmar_enabled;              /* Set if DMA remapping is enabled */
> >  
> >      uint16_t iq_head;               /* Current invalidation queue head */
> > -- 
> > 1.9.1
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
