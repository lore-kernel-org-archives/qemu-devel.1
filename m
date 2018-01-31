Received: from eggs.gnu.org ([2001:4830:134:3::10]:51270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvIW-00027A-Oa
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvIQ-0007Ry-6k
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:31:44 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvIP-0007QF-Qn
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:31:38 -0500
Received: by mail-lf0-x243.google.com with SMTP id f136so21635098lff.8
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:31:37 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123035837.16578-4-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:31:05 -0800
Message-ID: <CAKmqyKPRX=wB-JsWY8Tt+SYh_6PO5JFoKcr2B7h6achxaRf1qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/sd/milkymist-memcard: expose a
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> using the sdbus_*() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index a8e65892c7..5570c1e9a0 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -69,7 +69,7 @@ struct MilkymistMemcardState {
>      SysBusDevice parent_obj;
>
>      MemoryRegion regs_region;
> -    SDState *card;
> +    SDBus sdbus;
>
>      int command_write_ptr;
>      int response_read_ptr;
> @@ -105,7 +105,7 @@ static void memcard_sd_command(MilkymistMemcardState =
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
> @@ -150,10 +150,10 @@ static uint64_t memcard_read(void *opaque, hwaddr a=
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
> @@ -207,10 +207,10 @@ static void memcard_write(void *opaque, hwaddr addr=
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
> @@ -251,10 +251,6 @@ static void milkymist_memcard_reset(DeviceState *d)
>      for (i =3D 0; i < R_MAX; i++) {
>          s->regs[i] =3D 0;
>      }
> -    /* Since we're still using the legacy SD API the card is not plugged
> -     * into any bus, and we must reset it manually.
> -     */
> -    device_reset(DEVICE(s->card));
>  }
>
>  static void milkymist_memcard_init(Object *obj)
> @@ -270,15 +266,23 @@ static void milkymist_memcard_init(Object *obj)
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
