Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52bX-0002d1-I4
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52bW-0007Vs-OY
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:38:47 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:51462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e52bW-0007Vl-Jk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:38:46 -0400
Received: by mail-qt0-x241.google.com with SMTP id h4so12985928qtk.8
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 21:38:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-7-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2fc668f-8c7f-1527-d40c-864c5f6a1ec7@amsat.org>
Date: Thu, 19 Oct 2017 01:38:43 -0300
MIME-Version: 1.0
In-Reply-To: <1508006342-5304-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 06/13] sparc32_dma: use object link
 instead of qdev property to pass IOMMU reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/14/2017 03:38 PM, Mark Cave-Ayland wrote:
> This enables us to remove the last remaining (opaque) qdev property. Whilst we
> are here, also update iommu_init() to use TYPE_SUN4M_IOMMU instead of a
> hardcoded string.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c |   13 +++++--------
>  hw/sparc/sun4m.c     |    4 ++--
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index ae8fa06..c56a2ba 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -263,24 +263,21 @@ static void sparc32_dma_device_init(Object *obj)
>  
>      sysbus_init_mmio(sbd, &s->iomem);
>  
> +    object_property_add_link(OBJECT(dev), "iommu", TYPE_SUN4M_IOMMU,
> +                             (Object **) &s->iommu,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, NULL);
> +
>      qdev_init_gpio_in(dev, dma_set_irq, 1);
>      qdev_init_gpio_out(dev, s->gpio, 2);
>  }
>  
> -static Property sparc32_dma_device_properties[] = {
> -    DEFINE_PROP_PTR("iommu_opaque", DMADeviceState, iommu),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->reset = sparc32_dma_device_reset;
>      dc->vmsd = &vmstate_sparc32_dma_device;
> -    dc->props = sparc32_dma_device_properties;
> -    /* Reason: pointer property "iommu_opaque" */
> -    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo sparc32_dma_device_info = {
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 4f2ed4b..12d36b5 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -297,7 +297,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>      DeviceState *dev;
>      SysBusDevice *s;
>  
> -    dev = qdev_create(NULL, "iommu");
> +    dev = qdev_create(NULL, TYPE_SUN4M_IOMMU);
>      qdev_prop_set_uint32(dev, "version", version);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
> @@ -313,7 +313,7 @@ static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
>      SysBusDevice *s;
>  
>      dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
> -    qdev_prop_set_ptr(dev, "iommu_opaque", iommu);
> +    object_property_set_link(OBJECT(dev), OBJECT(iommu), "iommu", &error_abort);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(s, 0, daddr);
> 
