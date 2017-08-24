Received: from eggs.gnu.org ([2001:4830:134:3::10]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIU-0006Dz-RM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIR-0005If-No
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:06 -0400
Date: Thu, 24 Aug 2017 12:35:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824023552.GY5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
	<20170823023945.GM5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231108430.76247@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m8yuz6kcWj4yJ5vq"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708231108430.76247@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--m8yuz6kcWj4yJ5vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 12:16:24PM +0200, BALATON Zoltan wrote:
> On Wed, 23 Aug 2017, David Gibson wrote:
> > On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > > These registers are present in 440 SoCs (and maybe in others too) and
> > > U-Boot accesses them when printing register info. We don't emulate
> > > these but add them to avoid crashing when they are read or written.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > I'm ok with stub implementation, but I'm a bit uncomfortable with
> > registering these DCRs unconditionally rather than just on the chips
> > that actually implement them.
>=20
> Problem is that I don't know which chips have these. I can only try to fi=
nd
> out from the U-Boot sources where a comment says these are common registe=
rs
> for all SoCs (in u-boot/arch/powerpc/include/asm/ppc4xx.h:
>=20
> http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Darch/powerpc/include/asm/=
ppc4xx.h;h=3D45ff5dbacd9243e83bb2f6551e2dd64a7e544bf5;hb=3De2351d5cf1e97408=
b4c52bafeaa85e0ca85c920c
>=20
> while looking for this I've just noticed that u-boot has removed ppc440
> support just before 2017.07-rc3 so this is the last version that still has
> these files). So if that's true it should be OK for 405 too.

Ok, just to make sure I'm understanding correctly are you saying:

1) You suspect these registers were actually on all versions of the
   device, they just weren't implemented until now.

or

2) The registers are definitely on only some versions of the device,
   but you're not sure which ones

>=20
> > > ---
> > >  hw/ppc/ppc405_uc.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> > > index e621d0a..8e58065 100644
> > > --- a/hw/ppc/ppc405_uc.c
> > > +++ b/hw/ppc/ppc405_uc.c
> > > @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env=
, ppc4xx_bd_info_t *bd,
> > >  /*******************************************************************=
**********/
> > >  /* Peripheral local bus arbitrer */
> > >  enum {
> > > -    PLB0_BESR =3D 0x084,
> > > -    PLB0_BEAR =3D 0x086,
> > > -    PLB0_ACR  =3D 0x087,
> > > +    PLB3A0_ACR =3D 0x077,
> > > +    PLB4A0_ACR =3D 0x081,
> > > +    PLB0_BESR  =3D 0x084,
> > > +    PLB0_BEAR  =3D 0x086,
> > > +    PLB0_ACR   =3D 0x087,
> > > +    PLB4A1_ACR =3D 0x089,
> > >  };
> > >=20
> > >  typedef struct ppc4xx_plb_t ppc4xx_plb_t;
> > > @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
> > >      ppc4xx_plb_t *plb;
> > >=20
> > >      plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
> > > +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write=
_plb);
> > > +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write=
_plb);
> > >      ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_p=
lb);
> > >      ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_=
plb);
> > >      ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_=
plb);
> > > +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write=
_plb);
> > >      qemu_register_reset(ppc4xx_plb_reset, plb);
> > >  }
> > >=20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m8yuz6kcWj4yJ5vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeO4YACgkQbDjKyiDZ
s5JBNw//TMkYeERU6Z7Xah1u971q6fecG7UjoY/Hok5Cg6mzD9wHjPj6b+w7TQZz
4vpotUciU8ASkyBREO8ohgqdyWV8EXIYDCQqId9Dq3ne+7lheHWyy3325ZMfwUyO
FRJVpeKdgEDGZZbYfLgylkOE1/ZDZhCZERO1F5S5p93GF07jY3OrMpWe7LsyYWnc
MIsu61Pp7MZVkwhczIpq3x8qqO9FlEK0iow/eOY1gWcDWvuyt3z+4P2J/A3+mu9r
NbxlQDVEJBr/yudH1ug6ta8/ipnW6i2nGDxggyfqGBI6/TeFrKTPdkr2bSsZSzv2
m8NR2xAGv/5IFPy8XpjnCqv0YHXjXMYb3vZj1AXGcOq3zCoSGr2ShmAjTIO+OEii
fhoawmqcFR5R3Isx3tNmcNqE7J453tDTh4h1MKdKexgEWdAsWu3ZuxcIekfrWW69
pSIcCqPfN6peJJspHZ5KrBDqgBbQSaByMZDSxCSdW9vns0Ld5b7y1h8gOuRXSnRQ
WQz9OH7BuCD1V1i0Oupg9WZvX2wV239ahyMZQLCWJIIny3PQa35NVZYiQ2c11ITE
GtYyBG41fBb/sEDHor6IcWynGBUO10ntXLS9YRkvI9C13dqD+87uIIu6Td8CTita
PZr2HI1RuiPdb1LfFHZS6Kz6IxphwVNrl/HW0T1sSVUNaygh/WM=
=R5cb
-----END PGP SIGNATURE-----

--m8yuz6kcWj4yJ5vq--
