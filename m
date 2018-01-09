Received: from eggs.gnu.org ([2001:4830:134:3::10]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxAc-0002me-OR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1eYxAb-0000MZ-PV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:54:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 09 Jan 2018 17:54:30 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180103162400.10396-3-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-3-f4bug@amsat.org>
Message-ID: <60c89dbec86c14e2f0883d121872d0f6@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/sd/milkymist-memcard: split
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Xiaoqiang Zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Hey Philippe,

Am 2018-01-03 17:23, schrieb Philippe Mathieu-Daud=C3=A9:
> Create the SDCard in the realize() function.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/milkymist-memcard.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 5de3e00e2f..5df3a0f815 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -255,24 +255,29 @@ static void milkymist_memcard_reset(DeviceState=20
> *d)
>  static int milkymist_memcard_init(SysBusDevice *dev)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> -    DriveInfo *dinfo;
> +
> +    memory_region_init_io(&s->regs_region, OBJECT(s),=20
> &memcard_mmio_ops, s,
> +            "milkymist-memcard", R_MAX * 4);
> +    sysbus_init_mmio(dev, &s->regs_region);
> +
> +    return 0;
> +}

Creating the device (milkymist_memcard_create()) fails with an=20
assertion:
   sysbus_mmio_map_common: Assertion `n >=3D 0 && n < dev->num_mmio'=20
failed.

because dev->num_mmio is still 0. Seems that sysbus_init_mmio() hasn't=20
been called yet. Do we have to move the milkymist_memcard_init() to=20
.instance_init?

Eg.

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5df3a0f815..21c0e91926 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -252,15 +252,14 @@ static void milkymist_memcard_reset(DeviceState=20
*d)
      }
  }

-static int milkymist_memcard_init(SysBusDevice *dev)
+static void milkymist_memcard_init(Object *obj)
  {
-    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
+    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(obj);
+    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);

      memory_region_init_io(&s->regs_region, OBJECT(s),=20
&memcard_mmio_ops, s,
              "milkymist-memcard", R_MAX * 4);
      sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
  }

  static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
@@ -300,9 +299,7 @@ static const VMStateDescription=20
vmstate_milkymist_memcard =3D {
  static void milkymist_memcard_class_init(ObjectClass *klass, void=20
*data)
  {
      DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);

-    k->init =3D milkymist_memcard_init;
      dc->realize =3D milkymist_memcard_realize;
      dc->reset =3D milkymist_memcard_reset;
      dc->vmsd =3D &vmstate_milkymist_memcard;
@@ -314,6 +311,7 @@ static const TypeInfo milkymist_memcard_info =3D {
      .name          =3D TYPE_MILKYMIST_MEMCARD,
      .parent        =3D TYPE_SYS_BUS_DEVICE,
      .instance_size =3D sizeof(MilkymistMemcardState),
+    .instance_init =3D milkymist_memcard_init,
      .class_init    =3D milkymist_memcard_class_init,
  };

-michael

> +
> +static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
> +{
> +    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
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
> @@ -298,6 +303,7 @@ static void
> milkymist_memcard_class_init(ObjectClass *klass, void *data)
>      SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>=20
>      k->init =3D milkymist_memcard_init;
> +    dc->realize =3D milkymist_memcard_realize;
>      dc->reset =3D milkymist_memcard_reset;
>      dc->vmsd =3D &vmstate_milkymist_memcard;
>      /* Reason: init() method uses drive_get_next() */
