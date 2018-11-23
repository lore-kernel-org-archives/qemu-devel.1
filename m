Received: from eggs.gnu.org ([2001:4830:134:3::10]:36075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDcB-0008Uk-AH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQDc7-00075L-4r
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:43:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQDc6-00073b-V7
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:43:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so7126527wrr.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:43:26 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-6-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb7b4280-b717-47d3-8821-b24c977f5292@redhat.com>
Date: Fri, 23 Nov 2018 16:43:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-6-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/21] display/g364fb: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, alistair.francis@wdc.com, kraxel@redhat.com, pbonzini@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> g364fb_sysbus_class_init().
> 
> Cc: pbonzini@redhat.com
> Cc: kraxel@redhat.com
> Cc: f4bug@amsat.org
> Cc: alistair.francis@wdc.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/display/g364fb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index 8ad7e5d824..3407adf98d 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -489,18 +489,16 @@ typedef struct {
>      G364State g364;
>  } G364SysBusState;
>  
> -static int g364fb_sysbus_init(SysBusDevice *sbd)
> +static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
>      G364SysBusState *sbs = G364(dev);
>      G364State *s = &sbs->g364;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>  
>      g364fb_init(dev, s);
>      sysbus_init_irq(sbd, &s->irq);
>      sysbus_init_mmio(sbd, &s->mem_ctrl);
>      sysbus_init_mmio(sbd, &s->mem_vram);
> -
> -    return 0;
>  }
>  
>  static void g364fb_sysbus_reset(DeviceState *d)
> @@ -518,9 +516,8 @@ static Property g364fb_sysbus_properties[] = {
>  static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = g364fb_sysbus_init;
> +    dc->realize = g364fb_sysbus_realize;
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      dc->desc = "G364 framebuffer";
>      dc->reset = g364fb_sysbus_reset;
> 
