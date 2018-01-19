Received: from eggs.gnu.org ([2001:4830:134:3::10]:42662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecPm0-0001Hw-U8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecPlx-0003qi-0Y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:03:32 -0500
Date: Fri, 19 Jan 2018 17:03:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119060317.GB28299@umbus.fritz.box>
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
	<ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
	<20171219070919.42d90b94@w520.home>
	<87e241ad-4d65-1b51-aa22-a84f18de1cb6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <87e241ad-4d65-1b51-aa22-a84f18de1cb6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: spapr/iommu: Enable in-kernel
 TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 03:59:59PM +0100, Paolo Bonzini wrote:
> On 19/12/2017 15:09, Alex Williamson wrote:
> > On Tue, 19 Dec 2017 12:12:35 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >=20
> >> On 12/12/2017 06:46, Alex Williamson wrote:
> >>>> +enum IOMMUMemoryRegionAttr {
> >>>> +    IOMMU_ATTR_KVM_FD =20
> >>>
> >>> You're generalizing the wrong thing here, this is specifically a
> >>> SPAPR_TCE_FD, call it that. =20
> >>
> >> ... and you're not even implementing set_attr, so let's drop it.
> >>
> >> My suggestion is to add a function in hw/vfio:
> >>
> >>     int vfio_container_attach_kvm_spapr_tce(VFIOContainer *cont,
> >>                                             int tablefd);
> >>
> >> and an IOMMUMemoryRegionClass member:
> >>
> >>     int (*set_vfio_container_attrs)(IOMMUMemoryRegion *iommu,
> >>                                     VFIOContainer *cont)
> >>
> >> Then your implementation for the latter is as simple as this:
> >>
> >>     if (!kvm_enabled() || !kvmppc_has_cap_spapr_vfio()) {
> >>         sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iom=
mu);
> >>         return vfio_container_attach_kvm_spapr_tce(cont, tcet->fd);
> >>     }
> >=20
> > Ugh, exactly the sort of interface I've been trying to avoid, vfio
> > specific callbacks on common data structures handing out vfio private
> > data pointers,
>=20
> True, VFIOContainer* is private, but in those declarations it's also opaq=
ue.
>=20
> The VFIO container is the representation of the IOMMU, so it makes sense
> to me to have a function to set it up according to QEMU's IOMMU object.
> I don't think we will be introducing another object soon that is similar
> to the VFIO container.
>=20
> > requiring additional exported functions from vfio for
> > each new user of it.  Why is this better?
>=20
> I understand that you don't like having many exported functions, but you
> are just pushing the problem on the memory.h side where you'd get many
> attribute enums.

It's more than just enums, doing it the other way around is putting
fairly intimate knowledge of a specific guest IOMMU workings into the
VFIO code.

Fundamentally this *requires* linking vfio knowledge to guest iommu
(kvm) knowledge, so some cross linkage we'd usually want to avoid is
inevitable.  I don't see that there's a strong argument for whether we
put the bit of vfio knowledge into the spapr viommu or the bit of
spapr viommu knowledge into vfio.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphiiIACgkQbDjKyiDZ
s5IBxw/9GYNrWHohQi0xpTTSab+t+WrmDo0jI4mQ9GIBZ0wgsh3vS4RUP9zUqvfw
yaRhIEbQ0tUdiiAqMMrcA0zWA64U88FVxY2lvB7als8nkhKbqwtaicEioQrPTxW5
F+z23bi/Pfx6Rh0MNbPRCwVga3fmTIruR+ku7dwUvoUsLaZe0/GojW3cRMizrZF7
edz8t2WZ+JdhX2+QpMkFifE6LzwvUMoEFzPH2DRjU8rOEVWPqTIkFZQv0FLqSOXH
V4sFhHR0HDsLdDHKxq6oy2sddiDggVqV2oQL9KyINcGqzJYjv5q5iyztlV5JGYvt
rxmwR8UwjqAjqcYheysasA92MjSWtR5De7EAsVxN4j+eGgQXkYVAirlWYda1XkYm
R3Iqb8mKLFmo+N1juEogw38R8TDAoBqoiqeYgNezK/IQaJJxnGHpxYnUN1lSL2fT
Scq4vu35XB9ssCnKGJk9ywMgC8DQHX8HLL6J9uxtzypfEaX96fm7AIOe5qyJL0/S
HOghyiiTxSu7tWsO3nhvoAdpsgN2cJrvCJj8gIbAF55I/rBMAtide86RVjUo8iCT
uLXB5qqYhl9xhvbzW+xu8wGV/a1TepABdmHidssI8nBtKjaWqbnpnTOKaS68Ehf5
eOI4U0B7prFtGmbF+t3F36aPGWKlC8xEnNvLokP+lfJw6lDOKHM=
=EHTf
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
