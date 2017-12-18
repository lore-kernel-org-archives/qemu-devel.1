Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2q-00086Y-Mo
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQq2m-0007vc-NW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:04 -0500
Received: from ozlabs.org ([103.22.144.67]:36765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eQq2k-0007te-VX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:41:00 -0500
Date: Mon, 18 Dec 2017 16:41:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218054132.GV7753@umbus.fritz.box>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113082845.GA10932@xz-mi>
	<20171114005934.GD32308@umbus.fritz.box>
	<20171114033100.GA6821@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xVUAO+xN0VJlKSe3"
Content-Disposition: inline
In-Reply-To: <20171114033100.GA6821@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, tianyu.lan@intel.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com


--xVUAO+xN0VJlKSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry I've taken so long to reply, I've been super busy with other
things.

On Tue, Nov 14, 2017 at 11:31:00AM +0800, Peter Xu wrote:
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
>=20
> In VT-d (I believe the same to ARM SMMUs), IMHO the special thing is
> that the translation windows (and device address spaces in QEMU) are
> only talking about second level translations, but not first level,
> while virt-svm needs to play with first level translations.  Until
> now, AFAIU we don't really have a good interface for first level
> translations at all (aka. the process address space).

Ok, that explains why you need some kind of different model than the
existing one, but that wasn't really disputed.  It still doesn't say
why separating the unclearly defined IOMMUObject from the IOMMU MR is
a good way of modelling this.

If the issue is 1st vs. 2nd level translation, it really seems you
should be explicitly modelling the different 1st level vs. 2nd level
address spaces, rather than just splitting functions between the MR
and AS level with no clear rationale behind what goes where.

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
> > PCI host bridge.  Because of the paravirtualization, the mapping to
> > hardware is fuzzy, but for passthrough devices they will both be
> > implemented by the IOMMU built into the physical host bridge.  That
> > isn't importat to the guest, though - all operations happen at the
> > window level.
>=20
> Now I know that for Power it may not have anything like a "translation
> unit" but everything is defined as "translation windows" in the
> guests.  However the problem still exist for some other platforms.
> Say, for Intel we have emulated VT-d; for ARM, we have vSMMU.  AFAIU
> these platforms do have their translation units, and even for ARM it
> should need such an interface (or any better interfaces, which are
> always welcomed) for virt-svm to work.  Otherwise I don't know a way
> to configure the first level translation tables.
>=20
> Meanwhile, IMO this abstraction should not really affect pseries - it
> should be only useful for those platforms who would like to use it.
> For pseries, we can just ignore that new interface if we don't really
> even have such a translation unit.

But it's _still_ not clear to me what a "translation unit" means.
What is common across a translation unit that is not common across
different translation units?

>=20
> >=20
> > The other thing that bothers me here is the way it's attached to an
> > AddressSpace.  IIUC how SVM works, the whole point is that the device
> > no longer writes into a specific PCI address space.  Instead, it
> > writes directly into a process address space.  So it seems to me more
> > that SVM should operate at the PCI level, and disassociate the device
> > from the normal PCI address space entirely, rather than hooking up
> > something via that address space.
>=20
> IMO the PCI address space is still used.  For virt-svm, host IOMMU
> will be working in nested translation mode, so we should be having two
> mappings working in parallel:
>=20
>   1. DPDK process (in guest) address space mapping (GVA -> GPA)
>   2. guest direct memory mappings (GPA -> HPA)
>=20
> And here AFAIU the 2nd mapping is working exactly like general PCI
> devices, the only difference is that the 2nd level mapping is always
> static, just like when IOMMU passthrough is enabled for that device.

Ok.  IIUC the 2nd level mapping isn't visible to the guest, is that
right?

But this doesn't really affect my point - from the guest's point of
view, the "usual" address space for a PCI device is equal to the GPA
(i.e. no guest visible translation), but for SVM devices they instead
use an SVM address space depending on the process id, which is not the
same as the GPA space.

> So, IMHO virt-SVM is not really in parallel with PCI subsystem.

Well, it's not clear to me if it's in parallel to, or on top of.  But
the crucial point is that an SVM device does not access the "main" PCI
address space (whether or not that has a traditional IOMMU).  Instead
it has access to a bunch of different address spaces, one for each
process ID.

> For
> the SVM in guest, it may be different, since it should only be using
> first level translations.  However to implement virt-SVM, IMHO we not
> only need existing PCI address space translation logic, we also need
> an extra way to configure the first level mappings, as discussed.

Right.  I'm not disputing that a way to configure those first level
mappings is necessary.  The proposed model just doesn't seem a good
fit.  It still only represents a single "PCI address space", then
attaches things about the process table mapping to that, when in fact
they affect the process table and therefore *different* address spaces
=66rom that which the methods are attached to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xVUAO+xN0VJlKSe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3VQoACgkQbDjKyiDZ
s5IgqhAAn/EgJer90QZq8XG2qGsTlqw9E2YtGDTOh2hfz+1i2apMkS5AUTahlmwP
rDMnzyX9kYAT4dViYGf59e0ezB6nnFHj1m/01t5Urh1IXbC/fOONMfW0SLtSyK0X
LQZ9zWBGItC+0DDpTYJhCaJGxDRq5YCRsAtzdBt8hzVaAlMZnAsCfqPYwUOEnb5V
zpArdTJ6zLP/EmzCdh44uhcWfl+2ovnwa+bhgOUXggCAC5WHWz5dki7NvAwkZU5I
Yh3vZAIdze6TwpB8ZgDsIepWb4MM6892OnoCbG7z76c6AS2JdoZv0KwwXN7z2shi
YZgt8CNUXLIHes2saoGuszUgMK29sejCmM86GcHiZ2DDJcKG4vAV4OSjusyu5pPh
ve67mfUkZ6wd1DQZct5MuS9eVAe3uBNuFtKROBBVcBrkQWyogixZABB7cauYXSJ5
kukSk2Dpe40yKSbIntcsAwoRQIlzJG+C4EzEoRmjESbR94ZoFFYNMvix56Tb/ZW/
PXEsSLyEg+pQNIkeKg8EOnRPKv1RLemEA2nkR56608UIAXEGD7dlTp14t8/HnnSF
pb4sHo6hDQlS+Muieg6y9mM+73m/gHAjw71rZPezEYkPecJJTjRfiZqnn+zCnLYz
x9bhFJAbdbW7NxBVQhhaKEWSE3xLsyKS0iBpOBs6H1RPmKTXP9Q=
=CuQX
-----END PGP SIGNATURE-----

--xVUAO+xN0VJlKSe3--
