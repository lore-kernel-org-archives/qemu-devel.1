Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDae-0003Jb-8B
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDaa-0002IH-Qu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPDaa-0002EM-F9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so3736507wmc.4
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:29:43 -0800 (PST)
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-14-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29ae8070-69ed-fc41-63f5-e9923acbec4f@redhat.com>
Date: Tue, 20 Nov 2018 22:29:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-14-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/22] puv3_pm.c: Convert sysbus init
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
> puv3_pm_class_init().
> 
> Cc: gxt@mprc.pku.edu.cn
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/misc/puv3_pm.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
> index 577cebaac7..afe191fbe1 100644
> --- a/hw/misc/puv3_pm.c
> +++ b/hw/misc/puv3_pm.c
> @@ -119,7 +119,7 @@ static const MemoryRegionOps puv3_pm_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   
> -static int puv3_pm_init(SysBusDevice *dev)
> +static void puv3_pm_realize(DeviceState *dev, Error **errp)
>   {
>       PUV3PMState *s = PUV3_PM(dev);
>   
> @@ -127,16 +127,14 @@ static int puv3_pm_init(SysBusDevice *dev)
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &puv3_pm_ops, s, "puv3_pm",
>               PUV3_REGS_OFFSET);
> -    sysbus_init_mmio(dev, &s->iomem);
> -
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>   }
>   
>   static void puv3_pm_class_init(ObjectClass *klass, void *data)
>   {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    sdc->init = puv3_pm_init;
> +    dc->realize = puv3_pm_realize;
>   }
>   
>   static const TypeInfo puv3_pm_info = {
> 
