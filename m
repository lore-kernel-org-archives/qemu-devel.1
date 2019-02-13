Received: from eggs.gnu.org ([209.51.188.92]:47163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtrzy-0002wQ-O4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtrzx-00087p-SL
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtrzx-00087E-Ld
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:42:37 -0500
Date: Wed, 13 Feb 2019 18:42:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190213104224.GA4405@xz-x1>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190213090041.GF16968@yi.y.sun>
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

On Wed, Feb 13, 2019 at 05:00:41PM +0800, Yi Sun wrote:

[...]

> > >  
> > >  /* context entry operations */
> > >  #define vtd_get_ce_size(s, ce) \
> > > @@ -65,6 +66,9 @@
> > >  #define vtd_pe_get_slpt_base(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_SLPTPTR)
> > >  #define vtd_pe_get_domain_id(pe) VTD_SM_PASID_ENTRY_DID((pe)->val[1])
> > >  
> > > +/* invalidation desc */
> > > +#define vtd_get_inv_desc_width(s) ((s)->iq_dw ? 32 : 16)
> > 
> > Nit: I'll prefer dropping all the "get" wordings in these macros to be
> > "vtd_inv_desc_width" since that "get" doesn't help much on
> > understanding its meanings.  But it's personal preference too.
> > 
> That is fine.
> 
> > And since you've already have the iq_dw variable - why not store the
> > width directly into it?  An uint8_t would suffice.
> > 
> iq_dw corresponds to VTD_IQA_DW_MASK (Descriptor Width defined in IQA
> register). 1 means 256-bit descriptor, 0 means 128-bit descriptor.
> 
> It is also used in vtd_handle_gcmd_qie() and VTD_IQT_QT() by checking if
> its value is 1.
> 
> So, I would prefer to keep the original design.

It's ok.   But please make it a boolean.  Now iq_dw can be 0x800.

[...]

> > >  /* Fetch an Invalidation Descriptor from the Invalidation Queue */
> > > -static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
> > > +static bool vtd_get_inv_desc(IntelIOMMUState *s,
> > >                               VTDInvDesc *inv_desc)
> > >  {
> > > -    dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
> > > -    if (dma_memory_read(&address_space_memory, addr, inv_desc,
> > > -        sizeof(*inv_desc))) {
> > > -        error_report_once("Read INV DESC failed");
> > > -        inv_desc->lo = 0;
> > > -        inv_desc->hi = 0;
> > > +    dma_addr_t base_addr = s->iq;
> > > +    uint32_t offset = s->iq_head;
> > > +    uint32_t dw = vtd_get_inv_desc_width(s);
> > > +    dma_addr_t addr = base_addr + offset * dw;
> > > +
> > > +    /* init */
> > > +    inv_desc->val[0] = 0;
> > > +    inv_desc->val[1] = 0;
> > > +    inv_desc->val[2] = 0;
> > > +    inv_desc->val[3] = 0;
> > 
> > No need?
> > 
> This is necessary. Per my test, the val[] are not 0 by default.

I agree, it's a stack variable. However...

> That makes bug happen.

... could you explain the bug?

Regards,

-- 
Peter Xu
