Received: from eggs.gnu.org ([2001:4830:134:3::10]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDX1-00080C-Bq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDWy-0004Mb-4d
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPDWx-0004G9-QK
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so3486299wrs.8
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:25:54 -0800 (PST)
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-5-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7169f329-4eee-de9c-a4b8-ff167b0f7f82@redhat.com>
Date: Tue, 20 Nov 2018 22:25:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-5-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/22] core/empty_slot: Convert sysbus init
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
Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19/11/18 13:08, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> empty_slot_class_init().
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/core/empty_slot.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
> index c1b9c2b104..239f78e2a7 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/core/empty_slot.c
> @@ -71,21 +71,20 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
>       }
>   }
>   
> -static int empty_slot_init1(SysBusDevice *dev)
> +static void empty_slot_realize(DeviceState *dev, Error **errp)
>   {
>       EmptySlot *s = EMPTY_SLOT(dev);
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
>                             "empty-slot", s->size);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>   }
>   
>   static void empty_slot_class_init(ObjectClass *klass, void *data)
>   {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    k->init = empty_slot_init1;
> +    dc->realize = empty_slot_realize;
>   }
>   
>   static const TypeInfo empty_slot_info = {
> 
