Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDXq-0000D2-Lw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDXm-0005sg-W1
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPDXl-0005oh-R2
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so3710460wmc.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:26:49 -0800 (PST)
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-7-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09b5cdf9-f79a-58f6-2ccf-ae8066e957eb@redhat.com>
Date: Tue, 20 Nov 2018 22:26:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-7-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/22] dma/puv3_dma: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19/11/18 13:08, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> puv3_dma_class_init().
> 
> Cc: gxt@mprc.pku.edu.cn
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/dma/puv3_dma.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
> index b97a6c1767..c89eade029 100644
> --- a/hw/dma/puv3_dma.c
> +++ b/hw/dma/puv3_dma.c
> @@ -76,7 +76,7 @@ static const MemoryRegionOps puv3_dma_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   
> -static int puv3_dma_init(SysBusDevice *dev)
> +static void puv3_dma_realize(DeviceState *dev, Error **errp)
>   {
>       PUV3DMAState *s = PUV3_DMA(dev);
>       int i;
> @@ -87,16 +87,14 @@ static int puv3_dma_init(SysBusDevice *dev)
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &puv3_dma_ops, s, "puv3_dma",
>               PUV3_REGS_OFFSET);
> -    sysbus_init_mmio(dev, &s->iomem);
> -
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>   }
>   
>   static void puv3_dma_class_init(ObjectClass *klass, void *data)
>   {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    sdc->init = puv3_dma_init;
> +    dc->realize = puv3_dma_realize;
>   }
>   
>   static const TypeInfo puv3_dma_info = {
> 
