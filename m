Received: from eggs.gnu.org ([208.118.235.92]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gd3Y1-0008AH-JO
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 20:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gd3Rn-0001fI-Kv
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 20:29:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gd3Rm-0001dC-07
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 20:29:50 -0500
Date: Fri, 28 Dec 2018 23:29:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181229012941.GC6817@habkost.net>
References: <20181221151325.39b64733@redhat.com>
	<20181221160944.65c5skjhkel3of7y@linux.intel.com>
	<20181221120320-mutt-send-email-mst@kernel.org>
	<20181221173758.4ohku43as4dkb355@linux.intel.com>
	<20181221140016-mutt-send-email-mst@kernel.org>
	<20181222011126.fdse6h4pl2n7yacl@linux.intel.com>
	<20181225114552-mutt-send-email-mst@kernel.org>
	<20181226053000.kdakfnwhqj5ngaq5@linux.intel.com>
	<20181227151411.GZ19442@habkost.net>
	<20181228023259.cdzcpbe32dquyrpa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228023259.cdzcpbe32dquyrpa@linux.intel.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Dec 28, 2018 at 10:32:59AM +0800, Yu Zhang wrote:
> On Thu, Dec 27, 2018 at 01:14:11PM -0200, Eduardo Habkost wrote:
> > On Wed, Dec 26, 2018 at 01:30:00PM +0800, Yu Zhang wrote:
> > > On Tue, Dec 25, 2018 at 11:56:19AM -0500, Michael S. Tsirkin wrote:
> > > > On Sat, Dec 22, 2018 at 09:11:26AM +0800, Yu Zhang wrote:
> > > > > On Fri, Dec 21, 2018 at 02:02:28PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Sat, Dec 22, 2018 at 01:37:58AM +0800, Yu Zhang wrote:
> > > > > > > On Fri, Dec 21, 2018 at 12:04:49PM -0500, Michael S. Tsirkin wrote:
> > > > > > > > On Sat, Dec 22, 2018 at 12:09:44AM +0800, Yu Zhang wrote:
> > > > > > > > > Well, my understanding of the vt-d spec is that the address limitation in
> > > > > > > > > DMAR are referring to the same concept of CPUID.MAXPHYSADDR. I do not think
> > > > > > > > > there's any different in the native scenario. :)
> > > > > > > > 
> > > > > > > > I think native machines exist on which the two values are different.
> > > > > > > > Is that true?
> > > > > > > 
> > > > > > > I think the answer is not. My understanding is that HAW(host address wdith) is
> > > > > > > the maximum physical address width a CPU can detects(by cpuid.0x80000008).
> > > > > > > 
> > > > > > > I agree there are some addresses the CPU does not touch, but they are still in
> > > > > > > the physical address space, and there's only one physical address space...
> > > > > > > 
> > > > > > > B.R.
> > > > > > > Yu
> > > > > > 
> > > > > > Ouch I thought we are talking about the virtual address size.
> > > > > > I think I did have a box where VTD's virtual address size was
> > > > > > smaller than CPU's.
> > > > > > For physical one - we just need to make it as big as max supported
> > > > > > memory right?
> > > > > 
> > > > > Well, my understanding of the physical one is the maximum physical address
> > > > > width. Sorry, this explain seems nonsense... I mean, it's not just about
> > > > > the max supported memory, but also covers MMIO. It shall be detectable
> > > > > from cpuid, or ACPI's DMAR table, instead of calculated by the max memory
> > > > > size. One common usage of this value is to tell the paging structure entries(
> > > > > CPU's or IOMMU's) which bits shall be reserved. There are also some registers
> > > > > e.g. apic base reg etc, whose contents are physical addresses, therefore also
> > > > > need to follow the similar requirement for the reserved bits.
> > > > > 
> > > > > So I think the correct direction might be to define this property in the
> > > > > machine status level, instead of the CPU level. Is this reasonable to you?
> > > > 
> > > > At that level yes. But isn't this already specified by "pci-hole64-end"?
> > > 
> > > But this value is set by guest firmware? Will PCI hotplug change this address?
> > > 
> > > @Eduardo, do you have any plan to calculate the phys-bits by "pci-hole64-end"?
> > > Or introduce another property, say "max-phys-bits" in machine status?
> > 
> > I agree it may make sense to make the machine code control
> > phys-bits instead of the CPU object.  A machine property sounds
> > like the simplest solution.
> > 
> > But I don't think we can have a meaningful discussion about
> > implementation if we don't agree about the command-line
> > interface.  We must decide what will happen to the CPU and iommu
> > physical address width in cases like:
> 
> Thanks, Eduardo.
> 
> What about we just use "-machine phys-bits=52", and remove the
> "phys-bits" from CPU parameter?

Maybe we can deprecate it, but we can't remove it immediately.
We still need to decide what to do on the cases below, while the
option is still available.

> 
> > 
> >   $QEMU -device intel-iommu
> >   $QEMU -cpu ...,phys-bits=50 -device intel-iommu
> >   $QEMU -cpu ...,host-phys-bits=on -device intel-iommu
> >   $QEMU -machine phys-bits=50 -device intel-iommu
> >   $QEMU -machine phys-bits=50 -cpu ...,phys-bits=48 -device intel-iommu
> > 
> > -- 
> > Eduardo
> > 
> 
> B.R.
> Yu

-- 
Eduardo
