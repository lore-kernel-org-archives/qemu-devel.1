Received: from eggs.gnu.org ([2001:4830:134:3::10]:54470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEOu-0006Xw-P6
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEOr-0000iI-JB
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:33:52 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134]:39283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gQEOr-0000go-BC
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:33:49 -0500
Received: by mail-lf1-x134.google.com with SMTP id n18so9094256lfh.6
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:33:49 -0800 (PST)
Date: Fri, 23 Nov 2018 17:33:45 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181123163345.GK1148@toto>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-17-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123153040.18933-17-maozhongyi@cmss.chinamobile.com>
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
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, Nov 23, 2018 at 11:30:35PM +0800, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> etraxfs_timer_class_init().
> 
> Cc: edgar.iglesias@gmail.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


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
> -- 
> 2.17.1
> 
> 
> 
