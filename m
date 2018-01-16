Received: from eggs.gnu.org ([2001:4830:134:3::10]:38171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebKOO-0005ov-W0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebKON-000808-HI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:06:40 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ebKOM-0007yp-St
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:06:39 -0500
Date: Tue, 16 Jan 2018 17:04:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116060425.GH30352@umbus.fritz.box>
References: <20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
	<20171115071632.GF6821@xz-mi>
	<20171218113531.GC4786@umbus.fritz.box>
	<20171220064730.GB7070@sky-dev>
	<20171220111816.GG5981@umbus.fritz.box>
	<20180112102534.GA25168@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <20180112102534.GA25168@sky-dev>
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>, alex.williamson@redhat.com, pbonzini@redhat.com


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 06:25:34PM +0800, Liu, Yi L wrote:
> On Wed, Dec 20, 2017 at 10:18:16PM +1100, David Gibson wrote:
> > On Wed, Dec 20, 2017 at 02:47:30PM +0800, Liu, Yi L wrote:
> > > On Mon, Dec 18, 2017 at 10:35:31PM +1100, David Gibson wrote:
> > > > On Wed, Nov 15, 2017 at 03:16:32PM +0800, Peter Xu wrote:
> > > > > On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:
> > > > >=20
>=20
> [...]
>=20
> Sorry for the delayed reply, spent some time on reconsidering your commen=
ts.
>=20
> >=20
> > I'm ok with calling it a "PASID context".
> >=20
> > Thinking about this some more, here are some extra observations:
> >=20
> >  * I think each device needs both a PASID context and an ordinary
> >    address space.  The PASID context would be used for bus
> >    transactions which include a process id, the address space for
> >    those that don't.
> >=20
> >  * Theoretically, the PASID context could be modelled as an array/map
> >    of AddressSpace objects for each process ID.  However, creating all
> >    those AddressSpace objects in advance might be too expensive.  I
> >    can see a couple of options to avoid this:
> >=20
> > 1) Have the PASID context class include a 'translate' method similar
> > to the one in IOMMUMemoryRegionClass, but taking a process ID as well
> > as an address.  This would avoid creating extra AddressSpace objects,
> > but might require duplicating a bunch of the translation code that
> > already exists for AddressSpace.
> >=20
> > 2) "Lazily" create AddressSpace objects.  The generic part of the
> > PASID aware DMA helper functions would use a cache of AddressSpace's
> > for particular process IDs, using the AddressSpace (and MemoryRegion
> > within) to translate accesses for a particular process ID.  However,
> > these AddressSpace and MemoryRegion objects would only be created when
> > the device first accesses that address space.  In the common case,
> > where a single device is just being used by a single process or a
> > small number, this should keep the number of AddressSpace objects
> > relatively small.  Obviously the cache would need to be invalidated,
> > cleaning up the AddressSpace objects, when the PASID table is altered.
>=20
> Sorry, a double check here. Does "AddressSpace objects" mean the existing
> AddressSpace definition in Qemu?

Yes.

> >  * I realize that the expected case here is with KVM, where the guest
> >    controls the first level translation, but the host controls the
> >    second level translation.  However, we should also be able to model
> >    the case where the guest controls both levels for the sake of full
> >    system emulation.  I think understanding this case will lead to a
> >    better design even for the simpler case.
> >=20
> > Do you have a plan for what the virt-SVM aware DMA functions will look
> > like?
>=20
> The behaviour is device specific.
> For a SVM capable physcial device, it would store the pasid value in a
> register locates in the deivce. e.g. a GPU context can be set to use SVM,
> after the pasid is set, any DMA from this context is DMAs target to a
> process virtual address space.

That doesn't sound any more device specific than any DMA operation,
and we have helpers for that.

> So for a virt-SVM aware DMA device, the device model needs to figure out
> the target address space. With the correct address space, then consume
> the translate() callback provided by iommu emulator. And then emulate the
> DMA operation for the emulated device.

Nearly all of that sounds like something that belongs in a helper
function.  Basically a varaint of dma_memory_rw() (and related
functions) that takes a PASID as well as an address.

> I'll try to get a new version with your suggestions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdlekACgkQbDjKyiDZ
s5KsXQ//SHXg1MgulqPvP8+s9pElrbMEVyY0fAsLzC5bjW7bRYM1O+q3dQNRbBOR
MWaYg/X4wU6k0WavVqaX7EcBwbxB2wcrkcmHuJS2zOs0WTsDnv+oM2ICkK33QI5J
NjW4hIx16iMnymGsMZLLT33/J3BZ9gQirPlj0PQg1ra2ImZhHgE5gvhTWbvOPs+A
DZ8/lH3HP6Da9Hr0L/IVLJ5KArzg1mFNyYG7ONeQFUHZeKAbti9SpHTMqsJfdx+v
hazFNpovn/K34iZ0BbT86nJH/zxHLdqzLD2eEdk53TsMAndkYGivQWSOMxlhRWf4
0KbBqNAC4kNYCzzD+NgiUDzFbURxFtqykDGBS6ZfMBH2FGOOmrvTEnx2LTu8ccyZ
tsSsqPJD/Mw+WyAB0tr84rjibW0cA4WOQFqZR9lOb8jMDQ3bJP3x4wjE8GWZE4pW
6FREDJWoUt7mQ3VQ6iwRLU6+pDyqLQ57QNCvuSk1r60zQeO07nhl8/EnHMGWCVTy
tPOP+LFXiF4h4IC8knDMXRCaoKK1IbvD3ngU/wAlN8Y9PCJ/1izuXLmseQHF/nA6
qx4V1FsqknI/wJn7dxkeWuWbJdVQWa2jCpnJtDiODpL/D2DoPqe3Yp50+MVzOUKh
DpvLC5y+NrsJrOYIR4NUuXC6jt6GMKz0ftCqxQvWEUMUiH+NdpY=
=/tm8
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
