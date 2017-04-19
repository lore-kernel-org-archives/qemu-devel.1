Received: from eggs.gnu.org ([2001:4830:134:3::10]:36758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1d0pbp-0005J1-Tu
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1d0pbo-00064p-JU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:25:25 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1d0pbo-00064J-Cs
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:25:24 -0400
Received: by mail-it0-x242.google.com with SMTP id a140so2812100ita.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 06:25:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170415180316.2694-1-shah.suramya@gmail.com>
References: <20170415180316.2694-1-shah.suramya@gmail.com>
From: Suramya Shah <shah.suramya@gmail.com>
Date: Wed, 19 Apr 2017 18:55:22 +0530
Message-ID: <CABH=oPxjEROn-5m9cksJaN-VvL6BEmHeP-qTg2Tzuce9OhSXyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Qomify pxa2xx.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

On 15-Apr-2017 11:34 PM, "Suramya Shah" <shah.suramya@gmail.com> wrote:

> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/arm/pxa2xx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index cfee392..eea551d 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -755,19 +755,18 @@ static void pxa2xx_ssp_reset(DeviceState *d)
>      s->rx_start = s->rx_level = 0;
>  }
>
> -static int pxa2xx_ssp_init(SysBusDevice *sbd)
> +static void pxa2xx_ssp_init(Object *obj)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> -    PXA2xxSSPState *s = PXA2XX_SSP(dev);
> -
> +    DeviceState *dev = DEVICE(obj);
> +    PXA2xxSSPState *s = PXA2XX_SSP(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      sysbus_init_irq(sbd, &s->irq);
>
> -    memory_region_init_io(&s->iomem, OBJECT(s), &pxa2xx_ssp_ops, s,
> +    memory_region_init_io(&s->iomem, obj, &pxa2xx_ssp_ops, s,
>                            "pxa2xx-ssp", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>
>      s->bus = ssi_create_bus(dev, "ssi");
> -    return 0;
>  }
>
>  /* Real-Time Clock */
> @@ -2321,10 +2320,8 @@ PXA2xxState *pxa255_init(MemoryRegion
> *address_space, unsigned int sdram_size)
>
>  static void pxa2xx_ssp_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> -    sdc->init = pxa2xx_ssp_init;
>      dc->reset = pxa2xx_ssp_reset;
>      dc->vmsd = &vmstate_pxa2xx_ssp;
>  }
> @@ -2333,6 +2330,7 @@ static const TypeInfo pxa2xx_ssp_info = {
>      .name          = TYPE_PXA2XX_SSP,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(PXA2xxSSPState),
> +    .instance_init = pxa2xx_ssp_init,
>      .class_init    = pxa2xx_ssp_class_init,
>  };
>
> --
> 2.9.3
>
>
