Received: from eggs.gnu.org ([2001:4830:134:3::10]:36495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPz3k-0003LO-8r
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 19:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPz3j-0001MP-1H
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 19:38:44 -0400
Date: Tue, 5 Jun 2018 09:10:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604231033.GB5140@umbus.fritz.box>
References: <20180604172039.19427-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20180604172039.19427-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Ellerman <mpe@ellerman.id.au>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 07:20:39PM +0200, C=E9dric Le Goater wrote:
> POWER9 introduced a new variant of the eieio instruction using bit 6
> as a hint to tell the CPU it is a store-forwarding barrier.
>=20
> The usage of this eieio extension was recently added in Linux 4.17
> which activated the "support for a store forwarding barrier at kernel
> entry/exit".
>=20
> This loosen the QEMU eieio instruction mask to boot newer kernel but I
> think we should be adding a new *eieio* instruction specific to POWER9
> instead. I just don't know how to define an instruction variant with
> the same op code for an ISA version. Any idea ?

I think you're right that this should be done slightly differently.
I think you can do that by adding a new instruction mask bit; say
PPC2_MEM_EIEIO2 or whatever.  You leave the existing GEN_HANDLER as
is, add another GEN_HANDLER_E with the new mask dependent on the new
bit, then make sure POWER9 has the new bit set, but not the old one.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  target/ppc/translate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: qemu-powernv-2.13.git/target/ppc/translate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- qemu-powernv-2.13.git.orig/target/ppc/translate.c
> +++ qemu-powernv-2.13.git/target/ppc/translate.c
> @@ -6496,7 +6496,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00
>  GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>  GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
> +GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
>  GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsVxucACgkQbDjKyiDZ
s5LuXQ//bqH8Flx+qYH8uLIqxpVge2RvHk2pjyvKmYBrXQOlaZA4m9AlEzBdCARn
K2LBUhlWXtjbXJ2gnpaGxQUJt8XvmrsgZp/sul4rjHcUBUc+UeoR76WtP/EJQo/r
+r/AvnEZ/1rCbcSllwOM4IEzYlPwa5kOSmltUBnfF6RAV/EivXZ/xTGn9CrxShOC
+3CXwaAo5T9ru5Y2MgicEqPu8v6tcW5LmyjNnGs3RoGjgcw91Eqlj0MjIIk1pJfy
2GgUWg95Fw///vrRXgG3S+27h0KmHVbLVJk0wcKov2jixuBE4NU/Dx7+1fJ+7B0b
vQ/3R3U+/I7DyWjM+5/oi7YAoWHVO6yCNvdkfMt43ARUS7h8BavuxXrG2Tgn7Rjz
t2XtLxAeZDWIZY3ciF+0JdwswBqgephcgejZff0BbKeLmqMAlShy2cr5vRZTcQNn
+fPNMDyHKE+uK+IfpfEh1afFN3DP+hgVayLhU36N1mZiPh/GK5gaTOrKJWnpts6Q
rXPWW5ncD5495TuwjYrrDVrVkbdRF3MKOav5j035SEJkUyJGiUUCRHSiY2qfcHoC
CjbIK5vkx2cPVxjt9zEwSl/mRv8cAX+3EwbFqotn8LGCSsF/EvX/ghuA4VhIpNWt
aNRhyfm28GtsdW2eTViwEmTgKBcyHQUqdV7+VDPsndR2jNUZjgk=
=3zrK
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
