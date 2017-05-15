Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dA8dO-0004g9-1i
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dA8dM-00004r-7s
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dA8dL-0008R7-2Z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:33:28 -0400
Date: Mon, 15 May 2017 15:32:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170515053211.GB11105@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
	<20170508060744.GG25748@umbus.fritz.box>
	<20170508073217.GD2820@pxdev.xzpeter.org>
	<20170510070406.GU25748@umbus.fritz.box>
	<20170511050426.GF28293@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <20170511050426.GF28293@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 01:04:26PM +0800, Peter Xu wrote:
> On Wed, May 10, 2017 at 05:04:06PM +1000, David Gibson wrote:
> > On Mon, May 08, 2017 at 03:32:17PM +0800, Peter Xu wrote:
> > > On Mon, May 08, 2017 at 04:07:44PM +1000, David Gibson wrote:
> > > > On Mon, May 08, 2017 at 01:48:14PM +0800, Peter Xu wrote:
> > > > > On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> > > > > > On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > > > > > > This is something similar to MemoryRegionOps, it's just for a=
ddress
> > > > > > > spaces to store arch-specific hooks.
> > > > > > >=20
> > > > > > > The first hook I would like to introduce is iommu_get().
> > > > > > >=20
> > > > > > > For systems that have IOMMUs, we will create a special addres=
s space per
> > > > > > > device which is different from system default address space f=
or
> > > > > > > it (please refer to pci_device_iommu_address_space()). Normal=
ly when
> > > > > > > that happens, there will be one specific IOMMU (or say, trans=
lation
> > > > > > > unit) stands right behind that new address space.
> > > > > > >=20
> > > > > > > This iommu_get() fetches that guy behind the address space. H=
ere, the
> > > > > > > guy is defined as IOMMUObject, which is currently a (void *).=
 In the
> > > > > > > future, maybe we can make it a better definition, but imho it=
's good
> > > > > > > enough for now, considering it's arch-dependent.
> > > > > > >=20
> > > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > >=20
> > > > > > This doesn't make sense to me.  It would be entirely possible f=
or a
> > > > > > single address space to have different regions mapped by differ=
ent
> > > > > > IOMMUs.  Or some regions mapped by IOMMUs and others direct map=
ped to
> > > > > > a device or memory block.
> > > > >=20
> > > > > Oh, so it's more complicated than I thought... Then, do we really=
 have
> > > > > existing use case that one device is managed by more than one IOM=
MU
> > > > > (on any of the platform)? Frankly speaking I haven't thought about
> > > > > complicated scenarios like this, or nested IOMMUs yet.
> > > >=20
> > > > Sort of, it depends what you count as "more than one IOMMU".
> > > >=20
> > > > spapr can - depending on guest configuration - have two IOMMU windo=
ws
> > > > for each guest PCI domain.  In theory the guest can set these up
> > > > however it wants, in practice there's usually a small (~256MiB) at =
PCI
> > > > address 0 for the benefit of 32-bit PCI devices, then a much larger
> > > > window up at a high address to allow better performance for 64-bit
> > > > capable devices.
> > > >=20
> > > > Those are the same IOMMU in the sense that they're both implemented=
 by
