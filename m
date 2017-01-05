Received: from eggs.gnu.org ([2001:4830:134:3::10]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP9ga-0003hR-Cj
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP9gZ-0005h6-HN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:10:36 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP9gZ-0005h0-AC
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:10:35 -0500
Received: by mail-ua0-x229.google.com with SMTP id 34so340885292uac.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 07:10:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161225082559.2095-1-zxq_yx_007@163.com>
References: <20161225082559.2095-1-zxq_yx_007@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 15:10:14 +0000
Message-ID: <CAFEAcA8Tkxye4Qy3Oi5nPjgcJF_Jv9vOdHjiytP_DdFdEfk=bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/display: QOM'ify g364fb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 December 2016 at 08:25, xiaoqiang zhao <zxq_yx_007@163.com> wrote:
> Drop the old Sysbus init and use instance_init and
> DeviceClass::realize instead
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  hw/display/g364fb.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index 70ef2c7453..7a0fe48dd5 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -504,18 +504,24 @@ typedef struct {
>      G364State g364;
>  } G364SysBusState;
>
> -static int g364fb_sysbus_init(SysBusDevice *sbd)
> +static void g364fb_sysbus_init(Object *obj)

This isn't a sysbus init function any more, so we should
rename it. Since the existing g364fb_init() is only
called from one place, we should just inline its
contents into the right places, and have one function
364fb_init for the instance_init and g364fb_realize
for the realize function.

>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      DeviceState *dev =3D DEVICE(sbd);
>      G364SysBusState *sbs =3D G364(dev);
>      G364State *s =3D &sbs->g364;
>
> -    g364fb_init(dev, s);
>      sysbus_init_irq(sbd, &s->irq);
>      sysbus_init_mmio(sbd, &s->mem_ctrl);
>      sysbus_init_mmio(sbd, &s->mem_vram);

This means we call sysbus_init_mmio() on the MemoryRegion*s
before we have initialized them. That seems like a bad idea.

> +}
>
> -    return 0;
> +static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
> +{
> +    G364SysBusState *sbs =3D G364(dev);
> +    G364State *s =3D &sbs->g364;
> +
> +    g364fb_init(dev, s);
>  }
>
>  static void g364fb_sysbus_reset(DeviceState *d)
> @@ -534,9 +540,8 @@ static Property g364fb_sysbus_properties[] =3D {
>  static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init =3D g364fb_sysbus_init;
> +    dc->realize =3D g364fb_sysbus_realize;
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>      dc->desc =3D "G364 framebuffer";
>      dc->reset =3D g364fb_sysbus_reset;
> @@ -548,6 +553,7 @@ static const TypeInfo g364fb_sysbus_info =3D {
>      .name          =3D TYPE_G364,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(G364SysBusState),
> +    .instance_init =3D g364fb_sysbus_init,
>      .class_init    =3D g364fb_sysbus_class_init,
>  };

This device is used in the MIPS Jazz machine.
Can you cc the MIPS maintainers and also Herv=C3=A9 Poussineau
(the Jazz maintainer) on the next version of this patch,
please?

thanks
-- PMM
