Received: from eggs.gnu.org ([208.118.235.92]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gcX3J-0007u5-OP
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gcX3B-00026T-Tt
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gcX36-00024o-9j
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:54:13 -0500
Date: Thu, 27 Dec 2018 12:54:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181227145402.GY19442@habkost.net>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1544619939-18102-2-git-send-email-yu.c.zhang@linux.intel.com>
	<20181217141740.16ccfaa1@Igors-MacBook-Pro.local>
	<20181218092723.yhaerzm4vlzgef65@linux.intel.com>
	<20181218155536.2b35a037@Igors-MacBook-Pro.local>
	<20181219025717.6m72hq73p2haexkv@linux.intel.com>
	<20181219114037.5550a562@redhat.com>
	<20181220211801.GR19442@habkost.net>
	<20181221151325.39b64733@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221151325.39b64733@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Dec 21, 2018 at 03:13:25PM +0100, Igor Mammedov wrote:
> On Thu, 20 Dec 2018 19:18:01 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Dec 19, 2018 at 11:40:37AM +0100, Igor Mammedov wrote:
> > > On Wed, 19 Dec 2018 10:57:17 +0800
> > > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > >   
> > > > On Tue, Dec 18, 2018 at 03:55:36PM +0100, Igor Mammedov wrote:  
> > > > > On Tue, 18 Dec 2018 17:27:23 +0800
> > > > > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > > > >     
> > > > > > On Mon, Dec 17, 2018 at 02:17:40PM +0100, Igor Mammedov wrote:    
> > > > > > > On Wed, 12 Dec 2018 21:05:38 +0800
> > > > > > > Yu Zhang <yu.c.zhang@linux.intel.com> wrote:
> > > > > > >     
> > > > > > > > Currently, vIOMMU is using the value of IOVA address width, instead of
> > > > > > > > the host address width(HAW) to calculate the number of reserved bits in
> > > > > > > > data structures such as root entries, context entries, and entries of
> > > > > > > > DMA paging structures etc.
> > > > > > > > 
> > > > > > > > However values of IOVA address width and of the HAW may not equal. For
> > > > > > > > example, a 48-bit IOVA can only be mapped to host addresses no wider than
> > > > > > > > 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> > > > > > > > in an invalid IOVA being accepted.
> > > > > > > > 
> > > > > > > > To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> > > > > > > > whose value is initialized based on the maximum physical address set to
> > > > > > > > guest CPU.    
> > > > > > >     
> > > > > > > > Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> > > > > > > > to clarify.
> > > > > > > > 
> > > > > > > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > > > > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > > > > > ---    
> > > > > > > [...]
> > > > > > >     
> > > > > > > > @@ -3100,6 +3104,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
> > > > > > > >  static void vtd_init(IntelIOMMUState *s)
> > > > > > > >  {
> > > > > > > >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > > > > > > > +    CPUState *cs = first_cpu;
> > > > > > > > +    X86CPU *cpu = X86_CPU(cs);
> > > > > > > >  
> > > > > > > >      memset(s->csr, 0, DMAR_REG_SIZE);
> > > > > > > >      memset(s->wmask, 0, DMAR_REG_SIZE);
> > > > > > > > @@ -3119,23 +3125,24 @@ static void vtd_init(IntelIOMMUState *s)
> > > > > > > >      s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> > > > > > > >               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
> > > > > > > >               VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
> > > > > > > > -    if (s->aw_bits == VTD_HOST_AW_48BIT) {
> > > > > > > > +    if (s->aw_bits == VTD_AW_48BIT) {
> > > > > > > >          s->cap |= VTD_CAP_SAGAW_48bit;
> > > > > > > >      }
> > > > > > > >      s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> > > > > > > > +    s->haw_bits = cpu->phys_bits;    
> > > > > > > Is it possible to avoid accessing CPU fields directly or cpu altogether
> > > > > > > and set phys_bits when iommu is created?    
> > > > > > 
> > > > > > Thanks for your comments, Igor.
> > > > > > 
> > > > > > Well, I guess you prefer not to query the CPU capabilities while deciding
> > > > > > the vIOMMU features. But to me, they are not that irrelevant.:)
> > > > > > 
> > > > > > Here the hardware address width in vt-d, and the one in cpuid.MAXPHYSADDR
> > > > > > are referring to the same concept. In VM, both are the maximum guest physical
> > > > > > address width. If we do not check the CPU field here, we will still have to
> > > > > > check the CPU field in other places such as build_dmar_q35(), and reset the
> > > > > > s->haw_bits again.
> > > > > > 
> > > > > > Is this explanation convincing enough? :)    
> > > > > current build_dmar_q35() doesn't do it, it's all new code in this series that
> > > > > contains not acceptable direct access from one device (iommu) to another (cpu).   
> > > > > Proper way would be for the owner of iommu to fish limits from somewhere and set
> > > > > values during iommu creation.    
> > > > 
> > > > Well, current build_dmar_q35() doesn't do it, because it is using the incorrect value. :)
> > > > According to the spec, the host address width is the maximum physical address width,
> > > > yet current implementation is using the DMA address width. For me, this is not only
> > > > wrong, but also unsecure. For this point, I think we all agree this need to be fixed.
> > > > 
> > > > As to how to fix it - should we query the cpu fields, I still do not understand why
> > > > this is not acceptable. :)
> > > > 
> > > > I had thought of other approaches before, yet I did not choose:
> > > >   
> > > > 1> Introduce a new parameter, say, "x-haw-bits" which is used for iommu to limit its    
> > > > physical address width(similar to the "x-aw-bits" for IOVA). But what should we check
> > > > this parameter or not? What if this parameter is set to sth. different than the "phys-bits"
> > > > or not?
> > > >   
> > > > 2> Another choice I had thought of is, to query the physical iommu. I abandoned this    
> > > > idea because my understanding is that vIOMMU is not a passthrued device, it is emulated.  
> > >   
> > > > So Igor, may I ask why you think checking against the cpu fields so not acceptable? :)  
> > > Because accessing private fields of device from another random device is not robust
> > > and a subject to breaking in unpredictable manner when field meaning or initialization
> > > order changes. (analogy to baremetal: one does not solder wire to a CPU die to let
> > > access some piece of data from random device).
> > >   
> > 
> > With either the solution below or the one I proposed, we still
> > have a ordering problem: if we want "-cpu ...,phys-bits=..." to
> As Michael said, it's questionable if iommu should rely on guest's
> phys-bits at all,

