Received: from eggs.gnu.org ([2001:4830:134:3::10]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLSw-00011C-83
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLSs-0004CS-E5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLSr-0004Bt-Ta
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:19:14 -0500
Date: Mon, 10 Dec 2018 14:19:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210131911.lksvsw6l32areotp@sirius.home.kraxel.org>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
	<20181130093852.20739-20-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130093852.20739-20-maozhongyi@cmss.chinamobile.com>
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
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, Nov 30, 2018 at 05:38:50PM +0800, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> tusb6010_class_init().
> 
> Cc: kraxel@redhat.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

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
> -- 
> 2.17.1
> 
> 
> 
