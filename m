Received: from eggs.gnu.org ([2001:4830:134:3::10]:34582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDYw-0005OC-OU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDYq-0002EK-FH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:40:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQDYq-0002Bu-8L
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:40:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so12773159wrw.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:40:04 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-10-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d201235-0fbb-cf12-c002-7c6114d59926@redhat.com>
Date: Fri, 23 Nov 2018 16:40:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-10-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/21] input/pl050: Convert sysbus init
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> pl050_class_init().
> 
> Cc: peter.maydell@linaro.org
> Cc: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/input/pl050.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/input/pl050.c b/hw/input/pl050.c
> index be9cd57b17..15bffbfcad 100644
> --- a/hw/input/pl050.c
> +++ b/hw/input/pl050.c
> @@ -139,19 +139,19 @@ static const MemoryRegionOps pl050_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static int pl050_initfn(SysBusDevice *dev)
> +static void pl050_realize(DeviceState *dev, Error **errp)
>  {
>      PL050State *s = PL050(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &pl050_ops, s, "pl050", 0x1000);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    sysbus_init_irq(dev, &s->irq);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
>      if (s->is_mouse) {
>          s->dev = ps2_mouse_init(pl050_update, s);
>      } else {
>          s->dev = ps2_kbd_init(pl050_update, s);
>      }
> -    return 0;
>  }
>  
>  static void pl050_keyboard_init(Object *obj)
> @@ -183,9 +183,8 @@ static const TypeInfo pl050_mouse_info = {
>  static void pl050_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(oc);
>  
> -    sdc->init = pl050_initfn;
> +    dc->realize = pl050_realize;
>      dc->vmsd = &vmstate_pl050;
>  }
>  
> 
