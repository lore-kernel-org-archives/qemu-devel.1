Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e281v-0004lh-EQ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e281u-0007fD-G0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:49:59 -0400
Message-ID: <1507693785.5452.175.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 11 Oct 2017 14:19:45 +1030
In-Reply-To: <48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<1507507449.5452.147.camel@aj.id.au>
	<48144f71-c876-0e89-f01e-cbfe87687aee@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GQfEwtRaPYaNTDX4TOmI"
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


--=-GQfEwtRaPYaNTDX4TOmI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-10-10 at 15:30 +0200, C=C3=A9dric Le Goater wrote:
> On 10/09/2017 02:04 AM, Andrew Jeffery wrote:
> > On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> > > The Witherspoon boards are OpenPOWER system hosting POWER9 Processors=
.
> > > Let's add support for their BMC including a couple of I2C devices as
> > > found on real HW.
> > > =C2=A0
> > > > > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > ---
> > > =C2=A0hw/arm/aspeed.c | 49 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
> > > =C2=A01 file changed, 49 insertions(+)
> > > =C2=A0
> > > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > > index ab895ad490af..81f522f711ae 100644
> > > --- a/hw/arm/aspeed.c
> > > +++ b/hw/arm/aspeed.c
> > > @@ -46,6 +46,7 @@ enum {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PALMETTO_BMC,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AST2500_EVB,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ROMULUS_BMC,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0WITHERSPOON_BMC,
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0/* Palmetto hardware value: 0x120CE416 */
> > > @@ -83,8 +84,12 @@ enum {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_AST2500_HW_=
STRAP_ACPI_ENABLE |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_HW_STRAP_SP=
I_MODE(SCU_HW_STRAP_SPI_MASTER))
> > > =C2=A0
> > > +/* Witherspoon hardware value: 0xF10AD216 (but use romulus definitio=
n) */
> > > +#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> > > +
> > > =C2=A0static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
> > > =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> > > +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
> > > =C2=A0
> > > =C2=A0static const AspeedBoardConfig aspeed_boards[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PALMETTO_BMC] =3D {
> > > @@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards[] =
=3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D =
"mx66l1g45g",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=
=C2=A0=C2=A0=C2=A0=3D 2,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0[WITHERSPOON_BMC]=C2=A0=C2=A0=3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.soc_name=C2=A0=C2=
=A0=3D "ast2500-a1",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hw_strap1 =3D WITHE=
RSPOON_BMC_HW_STRAP1,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fmc_model =3D "mx25=
l25635e",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "mx66=
l1g45g",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=A0=
=C2=A0=C2=A0=3D 2,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.i2c_init=C2=A0=C2=
=A0=3D witherspoon_bmc_i2c_init,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0#define FIRMWARE_ADDR 0x0
> > > @@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D romulus_bmc_class_init,
> > > =C2=A0};
> > > =C2=A0
> > > +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&=
soc->i2c), 4), "tmp423", 0x4c);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&=
soc->i2c), 5), "tmp423", 0x4c);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&=
soc->i2c), 9), "tmp105", 0x4a);
> >=20
> > Looks like I need to track down newer versions of the schematics I have=
.
>=20
> the device on the board is a tmp275 but the tmp105 model is compatible.

It neither device is listed in the version I have :)

Andrew
--=-GQfEwtRaPYaNTDX4TOmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ3ZTZAAoJEJ0dnzgO5LT56qQP/1+xsFeE5zIZrR7vbMYs5AdR
aMYXE57yOJ3NGEa0X9TowSfUCvD0yMYI6+svBPnVS4meJGyhrcqgLvfYrX0f4GWA
/BycMTznMmKI41E44OSBg2ThfK8kPdfJUD92pwblUcXcEFiypBjq/D0Ny7DGZa4q
KHCTh3lWxduaVlrxRJ9woLygw6XSkjeop/+3HuD5rOQWTAqx34oN+RsbHv4BvhDI
665Vozk6Hro95/WjOf5x2arXQmsP54KgvvzLD6srIy3H75XYidxKzG06lgfhmfeH
Xzihmb9myD6qC+d/n54YFZeTPQYqYtse6YUTbnfOxkW+TK8MxvSuqmIPS+HEFXMW
niQDixEXUnWWf7Lf+32OOw7QVL8sRAtvTbY0NSCQYXh/2bDXPVfRWH7+GJTGsMbo
HEufePODvKWN9bLc4iRd514J4v4ce9VRZ4xmo06fe5SQQx5JcTqkd1nO8IwBWfsQ
RmFLQgmIkY9C6o2FayLCD1ewCihGPCGw111eC7+T0Hruu/qos3ByVZlcB8yM/Uwt
Lee45W9GZJhk/kowFsbgemQc/v8smOS8UB2+dPr6VLGcv8wLi6j/Rmx0N15n7pkU
HA/xwuWkHyKeOgxA5d6Iy3iMdsEiluOhD7d55izfaFrD/OjJxxXiDcHBcpN3CgF6
mtOPiJd2aIu0O6+n6+my
=l1LG
-----END PGP SIGNATURE-----

--=-GQfEwtRaPYaNTDX4TOmI--
