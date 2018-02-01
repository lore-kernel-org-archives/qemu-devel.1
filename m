Received: from eggs.gnu.org ([2001:4830:134:3::10]:50235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAq9-0006qL-Uu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAq6-000622-Pp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:29 -0500
Received: from ssl.serverraum.org ([213.133.101.245]:59723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1ehAq6-00061f-GM
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Feb 2018 10:07:25 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180123035837.16578-3-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-3-f4bug@amsat.org>
Message-ID: <468b247ac5f94147e5136d71f6a953d7@walle.cc>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-01-23 04:58, schrieb Philippe Mathieu-Daud=C3=A9:
> Create the SDCard in the realize() function.
>=20
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Michael Walle <michael@walle.cc>

> ---
>  hw/sd/milkymist-memcard.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 1292c0c099..a8e65892c7 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -257,27 +257,31 @@ static void milkymist_memcard_reset(DeviceState=20
> *d)
>      device_reset(DEVICE(s->card));
>  }
>=20
> -static int milkymist_memcard_init(SysBusDevice *dev)
> +static void milkymist_memcard_init(Object *obj)
> +{
> +    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(obj);
> +    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->regs_region, OBJECT(s),=20
> &memcard_mmio_ops, s,
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
>=20
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
> -    memory_region_init_io(&s->regs_region, OBJECT(s),=20
> &memcard_mmio_ops, s,
> -            "milkymist-memcard", R_MAX * 4);
> -    sysbus_init_mmio(dev, &s->regs_region);
> -
> -    return 0;
>  }
>=20
>  static const VMStateDescription vmstate_milkymist_memcard =3D {
> @@ -300,9 +304,8 @@ static const VMStateDescription
> vmstate_milkymist_memcard =3D {
>  static void milkymist_memcard_class_init(ObjectClass *klass, void=20
> *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>=20
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