> > > > logic built into the same virtual PCI host bridge.  However, they're
> > > > different IOMMUs in the sense that they have independent data
> > > > structures describing the mappings and are currently modelled as two
> > > > different IOMMU memory regions.
> > > >=20
> > > >=20
> > > > I don't believe we have any existing platforms with both an IOMMU a=
nd
> > > > a direct mapped window in a device's address space.  But it seems to
> > > > be just too plausible a setup to not plan for it. [1]
> > > >=20
> > > > > This patch derived from a requirement in virt-svm project (on x86=
).
> > > > > Virt-svm needs some notification mechanism for each IOMMU (or say=
, the
> > > > > IOMMU that managers the SVM-enabled device). For now, all IOMMU
> > > > > notifiers are per-memory-region not per-iommu, and that's imho not
> > > > > what virt-svm wants. Any suggestions?
> > > >=20
> > > > I don't know SVM, so I can't really make sense of that.  What format
> > > > does this identifier need?  What does "for one IOMMU" mean in this
> > > > context - i.e. what guest observable properties require the IDs to =
be
> > > > the same or to be different.
> > >=20
> > > Virt-svm should need to trap the content of a register (actually the
> > > data is in the memory, but, let's assume it's a mmio operation for
> > > simplicity, considering it is finally delivered via invalidation
> > > requests), then pass that info down to kernel. So the listened element
> > > is per-iommu not per-mr this time. When the content changed, vfio will
> > > need to be notified, then pass this info down.
> >=20
> > I don't entirely follow what you're saying.  When the virtual hardware
> > gets an invalidate request, it looks up the unit to invalidate in
> > memory?  Which component gets to decide that ID?  How is it advertised
> > to the guest OS?
> >=20
> > If your ID is tied to the AS now, you could just iterate through the
> > AS and invalidate any IOMMU MRs that are present within it.
> >=20
> > Alternatively, if the ID is tied to something more concrete, like a
> > specific PCI host bridge (which incorporates the IOMMU logic), then
> > that device probably already has a handle on the right IOMMU MR to
> > invalidate it.
>=20
> Sorry to be unclear on the requirement. I don't know what's the ID you
> mentioned above... Anyway, let me try to further simplify the use
> case.

Right, the ID was me guessing badly at what's going on here, so I
think it confused rather than clarifying.

> Just assume we have such a requirement: when one register of vIOMMU
> changes, we need to pass this register data to the hardware IOMMU by
> some way. And, let's assume this is a notification mechanism, so that
> every device in the system can listen to this register change, then
> capture what has changed to what. Here the point is, in all cases this
> event is not related to memory region at all. So imho we need some
> other way to do it besides memory region IOMMU notifiers.

Ok.  So is this right?
	* You have a single bank of vIOMMU registers
	* Which control two (or more) IOMMU regions in in the guest's
          address space
	* Assuming the host also has an AMD IOMMU, those will be
          backed by a single IOMMU on the host ("single" meaning
          controlled by a single bank of host registers)

I'm assuming the guest IOMMU code must know which IOMMU regions it is
managing, so getting from the guest registers to the set of IOMMU MRs
should be easy.

What's the operation that needs to happen on the host IOMMU, in terms
of the VFIO IOMMU interface?

Is this inherently only possible if both host and guest have an AMD
IOMMU?  Could it be made to work if the guest had an AMD IOMMU but the
host had an Intel one, or the other way around?

Would it make sense to have a single IOMMU MR in the guest, but
instead of mapping it whole into the guest address space, have two
(or more) alias MRs in the AS which each allow access to a portion of
the IOMMU MR?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGT1YAAoJEGw4ysog2bOSN14P/0ZBgMh+oH5Thmvbwf6HRdhW
nSxxbbQV1VnkQQ6eb/+pmiuJs6ByGQ6/bR1tg3pOotnl1Sc7n0upg7NNuOSQCFVx
6kDTd+4kgVxfep+Jj+pbOFm8gAboWZkI0UHoidCTue5O6VTWIxmB+ByRSuxkfcsB
KnlH8zT0yZbTnFpjgBLn0iBOuweTg9AhC3kkDoIz1WE+KWNalKxra6Kb/y3WtLWl
FwCBzMeaYJWdT77JjXMv9oac5lELOmpVrcJS4ol/TQv/OX0KU0pCg0Hs12J64RhF
WB1m3t0oh4LoYUaxEaOWm3eRv6ZMteha8kWeKlcVYidMy+QsZ8jbwGIivoUaCfIc
QSgGDOJcYY/BFx2zyGE1SF7JT/oVnRB69lQEd7sKVg+CimJWpLn/QSy8xSOGI8Zr
P248LVJYmdbTY+vKwygF9XyEPpDRXj0gA2xXSTX3fYGZeiDMExWxNAjahdouSn/n
pYdgihdxLRzG5jfyn8jtXgFddTuVOXmg9y0xh/VY4zZeIOoBhw5RSv6p6p1W9IN9
VPJMAP84RKDzR2VHsIrkBoW0q2A1XaJsq573bQ98cOgnWR3sGLMV2VWOlTpvzD4J
SAQ43W9pEhM0qY2hkg3s99R6jBhU28arT84P91hBZ/4ZrSIvSqHezOEKpWVltEqQ
hmfimBvYsHTyTVMpLoFE
=td4o
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
