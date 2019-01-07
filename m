Received: from eggs.gnu.org ([209.51.188.92]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggOiU-0002M6-U1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggOiT-0006Ex-Vo
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:48:54 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:37014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggOiT-0006Cc-PR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 01:48:53 -0500
Received: from player739.ha.ovh.net (unknown [10.109.143.24])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E17D2179003
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 07:48:44 +0100 (CET)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-2-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f8deb758-762b-fc7f-4c54-ef89f7323d99@kaod.org>
Date: Mon, 7 Jan 2019 07:48:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/16] hw/arm/aspeed: Use
 TYPE_TMP105/TYPE_PCA9552 instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 1/4/19 6:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/arm/aspeed.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 5158985482..817f9e1400 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -19,6 +19,8 @@
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/smbus.h"
> +#include "hw/misc/pca9552.h"
> +#include "hw/misc/tmp105.h"
>  #include "qemu/log.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/loader.h"
> @@ -267,7 +269,8 @@ static void ast2500_evb_i2c_init(AspeedBoardState *=
bmc)
>                            eeprom_buf);
> =20
>      /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105=
", 0x4d);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), TYPE_TM=
P105,
> +                     0x4d);
> =20
>      /* The AST2500 EVB does not have an RTC. Let's pretend that one is
>       * plugged on the I2C bus header */
> @@ -288,13 +291,15 @@ static void witherspoon_bmc_i2c_init(AspeedBoardS=
tate *bmc)
>      AspeedSoCState *soc =3D &bmc->soc;
>      uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
> =20
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca955=
2", 0x60);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PC=
A9552,
> +                     0x60);
> =20
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423=
", 0x4c);
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423=
", 0x4c);
> =20
>      /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105=
", 0x4a);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_TM=
P105,
> +                     0x4a);
> =20
>      /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338=
 is
>       * good enough */
> @@ -302,7 +307,7 @@ static void witherspoon_bmc_i2c_init(AspeedBoardSta=
te *bmc)
> =20
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0=
x51,
>                            eeprom_buf);
> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca95=
52",
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_P=
CA9552,
>                       0x60);
>  }
> =20
>=20