Agreed, this is not clear.  I don't know yet if we really want to
make "-cpu" affect other devices.  Probably not.

>                   but that aside we should use proper interfaces
> and hierarchy to initialize devices, see below why I dislike
> simplistic pc_max_phys_bits().

What do you mean by proper interfaces and hierarchy?

pc_max_phys_bits() is simple, and that's supposed to be a good
thing.

> 
> > affect the IOMMU device, we will need the CPU objects to be
> > created before IOMMU realize.
> > 
> > At least both proposals make the initialization ordering
> > explicitly a responsibility of the machine code.  In either case,
> > I don't think we will start creating all CPU objects after device
> > realize any time soon.
> > 
> > 
> > > I've looked at intel-iommu code and how it's created so here is a way to do the thing
> > > you need using proper interfaces:
> > > 
> > > 1. add x-haw_bits property
> > > 2. include in your series patch
> > >     '[Qemu-devel] [PATCH] qdev: let machine hotplug handler to override  bus hotplug handler'
> > > 3. add your iommu to pc_get_hotpug_handler() to redirect plug flow to
> > >    machine and let _pre_plug handler to check and set x-haw_bits for machine level  
> > 
> > Wow, that's a very complex way to pass a single integer from
> > machine code to device code.  If this is the only way to do that,
> > we really need to take a step back and rethink our API design.
> > 
> > What's wrong with having a simple
> >   uint32_t pc_max_phys_bits(PCMachineState*)
> > function?
> As suggested, it would be only aesthetic change for accessing first_cpu from
> random device at random time. IOMMU would still access cpu instance directly
> no matter how much wrappers one would use so it's still the same hack.
> If phys_bits were changing during VM lifecycle and iommu needed to use
> updated value then using pc_max_phys_bits() might be justified as
> we don't have interfaces to handle that but that's not the case here.

I don't understand what you mean here.  Which "interfaces to
handle that" you are talking about?

> 
> I suggested a typical way (albeit a bit complex) to handle device
> initialization in cases where bus plug handler is not sufficient.
> It follows proper hierarchy without any layer violations and can fail
> gracefully even if we start creating CPUs later using only '-device cpufoo'
> without need to fix iommu code to handle that (it would fail creating
> iommu with clear error that CPU isn't available and all user have to
> do is to fix CLI to make sure that CPU is created before iommu).

What do you mean by "proper hierarchy" and "layer violations"?
What exactly is wrong with having device code talking to the
machine object?

You do have a point about "-device cpufoo": making "-cpu" affect
iommu phys-bits is probably not a good idea after all.

> 
> So I'd prefer if we used exiting pattern for device initialization
> instead of hacks whenever it is possible.

Why do you describe it as a hack?  It's just C code calling a C
function.  I don't see any problem in having device code talking
to the machine code to get a bit of information.


> 
> > 
> > > 4. you probably can use phys-bits/host-phys-bits properties to get data that you need
> > >    also see how ms->possible_cpus, that's how you can get access to CPU from machine
> > >    layer.
> > >   
> > [...]
> > 
> PS:
> Another thing I'd like to draw your attention to (since you recently looked at
> phys-bits) is about host/guest phys_bits and if it's safe from migration pov
> between hosts with different limits.
> 
> 

-- 
Eduardo
