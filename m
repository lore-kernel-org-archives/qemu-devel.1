Received: from eggs.gnu.org ([209.51.188.92]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guAY3-0000b9-ET
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1guAY2-0002UZ-D3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:31:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:27593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1guAY2-00029r-3E
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:31:02 -0500
Date: Thu, 14 Feb 2019 14:27:30 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190214062730.GH16968@yi.y.sun>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
	<20190213104224.GA4405@xz-x1> <20190214015204.GG16968@yi.y.sun>
	<20190214032435.GA3197@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214032435.GA3197@xz-x1>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-02-14 11:24:35, Peter Xu wrote:
> On Thu, Feb 14, 2019 at 09:52:04AM +0800, Yi Sun wrote:
> 
> [...]
> 
> > > > > >  /* Fetch an Invalidation Descriptor from the Invalidation Queue */
> > > > > > -static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
> > > > > > +static bool vtd_get_inv_desc(IntelIOMMUState *s,
> > > > > >                               VTDInvDesc *inv_desc)
> > > > > >  {
> > > > > > -    dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
> > > > > > -    if (dma_memory_read(&address_space_memory, addr, inv_desc,
> > > > > > -        sizeof(*inv_desc))) {
> > > > > > -        error_report_once("Read INV DESC failed");
> > > > > > -        inv_desc->lo = 0;
> > > > > > -        inv_desc->hi = 0;
> > > > > > +    dma_addr_t base_addr = s->iq;
> > > > > > +    uint32_t offset = s->iq_head;
> > > > > > +    uint32_t dw = vtd_get_inv_desc_width(s);
> > > > > > +    dma_addr_t addr = base_addr + offset * dw;
> > > > > > +
> > > > > > +    /* init */
> > > > > > +    inv_desc->val[0] = 0;
> > > > > > +    inv_desc->val[1] = 0;
> > > > > > +    inv_desc->val[2] = 0;
> > > > > > +    inv_desc->val[3] = 0;
> > > > > 
> > > > > No need?
> > > > > 
> > > > This is necessary. Per my test, the val[] are not 0 by default.
> > > 
> > > I agree, it's a stack variable. However...
> > > 
> > > > That makes bug happen.
> > > 
> > > ... could you explain the bug?
> > > 
> > Below error can be observed.
> > 
> > qemu-system-x86_64: vtd_process_inv_desc: invalid inv desc: val[3]=10, val[2]=0 (detect reserve non-zero)
> 
> Ok so you're checking val[2] & val[3] unconditionally:
> 
>     if (inv_desc.val[3] || inv_desc.val[2]) {
>         error_report_once("%s: invalid inv desc: val[3]=%"PRIx64
>                           ", val[2]=%"PRIx64
>                           " (detect reserve non-zero)", __func__,
>                           inv_desc.val[3],
>                           inv_desc.val[2]);
>         return false;
>     }
> 
> Why?  Shouldn't they invalid if inv desc width is 128bits?
> 
Here, my intention is to simplify the codes. If inv_desc.val[] has been
initialized to 0, the error will not happen no matter 128bits or 256bits.

> When 256 bits invalidation descriptor is used, the guest driver
> should be responsible to fill in zeros into reserved fields.
> 
> Another question: is val[2] & val[3] used in any place even with
> 256bits mode?  From what I see from the spec (chap 6.5.2), all of them
> seems to be reserved as zeros, then I don't understand why bother
> extending this to 256bits...  Did I miss something?
> 
Although the high 128bits are not used now, they are defined by spec
so that we should handle them. At least we can know if there is error
by checking if high 128bits are 0. Furthermore, we handle them in codes
now can avoid some changes in the future.

> Regards,
> 
> -- 
> Peter Xu
