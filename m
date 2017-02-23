Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgimu-0001QU-8v
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgimq-0006sF-UQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:05:44 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgimq-0006s0-Pn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:05:40 -0500
Received: by mail-qk0-x244.google.com with SMTP id x71so3054813qkb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:05:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
	<20170205133727.23424-4-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1edab58f-9806-587e-d814-110e650a442a@amsat.org>
Date: Wed, 22 Feb 2017 23:05:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170205133727.23424-4-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND PATCH 3/9] hw/dma: QOM'ify sun4m_iommu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, peter.maydell@linaro.org

On 02/05/2017 10:37 AM, xiaoqiang zhao wrote:
> Drop the old SysBus init function and use instance_init
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sun4m_iommu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
> index b3cbc54c23..335ef63cbc 100644
> --- a/hw/dma/sun4m_iommu.c
> +++ b/hw/dma/sun4m_iommu.c
> @@ -349,17 +349,16 @@ static void iommu_reset(DeviceState *d)
>      s->regs[IOMMU_MASK_ID] = IOMMU_TS_MASK;
>  }
>
> -static int iommu_init1(SysBusDevice *dev)
> +static void iommu_init(Object *obj)
>  {
> -    IOMMUState *s = SUN4M_IOMMU(dev);
> +    IOMMUState *s = SUN4M_IOMMU(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>
>      sysbus_init_irq(dev, &s->irq);
>
> -    memory_region_init_io(&s->iomem, OBJECT(s), &iommu_mem_ops, s, "iommu",
> +    memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
>                            IOMMU_NREGS * sizeof(uint32_t));
>      sysbus_init_mmio(dev, &s->iomem);
> -
> -    return 0;
>  }
>
>  static Property iommu_properties[] = {
> @@ -370,9 +369,7 @@ static Property iommu_properties[] = {
>  static void iommu_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = iommu_init1;
>      dc->reset = iommu_reset;
>      dc->vmsd = &vmstate_iommu;
>      dc->props = iommu_properties;
> @@ -382,6 +379,7 @@ static const TypeInfo iommu_info = {
>      .name          = TYPE_SUN4M_IOMMU,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(IOMMUState),
> +    .instance_init = iommu_init,
>      .class_init    = iommu_class_init,
>  };
>
>
