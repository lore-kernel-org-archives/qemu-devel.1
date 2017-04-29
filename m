Received: from eggs.gnu.org ([2001:4830:134:3::10]:60966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4ar2-0003Ca-Kz
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4ar1-0007vl-Q2
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4ar1-0007ve-MR
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:39 -0400
Received: by mail-qt0-x242.google.com with SMTP id y33so12785554qta.1
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:28:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-4-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e76d2be4-3b20-af24-9a11-a4f3531ee182@amsat.org>
Date: Sat, 29 Apr 2017 19:28:35 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-4-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/9] hw/dma: QOM'ify sun4m_iommu.c
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
