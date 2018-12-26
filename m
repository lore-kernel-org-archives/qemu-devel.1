Received: from eggs.gnu.org ([208.118.235.92]:48399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gc1ot-0005ns-IG
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 00:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gc1op-0001OJ-Qv
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 00:33:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:27695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gc1op-0001IH-JB
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 00:33:23 -0500
Date: Wed, 26 Dec 2018 13:30:00 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181226053000.kdakfnwhqj5ngaq5@linux.intel.com>
References: <20181219025717.6m72hq73p2haexkv@linux.intel.com>
	<20181219114037.5550a562@redhat.com>
	<20181220211801.GR19442@habkost.net>
	<20181221151325.39b64733@redhat.com>
	<20181221160944.65c5skjhkel3of7y@linux.intel.com>
	<20181221120320-mutt-send-email-mst@kernel.org>
	<20181221173758.4ohku43as4dkb355@linux.intel.com>
	<20181221140016-mutt-send-email-mst@kernel.org>
	<20181222011126.fdse6h4pl2n7yacl@linux.intel.com>
	<20181225114552-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225114552-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 25, 2018 at 11:56:19AM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 22, 2018 at 09:11:26AM +0800, Yu Zhang wrote:
> > On Fri, Dec 21, 2018 at 02:02:28PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 22, 2018 at 01:37:58AM +0800, Yu Zhang wrote:
> > > > On Fri, Dec 21, 2018 at 12:04:49PM -0500, Michael S. Tsirkin wrote:
> > > > > On Sat, Dec 22, 2018 at 12:09:44AM +0800, Yu Zhang wrote:
> > > > > > Well, my understanding of the vt-d spec is that the address limitation in
> > > > > > DMAR are referring to the same concept of CPUID.MAXPHYSADDR. I do not think
> > > > > > there's any different in the native scenario. :)
> > > > > 
> > > > > I think native machines exist on which the two values are different.
> > > > > Is that true?
> > > > 
> > > > I think the answer is not. My understanding is that HAW(host address wdith) is
> > > > the maximum physical address width a CPU can detects(by cpuid.0x80000008).
> > > > 
> > > > I agree there are some addresses the CPU does not touch, but they are still in
> > > > the physical address space, and there's only one physical address space...
> > > > 
> > > > B.R.
> > > > Yu
> > > 
> > > Ouch I thought we are talking about the virtual address size.
> > > I think I did have a box where VTD's virtual address size was
> > > smaller than CPU's.
> > > For physical one - we just need to make it as big as max supported
> > > memory right?
> > 
> > Well, my understanding of the physical one is the maximum physical address
> > width. Sorry, this explain seems nonsense... I mean, it's not just about
> > the max supported memory, but also covers MMIO. It shall be detectable
> > from cpuid, or ACPI's DMAR table, instead of calculated by the max memory
> > size. One common usage of this value is to tell the paging structure entries(
> > CPU's or IOMMU's) which bits shall be reserved. There are also some registers
> > e.g. apic base reg etc, whose contents are physical addresses, therefore also
> > need to follow the similar requirement for the reserved bits.
> > 
> > So I think the correct direction might be to define this property in the
> > machine status level, instead of the CPU level. Is this reasonable to you?
> 
> At that level yes. But isn't this already specified by "pci-hole64-end"?

But this value is set by guest firmware? Will PCI hotplug change this address?

@Eduardo, do you have any plan to calculate the phys-bits by "pci-hole64-end"?
Or introduce another property, say "max-phys-bits" in machine status?

> 
> 
> 
> > > 
> > > -- 
> > > MST
> > 
> > B.R.
> > Yu
> 

B.R.
Yu
