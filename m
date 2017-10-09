Received: from eggs.gnu.org ([2001:4830:134:3::10]:42464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LYV-0007Ds-9k
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1e1LYU-0004VE-9T
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:04:23 -0400
Message-ID: <1507507449.5452.147.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 09 Oct 2017 10:34:09 +1030
In-Reply-To: <20170920070135.31379-2-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oY3VsICoF9BwTCvYHlV6"
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


--=-oY3VsICoF9BwTCvYHlV6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-09-20 at 09:01 +0200, C=C3=A9dric Le Goater wrote:
> The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
> Let's add support for their BMC including a couple of I2C devices as
> found on real HW.
>=C2=A0
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> =C2=A0hw/arm/aspeed.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 49 insertions(+)
>=C2=A0
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..81f522f711ae 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -46,6 +46,7 @@ enum {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PALMETTO_BMC,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AST2500_EVB,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ROMULUS_BMC,
> +=C2=A0=C2=A0=C2=A0=C2=A0WITHERSPOON_BMC,
> =C2=A0};
> =C2=A0
> =C2=A0/* Palmetto hardware value: 0x120CE416 */
> @@ -83,8 +84,12 @@ enum {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_AST2500_HW_STRA=
P_ACPI_ENABLE |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCU_HW_STRAP_SPI_MO=
DE(SCU_HW_STRAP_SPI_MASTER))
> =C2=A0
> +/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
> +#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> +
> =C2=A0static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
> =C2=A0static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
> =C2=A0
> =C2=A0static const AspeedBoardConfig aspeed_boards[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PALMETTO_BMC] =3D {
> @@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "mx6=
6l1g45g",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=A0=
=C2=A0=C2=A0=3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> +=C2=A0=C2=A0=C2=A0=C2=A0[WITHERSPOON_BMC]=C2=A0=C2=A0=3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.soc_name=C2=A0=C2=A0=3D=
 "ast2500-a1",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hw_strap1 =3D WITHERSPO=
ON_BMC_HW_STRAP1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fmc_model =3D "mx25l256=
35e",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.spi_model =3D "mx66l1g4=
5g",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_cs=C2=A0=C2=A0=C2=
=A0=C2=A0=3D 2,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.i2c_init=C2=A0=C2=A0=3D=
 witherspoon_bmc_i2c_init,
> +=C2=A0=C2=A0=C2=A0=C2=A0},
> =C2=A0};
> =C2=A0
> =C2=A0#define FIRMWARE_ADDR 0x0
> @@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D romulus_bmc_class_init,
> =C2=A0};
> =C2=A0
> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0AspeedSoCState *soc =3D &bmc->soc;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 4), "tmp423", 0x4c);
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 5), "tmp423", 0x4c);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc-=
>i2c), 9), "tmp105", 0x4a);

Looks like I need to track down newer versions of the schematics I have.

> +}
> +
> +static void witherspoon_bmc_init(MachineState *machine)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0aspeed_board_init(machine, &aspeed_boards[WITHER=
SPOON_BMC]);
> +}
> +
> +static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->desc =3D "OpenPOWER Witherspoon BMC (ARM1176=
)";
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->init =3D witherspoon_bmc_init;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->max_cpus =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_sdcard =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_floppy =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_cdrom =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->no_parallel =3D 1;
> +=C2=A0=C2=A0=C2=A0=C2=A0mc->ignore_memory_transaction_failures =3D true;

Aside from the issue with the above as pointed out by Peter,

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> +}
> +
> +static const TypeInfo witherspoon_bmc_type =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0.name =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
> +=C2=A0=C2=A0=C2=A0=C2=A0.parent =3D TYPE_MACHINE,
> +=C2=A0=C2=A0=C2=A0=C2=A0.class_init =3D witherspoon_bmc_class_init,
> +};
> +
> =C2=A0static void aspeed_machine_init(void)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&palmetto_bmc_type);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&ast2500_evb_type);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&romulus_bmc_type);
> +=C2=A0=C2=A0=C2=A0=C2=A0type_register_static(&witherspoon_bmc_type);
> =C2=A0}
> =C2=A0
> =C2=A0type_init(aspeed_machine_init)
--=-oY3VsICoF9BwTCvYHlV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ2rz5AAoJEJ0dnzgO5LT5NGwQAJRBPI/LN5+DXxFkXTKijyeR
gaYlkVmp0dvTh+5AhV2oEoruY/uEcZReiEeN+f9mI4Fp2JCln9QlV0V+UBkv66Xo
zNA/+cPtvo43DkzKKSwilInWvB7h1xvyiJaPGjUc510ivfVYP2SnB6MCMsiStS+r
AjUqUY9BcDua17UjmrJ5X/gomt+tUr+qYZoCT5Cg4SeogP9CbKauLHR0zwzGH8eS
4NTgmwXQc50mtnSfipzzxgMJzZlbxR79vMollMpvEgvYVXkphQwlmiEr2XFYZ26v
vLLaC2r3gegajihb552eoRHoN/DM/l2PXgNPSMst65C3LBwpii4xCcNOReosbeTk
Y6eOa8NGlb0ylUoXd5cnikhsdeJkdLQVDPfDW+XsnyK3gMnpqevjnsLx65+ihGHx
PWa0e99yhvDB8oy0e5GoPfPmlOYiIPitgdZRa6STonpTYkUwN+SPBuf7ZmUyVDwh
JNcBOrE4bYWSmR+Gylw4jGJnrazsyZAOjXcANCvfn3d+sSk3Lci8frXXRu76Hbhj
00DurB8nVQcxnh84oLZQ9Vv2uWlSLRChSbe0KNtIXFv09kZRQ9yhOlvH5GFMG+1g
jJ3JKCBwhbSauYisXu6p2sOOQJUcDP2hdtE7F7b9EusWavUWHrV1kc5Ww07H427W
+iGKo3UggKWMXJq/H0sK
=o0nP
-----END PGP SIGNATURE-----

--=-oY3VsICoF9BwTCvYHlV6--
