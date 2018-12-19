Received: from eggs.gnu.org ([2001:4830:134:3::10]:33344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZSJO-00004z-Mi
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 22:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZSHx-0002yV-Pp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 22:12:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZSHx-0002y9-Gv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 22:12:49 -0500
Date: Tue, 18 Dec 2018 22:12:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218221031-mutt-send-email-mst@kernel.org>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1544619939-18102-2-git-send-email-yu.c.zhang@linux.intel.com>
	<20181217141740.16ccfaa1@Igors-MacBook-Pro.local>
	<20181218092723.yhaerzm4vlzgef65@linux.intel.com>
	<20181218155536.2b35a037@Igors-MacBook-Pro.local>
	<20181218095745-mutt-send-email-mst@kernel.org>
	<20181219030358.drxnsqchuj5i37bp@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219030358.drxnsqchuj5i37bp@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] intel-iommu: differentiate host
 address width from IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Dec 19, 2018 at 11:03:58AM +0800, Yu Zhang wrote:
> On Tue, Dec 18, 2018 at 09:58:35AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 18, 2018 at 03:55:36PM +0100, Igor Mammedov wrote:
> > > On Tue, 18 Dec 2018 17:27:23 +0800
> > > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > > 
> > > > On Mon, Dec 17, 2018 at 02:17:40PM +0100, Igor Mammedov wrote:
> > > > > On Wed, 12 Dec 2018 21:05:38 +0800
> > > > > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > > > > 
> > > > > > Currently, vIOMMU is using the value of IOVA address width, instead of
> > > > > > the host address width(HAW) to calculate the number of reserved bits in
> > > > > > data structures such as root entries, context entries, and entries of
> > > > > > DMA paging structures etc.
> > > > > > 
> > > > > > However values of IOVA address width and of the HAW may not equal. For
> > > > > > example, a 48-bit IOVA can only be mapped to host addresses no wider than
> > > > > > 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> > > > > > in an invalid IOVA being accepted.
> > > > > > 
> > > > > > To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> > > > > > whose value is initialized based on the maximum physical address set to
> > > > > > guest CPU.
> > > > > 
> > > > > > Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> > > > > > to clarify.
> > > > > > 
> > > > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > [...]
> > > > > 
> > > > > > @@ -3100,6 +3104,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> > > > > >  static void vtd_init(IntelIOMMUState *s)
> > > > > >  {
> > > > > >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > > > > > +    CPUState *cs = first_cpu;
> > > > > > +    X86CPU *cpu = X86_CPU(cs);
> > > > > >  
> > > > > >      memset(s->csr, 0, DMAR_REG_SIZE);
> > > > > >      memset(s->wmask, 0, DMAR_REG_SIZE);
> > > > > > @@ -3119,23 +3125,24 @@ static void vtd_init(IntelIOMMUState *s)
> > > > > >      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> > > > > >               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
> > > > > >               VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
> > > > > > -    if (s->aw_bits == VTD_HOST_AW_48BIT) {
> > > > > > +    if (s->aw_bits == VTD_AW_48BIT) {
> > > > > >          s->cap |= VTD_CAP_SAGAW_48bit;
> > > > > >      }
> > > > > >      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> > > > > > +    s->haw_bits = cpu->phys_bits;
> > > > > Is it possible to avoid accessing CPU fields directly or cpu altogether
> > > > > and set phys_bits when iommu is created?
> > > > 
> > > > Thanks for your comments, Igor.
> > > > 
> > > > Well, I guess you prefer not to query the CPU capabilities while deciding
> > > > the vIOMMU features. But to me, they are not that irrelevant.:)
> > > > 
> > > > Here the hardware address width in vt-d, and the one in cpuid.MAXPHYSADDR
> > > > are referring to the same concept. In VM, both are the maximum guest physical
> > > > address width. If we do not check the CPU field here, we will still have to
> > > > check the CPU field in other places such as build_dmar_q35(), and reset the
> > > > s->haw_bits again.
> > > > 
> > > > Is this explanation convincing enough? :)
> > > current build_dmar_q35() doesn't do it, it's all new code in this series that
> > > contains not acceptable direct access from one device (iommu) to another (cpu).   
> > > Proper way would be for the owner of iommu to fish limits from somewhere and set
> > > values during iommu creation.
> > 
> > Maybe it's a good idea to add documentation for now.
> 
> Thanks Michael. So what kind of documentation do you refer? 

