Received: from eggs.gnu.org ([2001:4830:134:3::10]:48128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gP9cD-0007Ra-EI
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gP9c6-0001wz-NW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:15:09 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gP9c6-0001vX-Ek
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:15:02 -0500
Received: by mail-lj1-x242.google.com with SMTP id l15-v6so2311486lja.9
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 09:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-6-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-6-maozhongyi@cmss.chinamobile.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 09:14:33 -0800
Message-ID: <CAKmqyKNpo9+7Urge15NKWa=agiWohfgjLEX5GfxMgNDR1pgA4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/22] display/g364fb: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozhongyi@cmss.chinamobile.com
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, zhangshengju@cmss.chinamobile.com

On Mon, Nov 19, 2018 at 4:28 AM Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/g364fb.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index 8ad7e5d824..e7f67088b0 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -489,18 +489,15 @@ typedef struct {
>      G364State g364;
>  } G364SysBusState;
>
> -static int g364fb_sysbus_init(SysBusDevice *sbd)
> +static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
>      G364SysBusState *sbs = G364(dev);
>      G364State *s = &sbs->g364;
>
>      g364fb_init(dev, s);
> -    sysbus_init_irq(sbd, &s->irq);
> -    sysbus_init_mmio(sbd, &s->mem_ctrl);
> -    sysbus_init_mmio(sbd, &s->mem_vram);
> -
> -    return 0;
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem_ctrl);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem_vram);
>  }
>
>  static void g364fb_sysbus_reset(DeviceState *d)
> @@ -518,9 +515,8 @@ static Property g364fb_sysbus_properties[] = {
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
> --
> 2.17.1
>
>
>
>
