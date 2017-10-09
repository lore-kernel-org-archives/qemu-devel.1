Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LwO-0003TU-9c
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LwN-00047J-9Y
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:29:04 -0400
Message-ID: <1507508929.5452.148.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 09 Oct 2017 10:58:49 +1030
In-Reply-To: <20170920070135.31379-3-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-3-clg@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/dT+XB7iCO0KsHsc2QRx"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/6] aspeed: add an I2C RTC device to
 all machines
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


--=-/dT+XB7iCO0KsHsc2QRx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> The AST2500 EVB does not have an RTC but we can pretend that one is
> plugged on the I2C bus header.
>=C2=A0
> The romulus and witherspoon boards expects an Epson RX8900 I2C RTC but
> a ds1338 is good enough for the basic features we need.
>=C2=A0
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> =C2=A0hw/arm/aspeed.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=C2=A0
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 81f522f711ae..362b683e9021 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -89,6 +89,7 @@ enum {
> =C2=A0
> =C2=A0static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
> =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> +static void romulus_bmc_i2c_init(AspeedBoardState *bmc);
> =C2=A0static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
> =C2=A0
> =C2=A0static const AspeedBoardConfig aspeed_boards[] =3D {
> @@ -114,6 +115,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fmc_model =3D "n25=
q256a",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "mx6=
6l1g45g",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=A0=
=C2=A0=C2=A0=3D 2,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.i2c_init=C2=A0=C2=A0=3D=
 romulus_bmc_i2c_init,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[WITHERSPOON_BMC]=C2=A0=C2=A0=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.soc_name=C2=A0=C2=
=A0=3D "ast2500-a1",
> @@ -298,6 +300,10 @@ static void ast2500_evb_i2c_init(AspeedBoardState *b=
mc)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The AST2500 EVB expects a LM75 but a TMP=
105 is compatible */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 7), "tmp105", 0x4d);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0/* The AST2500 EVB does not have an RTC. Let's p=
retend that one is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* plugged on the I2C bus header */
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 11), "ds1338", 0x32);
> =C2=A0}
> =C2=A0
> =C2=A0static void ast2500_evb_init(MachineState *machine)
> @@ -325,6 +331,15 @@ static const TypeInfo ast2500_evb_type =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D ast2500_evb_class_init,
> =C2=A0};
> =C2=A0
> +static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0/* The romulus board expects Epson RX8900 I2C RT=
C but a ds1338 is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* good enough */
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 11), "ds1338", 0x32);
> +}
> +
> =C2=A0static void romulus_bmc_init(MachineState *machine)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspeed_board_init(machine, &aspeed_boards[R=
OMULUS_BMC]);
> @@ -358,6 +373,10 @@ static void witherspoon_bmc_i2c_init(AspeedBoardStat=
e *bmc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 5), "tmp423", 0x4c);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(=
&soc->i2c), 9), "tmp105", 0x4a);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0/* The witherspoon board expects Epson RX8900 I2=
C RTC but a ds1338 is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* good enough */
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 11), "ds1338", 0x32);
> =C2=A0}
> =C2=A0
> =C2=A0static void witherspoon_bmc_init(MachineState *machine)
--=-/dT+XB7iCO0KsHsc2QRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ2sLBAAoJEJ0dnzgO5LT5x+sQAJ9GCa1X8zkE+xS8MLvNx0Rd
/EwqXyvTXdAcvg49lhoYL+6xNQ5wEBRlutG11agCbRKxy5RG/kjTY95H3JOCc78s
TtCIeXUa7GRvyOX46q8f7GBUqymXb7uEkwBl5u5fEM9so7cHAn41Lc8dofxIBi0S
SsrSa9695rrGwUmo+VLx0yXguu4xeSUbmWaGoBFQtLhqfU0OewbwZcb/UC2m9+UM
6H+SXCE88NVp1c9X+ZAN8EMC2eWPwIagie1AIZeJ9g0l4aG1sCThF5TJeNlPMVZO
CH8kTs6FThfqDRYt5xKV8DAvnz/vYtE2/d9RsO7HDz6OJOAiTKwZMheKlrop+Qfj
l4Tuyz4+B1kuw4diNR/PxF1SWbMrZFfbTnx8HHHY6tdVuQtx0q6dKCfY6OCz2Pqw
oBp3+3IjyA3mooJsMu55ub0Ec0vxY7gHLFy8PuEgX6qwh5SDygGoY0xlZ4B+JBTP
U3PP4FtZ0s+wxhAidlt5fERYYmBRGV54PPjIfzgrvghBnl4xK48DkmrQFjbZGmyV
T9q3vGIF2sPFBKU2tys2xCFE8BrRqHYPSl/YS6Ofb30EXWAkKPxQof8Fma1W4EWi
L2/Neo7OGibDMcsblX+LoIozb8HPcMBfTt2FCxmgn3nY9sp9GtzX+zAcGjeeUihZ
ZeKUfb/46/dO354iOS/g
=gCOi
-----END PGP SIGNATURE-----

--=-/dT+XB7iCO0KsHsc2QRx--
