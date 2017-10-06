Received: from eggs.gnu.org ([2001:4830:134:3::10]:37588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UGx-0000xL-7d
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UGw-0002jE-5v
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:10:43 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:57078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0UGv-0002hv-VM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:10:42 -0400
Received: by mail-wr0-x232.google.com with SMTP id r79so7896882wrb.13
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 08:10:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920070135.31379-2-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 16:10:20 +0100
Message-ID: <CAFEAcA9-dmTD3v1YU7Wr5EcA53z=c_WxS0K1+1zbw16q=vj-vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 September 2017 at 08:01, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
> Let's add support for their BMC including a couple of I2C devices as
> found on real HW.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..81f522f711ae 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -46,6 +46,7 @@ enum {
>      PALMETTO_BMC,
>      AST2500_EVB,
>      ROMULUS_BMC,
> +    WITHERSPOON_BMC,
>  };
>
>  /* Palmetto hardware value: 0x120CE416 */
> @@ -83,8 +84,12 @@ enum {
>          SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              =
\
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>
> +/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
> +#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> +
>  static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
>  static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
>
>  static const AspeedBoardConfig aspeed_boards[] =3D {
>      [PALMETTO_BMC] =3D {
> @@ -110,6 +115,14 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .spi_model =3D "mx66l1g45g",
>          .num_cs    =3D 2,
>      },
> +    [WITHERSPOON_BMC]  =3D {
> +        .soc_name  =3D "ast2500-a1",
> +        .hw_strap1 =3D WITHERSPOON_BMC_HW_STRAP1,
> +        .fmc_model =3D "mx25l25635e",
> +        .spi_model =3D "mx66l1g45g",
> +        .num_cs    =3D 2,
> +        .i2c_init  =3D witherspoon_bmc_i2c_init,
> +    },
>  };
>
>  #define FIRMWARE_ADDR 0x0
> @@ -337,11 +350,47 @@ static const TypeInfo romulus_bmc_type =3D {
>      .class_init =3D romulus_bmc_class_init,
>  };
>
> +static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +    AspeedSoCState *soc =3D &bmc->soc;
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423",=
 0x4c);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423",=
 0x4c);
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105",=
 0x4a);
> +}
> +
> +static void witherspoon_bmc_init(MachineState *machine)
> +{
> +    aspeed_board_init(machine, &aspeed_boards[WITHERSPOON_BMC]);
> +}
> +
> +static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "OpenPOWER Witherspoon BMC (ARM1176)";
> +    mc->init =3D witherspoon_bmc_init;
> +    mc->max_cpus =3D 1;
> +    mc->no_sdcard =3D 1;
> +    mc->no_floppy =3D 1;
> +    mc->no_cdrom =3D 1;
> +    mc->no_parallel =3D 1;
> +    mc->ignore_memory_transaction_failures =3D true;

Please don't set this flag for new board models, it is only
for our legacy existing ones. Instead implement any devices
that you need for guest code to boot (stub them out with
create_unimplemented_device() if you like).

thanks
-- PMM
