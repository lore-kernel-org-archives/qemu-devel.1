Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eZwmn-0007QE-T3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eZwmj-0002Tz-0Y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:42:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:60847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eZwmi-0002Rn-NX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:42:04 -0500
Date: Fri, 12 Jan 2018 18:25:34 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180112102534.GA25168@sky-dev>
References: <1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
	<20171220064730.GB7070@sky-dev>
	<20171220111816.GG5981@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220111816.GG5981@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>, alex.williamson@redhat.com, pbonzini@redhat.com

On Wed, Dec 20, 2017 at 10:18:16PM +1100, David Gibson wrote:
> On Wed, Dec 20, 2017 at 02:47:30PM +0800, Liu, Yi L wrote:
> > On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> > > On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > > > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > > > 

[...]

Sorry for the delayed reply, spent some time on reconsidering your comments.

> 
> I'm ok with calling it a "PASID context".
> 
> Thinking about this some more, here are some extra observations:
> 
>  * I think each device needs both a PASID context and an ordinary
>    address space.  The PASID context would be used for bus
>    transactions which include a process id, the address space for
>    those that don't.
> 
>  * Theoretically, the PASID context could be modelled as an array/map
>    of AddressSpace objects for each process ID.  However, creating all
>    those AddressSpace objects in advance might be too expensive.  I
>    can see a couple of options to avoid this:
> 
> 1) Have the PASID context class include a 'translate' method similar
> to the one in IOMMUMemoryRegionClass, but taking a process ID as well
> as an address.  This would avoid creating extra AddressSpace objects,
> but might require duplicating a bunch of the translation code that
> already exists for AddressSpace.
> 
> 2) "Lazily" create AddressSpace objects.  The generic part of the
> PASID aware DMA helper functions would use a cache of AddressSpace's
> for particular process IDs, using the AddressSpace (and MemoryRegion
> within) to translate accesses for a particular process ID.  However,
> these AddressSpace and MemoryRegion objects would only be created when
> the device first accesses that address space.  In the common case,
> where a single device is just being used by a single process or a
> small number, this should keep the number of AddressSpace objects
> relatively small.  Obviously the cache would need to be invalidated,
> cleaning up the AddressSpace objects, when the PASID table is altered.

Sorry, a double check here. Does "AddressSpace objects" mean the existing
AddressSpace definition in Qemu?

> 
>  * I realize that the expected case here is with KVM, where the guest
>    controls the first level translation, but the host controls the
>    second level translation.  However, we should also be able to model
>    the case where the guest controls both levels for the sake of full
>    system emulation.  I think understanding this case will lead to a
>    better design even for the simpler case.
> 
> Do you have a plan for what the virt-SVM aware DMA functions will look
> like?

The behaviour is device specific.
For a SVM capable physcial device, it would store the pasid value in a
register locates in the deivce. e.g. a GPU context can be set to use SVM,
after the pasid is set, any DMA from this context is DMAs target to a
process virtual address space.

So for a virt-SVM aware DMA device, the device model needs to figure out
the target address space. With the correct address space, then consume
the translate() callback provided by iommu emulator. And then emulate the
DMA operation for the emulated device.

I'll try to get a new version with your suggestions.

Thanks,
Yi L
