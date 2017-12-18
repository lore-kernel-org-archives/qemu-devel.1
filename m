Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2q-00086I-01
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2l-0007vG-UO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:04 -0500
Received: from ozlabs.org ([103.22.144.67]:50031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eQq2l-0007tc-91
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:40:59 -0500
Date: Mon, 18 Dec 2017 17:14:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218061442.GW7753@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
	<20171116085709.GA5072@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hSsVBZHIO2Q9XETc"
Content-Disposition: inline
In-Reply-To: <20171116085709.GA5072@sky-dev>
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
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com


--hSsVBZHIO2Q9XETc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 04:57:09PM +0800, Liu, Yi L wrote:
> Hi David,
>=20
> On Tue, Nov 14, 2017 at 11:59:34AM +1100, David Gibson wrote:
> > On Mon, Nov 13, 2017 at 04:28:45PM +0800, Peter Xu wrote:
> > > On Mon, Nov 13, 2017 at 04:56:01PM +1100, David Gibson wrote:
> > > > On Fri, Nov 03, 2017 at 08:01:52PM +0800, Liu, Yi L wrote:
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > >=20
> > > > > AddressSpaceOps is similar to MemoryRegionOps, it's just for addr=
ess
> > > > > spaces to store arch-specific hooks.
> > > > >=20
> > > > > The first hook I would like to introduce is iommu_get(). Return an
> > > > > IOMMUObject behind the AddressSpace.
> > > > >=20
> > > > > For systems that have IOMMUs, we will create a special address
> > > > > space per device which is different from system default address
> > > > > space for it (please refer to pci_device_iommu_address_space()).
> > > > > Normally when that happens, there will be one specific IOMMU (or
> > > > > say, translation unit) stands right behind that new address space.
> > > > >=20
> > > > > This iommu_get() fetches that guy behind the address space. Here,
> > > > > the guy is defined as IOMMUObject, which includes a notifier_list
> > > > > so far, may extend in future. Along with IOMMUObject, a new iommu
> > > > > notifier mechanism is introduced. It would be used for virt-svm.
> > > > > Also IOMMUObject can further have a IOMMUObjectOps which is simil=
ar
> > > > > to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
> > > > > on MemoryRegion.
> > > > >=20
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > > >=20
> > > > Hi, sorry I didn't reply to the earlier postings of this after our
> > > > discussion in China.  I've been sick several times and very busy.
> > > >=20
> > > > I still don't feel like there's an adequate explanation of exactly
> > > > what an IOMMUObject represents.   Obviously it can represent more t=
han
> > > > a single translation window - since that's represented by the
> > > > IOMMUMR.  But what exactly do all the MRs - or whatever else - that
> > > > are represented by the IOMMUObject have in common, from a functional
> > > > point of view.
> > > >=20
> > > > Even understanding the SVM stuff better than I did, I don't really =
see
> > > > why an AddressSpace is an obvious unit to have an IOMMUObject
> > > > associated with it.
> > >=20
> > > Here's what I thought about it: IOMMUObject was planned to be the
> > > abstraction of the hardware translation unit, which is a higher level
> > > of the translated address spaces.  Say, for each PCI device, it can
> > > have its own translated address space.  However for multiple PCI
> > > devices, they can be sharing the same translation unit that handles
> > > the translation requests from different devices.  That's the case for
> > > Intel platforms.  We introduced this IOMMUObject because sometimes we
> > > want to do something with that translation unit rather than a specific
> > > device, in which we need a general IOMMU device handle.
> >=20
> > Ok, but what does "hardware translation unit" mean in practice.  The
> > guest neither knows nor cares, which bits of IOMMU translation happen
> > to be included in the same bundle of silicon.  It only cares what the
> > behaviour is.  What behavioural characteristics does a single
> > IOMMUObject have?
> >=20
> > > IIRC one issue left over during last time's discussion was that there
> > > could be more complicated IOMMU models. E.g., one device's DMA request
> > > can be translated nestedly by two or multiple IOMMUs, and current
> > > proposal cannot really handle that complicated hierachy.  I'm just
> > > thinking whether we can start from a simple model (say, we don't allow
> > > nested IOMMUs, and actually we don't even allow multiple IOMMUs so
> > > far), then we can evolve from that point in the future.
> > >=20
> > > Also, I thought there were something you mentioned that this approach
> > > is not correct for Power systems, but I can't really remember the
> > > details...  Anyways, I think this is not the only approach to solve
> > > the problem, and I believe any new better idea would be greatly
> > > welcomed as well. :)
> >=20
> > So, some of my initial comments were based on a misunderstanding of
> > what was proposed here - since discussing this with Yi at LinuxCon
> > Beijing, I have a better idea of what's going on.
> >=20
> > On POWER - or rather the "pseries" platform, which is paravirtualized.
> > We can have multiple vIOMMU windows (usually 2) for a single virtual
>=20
> On POWER, the DMA isolation is done by allocating different DMA window
> to different isolation domains? And a single isolation domain may include
> multiple dma windows? So with or withou IOMMU, there is only a single
> DMA address shared by all the devices in the system? The isolation=20
> mechanism is as what described above?

No, the multiple windows are completely unrelated to how things are
isolated.

Just like on x86, each IOMMU domain has independent IOMMU mappings.
The only difference is that IBM calls the domains "partitionable
endpoints" (PEs) and they tend to be statically created at boot time,
rather than runtime generated.

