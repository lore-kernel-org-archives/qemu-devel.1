Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDoE-0007Hz-6Z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDo9-0004XN-Fj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:43:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPDo9-0004Vi-7e
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:43:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so3517840wrr.12
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:43:45 -0800 (PST)
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-2-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b623909-c4f1-e939-417d-b711e7ab8150@redhat.com>
Date: Tue, 20 Nov 2018 22:43:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-2-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/22] musicpal: Convert sysbus init
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, jan.kiszka@web.de, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19/11/18 13:07, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> mv88w8618_wlan_class_init().
> 
> Cc: jan.kiszka@web.de
> Cc: peter.maydell@linaro.org
> Cc: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/arm/musicpal.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 9648b3af44..7ffcdbb097 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1147,14 +1147,13 @@ static const MemoryRegionOps mv88w8618_wlan_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
>   
> -static int mv88w8618_wlan_init(SysBusDevice *dev)
> +static void mv88w8618_wlan_realize(DeviceState *dev, Error **errp)
>   {
>       MemoryRegion *iomem = g_new(MemoryRegion, 1);
>   
>       memory_region_init_io(iomem, OBJECT(dev), &mv88w8618_wlan_ops, NULL,
>                             "musicpal-wlan", MP_WLAN_SIZE);
> -    sysbus_init_mmio(dev, iomem);
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), iomem);
>   }
>   
>   /* GPIO register offsets */
> @@ -1720,9 +1719,9 @@ DEFINE_MACHINE("musicpal", musicpal_machine_init)
>   
>   static void mv88w8618_wlan_class_init(ObjectClass *klass, void *data)
>   {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    sdc->init = mv88w8618_wlan_init;
> +    dc->realize = mv88w8618_wlan_realize;
>   }
>   
>   static const TypeInfo mv88w8618_wlan_info = {
> 
