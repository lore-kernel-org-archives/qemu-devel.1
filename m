Received: from eggs.gnu.org ([2001:4830:134:3::10]:47650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLs3-0004Zd-7j
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLrz-0001Qy-9h
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:19 -0400
Date: Wed, 23 Aug 2017 12:40:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823024029.GN5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
	<1f2ce36c-928b-0631-fdb0-0f413a7a5cb5@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Content-Disposition: inline
In-Reply-To: <1f2ce36c-928b-0631-fdb0-0f413a7a5cb5@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 06:58:52PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Zoltan,
>=20
> On 08/20/2017 02:23 PM, BALATON Zoltan wrote:
> > These registers are present in 440 SoCs (and maybe in others too) and
> > U-Boot accesses them when printing register info. We don't emulate
> > these but add them to avoid crashing when they are read or written.
>=20
> Your code isn't incorrect but it doesn't sound the right way to fix your
> problem. Your firmware shouldn't *crash* on unimplemented dcr.
>=20
> Looking at ppc_dcr_read() I see that *valp isn't updated on unimp dcrn,
> while the dcr_read_plb() callback you are using return 0 on unimp (with an
> "avoid gcc warning" misleading comment).

Hrm.. I thought accessing a bad DCR led to a 0x700 exception rather
than just returning a dummy value.

>=20
> What is the hardware behavior on implemented dcr? return 0? In that case
> this should be used in ppc_dcr_read(), also adding some
> qemu_log_mask(LOG_UNIMP,...) log entry there.
>=20
> Regards,
>=20
> Phil.
>=20
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> >   hw/ppc/ppc405_uc.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> > index e621d0a..8e58065 100644
> > --- a/hw/ppc/ppc405_uc.c
> > +++ b/hw/ppc/ppc405_uc.c
> > @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, =
ppc4xx_bd_info_t *bd,
> >   /********************************************************************=
*********/
> >   /* Peripheral local bus arbitrer */
> >   enum {
> > -    PLB0_BESR =3D 0x084,
> > -    PLB0_BEAR =3D 0x086,
> > -    PLB0_ACR  =3D 0x087,
> > +    PLB3A0_ACR =3D 0x077,
> > +    PLB4A0_ACR =3D 0x081,
> > +    PLB0_BESR  =3D 0x084,
> > +    PLB0_BEAR  =3D 0x086,
> > +    PLB0_ACR   =3D 0x087,
> > +    PLB4A1_ACR =3D 0x089,
> >   };
> >   typedef struct ppc4xx_plb_t ppc4xx_plb_t;
> > @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
> >       ppc4xx_plb_t *plb;
> >       plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
> > +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> > +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> >       ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_pl=
b);
> >       ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> >       ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> > +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> >       qemu_register_reset(ppc4xx_plb_reset, plb);
> >   }
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc6xwACgkQbDjKyiDZ
s5LroRAAiQB/7LHEDy8feOPE5D46H5FL5kLxP8KNuyungGh1RhRzqJHrEOQSfiYl
O09byki5SDOAptlFPLeC7FM5PIRI0/mu+KMAO5vwESWA7/wR6x8Z7ugaMt84JVJQ
R1eNBC8doBFACAiUESpmeGLEXbcWRezzNoK9zUq1FxrXwHV1NrqzErEe0oYLSAxY
0lQEX4wWew5OcyNKmrpnUsRW9f+1Ki6DwJIkv2itByOz4Uv5vX2p9lEiUrM3VAvj
r7V1WYNHFNZ79aUfgMQwe+MmWhR1g3XDMKIr84XYWbRv1pm/hYTK8bGIXtt48RLP
XSLZNaTYIyI/aBYIg1vYjaXGRF+GcQjxvJyscdBFMfYEp5/qXcz8cewjPG1MeCJF
rcH06MHzcaYC8i3mEwHNau19OsJunPb5vCeyfna0kkZQ0kYHaMjrohf+upL4IJLu
ivsrQp6+iazc3K+JMPtxORxRwMCp4mBvk6NQTckOSQtiossLAaoX/lGPPSl9SvgU
IG76IYVzY8jy4GwEvx7d83jNC5uH/TGH9diNry+YCo1u1yAOjt5p4HKlJ0E9kFRi
WRdDXGD/+NOblc68slRpGMUGVTrUKpDQ3gKYzMo1XrAnvAaQ4CXMQdYp/S3KKpQu
0RlHGvCokuXNMpI4EYgjMWI0Y0HVim2qUGonClpLHvAl9rUNJYI=
=UUT7
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