The idea would be to have two properties, AW for the CPU and
the IOMMU. In the documentation explain that they
should normally be set to the same value.

> > 
> > It would be nice not to push this stuff up the stack,
> > it's unfortunate that our internal APIs make it hard.
> 
> Sorry, I do not quite get it. What do you mean "internal APIs make it hard"? :)

The API doesn't actually guarantee any initialization order.
CPU happens to be initialized first but I do not
think there's a guarantee that it will keep being the case.
This makes it hard to get properties from one device
and use in another one.

> > 
> > 
> > > > > 
> > > > > Perhaps Eduardo
> > > > >  can suggest better approach, since he's more familiar with phys_bits topic
> > > > 
> > > > @Eduardo, any comments? Thanks!
> > > > 
> > > > > 
> > > > > >      /*
> > > > > >       * Rsvd field masks for spte
> > > > > >       */
> > > > > >      vtd_paging_entry_rsvd_field[0] = ~0ULL;
> > > > > > -    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
> > > > > >  
> > > > > >      if (x86_iommu->intr_supported) {
> > > > > >          s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
> > > > > > @@ -3261,10 +3268,10 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> > > > > >      }
> > > > > >  
> > > > > >      /* Currently only address widths supported are 39 and 48 bits */
> > > > > > -    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
> > > > > > -        (s->aw_bits != VTD_HOST_AW_48BIT)) {
> > > > > > +    if ((s->aw_bits != VTD_AW_39BIT) &&
> > > > > > +        (s->aw_bits != VTD_AW_48BIT)) {
> > > > > >          error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
> > > > > > -                   VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
> > > > > > +                   VTD_AW_39BIT, VTD_AW_48BIT);
> > > > > >          return false;
> > > > > >      }
> > > > > >  
> > > > > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > > > > > index ed4e758..820451c 100644
> > > > > > --- a/include/hw/i386/intel_iommu.h
> > > > > > +++ b/include/hw/i386/intel_iommu.h
> > > > > > @@ -47,9 +47,9 @@
> > > > > >  #define VTD_SID_TO_DEVFN(sid)       ((sid) & 0xff)
> > > > > >  
> > > > > >  #define DMAR_REG_SIZE               0x230
> > > > > > -#define VTD_HOST_AW_39BIT           39
> > > > > > -#define VTD_HOST_AW_48BIT           48
> > > > > > -#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
> > > > > > +#define VTD_AW_39BIT                39
> > > > > > +#define VTD_AW_48BIT                48
> > > > > > +#define VTD_ADDRESS_WIDTH           VTD_AW_39BIT
> > > > > >  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
> > > > > >  
> > > > > >  #define DMAR_REPORT_F_INTR          (1)
> > > > > > @@ -244,7 +244,8 @@ struct IntelIOMMUState {
> > > > > >      bool intr_eime;                 /* Extended interrupt mode enabled */
> > > > > >      OnOffAuto intr_eim;             /* Toggle for EIM cabability */
> > > > > >      bool buggy_eim;                 /* Force buggy EIM unless eim=off */
> > > > > > -    uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> > > > > > +    uint8_t aw_bits;                /* IOVA address width (in bits) */
> > > > > > +    uint8_t haw_bits;               /* Hardware address width (in bits) */
> > > > > >  
> > > > > >      /*
> > > > > >       * Protects IOMMU states in general.  Currently it protects the
> > > > > 
> > > > > 
> > > > 
> > > > B.R.
> > > > Yu
> > 
> 
> B.R.
> Yu
