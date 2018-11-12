Received: from eggs.gnu.org ([2001:4830:134:3::10]:60786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMBWX-0001XX-Pp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMBWT-0003Qt-Bi
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:41:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:5809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gMBWS-0001A5-WC
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:40:57 -0500
Date: Mon, 12 Nov 2018 20:38:30 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181112123830.r7mtvmlbhmcsct43@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-4-git-send-email-yu.c.zhang@linux.intel.com>
	<20181112085121.GD20675@xz-x1>
	<20181112092548.4rnr56lw6zgzmfwh@linux.intel.com>
	<20181112093638.GG20675@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112093638.GG20675@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v1 3/3] intel-iommu: search iotlb for
 levels supported by the address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Nov 12, 2018 at 05:36:38PM +0800, Peter Xu wrote:
> On Mon, Nov 12, 2018 at 05:25:48PM +0800, Yu Zhang wrote:
> > On Mon, Nov 12, 2018 at 04:51:22PM +0800, Peter Xu wrote:
> > > On Fri, Nov 09, 2018 at 07:49:47PM +0800, Yu Zhang wrote:
> > > > This patch updates vtd_lookup_iotlb() to search cached mappings only
> > > > for all page levels supported by address width of current vIOMMU. Also,
> > > > to cover 57-bit width, the shift of source id(VTD_IOTLB_SID_SHIFT) and
> > > > of page level(VTD_IOTLB_LVL_SHIFT) are enlarged by 9 - the stride of
> > > > one paging structure level.
> > > > 
> > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > ---
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com> 
> > > > Cc: Richard Henderson <rth@twiddle.net> 
> > > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  hw/i386/intel_iommu.c          | 5 +++--
> > > >  hw/i386/intel_iommu_internal.h | 7 ++-----
> > > >  2 files changed, 5 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > index 9cdf755..ce7e17e 100644
> > > > --- a/hw/i386/intel_iommu.c
> > > > +++ b/hw/i386/intel_iommu.c
> > > > @@ -254,11 +254,12 @@ static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
> > > >  static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
> > > >                                         hwaddr addr)
> > > >  {
> > > > -    VTDIOTLBEntry *entry;
> > > > +    VTDIOTLBEntry *entry = NULL;
> > > >      uint64_t key;
> > > >      int level;
> > > > +    int max_level = (s->aw_bits - VTD_PAGE_SHIFT_4K) / VTD_SL_LEVEL_BITS;
> > > >  
> > > > -    for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> > > > +    for (level = VTD_SL_PT_LEVEL; level < max_level; level++) {
> > > 
> > > My understanding of current IOTLB is that it only caches the last
> > > level of mapping, say:
> > > 
> > >   - level 1: 4K page
> > >   - level 2: 2M page
> > >   - level 3: 1G page
> > > 
> > > So we don't check against level=4 even if x-aw-bits=48 is specified.
> > > 
> > > Here does it mean that we're going to have... 512G iommu huge pages?
> > > 
> > 
> > No. My bad, I misunderstood this routine. And now I believe we do not
> > need this patch. :-)
> 
> Yeah good to confirm that :-)

Sorry, Peter. I still have question about this part. I agree we do not need
to do the extra loop - therefore no need for the max_level part introduced
in this patch.

But as to modification of VTD_IOTLB_SID_SHIFT/VTD_IOTLB_LVL_SHIFT, we may
still need to do it due to the enlarged gfn, to search an IOTLB entry for
a 4K mapping, the pfn itself could be as large as 45-bit.

Besides, currently vtd_get_iotlb_gfn() is just shifting 12 bits for all
different levels, is this necessary? I mean, how about we do the shift
based on current level?

 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
 {
-    return (addr & vtd_slpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
+    uint32_t shift = vtd_slpt_level_shift(level);
+    return (addr & vtd_slpt_level_page_mask(level)) >> shift;
 }

> 
> Regards,
> 
> -- 
> Peter Xu
> 

B.R.
Yu
