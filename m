Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIU4-0004HN-DQ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIU3-0003LM-6U
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:12:24 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZIU3-0003JT-0U
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:12:23 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so13111805otj.0
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 09:12:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630083357.23489-2-huth@tuxfamily.org>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<20180630083357.23489-2-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 17:12:01 +0100
Message-ID: <CAFEAcA8n_qgGgtn055dGkAjHNPbE9d-dRDtfJGMcfhBg_x_Y5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/4] m68k: Add NeXTcube framebuffer
 device emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

On 30 June 2018 at 09:33, Thomas Huth <huth@tuxfamily.org> wrote:
> The NeXTcube uses a linear framebuffer with 4 greyscale colors and
> a fixed resolution of 1120 * 832.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
>
> and altered to fit the latest interface of the current QEMU (e.g.
> the device has been "qdev"-ified etc.).
>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

> +static void nextfb_realize(DeviceState *dev, Error **errp)
> +{
> +    NeXTFbState *s = NEXTFB(dev);
> +
> +    memory_region_allocate_system_memory(&s->fb_mr, NULL, "next.video",
> +                                         0x1CB100);

memory_region_allocate_system_memory() is for allocating
a machine model's main memory, not for things like video
framebuffer RAM. (See the doc comment in memory.h.)

> +    memory_region_add_subregion(get_system_memory(), 0xB000000, &s->fb_mr);

Devices shouldn't directly add memory regions into
system memory. Instead they should expose sysbus
memory regions which the board model then maps into
the right place.

> +
> +    s->invalidate = 1;
> +    s->cols = 1120;
> +    s->rows = 832;
> +
> +    s->con = graphic_console_init(dev, 0, &nextfb_ops, s);
> +    qemu_console_resize(s->con, s->cols, s->rows);
> +}
> +
> +static void nextfb_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    dc->realize = nextfb_realize;

Worth having at least a comment to say this device has
no mutable state and so needs no reset function or
vmstate.

> +}
> +
> +static const TypeInfo nextfb_info = {
> +    .name          = TYPE_NEXTFB,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(NeXTFbState),
> +    .class_init    = nextfb_class_init,
> +};
> +
> +static void nextfb_register_types(void)
> +{
> +    type_register_static(&nextfb_info);
> +}
> +
> +type_init(nextfb_register_types)
> +
> +void nextfb_init(void)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create(NULL, TYPE_NEXTFB);
> +    qdev_init_nofail(dev);
> +}

This is so simple it's not really worth having, I think.
Just have the board model code create the device...

> diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
> new file mode 100644
> index 0000000000..cf07243bda
> --- /dev/null
> +++ b/include/hw/m68k/next-cube.h
> @@ -0,0 +1,8 @@
> +
> +#ifndef NEXT_CUBE_H
> +#define NEXT_CUBE_H
> +
> +/* next-fb.c */
> +void nextfb_init(void);
> +
> +#endif /* NEXT_CUBE_H */

New header files should have copyright and license comment headers
too, though in this case if you drop the nextfb_init() function
then the header isn't needed any more.

thanks
-- PMM
