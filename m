Received: from eggs.gnu.org ([2001:4830:134:3::10]:53327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cgd6L-0003Hk-4D
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cgd6G-0004BP-Hy
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 15:01:25 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Wed, 22 Feb 2017 18:27:28 +0000
Message-ID: <DM5PR03MB2827C1EEB91C11DEF0FBE9D89E500@DM5PR03MB2827.namprd03.prod.outlook.com>
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
	<20170222112338.25492-4-clement.deschamps@antfield.fr>
In-Reply-To: <20170222112338.25492-4-clement.deschamps@antfield.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/3] bcm2835: add sdhost and gpio
 controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Hi,

> From: Clement Deschamps [mailto:clement.deschamps@antfield.fr]
> Sent: Wednesday, 22 February 2017 3:24
> Subject: [PATCH v2 3/3] bcm2835: add sdhost and gpio controllers
>=20
> This adds the bcm2835_sdhost and bcm2835_gpio to the BCM2835 platform.
>=20
> The bcm2835_gpio has a link to both the sdhci and sdhost controllers for
> supporting the alternate function of GPIOs 48-53 (SD controller selection=
)
>=20
> Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
[...]
> +    /* SDHOST */
> +    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &err)=
;
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->peri_mr, MMCI0_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhost), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhost), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> +                               INTERRUPT_SDIO));
> +    object_property_add_alias(OBJECT(s), "sd-bus-2", OBJECT(&s->sdhost),
> +                              "sd-bus", &err);

Is this alias still meaningful / needed, or is it a relic from the previous=
 version? Right now it doesn't appear to be used, and I'm thinking that if =
someone did try to use it (e.g. at the board level by connecting an SD card=
) then the new GPIO logic would allow swapping the two SD cards between the=
 two controllers, which doesn't sound like a faithful recreation of the har=
dware.

Otherwise,
Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>

Cheers,
Andrew
