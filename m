Received: from eggs.gnu.org ([2001:4830:134:3::10]:52097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk4ie-0002Ju-AS
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 05:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk4ic-0002x2-V6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 05:44:00 -0400
Date: Mon, 30 Jul 2018 19:39:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180730093911.GE2708@umbus.fritz.box>
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-2-clg@kaod.org>
	<20180727035611.GG3694@umbus.fritz.box>
	<bd62d2e5-eab6-84c5-c110-dfd93768885d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <bd62d2e5-eab6-84c5-c110-dfd93768885d@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 11:05:58AM +0200, C=E9dric Le Goater wrote:
> On 07/27/2018 05:56 AM, David Gibson wrote:
> > On Thu, Jul 26, 2018 at 03:37:21PM +0200, C=E9dric Le Goater wrote:
> >> This proposal introduces a new IRQ number space layout using static
> >> numbers for all devices, depending on a device index, and a bitmap
> >> allocator for the MSI IRQ numbers which are negotiated by the guest at
> >> runtime.
> >>
> >> As the VIO device model does not have a device index but a "reg"
> >> property, we introduce a formula to compute an IRQ number from a "reg"
> >> value. It should minimize most of the collisions.
> >>
> >> The previous layout is kept in pre-3.1 machines raising the
> >> 'legacy_irq_allocation' machine class flag.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > One nit left..
> >=20
> > [snip]
> >> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
> >> +{
> >> +    uint32_t irq;
> >> +
> >> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
> >> +        /*
> >> +         * VIO device register values when allocated by QEMU. For
> >> +         * these, we simply mask the high bits to fit the overall
> >> +         * range: [0x00 - 0xff].
> >> +         *
> >> +         * The nvram VIO device (reg=3D0x71000000) is a static device=
 of
> >> +         * the pseries machine and so is always allocated by QEMU. Its
> >> +         * IRQ number is 0x0.
> >> +         */
> >> +        irq =3D reg & 0xff;
> >> +
> >> +    } else if (reg >=3D 0x30000000) {
> >> +        /*
> >> +         * VIO tty devices register values, when allocated by livirt,
> >> +         * are mapped in range [0xf0 - 0xff], gives us a maximum of 16
> >> +         * vtys.
> >> +         */
> >> +        irq =3D 0xf0 | ((reg >> 12) & 0xf);
> >> +
> >> +    } else {
> >> +        /*
> >> +         * Other VIO devices register values, when allocated by
> >> +         * livirt, are mapped in range [0x00 - 0xef].
> >> +         */
> >> +        irq =3D (reg >> 12) & 0xef;
> >=20
> > This mask doesn't do what you intend - it will map 0x10 to 0, for
> > example.  You could use % 0xf0, but actually you might as well just
> > use & 0xff.  Yes, it could collide with the vty devices, but either
> > way you can still have collisions if you try hard enough.  And, either
> > way, they'll get detected later.
> >=20
>=20
>=20
> David,
>=20
> Shall I resend a v6 with this fix or should I wait for the patch adding=
=20
> 3.1. I could also send a 3.1 pseries machine also if you prefer.

We'll need a pseries-3.1 at some point, so if you can send that, it
would be great.  Then I can stage the lot in ppc-for-3.1.  It might
need some tweaking before final merge, but that shouldn't be too hard.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlte3L0ACgkQbDjKyiDZ
s5JGiw//ce7hW1y7D6n5Ll5nU3U0l57O8xl6qgMK+gwAM9cmAz21EltwlFD6QKlH
lOzWDntRjYqecX1ersSCf6RYKt67bYTf6PpyNeuSWfbVkNoHD3URLeq9CNufNC+h
qrrE/BbV1jARO+2jDRYV0U9GJzhGmpZhU2tk24XpH9/hMzLQg10XnTCyOzJXt7PA
SipHmnlSgo55h72CQrXzTgvxrtwKH7zbmST+91LQpjUQ6Mdk2TnVoqyFFd7rvFhT
UBqbAfAXvfbEa9Z7ZM/A/3DFCD7+qBpbbuB06QOrF2VNKJaxgo2hr24zeJnDs1OI
pMS/fOOX5dDcuxjD46OqAttvkEpDy/IO/EGUsFKElPD4mPbW741slgTRH+to53P2
/nNtyk/qTrQXUhQWcrtEbuJjlKyL6QdHCiCSq6NTqDiJlTIwrAcOaWPlrosObhdA
3f0uAxn2Xl6iizJgjoINcvVBhHo7++WUaI/qUXVcAYfnCCTOU6b08bt56/GBUP6T
yLLfLR1KSfIGk6kb8Na7oRj2v8SutWkQf2UHlW32mSC+8/e4IN+b7OYPFBuUsWhw
ccoONNk/oxeZfo8KIRPYbaM3g04ZuY3twN7qVlCbGTHPn/6i6EJeBSZQx3gs2LnT
mnxa3gTwkNqey7uOdfPzwL1JDm0A9HcNLOW++sOC2ReRkTc2tmU=
=PnQe
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
