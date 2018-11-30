Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gShW7-0001dm-NC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gShW1-0004p9-N1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gShW1-0004oQ-G0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:03:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so5041537wrs.3
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 04:03:25 -0800 (PST)
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
	<20181130093852.20739-20-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18506233-17cd-27cc-6d95-8a71e0e7ae22@redhat.com>
Date: Fri, 30 Nov 2018 13:03:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181130093852.20739-20-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/21] usb/tusb6010: Convert sysbus init
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
Cc: kraxel@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 30/11/18 10:38, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> tusb6010_class_init().
> 
> Cc: kraxel@redhat.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/tusb6010.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
> index a2128024c1..501706e2b2 100644
> --- a/hw/usb/tusb6010.c
> +++ b/hw/usb/tusb6010.c
> @@ -808,10 +808,10 @@ static void tusb6010_reset(DeviceState *dev)
>      musb_reset(s->musb);
>  }
>  
> -static int tusb6010_init(SysBusDevice *sbd)
> +static void tusb6010_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
>      TUSBState *s = TUSB(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      s->otg_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_otg_tick, s);
>      s->pwr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_power_tick, s);
> @@ -822,15 +822,13 @@ static int tusb6010_init(SysBusDevice *sbd)
>      sysbus_init_irq(sbd, &s->irq);
>      qdev_init_gpio_in(dev, tusb6010_irq, musb_irq_max + 1);
>      s->musb = musb_init(dev, 1);
> -    return 0;
>  }
>  
>  static void tusb6010_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = tusb6010_init;
> +    dc->realize = tusb6010_realize;
>      dc->reset = tusb6010_reset;
>  }
>  
> 
