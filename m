Received: from eggs.gnu.org ([2001:4830:134:3::10]:44217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYf6K-0003jY-T2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYf6J-0003VT-Om
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:37:00 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103162400.10396-4-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:36:23 -0800
Message-ID: <CAKmqyKOBG7dKx+kDd9fSR6W5st7S1JPV=u66ZkigUjw3dyoCpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/sd/milkymist-memcard: expose a
 SDBus and connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:23 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> using the sdbus_*() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 5df3a0f815..9f4c7dad63 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -68,7 +68,7 @@ struct MilkymistMemcardState {
>      SysBusDevice parent_obj;
>
>      MemoryRegion regs_region;
> -    SDState *card;
> +    SDBus sdbus;
>
>      int command_write_ptr;
>      int response_read_ptr;
> @@ -104,7 +104,7 @@ static void memcard_sd_command(MilkymistMemcardState =
*s)
>      req.crc =3D s->command[5];
>
>      s->response[0] =3D req.cmd;
> -    s->response_len =3D sd_do_command(s->card, &req, s->response+1);
> +    s->response_len =3D sdbus_do_command(&s->sdbus, &req, s->response + =
1);
>      s->response_read_ptr =3D 0;
>
>      if (s->response_len =3D=3D 16) {
> @@ -149,10 +149,10 @@ static uint64_t memcard_read(void *opaque, hwaddr a=
ddr,
>              r =3D 0xffffffff;
>          } else {
>              r =3D 0;
> -            r |=3D sd_read_data(s->card) << 24;
> -            r |=3D sd_read_data(s->card) << 16;
> -            r |=3D sd_read_data(s->card) << 8;
> -            r |=3D sd_read_data(s->card);
> +            r |=3D sdbus_read_data(&s->sdbus) << 24;
> +            r |=3D sdbus_read_data(&s->sdbus) << 16;
> +            r |=3D sdbus_read_data(&s->sdbus) << 8;
> +            r |=3D sdbus_read_data(&s->sdbus);
>          }
>          break;
>      case R_CLK2XDIV:
> @@ -206,10 +206,10 @@ static void memcard_write(void *opaque, hwaddr addr=
, uint64_t value,
>          if (!s->enabled) {
>              break;
>          }
> -        sd_write_data(s->card, (value >> 24) & 0xff);
> -        sd_write_data(s->card, (value >> 16) & 0xff);
> -        sd_write_data(s->card, (value >> 8) & 0xff);
> -        sd_write_data(s->card, value & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
> +        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
> +        sdbus_write_data(&s->sdbus, value & 0xff);
>          break;
>      case R_ENABLE:
>          s->regs[addr] =3D value;
> @@ -266,15 +266,23 @@ static int milkymist_memcard_init(SysBusDevice *dev=
)
>  static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> +    DeviceState *carddev;
>      BlockBackend *blk;
>      DriveInfo *dinfo;
> +    Error *err =3D NULL;
>
> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
> +                        dev, "sd-bus");
> +
> +    /* Create and plug in the sd card */
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
>      blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> -    s->card =3D sd_init(blk, false);
> -    if (s->card =3D=3D NULL) {
> -        error_setg(errp, "failed to init SD card");
> +    carddev =3D qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
> +    qdev_prop_set_drive(carddev, "drive", blk, &err);
> +    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
> +    if (err) {
> +        error_setg(errp, "failed to init SD card: %s", error_get_pretty(=
err));
>          return;
>      }
>      s->enabled =3D blk && blk_is_inserted(blk);
> --
> 2.15.1
>
>
