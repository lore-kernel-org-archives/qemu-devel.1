Received: from eggs.gnu.org ([209.51.188.92]:40177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzc23-0006et-UA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzc22-0002vC-Q0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:52:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gzc22-0002sz-Fe
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:52:30 -0500
Date: Fri, 1 Mar 2019 14:52:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190301065219.GA22229@xz-x1>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551361677-28933-2-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551361677-28933-2-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC v2 1/3] intel_iommu: scalable mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Thu, Feb 28, 2019 at 09:47:55PM +0800, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> Intel(R) VT-d 3.0 spec introduces scalable mode address translation to
> replace extended context mode. This patch extends current emulator to
> support Scalable Mode which includes root table, context table and new
> pasid table format change. Now intel_iommu emulates both legacy mode
> and scalable mode (with legacy-equivalent capability set).
> 
> The key points are below:
> 1. Extend root table operations to support both legacy mode and scalable
>    mode.
> 2. Extend context table operations to support both legacy mode and
>    scalable mode.
> 3. Add pasid tabled operations to support scalable mode.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> [Yi Sun is co-developer to contribute much to refine the whole commit.]
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Hi, Yi,

The Patch looks very good to me already, though I still have some
trivial comments below.

[...]

> -static inline bool vtd_ce_present(VTDContextEntry *context)
> +static inline bool vtd_ce_present(VTDContextEntry *ce)
>  {
> -    return context->lo & VTD_CONTEXT_ENTRY_P;
> +    return ce->lo & VTD_CONTEXT_ENTRY_P;

The renaming seems not needed.

>  }
>  
> -static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
> +static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
> +                                           VTDRootEntry *re,
> +                                           uint8_t index,
>                                             VTDContextEntry *ce)
>  {
> -    dma_addr_t addr;
> +    dma_addr_t addr, ce_size;
>  
>      /* we have checked that root entry is present */
> -    addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
> -    if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
> +    ce_size = s->root_scalable ? VTD_CTX_ENTRY_SCALABLE_SIZE :
> +              VTD_CTX_ENTRY_LEGACY_SIZE;
> +
> +    if (s->root_scalable && index > UINT8_MAX / 2) {
> +        index = index & (~VTD_DEVFN_CHECK_MASK);
> +        addr = re->hi & VTD_ROOT_ENTRY_CTP;
> +    } else {
> +        addr = re->lo & VTD_ROOT_ENTRY_CTP;
> +    }
> +
> +    addr = addr + index * ce_size;
> +    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
>          return -VTD_FR_CONTEXT_TABLE_INV;
>      }
> +
>      ce->lo = le64_to_cpu(ce->lo);
>      ce->hi = le64_to_cpu(ce->hi);
> +    if (s->root_scalable) {

(or use ce_size which might be more obvious)

> +        ce->val[2] = le64_to_cpu(ce->val[2]);
> +        ce->val[3] = le64_to_cpu(ce->val[3]);
> +    }
>      return 0;
>  }

[...]

> +static inline int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
> +                                             VTDContextEntry *ce,
> +                                             VTDPASIDEntry *pe)
> +{
> +    uint32_t pasid;
> +    dma_addr_t pasid_dir_base;
> +    int ret = 0;
> +
> +    pasid = VTD_CE_GET_RID2PASID(ce);
> +    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
> +    ret = vtd_get_pasid_entry_from_pasid(s, pasid_dir_base, pasid, pe);
> +
> +    return ret;
> +}
> +
> +static inline int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
> +                                       VTDContextEntry *ce,
> +                                       bool *pe_fpd_set)

Many functions are defined as inlined (even some functions that may
not be that short IMHO) and many of them are not.  Could you share how
you decide which function should be inlined?

[...]

>  static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
>                                       VTDContextEntry *ce)
>  {
> +    IntelIOMMUState *s = INTEL_IOMMU_DEVICE(x86_iommu);
> +
> +    if (s->root_scalable) {
> +        /*
> +         * Translation Type locates in context entry only when VTD is in
> +         * legacy mode. For scalable mode, need to return true to avoid
> +         * unnecessary fault.
> +         */
> +        return true;
> +    }

Do you think we can move this check directly into caller of
vtd_ce_type_check() which is vtd_dev_to_context_entry()?  Then:

  if (scalable_mode)
    vtd_ce_rid2pasid_check()
  else
    vtd_ce_type_check()

You can comment on function vtd_ce_type_check() that this only checks
legacy context entries, since calling vtd_ce_type_check() upon an
scalable mode context entry does not make much sense itself already.

[...]

>  /* Return whether the device is using IOMMU translation. */
> @@ -1322,9 +1636,24 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>                                 cc_entry->context_cache_gen);
>          ce = cc_entry->context_entry;
>          is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
> +        if (!is_fpd_set && s->root_scalable) {
> +            ret_fr = vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set);
> +            if (ret_fr) {
> +                ret_fr = -ret_fr;
> +                if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {

I noticed that I can't find how's vtd_qualified_faults defined and how
that was reflected in the vt-d spec...  Do you know?  Meanwhile, do
you need to add the new error VTD_FR_PASID_TABLE_INV into the table?

Also, this pattern repeated for times.  Maybe it's time to introduce a
new helper.  Your call on this:

        if (ret_fr) {
            ret_fr = -ret_fr;
            if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
                trace_vtd_fault_disabled();
            } else {
                vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
            }
            goto error;
        }

> +                    trace_vtd_fault_disabled();
> +                } else {
> +                    vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
> +                }
> +                goto error;
> +            }
> +        }

[...]

> @@ -2629,6 +2958,7 @@ static const VMStateDescription vtd_vmstate = {
>          VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
>          VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
>          VMSTATE_BOOL(root_extended, IntelIOMMUState),
> +        VMSTATE_BOOL(root_scalable, IntelIOMMUState),
>          VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> @@ -3098,9 +3428,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      vtd_address_space_unmap(vtd_as, n);
>  
>      if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> -        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> +        trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" : "",

"scalable mode" : "legacy mode"?

Regards,

-- 
Peter Xu