The windows are about what addresses in PCI space are translated by
the IOMMU.  If the device generates a PCI cycle, only certain
addresses will be mapped by the IOMMU to DMA - other addresses will
correspond to other devices MMIOs, MSI vectors, maybe other things.

The set of addresses translated by the IOMMU need not be contiguous.
Or, there could be two IOMMUs on the bus, each accepting different
address ranges.  These two situations are not distinguishable from the
guest's point of view.

So for a typical PAPR setup, the device can access system RAM either
via DMA in the range 0..1GiB (the "32-bit window") or in the range
2^59..2^59+<something> (the "64-bit window").  Typically the 32-bit
window has mappings dynamically created by drivers, and the 64-bit
window has all of system RAM mapped 1:1, but that's entirely up to the
OS, it can map each window however it wants.

32-bit devices (or "64 bit" devices which don't actually implement
enough the address bits) will only be able to use the 32-bit window,
of course.

MMIOs of other devices, the "magic" MSI-X addresses belonging to the
host bridge and other things exist outside those ranges.  Those are
just the ranges which are used to DMA to RAM.

Each PE (domain) can see a different version of what's in each
window.

In fact, if I understand the "IO hole" correctly, the situation on x86
isn't very different.  It has a window below the IO hole and a second
window above the IO hole.  The addresses within the IO hole go to
(32-bit) devices on the PCI bus, rather than being translated by the
IOMMU to RAM addresses.  Because the gap is smaller between the two
windows, I think we get away without really modelling this detail in
qemu though.

> > PCI host bridge.  Because of the paravirtualization, the mapping to
> > hardware is fuzzy, but for passthrough devices they will both be
> > implemented by the IOMMU built into the physical host bridge.  That
> > isn't importat to the guest, though - all operations happen at the
> > window level.
>=20
> On VT-d, with IOMMU presented, each isolation domain has its own address
> space. That's why we talked more on address space level. And iommu makes
> the difference. That's the behavioural characteristics a single iommu
> translation unit has. And thus an IOMMUObject going to have.

Right, that's the same on POWER.  But the IOMMU only translates *some*
addresses within the address space, not all of them.  The rest will go
to other PCI devices or be unmapped, but won't go to RAM.

That's why the IOMMU should really be associated with an MR (or
several MRs), not an AddressSpace, it only translates some addresses.

> > The other thing that bothers me here is the way it's attached to an
> > AddressSpace.
>=20
> My consideration is iommu handles AddressSpaces. dma address space is also
> an address space managed by iommu.

No, it's not.  It's a region (or several) within the overall PCI
address space.  Other things in the addressspace, such as other
device's BARs exist independent of the IOMMU.

It's not something that could really work with PCI-E, I think, but
with a more traditional PCI bus there's no reason you couldn't have
multiple IOMMUs listening on different regions of the PCI address
space.

> That's why we believe it is fine to
> associate dma address space with an IOMMUObject.

> >  IIUC how SVM works, the whole point is that the device
> > no longer writes into a specific PCI address space.  Instead, it
> > writes directly into a process address space.  So it seems to me more
> > that SVM should operate at the PCI level, and disassociate the device
> > from the normal PCI address space entirely, rather than hooking up
> > something via that address space.
>=20
> As Peter replied, we still need the PCI address space, it would be used
> to build up the 2nd level page table which would be used in nested
> translation.
>=20
> Thanks,
> Yi L
>=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hSsVBZHIO2Q9XETc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3XNAACgkQbDjKyiDZ
s5IlnhAA1a3rx7loQV9gJ735jJ+HZNGiuCwKKBOKauH/UqiIiIiGXEeCyPGmdrWN
xyUAzZMw4JrLMG2CloOuSByyBxNRHoYxy+dwbTu3pULtRdFLv0r3hYOmBtW/YdTB
STURUF50n/h/HLVo4FCyF3ETyQpxJ+7MHJL3q/j5NMivbIF5wt4VlsZSKpDgN3Wd
RXaTK1gHDlR9cbAPXOst7wrnkD2NTATFArQfzkS4XZ2wmgEC+H9jVlFhbsBZfWnv
Lf6bdJRAr0P8UU8x6Bt1rcV1hMi7E3DVxrIBU5JJH+YArJLn6rJ/JIjPpHp2CSLG
jDcQvNshXye5c5iDVK9eghzrEyMk4BCPETNUAp8e8exFlLPuP9Z2CqKgMv020uju
7r4uH0hvGNC+iZ6ItlFATs/PVvBaT9dqP771aisLrW4HfY04tfl8kFkRZWSuQlz4
cRWpSfmjVGG8Anh9zQFbW8w6RZTVX2hznR48/q0uwaJ09WVmwwMGkhXY17R1Tyb+
iCG56dMzfgq0Z394tzDJot7ts0uETiQhqiDgG8gN2J+GK/ZgQs57x1sKPRCORD3A
DiZArDDGc85coQ0VEGzAij526afkeU4IsJpbipjkPb0vNXzlEsOxoRX4qk5u1jVc
uibooGMnZ1GpmJB461GnmNtuk/dK9yiyWB6Q/5mAHYm+cWYuPG0=
=GVdR
-----END PGP SIGNATURE-----

--hSsVBZHIO2Q9XETc--
