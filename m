Received: from eggs.gnu.org ([2001:4830:134:3::10]:50683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvHZ-0001Op-Mo
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvHR-0006b0-M3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:45 -0500
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:34307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvHR-0006aY-Ed
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:30:37 -0500
Received: by mail-lf0-x230.google.com with SMTP id k19so21674392lfj.1
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:30:37 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123035837.16578-3-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:30:05 -0800
Message-ID: <CAKmqyKN-Cc9cJESWm-Vb9t5t2=KK_byNqAR1BgW6+BgBitsg_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] hw/sd/milkymist-memcard: split
 realize() out of SysBusDevice init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Create the SDCard in the realize() function.
>
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 1292c0c099..a8e65892c7 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -257,27 +257,31 @@ static void milkymist_memcard_reset(DeviceState *d)
>      device_reset(DEVICE(s->card));
>  }
>
> -static int milkymist_memcard_init(SysBusDevice *dev)
> +static void milkymist_memcard_init(Object *obj)
> +{
> +    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(obj);
> +    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops,=
 s,
> +            "milkymist-memcard", R_MAX * 4);
> +    sysbus_init_mmio(dev, &s->regs_region);
> +}
> +
> +static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> -    DriveInfo *dinfo;
>      BlockBackend *blk;
> +    DriveInfo *dinfo;
>
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
>      blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>      s->card =3D sd_init(blk, false);
>      if (s->card =3D=3D NULL) {
> -        return -1;
> +        error_setg(errp, "failed to init SD card");
> +        return;
>      }
> -
>      s->enabled =3D blk && blk_is_inserted(blk);
> -
> -    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops,=
 s,
> -            "milkymist-memcard", R_MAX * 4);
> -    sysbus_init_mmio(dev, &s->regs_region);
> -
> -    return 0;
>  }
>
>  static const VMStateDescription vmstate_milkymist_memcard =3D {
> @@ -300,9 +304,8 @@ static const VMStateDescription vmstate_milkymist_mem=
card =3D {
>  static void milkymist_memcard_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init =3D milkymist_memcard_init;
> +    dc->realize =3D milkymist_memcard_realize;
>      dc->reset =3D milkymist_memcard_reset;
>      dc->vmsd =3D &vmstate_milkymist_memcard;
>      /* Reason: init() method uses drive_get_next() */
> @@ -313,6 +316,7 @@ static const TypeInfo milkymist_memcard_info =3D {
>      .name          =3D TYPE_MILKYMIST_MEMCARD,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(MilkymistMemcardState),
> +    .instance_init =3D milkymist_memcard_init,
>      .class_init    =3D milkymist_memcard_class_init,
>  };
>
> --
> 2.15.1
>
>
