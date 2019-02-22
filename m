Received: from eggs.gnu.org ([209.51.188.92]:38363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gx34b-0008OH-PB
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gx34Z-0006iX-RE
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:08:33 -0500
References: <20190221183829.31019-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c49607a1-e8aa-3c93-8447-48db7e5bc0b5@redhat.com>
Date: Fri, 22 Feb 2019 06:08:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190221183829.31019-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Antony Pavlov <antonynpavlov@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 21/02/2019 19.38, Philippe Mathieu-Daud=C3=A9 wrote:
> As Thomas Huth explained:
> "Both functions, object_initialize() and object_property_add_child()
> increase the reference counter of the new object, so one of the
> references has to be dropped afterwards to get the reference counting
> right. Otherwise the child object will not be properly cleaned up
> when the parent gets destroyed.
> Thus let's use now object_initialize_child() instead to get the
> reference counting here right."
>=20
> This patch was generated using the following Coccinelle script:
>=20
>  @use_object_initialize_child@
>  identifier parent_obj;
>  expression child;
>  expression propname;
>  expression child_type;
>  expression errp;
>  @@
>  (
>  -    object_initialize(&child, sizeof(child), child_type);
>  -    object_property_add_child(parent_obj, propname, OBJECT(&child), N=
ULL);
>  +    object_initialize_child(parent_obj, propname,  &child, sizeof(chi=
ld),
>  +                            child_type, &error_abort, NULL);
>  |
>  -    object_initialize(&child, sizeof(child), child_type);
>  -    object_property_add_child(parent_obj, propname, OBJECT(&child), e=
rrp);
>  +    object_initialize_child(parent_obj, propname,  &child, sizeof(chi=
ld),
>  +                            child_type, errp, NULL);
>  )
>=20
> and a bit of manual fix-up for overly long lines.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/aspeed_soc.c          | 43 ++++++++++++++++++------------------
>  hw/arm/bcm2835_peripherals.c | 41 +++++++++++++++++-----------------
>  hw/arm/digic.c               |  4 ++--
>  3 files changed, 45 insertions(+), 43 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d487..81665f2948 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -106,11 +106,11 @@ static void aspeed_soc_init(Object *obj)
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>      int i;
> =20
> -    object_initialize(&s->cpu, sizeof(s->cpu), sc->info->cpu_type);
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            sc->info->cpu_type, &error_abort, NULL);
> =20
> -    object_initialize(&s->scu, sizeof(s->scu), TYPE_ASPEED_SCU);
> -    object_property_add_child(obj, "scu", OBJECT(&s->scu), NULL);
> +    object_initialize_child(obj, "scu", &s->scu, sizeof(s->scu),
> +                            TYPE_ASPEED_SCU, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->scu), sysbus_get_default());
>      qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
>                           sc->info->silicon_rev);
> @@ -121,35 +121,35 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
>                                "hw-prot-key", &error_abort);
> =20
> -    object_initialize(&s->vic, sizeof(s->vic), TYPE_ASPEED_VIC);
> -    object_property_add_child(obj, "vic", OBJECT(&s->vic), NULL);
> +    object_initialize_child(obj, "vic", &s->vic, sizeof(s->vic),
> +                            TYPE_ASPEED_VIC, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->vic), sysbus_get_default());
> =20
> -    object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED=
_TIMER);
> -    object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl),=
 NULL);
> +    object_initialize_child(obj, "timerctrl", &s->timerctrl,
> +                            sizeof(s->timerctrl), TYPE_ASPEED_TIMER,
> +                            &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
>                                     OBJECT(&s->scu), &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
> =20
> -    object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
> -    object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
> +    object_initialize_child(obj, "i2c", &s->i2c, sizeof(s->i2c),
> +                            TYPE_ASPEED_I2C, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
> =20
> -    object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename)=
;
> -    object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
> +    object_initialize_child(obj, "fmc", &s->fmc, sizeof(s->fmc),
> +                            sc->info->fmc_typename, &error_abort, NULL=
);
>      qdev_set_parent_bus(DEVICE(&s->fmc), sysbus_get_default());
>      object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs"=
,
>                                &error_abort);
> =20
>      for (i =3D 0; i < sc->info->spis_num; i++) {
> -        object_initialize(&s->spi[i], sizeof(s->spi[i]),
> -                          sc->info->spi_typename[i]);
> -        object_property_add_child(obj, "spi[*]", OBJECT(&s->spi[i]), N=
ULL);
> +        object_initialize_child(obj, "spi[*]", &s->spi[i], sizeof(s->s=
pi[i]),
> +                                sc->info->spi_typename[i], &error_abor=
t, NULL);
>          qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
>      }
> =20
> -    object_initialize(&s->sdmc, sizeof(s->sdmc), TYPE_ASPEED_SDMC);
> -    object_property_add_child(obj, "sdmc", OBJECT(&s->sdmc), NULL);
> +    object_initialize_child(obj, "sdmc", &s->sdmc, sizeof(s->sdmc),
> +                            TYPE_ASPEED_SDMC, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->sdmc), sysbus_get_default());
>      qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
>                           sc->info->silicon_rev);
> @@ -159,15 +159,16 @@ static void aspeed_soc_init(Object *obj)
>                                "max-ram-size", &error_abort);
> =20
>      for (i =3D 0; i < sc->info->wdts_num; i++) {
> -        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_W=
DT);
> -        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), N=
ULL);
> +        object_initialize_child(obj, "wdt[*]", &s->wdt[i], sizeof(s->w=
dt[i]),
> +                                TYPE_ASPEED_WDT, &error_abort, NULL);
>          qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>                                      sc->info->silicon_rev);
>      }
> =20
> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC=
100);
> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100),=
 NULL);
