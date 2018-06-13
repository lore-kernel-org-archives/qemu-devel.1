Received: from eggs.gnu.org ([2001:4830:134:3::10]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSuUv-00045X-Cn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSuUr-0003IY-B2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:22:53 -0400
Date: Wed, 13 Jun 2018 11:20:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613012027.GP30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
	<20180608085618.GT3344@umbus.fritz.box>
	<alpine.BSF.2.21.1806081112180.22949@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806081112180.22949@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] ppc4xx_i2c: Move register state to
 private struct and remove unimplemented sdata and intr registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 11:20:50AM +0200, BALATON Zoltan wrote:
> On Fri, 8 Jun 2018, David Gibson wrote:
> > On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > It's not clear to me why this is preferable to having the registers
> > embedded in the state structure.  The latter is pretty standard
> > practice for qemu.
>=20
> Maybe it will be clearer after the next patch in the series. I needed a
> place to store the bitbang_i2c_interface for the directcntl way of access=
ing
> the i2c bus but I can't include bitbang_i2c.h from the public header beca=
use
> it's a local header. So I needed a local extension to the state struct. O=
nce
> I have that then it's a good place to also store private registers which =
are
> now defined in the same file so I don't have to look up them in a differe=
nt
> place. This seemed clearer to me and easier to work with. Maybe the split=
ing
> of the rewrite did not make this clear.

Oh.. right.  There's a better way.

You can just forward declare the bitbang_i2c_interface structure like
this in your header:
	typdef struct bitbang_i2c_interface bitbang_i2c_interface;

So you're declaring the existence of the structure, but not its
contents - that's sufficient to create a pointer to it.  Then you
don't need to creat the substructure and extra level of indirection.

> One thing I'm not sure about though:
>=20
> > > ---
> > >  hw/i2c/ppc4xx_i2c.c         | 75 +++++++++++++++++++++++++----------=
----------
> > >  include/hw/i2c/ppc4xx_i2c.h | 19 ++----------
> > >  2 files changed, 43 insertions(+), 51 deletions(-)
> > >=20
> > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > index d1936db..a68b5f7 100644
> > > --- a/hw/i2c/ppc4xx_i2c.c
> > > +++ b/hw/i2c/ppc4xx_i2c.c
> [...]
> > > @@ -330,7 +335,9 @@ static const MemoryRegionOps ppc4xx_i2c_ops =3D {
> > >  static void ppc4xx_i2c_init(Object *o)
> > >  {
> > >      PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> > > +    PPC4xxI2CRegs *r =3D g_malloc0(sizeof(PPC4xxI2CRegs));
> > >=20
> > > +    s->regs =3D r;
> > >      memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
> > >                            TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
> > >      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>=20
> I allocate memory here but I'm not sure if it should be g_free'd somewhere
> and if so where? I was not able to detangle QOM object hierarchies and th=
ere
> seems to be no good docs available or I haven't found them. (PCI devices
> seem to have unrealize methods but this did not work for I2C objects.)

Yes, if you're allocating you definitely should be free()ing.  It
should go in the corresponding cleanup routine to where it is
allocated.  Since the allocation is in instance_init(), the free()
should be in instance_finalize() (which you'd need to add).

Except that the above should let you avoid that.

=2E.and I guess this won't actually ever be finalized in practice.

=2E.and there doesn't seem to be a way to free up a bitbang_interface,
so even if you added the finalize, it still wouldn't really clean up
properly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgcVgACgkQbDjKyiDZ
s5Jckg//RxR+UFRJtmHUlj09kB4kcjNcoSKmN0+1L7S6rYWHZE449PAfvHMDw5Dk
BC3rgosCOelGAzLmXti5/Ms1gr5UTaERmDjhteM7VhchizcOJQuvyx5FvX+uHxO+
4ffzmHNN9S17bX/Rx/gjCF6BYk8sNMYLoRnstwPCBevTNr9/lkSYeYRjJzYOStis
P0yLI4YAp63eKN+1TGxNft97R7uQUFQLGpVPMHH8Ir27RewN42Qc/6isSUcAC3Uv
88dTSX2hL2Rg09uQeO8dX4ClfQwfKDyj9ZNTd4AkQEULa6dQXYquzPwdnNNBnHoq
vzoOj3umkMFInLungoFMXixYubjF8xen7AFhUtHyc4Y0o3CV1+Bkzt9fXlN8cLjj
UUpzTFZ8ZnKQxPV59jvgVfU+GDKa4+xk6evk6kwU2SsySZGK8r5zHh9ZPjIECTs/
t1wRBUU4Y/oyKxwuupvjnZ7smezwj0zPjuHjVLHhp7LG3YGlDmlBtiekbCyyweHT
Btj98pTWBiO/Q9TZgCCkuMvJc3X0ipSCYVSjMlM0otpkvt7ZorkMkQh5wnLcGjEf
79TzRS5MurdsM8df3aQVOYi4l3Uy50ewjIAgKbUBJTQgIc9JWKT+idmJoBrQNyZH
TQJj4qk8RQLuTMxSmNx0CSS5FFPJ4Jc6ZPUwGKtqSBgeGAKVAqw=
=Vh61
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--
