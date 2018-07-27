Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fittE-0005tv-9x
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fittB-0005cA-8L
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 23:58:04 -0400
Date: Fri, 27 Jul 2018 13:56:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727035611.GG3694@umbus.fritz.box>
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <20180726133723.17041-2-clg@kaod.org>
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


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 03:37:21PM +0200, C=E9dric Le Goater wrote:
> This proposal introduces a new IRQ number space layout using static
> numbers for all devices, depending on a device index, and a bitmap
> allocator for the MSI IRQ numbers which are negotiated by the guest at
> runtime.
>=20
> As the VIO device model does not have a device index but a "reg"
> property, we introduce a formula to compute an IRQ number from a "reg"
> value. It should minimize most of the collisions.
>=20
> The previous layout is kept in pre-3.1 machines raising the
> 'legacy_irq_allocation' machine class flag.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

One nit left..

[snip]
> +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
> +{
> +    uint32_t irq;
> +
> +    if (reg >=3D SPAPR_VIO_REG_BASE) {
> +        /*
> +         * VIO device register values when allocated by QEMU. For
> +         * these, we simply mask the high bits to fit the overall
> +         * range: [0x00 - 0xff].
> +         *
> +         * The nvram VIO device (reg=3D0x71000000) is a static device of
> +         * the pseries machine and so is always allocated by QEMU. Its
> +         * IRQ number is 0x0.
> +         */
> +        irq =3D reg & 0xff;
> +
> +    } else if (reg >=3D 0x30000000) {
> +        /*
> +         * VIO tty devices register values, when allocated by livirt,
> +         * are mapped in range [0xf0 - 0xff], gives us a maximum of 16
> +         * vtys.
> +         */
> +        irq =3D 0xf0 | ((reg >> 12) & 0xf);
> +
> +    } else {
> +        /*
> +         * Other VIO devices register values, when allocated by
> +         * livirt, are mapped in range [0x00 - 0xef].
> +         */
> +        irq =3D (reg >> 12) & 0xef;

This mask doesn't do what you intend - it will map 0x10 to 0, for
example.  You could use % 0xf0, but actually you might as well just
use & 0xff.  Yes, it could collide with the vty devices, but either
way you can still have collisions if you try hard enough.  And, either
way, they'll get detected later.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltal9gACgkQbDjKyiDZ
s5LR0RAAgHdFYWg/vAJsmbyR9WnIcWIEr/BLOw1jx9dedSkCFVBfFARlR1glGAbh
uM81bs26t97HClk/HKTcIVNbI6ZAI6/dEl513xZpBLVNngPP1Q5HCfd1kx0ylfWk
ZEGwXO7SZQFAq9brfnAJP1OqSeZQjOQRDB+7fAJz3hLfNoi7tToDTmAaYY9229RZ
zHyN/2pmC7+4ljAi2+JnZ44WmaO1GWKU8RtFGTk//5zx9ioIvB5mS5TCDcgeEgTV
k7gZHek7cHUql1pASiNleEn97dG1jH9bJukvWHk/9GTeEn3qCAMIub83Tv+KsHFF
SfV5S7JOVBzzBkWs8ccR5r+ZgrgfQyZIco85jywtUfFGJVhI3xbqP+/rQiI7P/WK
U8tVCbmP1zeMoVDI1MdMA5fGa5C4kOEy8quvvmlk19CqN1W6mw1YWH66q83XD/pY
eVohCPEttp4eFH73AdBvVkLndELeYQVfZv6t0ucRm4cELyqva0kYANnmLfUUofVH
1jIk10fteUjq0OME8yxSXBeYUgeutJC/o9CIgM3eJsLR53VtzmofiILTj5Ips4TC
IllXP5JIn50jPuS8qpA9Uv2KFzNVKK4FK6SuGS8ANt+iBPA/Z/tTeSnsirPuQkIo
QL1hGXq67Mwi+oOIl64X1uzSdJSMLG8GJPPbKi6Q/jrNs5/ojx4=
=l8sr
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
