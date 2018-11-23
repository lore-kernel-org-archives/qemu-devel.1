Received: from eggs.gnu.org ([2001:4830:134:3::10]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDaA-0006d9-KQ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDa6-0004E5-AI
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:41:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQDa5-0004CH-Vt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:41:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so12420106wmd.3
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:41:21 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-18-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0163b6b-a66f-53ed-24c8-1e5f6e0ae8f5@redhat.com>
Date: Fri, 23 Nov 2018 16:41:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-18-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 17/21] timer/grlib_gptimer: Convert
 sysbus init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: chouteau@adacore.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> grlib_gptimer_class_init().
> 
> Cc: chouteau@adacore.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/timer/grlib_gptimer.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
> index 4ed96e970a..183eddc073 100644
> --- a/hw/timer/grlib_gptimer.c
> +++ b/hw/timer/grlib_gptimer.c
> @@ -347,10 +347,11 @@ static void grlib_gptimer_reset(DeviceState *d)
>      }
>  }
>  
> -static int grlib_gptimer_init(SysBusDevice *dev)
> +static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
>  {
>      GPTimerUnit  *unit = GRLIB_GPTIMER(dev);
>      unsigned int  i;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      assert(unit->nr_timers > 0);
>      assert(unit->nr_timers <= GPTIMER_MAX_TIMERS);
> @@ -366,7 +367,7 @@ static int grlib_gptimer_init(SysBusDevice *dev)
>          timer->id     = i;
>  
>          /* One IRQ line for each timer */
> -        sysbus_init_irq(dev, &timer->irq);
> +        sysbus_init_irq(sbd, &timer->irq);
>  
>          ptimer_set_freq(timer->ptimer, unit->freq_hz);
>      }
> @@ -375,8 +376,7 @@ static int grlib_gptimer_init(SysBusDevice *dev)
>                            unit, "gptimer",
>                            UNIT_REG_SIZE + GPTIMER_REG_SIZE * unit->nr_timers);
>  
> -    sysbus_init_mmio(dev, &unit->iomem);
> -    return 0;
> +    sysbus_init_mmio(sbd, &unit->iomem);
>  }
>  
>  static Property grlib_gptimer_properties[] = {
> @@ -389,9 +389,8 @@ static Property grlib_gptimer_properties[] = {
>  static void grlib_gptimer_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = grlib_gptimer_init;
> +    dc->realize = grlib_gptimer_realize;
>      dc->reset = grlib_gptimer_reset;
>      dc->props = grlib_gptimer_properties;
>  }
> 
