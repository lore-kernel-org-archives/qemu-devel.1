Received: from eggs.gnu.org ([2001:4830:134:3::10]:35111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e3ud8-0006JU-1D
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 21:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e3ud6-0006qE-Rv
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 21:55:46 -0400
Message-ID: <1508118927.24322.0.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 16 Oct 2017 12:25:27 +1030
In-Reply-To: <ca6255bb-64f8-10bf-1e1f-a693ae38f4c3@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<1507507449.5452.147.camel@aj.id.au>
	<48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
	<1507693785.5452.175.camel@aj.id.au>
	<ca6255bb-64f8-10bf-1e1f-a693ae38f4c3@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZAn+KUcnrehn6Q1D5hz2"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--=-ZAn+KUcnrehn6Q1D5hz2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-10-11 at 09:28 +0200, C=C3=A9dric Le Goater wrote:
> On 10/11/2017 05:49 AM, Andrew Jeffery wrote:
> > On Tue, 2017-10-10 at 15:30 +0200, C=C3=A9dric Le Goater wrote:
> > > On 10/09/2017 02:04 AM, Andrew Jeffery wrote:
> > > > On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> > > > > The Witherspoon boards are OpenPOWER system hosting POWER9 Proces=
sors.
> > > > > Let's add support for their BMC including a couple of I2C devices=
 as
> > > > > found on real HW.
> > > > > =C2=A0
> > > > > > > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > > >=20
> > > > > ---
> > > > > =C2=A0hw/arm/aspeed.c | 49 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > > > > =C2=A01 file changed, 49 insertions(+)
> > > > > =C2=A0
> > > > > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > > > > index ab895ad490af..81f522f711ae 100644
> > > > > --- a/hw/arm/aspeed.c
> > > > > +++ b/hw/arm/aspeed.c
> > > > > @@ -46,6 +46,7 @@ enum {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PALMETTO_BMC,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AST2500_EVB,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ROMULUS_BMC,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0WITHERSPOON_BMC,
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > =C2=A0/* Palmetto hardware value: 0x120CE416 */
> > > > > @@ -83,8 +84,12 @@ enum {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_AST2500=
_HW_STRAP_ACPI_ENABLE |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_HW_STRA=
P_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
> > > > > =C2=A0
> > > > > +/* Witherspoon hardware value: 0xF10AD216 (but use romulus defin=
ition) */
> > > > > +#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> > > > > +
> > > > > =C2=A0static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
> > > > > =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> > > > > +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
> > > > > =C2=A0
> > > > > =C2=A0static const AspeedBoardConfig aspeed_boards[] =3D {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PALMETTO_BMC] =3D {
> > > > > @@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards=
[] =3D {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =
=3D "mx66l1g45g",
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=
=A0=C2=A0=C2=A0=C2=A0=3D 2,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0[WITHERSPOON_BMC]=C2=A0=C2=A0=3D {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.soc_name=C2=A0=
=C2=A0=3D "ast2500-a1",
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hw_strap1 =3D W=
ITHERSPOON_BMC_HW_STRAP1,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fmc_model =3D "=
mx25l25635e",
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "=
mx66l1g45g",
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=
=A0=C2=A0=C2=A0=3D 2,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.i2c_init=C2=A0=
=C2=A0=3D witherspoon_bmc_i2c_init,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0},
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > =C2=A0#define FIRMWARE_ADDR 0x0
> > > > > @@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D =
{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D romulus_bmc_class_i=
nit,
> > > > > =C2=A0};
> > > > > =C2=A0
> > > > > +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVI=
CE(&soc->i2c), 4), "tmp423", 0x4c);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVI=
CE(&soc->i2c), 5), "tmp423", 0x4c);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVI=
CE(&soc->i2c), 9), "tmp105", 0x4a);
> > > >=20
> > > > Looks like I need to track down newer versions of the schematics I =
have.
> > >=20
> > > the device on the board is a tmp275 but the tmp105 model is compatibl=
e.
> >=20
> > It neither device is listed in the version I have :)
>=20
> Here is my source :
>=20
> 	https://github.com/openbmc/linux/blob/dev-4.10/arch/arm/boot/dts/aspeed-=
bmc-opp-witherspoon.dts#L504
>=20

Yeah, I ended up jumping on a machine and verifying the device was on
the bus.

Cheers,

Andrew
--=-ZAn+KUcnrehn6Q1D5hz2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ5BGQAAoJEJ0dnzgO5LT5k2IQAK9f1PgBuIXxAzhL+yoYQ/8+
TE8/Jhe/5/1LDPrM3qFz6h5ZX93ptYlCKX/TW/mByPZaE9sEFtXjx58i6hJ2EBGV
xAOGV/lG866gQjPRa6c3WtbjhQCOoj9A/poH0znOFcLYD2wzLb4ylveILiMOxpXE
tqZJCbTfqH/EgjUUK7O9b5A7n/sUmsA556GZoKxR34Acv6yUqvh5uRtHmLtcMDe/
KhP4KdzL98jZWyXg/O16OyaxxKBVNkYQXua50Bocd7T2FV+oxRj+i3FfSBavDCJk
+IBatULPtePXR9xUHkBpOLMecS4D5c1iqG1A4MQn5p/g3wNf0iTcNKMfA+PpIGk9
Yt0w26W6LGKVUTntFyGYnRA5u3q+r9zZC1zUAD/9orRp3WsJ8FmUG+SnY9tXpvvr
pB44UhONVjocKwRZNa2kURz3tAlo4on36/spSe7nvivVTl/57OJO83RD+i6fUKJX
Pn6fCkwJMtMlZPo9Bq7UjJCMhwTnqpE+TenGMRB8FCdReL4XhP6zkIuyIwfYg5IJ
/wz4UCj/cRycW+jEObuEOrKVRnV1bIUe3YuqEY0AAApcYdRbIKR2QkV3rhr4+qVv
iJNOC1/u9Yd2uLEM2Cmt2oBfUhkxn3VOMlYv9ORHU//dCx3iKObzgeWo0xK32iht
dJKLhnkFdpXWuTo4geAJ
=PFRy
-----END PGP SIGNATURE-----

--=-ZAn+KUcnrehn6Q1D5hz2--