> +    object_initialize_child(obj, "ftgmac100", &s->ftgmac100,
> +                            sizeof(s->ftgmac100), TYPE_FTGMAC100,
> +                            &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
>  }
> =20
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.=
c
> index 6be7660e8c..0355a41d8b 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -41,8 +41,8 @@ static void bcm2835_peripherals_init(Object *obj)
>                         MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
> =20
>      /* Interrupt Controller */
> -    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
> -    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
> +    object_initialize_child(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM=
2835_IC,
> +                            &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
> =20
>      /* UART0 */
> @@ -51,21 +51,21 @@ static void bcm2835_peripherals_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
> =20
>      /* AUX / UART1 */
> -    object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
> -    object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
> +    object_initialize_child(obj, "aux", &s->aux, sizeof(s->aux),
> +                            TYPE_BCM2835_AUX, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
> =20
>      /* Mailboxes */
> -    object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX=
);
> -    object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
> +    object_initialize_child(obj, "mbox", &s->mboxes, sizeof(s->mboxes)=
,
> +                            TYPE_BCM2835_MBOX, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
> =20
>      object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
>                                     OBJECT(&s->mbox_mr), &error_abort);
> =20
>      /* Framebuffer */
> -    object_initialize(&s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
> -    object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
> +    object_initialize_child(obj, "fb", &s->fb, sizeof(s->fb), TYPE_BCM=
2835_FB,
> +                            &error_abort, NULL);
>      object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcra=
m-size",
>                                &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->fb), sysbus_get_default());
> @@ -74,8 +74,9 @@ static void bcm2835_peripherals_init(Object *obj)
>                                     OBJECT(&s->gpu_bus_mr), &error_abor=
t);
> =20
>      /* Property channel */
> -    object_initialize(&s->property, sizeof(s->property), TYPE_BCM2835_=
PROPERTY);
> -    object_property_add_child(obj, "property", OBJECT(&s->property), N=
ULL);
> +    object_initialize_child(obj, "property", &s->property,
> +                            sizeof(s->property), TYPE_BCM2835_PROPERTY=
,
> +                            &error_abort, NULL);
>      object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
>                                "board-rev", &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->property), sysbus_get_default());
> @@ -86,31 +87,31 @@ static void bcm2835_peripherals_init(Object *obj)
>                                     OBJECT(&s->gpu_bus_mr), &error_abor=
t);
> =20
>      /* Random Number Generator */
> -    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
> -    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
> +    object_initialize_child(obj, "rng", &s->rng, sizeof(s->rng),
> +                            TYPE_BCM2835_RNG, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
> =20
>      /* Extended Mass Media Controller */
> -    object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
> -    object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
> +    object_initialize_child(obj, "sdhci", &s->sdhci, sizeof(s->sdhci),
> +                            TYPE_SYSBUS_SDHCI, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
> =20
>      /* SDHOST */
> -    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHO=
ST);
> -    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL)=
;
> +    object_initialize_child(obj, "sdhost", &s->sdhost, sizeof(s->sdhos=
t),
> +                            TYPE_BCM2835_SDHOST, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
> =20
>      /* DMA Channels */
> -    object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
> -    object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
> +    object_initialize_child(obj, "dma", &s->dma, sizeof(s->dma),
> +                            TYPE_BCM2835_DMA, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
> =20
>      object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr), &error_abor=
t);
> =20
>      /* GPIO */
> -    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
> -    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
> +    object_initialize_child(obj, "gpio", &s->gpio, sizeof(s->gpio),
> +                            TYPE_BCM2835_GPIO, &error_abort, NULL);
>      qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
> =20
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",

Ack so far.

> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
> index 726abb9b48..14409ef080 100644
> --- a/hw/arm/digic.c
> +++ b/hw/arm/digic.c
> @@ -35,8 +35,8 @@ static void digic_init(Object *obj)
>      DeviceState *dev;
>      int i;
> =20
> -    object_initialize(&s->cpu, sizeof(s->cpu), "arm946-" TYPE_ARM_CPU)=
;
> -    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), NULL);
> +    object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
> +                            "arm946-" TYPE_ARM_CPU, &error_abort, NULL=
);
> =20
>      for (i =3D 0; i < DIGIC4_NB_TIMERS; i++) {
>  #define DIGIC_TIMER_NAME_MLEN    11
>=20

I think digic_init() needs some more manual tweaking. You can see two
more instances of object_initialize() + add_child() later in that
function, just with some code in between. That either needs to be
re-arranged a little bit, or we should add an object_unref() each time
at the end there.

Also there is one more spot in xlnx_zynqmp_create_rpu() in xlnx-zynqmp.c
that should also be fixed, I think.

Eduardo also listed the machine init functions last year:

 https://patchwork.ozlabs.org/patch/943333/#1953608

Do we want to fix them, too? I think it's currently not really necessary
there since we don't clean up machines anyway, but maybe it would still
be a good idea to avoid that people copy-n-paste bad code snippets...
Well, maybe something for a separate patch, at least.

 Thomas
