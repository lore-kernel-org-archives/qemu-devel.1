Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dQBaq-00027H-9A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dQBan-0006Ph-5M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:57:12 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:40734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dQBam-0006P9-Rd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:57:09 -0400
Received: from player759.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CC8A37D431
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 13:57:06 +0200 (CEST)
References: <20170628114717.22349-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6c9540fe-9acb-c1ab-9f19-b59682b8fd4c@kaod.org>
Date: Wed, 28 Jun 2017 13:57:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170628114717.22349-1-joel@jms.id.au>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed: Register all watchdogs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/28/2017 01:47 PM, Joel Stanley wrote:
> The ast2400 contains two and the ast2500 contains three watchdogs.
> Add this information to the AspeedSoCInfo and realise the correct numbe=
r
> of watchdogs for that each SoC type.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-and-tested-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/arm/aspeed_soc.c         | 25 +++++++++++++++++--------
>  include/hw/arm/aspeed_soc.h |  4 +++-
>  2 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 4937e2bc8323..3034849c80bf 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -62,6 +62,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
>          .fmc_typename =3D "aspeed.smc.fmc",
>          .spi_typename =3D aspeed_soc_ast2400_typenames,
> +        .wdts_num     =3D 2,
>      }, {
>          .name         =3D "ast2400-a1",
>          .cpu_model    =3D "arm926",
> @@ -72,6 +73,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
>          .fmc_typename =3D "aspeed.smc.fmc",
>          .spi_typename =3D aspeed_soc_ast2400_typenames,
> +        .wdts_num     =3D 2,
>      }, {
>          .name         =3D "ast2400",
>          .cpu_model    =3D "arm926",
> @@ -82,6 +84,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .spi_bases    =3D aspeed_soc_ast2400_spi_bases,
>          .fmc_typename =3D "aspeed.smc.fmc",
>          .spi_typename =3D aspeed_soc_ast2400_typenames,
> +        .wdts_num     =3D 2,
>      }, {
>          .name         =3D "ast2500-a1",
>          .cpu_model    =3D "arm1176",
> @@ -92,6 +95,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
>          .spi_bases    =3D aspeed_soc_ast2500_spi_bases,
>          .fmc_typename =3D "aspeed.smc.ast2500-fmc",
>          .spi_typename =3D aspeed_soc_ast2500_typenames,
> +        .wdts_num     =3D 3,
>      },
>  };
> =20
> @@ -175,9 +179,11 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
>                                "ram-size", &error_abort);
> =20
> -    object_initialize(&s->wdt, sizeof(s->wdt), TYPE_ASPEED_WDT);
> -    object_property_add_child(obj, "wdt", OBJECT(&s->wdt), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->wdt), sysbus_get_default());
> +    for (i =3D 0; i < sc->info->wdts_num; i++) {
> +        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_W=
DT);
> +        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), N=
ULL);
> +        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
> +    }
> =20
>      object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC=
100);
>      object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100),=
 NULL);
> @@ -300,12 +306,15 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE)=
;
> =20
>      /* Watch dog */
> -    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    for (i =3D 0; i < sc->info->wdts_num; i++) {
> +        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",=
 &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> +                        ASPEED_SOC_WDT_BASE + i * 0x20);
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, ASPEED_SOC_WDT_BASE);
> =20
>      /* Net */
>      qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 4c5fc66a1ee0..0b88baaad00e 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -23,6 +23,7 @@
>  #include "hw/net/ftgmac100.h"
> =20
>  #define ASPEED_SPIS_NUM  2
> +#define ASPEED_WDTS_NUM  3
> =20
>  typedef struct AspeedSoCState {
>      /*< private >*/
> @@ -39,7 +40,7 @@ typedef struct AspeedSoCState {
>      AspeedSMCState fmc;
>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>      AspeedSDMCState sdmc;
> -    AspeedWDTState wdt;
> +    AspeedWDTState wdt[ASPEED_WDTS_NUM];
>      FTGMAC100State ftgmac100;
>  } AspeedSoCState;
> =20
> @@ -56,6 +57,7 @@ typedef struct AspeedSoCInfo {
>      const hwaddr *spi_bases;
>      const char *fmc_typename;
>      const char **spi_typename;
> +    int wdts_num;
>  } AspeedSoCInfo;
> =20
>  typedef struct AspeedSoCClass {
>=20
