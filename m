Received: from eggs.gnu.org ([2001:4830:134:3::10]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDXE-0003Iq-Vx
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDXB-0006iH-Rx
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:38:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQDXB-0006g5-Ly
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:38:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so9276289wrw.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:38:21 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-4-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c3f7039-b78b-69c6-8e80-482b4c177c57@redhat.com>
Date: Fri, 23 Nov 2018 16:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-4-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/21] char/grlib_apbuart: Convert
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
Cc: marcandre.lureau@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, chouteau@adacore.com, pbonzini@redhat.com

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> grlib_apbuart_class_init().
> 
> Cc: chouteau@adacore.com
> Cc: marcandre.lureau@redhat.com
> Cc: pbonzini@redhat.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/char/grlib_apbuart.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index bac11bec58..e1d258b611 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -239,9 +239,10 @@ static const MemoryRegionOps grlib_apbuart_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static int grlib_apbuart_init(SysBusDevice *dev)
> +static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
>  {
>      UART *uart = GRLIB_APB_UART(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      qemu_chr_fe_set_handlers(&uart->chr,
>                               grlib_apbuart_can_receive,
> @@ -249,14 +250,12 @@ static int grlib_apbuart_init(SysBusDevice *dev)
>                               grlib_apbuart_event,
>                               NULL, uart, NULL, true);
>  
> -    sysbus_init_irq(dev, &uart->irq);
> +    sysbus_init_irq(sbd, &uart->irq);
>  
>      memory_region_init_io(&uart->iomem, OBJECT(uart), &grlib_apbuart_ops, uart,
>                            "uart", UART_REG_SIZE);
>  
> -    sysbus_init_mmio(dev, &uart->iomem);
> -
> -    return 0;
> +    sysbus_init_mmio(sbd, &uart->iomem);
>  }
>  
>  static void grlib_apbuart_reset(DeviceState *d)
> @@ -280,9 +279,8 @@ static Property grlib_apbuart_properties[] = {
>  static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = grlib_apbuart_init;
> +    dc->realize = grlib_apbuart_realize;
>      dc->reset = grlib_apbuart_reset;
>      dc->props = grlib_apbuart_properties;
>  }
> 
