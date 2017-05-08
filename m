Received: from eggs.gnu.org ([2001:4830:134:3::10]:35353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7d9k-000259-M2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7d9g-0004Y0-CY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:32:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7d9g-0004XS-00
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:32:28 -0400
Date: Mon, 8 May 2017 15:32:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170508073217.GD2820@pxdev.xzpeter.org>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
	<20170508060744.GG25748@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508060744.GG25748@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Mon, May 08, 2017 at 04:07:44PM +1000, David Gibson wrote:
> On Mon, May 08, 2017 at 01:48:14PM +0800, Peter Xu wrote:
> > On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> > > On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > > > This is something similar to MemoryRegionOps, it's just for address
> > > > spaces to store arch-specific hooks.
> > > > 
> > > > The first hook I would like to introduce is iommu_get().
> > > > 
> > > > For systems that have IOMMUs, we will create a special address space per
> > > > device which is different from system default address space for
> > > > it (please refer to pci_device_iommu_address_space()). Normally when
> > > > that happens, there will be one specific IOMMU (or say, translation
> > > > unit) stands right behind that new address space.
> > > > 
> > > > This iommu_get() fetches that guy behind the address space. Here, the
> > > > guy is defined as IOMMUObject, which is currently a (void *). In the
> > > > future, maybe we can make it a better definition, but imho it's good
> > > > enough for now, considering it's arch-dependent.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > This doesn't make sense to me.  It would be entirely possible for a
> > > single address space to have different regions mapped by different
> > > IOMMUs.  Or some regions mapped by IOMMUs and others direct mapped to
> > > a device or memory block.
> > 
> > Oh, so it's more complicated than I thought... Then, do we really have
> > existing use case that one device is managed by more than one IOMMU
> > (on any of the platform)? Frankly speaking I haven't thought about
> > complicated scenarios like this, or nested IOMMUs yet.
> 
> Sort of, it depends what you count as "more than one IOMMU".
> 
> spapr can - depending on guest configuration - have two IOMMU windows
> for each guest PCI domain.  In theory the guest can set these up
> however it wants, in practice there's usually a small (~256MiB) at PCI
> address 0 for the benefit of 32-bit PCI devices, then a much larger
> window up at a high address to allow better performance for 64-bit
> capable devices.
> 
> Those are the same IOMMU in the sense that they're both implemented by
> logic built into the same virtual PCI host bridge.  However, they're
> different IOMMUs in the sense that they have independent data
> structures describing the mappings and are currently modelled as two
> different IOMMU memory regions.
> 
> 
> I don't believe we have any existing platforms with both an IOMMU and
> a direct mapped window in a device's address space.  But it seems to
> be just too plausible a setup to not plan for it. [1]
> 
> > This patch derived from a requirement in virt-svm project (on x86).
> > Virt-svm needs some notification mechanism for each IOMMU (or say, the
> > IOMMU that managers the SVM-enabled device). For now, all IOMMU
> > notifiers are per-memory-region not per-iommu, and that's imho not
> > what virt-svm wants. Any suggestions?
> 
> I don't know SVM, so I can't really make sense of that.  What format
> does this identifier need?  What does "for one IOMMU" mean in this
> context - i.e. what guest observable properties require the IDs to be
> the same or to be different.

Virt-svm should need to trap the content of a register (actually the
data is in the memory, but, let's assume it's a mmio operation for
simplicity, considering it is finally delivered via invalidation
requests), then pass that info down to kernel. So the listened element
is per-iommu not per-mr this time. When the content changed, vfio will
need to be notified, then pass this info down.

Yi/others, please feel free to correct me.

Thanks,

> 
> 
> [1] My reasoning here is similar to the reason sPAPR allows the two
> windows.  For PAPR, the guest is paravirtualized, so both windows
> essentially have to be remapped IOMMU windows.  For a bare metal
> platform it seems a very reasonable tradeoff would be to have a
> small(ish) 32-bit IOMMU window to allow 32-bit devices to work on a
> large RAM machine, along with a large direct mapped "bypass" window
> for maxmimum performance for 64-bit devices.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

-- 
Peter Xu
