Received: from eggs.gnu.org ([209.51.188.92]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gu7pW-0008C9-I3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gu7dm-0006rb-L6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:24:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gu7dm-0006r5-FM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:24:46 -0500
Date: Thu, 14 Feb 2019 11:24:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190214032435.GA3197@xz-x1>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
	<20190213104224.GA4405@xz-x1> <20190214015204.GG16968@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214015204.GG16968@yi.y.sun>
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

On Thu, Feb 14, 2019 at 09:52:04AM +0800, Yi Sun wrote:

[...]

> > > > >  /* Fetch an Invalidation Descriptor from the Invalidation Queue */
> > > > > -static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
> > > > > +static bool vtd_get_inv_desc(IntelIOMMUState *s,
> > > > >                               VTDInvDesc *inv_desc)
> > > > >  {
> > > > > -    dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
> > > > > -    if (dma_memory_read(&address_space_memory, addr, inv_desc,
> > > > > -        sizeof(*inv_desc))) {
> > > > > -        error_report_once("Read INV DESC failed");
> > > > > -        inv_desc->lo = 0;
> > > > > -        inv_desc->hi = 0;
> > > > > +    dma_addr_t base_addr = s->iq;
> > > > > +    uint32_t offset = s->iq_head;
> > > > > +    uint32_t dw = vtd_get_inv_desc_width(s);
> > > > > +    dma_addr_t addr = base_addr + offset * dw;
> > > > > +
> > > > > +    /* init */
> > > > > +    inv_desc->val[0] = 0;
> > > > > +    inv_desc->val[1] = 0;
> > > > > +    inv_desc->val[2] = 0;
> > > > > +    inv_desc->val[3] = 0;
> > > > 
> > > > No need?
> > > > 
> > > This is necessary. Per my test, the val[] are not 0 by default.
> > 
> > I agree, it's a stack variable. However...
> > 
> > > That makes bug happen.
> > 
> > ... could you explain the bug?
> > 
> Below error can be observed.
> 
> qemu-system-x86_64: vtd_process_inv_desc: invalid inv desc: val[3]=10, val[2]=0 (detect reserve non-zero)

Ok so you're checking val[2] & val[3] unconditionally:

    if (inv_desc.val[3] || inv_desc.val[2]) {
        error_report_once("%s: invalid inv desc: val[3]=%"PRIx64
                          ", val[2]=%"PRIx64
                          " (detect reserve non-zero)", __func__,
                          inv_desc.val[3],
                          inv_desc.val[2]);
        return false;
    }

Why?  Shouldn't they invalid if inv desc width is 128bits?

When 256 bits invalidation descriptor is used, the guest driver
should be responsible to fill in zeros into reserved fields.

Another question: is val[2] & val[3] used in any place even with
256bits mode?  From what I see from the spec (chap 6.5.2), all of them
seems to be reserved as zeros, then I don't understand why bother
extending this to 256bits...  Did I miss something?

Regards,

-- 
Peter Xu
