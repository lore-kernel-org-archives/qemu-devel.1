Received: from eggs.gnu.org ([2001:4830:134:3::10]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gM8Vn-0000dn-IX
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gM8Vj-0001Cl-FS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:28:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:9218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gM8Vj-0001Bg-5W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:27:59 -0500
Date: Mon, 12 Nov 2018 17:25:48 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181112092548.4rnr56lw6zgzmfwh@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-4-git-send-email-yu.c.zhang@linux.intel.com>
	<20181112085121.GD20675@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112085121.GD20675@xz-x1>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Nov 12, 2018 at 04:51:22PM +0800, Peter Xu wrote:
> On Fri, Nov 09, 2018 at 07:49:47PM +0800, Yu Zhang wrote:
> > This patch updates vtd_lookup_iotlb() to search cached mappings only
> > for all page levels supported by address width of current vIOMMU. Also,
> > to cover 57-bit width, the shift of source id(VTD_IOTLB_SID_SHIFT) and
> > of page level(VTD_IOTLB_LVL_SHIFT) are enlarged by 9 - the stride of
> > one paging structure level.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > ---
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com> 
> > Cc: Richard Henderson <rth@twiddle.net> 
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c          | 5 +++--
> >  hw/i386/intel_iommu_internal.h | 7 ++-----
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 9cdf755..ce7e17e 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -254,11 +254,12 @@ static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
> >  static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
> >                                         hwaddr addr)
> >  {
> > -    VTDIOTLBEntry *entry;
> > +    VTDIOTLBEntry *entry = NULL;
> >      uint64_t key;
> >      int level;
> > +    int max_level = (s->aw_bits - VTD_PAGE_SHIFT_4K) / VTD_SL_LEVEL_BITS;
> >  
> > -    for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> > +    for (level = VTD_SL_PT_LEVEL; level < max_level; level++) {
> 
> My understanding of current IOTLB is that it only caches the last
> level of mapping, say:
> 
>   - level 1: 4K page
>   - level 2: 2M page
>   - level 3: 1G page
> 
> So we don't check against level=4 even if x-aw-bits=48 is specified.
> 
> Here does it mean that we're going to have... 512G iommu huge pages?
> 

No. My bad, I misunderstood this routine. And now I believe we do not
need this patch. :-)

Thanks, Peter.

> >          key = vtd_get_iotlb_key(vtd_get_iotlb_gfn(addr, level),
> >                                  source_id, level);
> >          entry = g_hash_table_lookup(s->iotlb, &key);
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index a7ef24b..bdf2b7c 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -114,8 +114,8 @@
> >                                       VTD_INTERRUPT_ADDR_FIRST + 1)
> >  
> >  /* The shift of source_id in the key of IOTLB hash table */
> > -#define VTD_IOTLB_SID_SHIFT         36
> > -#define VTD_IOTLB_LVL_SHIFT         52
> > +#define VTD_IOTLB_SID_SHIFT         45
> > +#define VTD_IOTLB_LVL_SHIFT         61
> >  #define VTD_IOTLB_MAX_SIZE          1024    /* Max size of the hash table */
> >  
> >  /* IOTLB_REG */
> > @@ -450,9 +450,6 @@ typedef struct VTDRootEntry VTDRootEntry;
> >  #define VTD_SL_LEVEL_BITS           9
> >  
> >  /* Second Level Paging Structure */
> > -#define VTD_SL_PML4_LEVEL           4
> > -#define VTD_SL_PDP_LEVEL            3
> > -#define VTD_SL_PD_LEVEL             2
> >  #define VTD_SL_PT_LEVEL             1
> >  #define VTD_SL_PT_ENTRY_NR          512
> >  
> > -- 
> > 1.9.1
> > 
> 
> Regards,
> 
> -- 
> Peter Xu
> 

B.R.
Yu
