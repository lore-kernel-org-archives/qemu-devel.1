Received: from eggs.gnu.org ([2001:4830:134:3::10]:49455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXeBG-00029f-Ri
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXeBF-00016N-Sq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:25:54 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103162400.10396-3-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 5 Jan 2018 18:25:19 -0800
Message-ID: <CAKmqyKPzQhhK80WOnP7qbKMUBsQwfC7yT+2A67u=AU3g2rLUzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Xiaoqiang Zhao <zxq_yx_007@163.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:23 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Create the SDCard in the realize() function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 5de3e00e2f..5df3a0f815 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -255,24 +255,29 @@ static void milkymist_memcard_reset(DeviceState *d)
>  static int milkymist_memcard_init(SysBusDevice *dev)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> -    DriveInfo *dinfo;
> +
> +    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops,=
 s,
> +            "milkymist-memcard", R_MAX * 4);
> +    sysbus_init_mmio(dev, &s->regs_region);
> +
> +    return 0;
> +}
> +
> +static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
> +{
> +    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
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
> @@ -298,6 +303,7 @@ static void milkymist_memcard_class_init(ObjectClass =
*klass, void *data)
>      SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>
>      k->init =3D milkymist_memcard_init;
> +    dc->realize =3D milkymist_memcard_realize;
>      dc->reset =3D milkymist_memcard_reset;
>      dc->vmsd =3D &vmstate_milkymist_memcard;
>      /* Reason: init() method uses drive_get_next() */
> --
> 2.15.1
>
>
