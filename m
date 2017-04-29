Received: from eggs.gnu.org ([2001:4830:134:3::10]:60946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqw-00039w-7l
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqt-0007v1-5r
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqt-0007us-1P
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id y33so12785222qta.1
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:28:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-3-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c1dfd93e-5f8e-7cdc-861d-5332b5eb08f7@amsat.org>
Date: Sat, 29 Apr 2017 19:28:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-3-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/9] hw/dma: QOM'ify sparc32_dma.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 04/29/2017 07:49 AM, xiaoqiang zhao wrote:
> Drop the old SysBus init function and use instance_init
> and an realize function
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 9d545e412e..ef4c6a93c8 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -270,23 +270,28 @@ static const VMStateDescription vmstate_dma = {
>      }
>  };
>
> -static int sparc32_dma_init1(SysBusDevice *sbd)
> +static void sparc32_dma_init(Object *obj)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> -    DMAState *s = SPARC32_DMA(dev);
> -    int reg_size;
> +    DeviceState *dev = DEVICE(obj);
> +    DMAState *s = SPARC32_DMA(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>
>      sysbus_init_irq(sbd, &s->irq);
>
> -    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
> -    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
> -                          "dma", reg_size);
>      sysbus_init_mmio(sbd, &s->iomem);
>
>      qdev_init_gpio_in(dev, dma_set_irq, 1);
>      qdev_init_gpio_out(dev, s->gpio, 2);
> +}
>
> -    return 0;
> +static void sparc32_dma_realize(DeviceState *dev, Error **errp)
> +{
> +    DMAState *s = SPARC32_DMA(dev);
> +    int reg_size;
> +
> +    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &dma_mem_ops, s,
> +                          "dma", reg_size);
>  }
>
>  static Property sparc32_dma_properties[] = {
> @@ -298,12 +303,11 @@ static Property sparc32_dma_properties[] = {
>  static void sparc32_dma_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = sparc32_dma_init1;
>      dc->reset = dma_reset;
>      dc->vmsd = &vmstate_dma;
>      dc->props = sparc32_dma_properties;
> +    dc->realize = sparc32_dma_realize;
>      /* Reason: pointer property "iommu_opaque" */
>      dc->cannot_instantiate_with_device_add_yet = true;
>  }
> @@ -312,6 +316,7 @@ static const TypeInfo sparc32_dma_info = {
>      .name          = TYPE_SPARC32_DMA,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(DMAState),
> +    .instance_init = sparc32_dma_init,
>      .class_init    = sparc32_dma_class_init,
>  };
>
>
