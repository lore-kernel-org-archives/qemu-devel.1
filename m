Received: from eggs.gnu.org ([2001:4830:134:3::10]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2dD-0008TO-Fw
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2d9-00077T-Em
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:03:59 -0400
Date: Wed, 13 Jun 2018 20:01:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613100145.GI30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
	<20180608085618.GT3344@umbus.fritz.box>
	<alpine.BSF.2.21.1806081112180.22949@zero.eik.bme.hu>
	<20180613012027.GP30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131054300.620@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WVhxcSV8VTJlfoH7"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806131054300.620@zero.eik.bme.hu>
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


--WVhxcSV8VTJlfoH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:56:59AM +0200, BALATON Zoltan wrote:
> On Wed, 13 Jun 2018, David Gibson wrote:
> > On Fri, Jun 08, 2018 at 11:20:50AM +0200, BALATON Zoltan wrote:
> > > On Fri, 8 Jun 2018, David Gibson wrote:
> > > > On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > >=20
> > > > It's not clear to me why this is preferable to having the registers
> > > > embedded in the state structure.  The latter is pretty standard
> > > > practice for qemu.
> > >=20
> > > Maybe it will be clearer after the next patch in the series. I needed=
 a
> > > place to store the bitbang_i2c_interface for the directcntl way of ac=
cessing
> > > the i2c bus but I can't include bitbang_i2c.h from the public header =
because
> > > it's a local header. So I needed a local extension to the state struc=
t. Once
> > > I have that then it's a good place to also store private registers wh=
ich are
> > > now defined in the same file so I don't have to look up them in a dif=
ferent
> > > place. This seemed clearer to me and easier to work with. Maybe the s=
pliting
> > > of the rewrite did not make this clear.
> >=20
> > Oh.. right.  There's a better way.
> >=20
> > You can just forward declare the bitbang_i2c_interface structure like
> > this in your header:
> > 	typdef struct bitbang_i2c_interface bitbang_i2c_interface;
> >=20
> > So you're declaring the existence of the structure, but not its
> > contents - that's sufficient to create a pointer to it.  Then you
> > don't need to creat the substructure and extra level of indirection.
> >=20
> > > One thing I'm not sure about though:
> > >=20
> > > > > ---
> > > > >  hw/i2c/ppc4xx_i2c.c         | 75 +++++++++++++++++++++++++------=
--------------
> > > > >  include/hw/i2c/ppc4xx_i2c.h | 19 ++----------
> > > > >  2 files changed, 43 insertions(+), 51 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > > > index d1936db..a68b5f7 100644
> > > > > --- a/hw/i2c/ppc4xx_i2c.c
> > > > > +++ b/hw/i2c/ppc4xx_i2c.c
> > > [...]
> > > > > @@ -330,7 +335,9 @@ static const MemoryRegionOps ppc4xx_i2c_ops =
=3D {
> > > > >  static void ppc4xx_i2c_init(Object *o)
> > > > >  {
> > > > >      PPC4xxI2CState *s =3D PPC4xx_I2C(o);
> > > > > +    PPC4xxI2CRegs *r =3D g_malloc0(sizeof(PPC4xxI2CRegs));
> > > > >=20
> > > > > +    s->regs =3D r;
> > > > >      memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops,=
 s,
> > > > >                            TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
> > > > >      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> > >=20
> > > I allocate memory here but I'm not sure if it should be g_free'd some=
where
> > > and if so where? I was not able to detangle QOM object hierarchies an=
d there
> > > seems to be no good docs available or I haven't found them. (PCI devi=
ces
> > > seem to have unrealize methods but this did not work for I2C objects.)
> >=20
> > Yes, if you're allocating you definitely should be free()ing.  It
> > should go in the corresponding cleanup routine to where it is
> > allocated.  Since the allocation is in instance_init(), the free()
> > should be in instance_finalize() (which you'd need to add).
> >=20
> > Except that the above should let you avoid that.
> >=20
> > ..and I guess this won't actually ever be finalized in practice.
> >=20
> > ..and there doesn't seem to be a way to free up a bitbang_interface,
> > so even if you added the finalize, it still wouldn't really clean up
> > properly.
>=20
> Yes, I suspected it won't matter anyway. I'll try your suggestion to just
> declare the bitbang_i2c_interface in the public header in next version.
>=20
> Any more reviews to expect from you for other patches or should I send a =
v3
> with the changes so far?

Go ahead with v3.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WVhxcSV8VTJlfoH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg64kACgkQbDjKyiDZ
s5LirQ//eNkBR4VBvhh+K96sth10vEP6pxXQwV+kMea+VkAa/wwKYQWpw3Z203dM
+eTkWTiOP7aaFwn2XGgRz+QfpW2uq3lG4XmI/rCbogH+twiwIdJ+O0VAeUWRVaU8
rURvxfc0Uw/yMFbAHbQH+7OiZB1S6AaPf70+fHAfVUhpN8vwqBFmTBliikvfXl7P
w/85YZJLYlEqUKK9nJ8uB7oHMCn1lE63OFyDKWKlMq7ZPqcYlvhMNGEVJNWWqsc8
GHp4dlMKiB3myrkeFkawFi8YrwnITxK3nH6oeVrm4j/pV8nNw6tIbbtRlC/Jc3aU
GYAJuHlCKcX8gVEAJbPuQKoocB0ehfFPBY4ukWIHorU246iC5WGuF03iKFIigPcO
9J1hx1ZfC1ghtfImYLKIkPPe0yRdGMxuBKpaAn60OgIaNUJyADUOsJ7LBs4WeGET
HRXQ4CsTjr5rgJksUl7PAWXSNm0rCwyy9NMVSTvrjQIWjSy7DRurUcTSSTnNPSHP
uXXcl8QprOQGSiSgpMUWiHqAn2wwJsPMAEqZ5OoP6NeV/mFBufDIVxUgMphVaVpJ
KXMkt9VuELkTME9Yn5A6yDMfHhqgNrs4ceJLHhvoP96kPEzHNZE/fs5ykGJSre+y
CmaxVp4ElLZs/unx4az7PsAP97VXh5suhscb1Jtzgqw9qK1mPEY=
=n+fa
-----END PGP SIGNATURE-----

--WVhxcSV8VTJlfoH7--
