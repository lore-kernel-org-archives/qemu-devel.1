Received: from eggs.gnu.org ([2001:4830:134:3::10]:59685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDa1-0002lq-BT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPDZy-0001LM-7H
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPDZx-0001Iz-VV
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:29:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so3523415wrw.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 13:29:05 -0800 (PST)
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-12-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <85777add-a6e5-2ca6-19d2-9a24ad4d2cbe@redhat.com>
Date: Tue, 20 Nov 2018 22:29:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-12-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/22] milkymist-hpdmc: Convert sysbus init
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
Cc: michael@walle.cc, gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 19/11/18 13:08, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> milkymist_hpdmc_class_init().
> 
> Cc: gxt@mprc.pku.edu.cn
> Cc: michael@walle.cc
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>   hw/intc/puv3_intc.c       | 1 +
>   hw/misc/milkymist-hpdmc.c | 9 +++------
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
> index dfef505c47..a3ca6d466b 100644
> --- a/hw/intc/puv3_intc.c
> +++ b/hw/intc/puv3_intc.c
> @@ -119,6 +119,7 @@ static void puv3_intc_realize(DeviceState *dev, Error **errp)
>   static void puv3_intc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +

This change isn't related to milkymist-hpdmc (subject of your patch).

Except that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>       dc->realize = puv3_intc_realize;
>   }
>   
> diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
> index e6140eec6b..44dc0698ec 100644
> --- a/hw/misc/milkymist-hpdmc.c
> +++ b/hw/misc/milkymist-hpdmc.c
> @@ -129,15 +129,13 @@ static void milkymist_hpdmc_reset(DeviceState *d)
>                            | IODELAY_PLL2_LOCKED;
>   }
>   
> -static int milkymist_hpdmc_init(SysBusDevice *dev)
> +static void milkymist_hpdmc_realize(DeviceState *dev, Error **errp)
>   {
>       MilkymistHpdmcState *s = MILKYMIST_HPDMC(dev);
>   
>       memory_region_init_io(&s->regs_region, OBJECT(dev), &hpdmc_mmio_ops, s,
>               "milkymist-hpdmc", R_MAX * 4);
> -    sysbus_init_mmio(dev, &s->regs_region);
> -
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->regs_region);
>   }
>   
>   static const VMStateDescription vmstate_milkymist_hpdmc = {
> @@ -153,9 +151,8 @@ static const VMStateDescription vmstate_milkymist_hpdmc = {
>   static void milkymist_hpdmc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>   
> -    k->init = milkymist_hpdmc_init;
> +    dc->realize = milkymist_hpdmc_realize;
>       dc->reset = milkymist_hpdmc_reset;
>       dc->vmsd = &vmstate_milkymist_hpdmc;
>   }
> 
