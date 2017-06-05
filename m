Received: from eggs.gnu.org ([2001:4830:134:3::10]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dHiMm-0005HJ-5X
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dHiMh-0007yD-7E
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dHiMg-0007x4-Ur
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 23:07:35 -0400
Date: Mon, 5 Jun 2017 11:07:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170605030725.GF4056@pxdev.xzpeter.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602194523-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jun 02, 2017 at 07:49:58PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 02, 2017 at 07:50:53PM +0800, Peter Xu wrote:
> > This patch let address_space_get_iotlb_entry() to use the newly
> > introduced page_mask parameter in address_space_do_translate(). Then we
> > will be sure the IOTLB can be aligned to page mask, also we should
> > nicely support huge pages now when introducing a764040.
> > 
> > Fixes: a764040 ("exec: abstract address_space_do_translate()")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  exec.c | 29 ++++++++++-------------------
> >  1 file changed, 10 insertions(+), 19 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 63a3ff0..1f86253 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -544,14 +544,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> >                                              bool is_write)
> >  {
> >      MemoryRegionSection section;
> > -    hwaddr xlat, plen;
> > +    hwaddr xlat, page_mask;
> >  
> > -    /* Try to get maximum page mask during translation. */
> > -    plen = (hwaddr)-1;
> > -
> > -    /* This can never be MMIO. */
> > -    section = address_space_do_translate(as, addr, &xlat, &plen,
> > -                                         NULL, is_write, false);
> > +    /*
> > +     * This can never be MMIO, and we don't really care about plen,
> > +     * but page mask.
> > +     */
> > +    section = address_space_do_translate(as, addr, &xlat, NULL,
> > +                                         &page_mask, is_write, false);
> >  
> >      /* Illegal translation */
> >      if (section.mr == &io_mem_unassigned) {
> 
> 
> Can we just use section.size - xlat here?

I replied in the other thread about what I thought... So will skip
here.

> 
> > @@ -562,20 +562,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> >      xlat += section.offset_within_address_space -
> >          section.offset_within_region;
> >  
> > -    if (plen == (hwaddr)-1) {
> > -        /* If not specified during translation, use default mask */
> > -        plen = TARGET_PAGE_MASK;
> > -    } else {
> > -        /* Make it a valid page mask */
> > -        assert(plen);
> > -        plen = pow2floor(plen) - 1;
> > -    }
> > -
> >      return (IOMMUTLBEntry) {
> >          .target_as = section.address_space,
> > -        .iova = addr & ~plen,
> > -        .translated_addr = xlat & ~plen,
> > -        .addr_mask = plen,
> > +        .iova = addr & ~page_mask,
> > +        .translated_addr = xlat & ~page_mask,
> > +        .addr_mask = page_mask,
> >          /* IOTLBs are for DMAs, and DMA only allows on RAMs. */
> 
> BTW this comment is pretty confusing. What does it mean?

This function, address_space_get_iotlb_entry(), is for device to get
IOTLB entry when they want to request for page translations for DMA,
and DMA should only be allowed to RAM, right? Then we need IOMMU_RW
permission here.

Maybe I should add one more check above on the returned MR - it should
be RAM typed as well. But I don't really know whether that's too
strict, since if guest setup the IOMMU page table to allow one IOVA
points to a non-RAM region, I thought it should still be legal from
hypervisor POV (I see it a guest OS bug though)?

> 
> >          .perm = IOMMU_RW,
> >      };
> 
> Looks like we should change IOMMUTLBEntry to pass size and not mask -
> then we could simply pass info from section as is. iova would be
> addr - xlat.

I don't sure whether it'll be a good interface for IOTLB. AFAIU at
least for VT-d, the IOMMU translation is page aligned which is defined
by spec, so it makes sense that (again at least for VT-d) here we'd
better just use page_mask/addr_mask.

That's also how I know about IOMMU in general - I assume it do the
translations always with page masks (never arbitary length), though
page size can differ from platfrom to platform, that's why here the
IOTLB interface used addr_mask, then it works for all platforms. I
don't know whether I'm 100% correct here though.

Maybe David/Paolo/... would comment as well?

(CC David)

Thanks,

-- 
Peter Xu
