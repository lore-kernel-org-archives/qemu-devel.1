Received: from eggs.gnu.org ([2001:4830:134:3::10]:40752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ga5Oy-0006xi-97
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ga5Ov-0006S5-3B
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:58:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ga5Ou-0006RC-Qw
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:58:37 -0500
Date: Thu, 20 Dec 2018 18:58:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181220205829.GQ19442@habkost.net>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1544619939-18102-2-git-send-email-yu.c.zhang@linux.intel.com>
	<20181217141740.16ccfaa1@Igors-MacBook-Pro.local>
	<20181218092723.yhaerzm4vlzgef65@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218092723.yhaerzm4vlzgef65@linux.intel.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 18, 2018 at 05:27:23PM +0800, Yu Zhang wrote:
> On Mon, Dec 17, 2018 at 02:17:40PM +0100, Igor Mammedov wrote:
> > On Wed, 12 Dec 2018 21:05:38 +0800
> > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > 
> > > Currently, vIOMMU is using the value of IOVA address width, instead of
> > > the host address width(HAW) to calculate the number of reserved bits in
> > > data structures such as root entries, context entries, and entries of
> > > DMA paging structures etc.
> > > 
> > > However values of IOVA address width and of the HAW may not equal. For
> > > example, a 48-bit IOVA can only be mapped to host addresses no wider than
> > > 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> > > in an invalid IOVA being accepted.
> > > 
> > > To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> > > whose value is initialized based on the maximum physical address set to
> > > guest CPU.
> > 
> > > Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> > > to clarify.
> > > 
> > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > ---
> > [...]
> > 
> > > @@ -3100,6 +3104,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> > >  static void vtd_init(IntelIOMMUState *s)
> > >  {
> > >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > > +    CPUState *cs = first_cpu;
> > > +    X86CPU *cpu = X86_CPU(cs);
> > >  
> > >      memset(s->csr, 0, DMAR_REG_SIZE);
> > >      memset(s->wmask, 0, DMAR_REG_SIZE);
> > > @@ -3119,23 +3125,24 @@ static void vtd_init(IntelIOMMUState *s)
> > >      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> > >               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
> > >               VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
> > > -    if (s->aw_bits == VTD_HOST_AW_48BIT) {
> > > +    if (s->aw_bits == VTD_AW_48BIT) {
> > >          s->cap |= VTD_CAP_SAGAW_48bit;
> > >      }
> > >      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> > > +    s->haw_bits = cpu->phys_bits;
> > Is it possible to avoid accessing CPU fields directly or cpu altogether
> > and set phys_bits when iommu is created?
> 
> Thanks for your comments, Igor.
> 
> Well, I guess you prefer not to query the CPU capabilities while deciding
> the vIOMMU features. But to me, they are not that irrelevant.:)
> 
> Here the hardware address width in vt-d, and the one in cpuid.MAXPHYSADDR
> are referring to the same concept. In VM, both are the maximum guest physical
> address width. If we do not check the CPU field here, we will still have to
> check the CPU field in other places such as build_dmar_q35(), and reset the
> s->haw_bits again.
> 
> Is this explanation convincing enough? :)
> 
> > 
> > Perhaps Eduardo
> >  can suggest better approach, since he's more familiar with phys_bits topic
> 
> @Eduardo, any comments? Thanks!

Configuring IOMMU phys-bits automatically depending on the
configured CPU is OK, but accessing first_cpu directly in iommu
code is.  I suggest delegating this to the machine object, e.g.:

  uint32_t pc_max_phys_bits(PCMachineState *pcms)
  {
      return object_property_get_uint(OBJECT(first_cpu), "phys-bits", &error_abort);
  }

as the machine itself is responsible for creating the CPU
objects, and I believe there are other places in PC code where we
do physical address calculations that could be affected by the
physical address space size.

-- 
Eduardo
