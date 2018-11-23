Received: from eggs.gnu.org ([2001:4830:134:3::10]:54210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQENw-0005E6-ME
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQENt-0007Hu-G6
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:32:52 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQENt-0007Gt-AP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:32:49 -0500
Received: by mail-wr1-f46.google.com with SMTP id x10so12907927wrs.8
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:32:49 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-17-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e9d4cd2-042f-5431-8d89-f77464d0d119@redhat.com>
Date: Fri, 23 Nov 2018 17:32:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-17-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/21] timer/etraxfs_timer: Convert
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
Cc: edgar.iglesias@gmail.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> etraxfs_timer_class_init().
> 
> Cc: edgar.iglesias@gmail.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/timer/etraxfs_timer.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
> index d13bc30b2d..2280914b1d 100644
> --- a/hw/timer/etraxfs_timer.c
> +++ b/hw/timer/etraxfs_timer.c
> @@ -315,9 +315,10 @@ static void etraxfs_timer_reset(void *opaque)
>      qemu_irq_lower(t->irq);
>  }
>  
> -static int etraxfs_timer_init(SysBusDevice *dev)
> +static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
>  {
>      ETRAXTimerState *t = ETRAX_TIMER(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      t->bh_t0 = qemu_bh_new(timer0_hit, t);
>      t->bh_t1 = qemu_bh_new(timer1_hit, t);
> @@ -326,21 +327,20 @@ static int etraxfs_timer_init(SysBusDevice *dev)
>      t->ptimer_t1 = ptimer_init(t->bh_t1, PTIMER_POLICY_DEFAULT);
>      t->ptimer_wd = ptimer_init(t->bh_wd, PTIMER_POLICY_DEFAULT);
>  
> -    sysbus_init_irq(dev, &t->irq);
> -    sysbus_init_irq(dev, &t->nmi);
> +    sysbus_init_irq(sbd, &t->irq);
> +    sysbus_init_irq(sbd, &t->nmi);
>  
>      memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
>                            "etraxfs-timer", 0x5c);
> -    sysbus_init_mmio(dev, &t->mmio);
> +    sysbus_init_mmio(sbd, &t->mmio);
>      qemu_register_reset(etraxfs_timer_reset, t);
> -    return 0;
>  }
>  
>  static void etraxfs_timer_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    sdc->init = etraxfs_timer_init;
> +    dc->realize = etraxfs_timer_realize;
>  }
>  
>  static const TypeInfo etraxfs_timer_info = {
> 
