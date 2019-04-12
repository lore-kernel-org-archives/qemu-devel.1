Received: from eggs.gnu.org ([209.51.188.92]:50854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmg1-0007eg-BT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1hEmg0-00005I-73
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:16:29 -0400
Mime-Version: 1.0
Message-Id: <17c56d46-117c-4b8b-a60f-ea7d1725dfc8@www.fastmail.com>
In-Reply-To: <20190411161013.4514-4-clg@kaod.org>
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-4-clg@kaod.org>
Date: Thu, 11 Apr 2019 23:16:22 -0400
From: "Andrew Jeffery" <andrew@aj.id.au>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_3/3=5D_aspeed=3A_use_sysbus=5Fin?=
 =?utf-8?q?it=5Fchild=5Fobj=28=29_to_initialize_children?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>



On Fri, 12 Apr 2019, at 01:40, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/arm/aspeed_soc.c | 50 ++++++++++++++++++--------------------------=
-
>  1 file changed, 20 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 9b601709e93c..110956828c44 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -212,12 +212,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      int i;
> =20
> -    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cp=
u),
> +                            sc->info->cpu_type, &error_abort, NULL);
> =20
> -    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
> -    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu)=
,
> +                          TYPE_ASPEED_SCU);
>      qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
>                           sc->info->silicon_rev);
>      object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
> @@ -227,36 +226,29 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                "hw-prot-key", &error_abort);
> =20
> -    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
> -    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic)=
,
> +                          TYPE_ASPEED_VIC);
> =20
> -    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEE=
D_TIMER);
> -    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl)=
, NULL);
> +    sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
> +                          sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
>      object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
>                                     OBJECT(&s->scu), &error_abort);
> -    qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());=

> =20
> -    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
> -    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c)=
,
> +                          TYPE_ASPEED_I2C);
> =20
> -    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename=
);
> -    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc)=
,
> +                          sc->info->fmc_typename);
>      object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs=
",
>                                &error_abort);
> =20
>      for (i =3D 0; i < sc->info->spis_num; i++) {
> -        object_initialize(&s->spi[i], sizeof(s->spi[i]),
> -                          sc->info->spi_typename[i]);
> -        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), =
NULL);
> -        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default())=
;
> +        sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
> +                              sizeof(s->spi[i]), sc->info->spi_typena=
me[i]);
>      }
> =20
> -    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
> -    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sd=
mc),
> +                          TYPE_ASPEED_SDMC);
>      qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
>                           sc->info->silicon_rev);
>      object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
> @@ -265,16 +257,14 @@ static void aspeed_soc_init(Object *obj)
>                                "max-ram-size", &error_abort);
> =20
>      for (i =3D 0; i < sc->info->wdts_num; i++) {
> -        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_=
WDT);
> -        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), =
NULL);
> -        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default())=
;
> +        sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
> +                              sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>                                      sc->info->silicon_rev);
>      }
> =20
> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMA=
C100);
> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100)=
, NULL);
> -    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());=

> +    sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
> +                          sizeof(s->ftgmac100), TYPE_FTGMAC100);
>  }
> =20
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> --=20
> 2.20.1
>=20
>
