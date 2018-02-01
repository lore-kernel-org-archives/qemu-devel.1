Received: from eggs.gnu.org ([2001:4830:134:3::10]:50519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAqm-0007CL-7p
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAqk-0006Z0-ST
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:08:08 -0500
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:57983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1ehAqk-0006Xg-J5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:08:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Feb 2018 10:08:05 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180123035837.16578-4-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-4-f4bug@amsat.org>
Message-ID: <79fd3ee5e64caf962d20375d1966ed10@walle.cc>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-01-23 04:58, schrieb Philippe Mathieu-Daud=C3=A9:
> using the sdbus_*() API.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Michael Walle <michael@walle.cc>

> ---
>  hw/sd/milkymist-memcard.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index a8e65892c7..5570c1e9a0 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -69,7 +69,7 @@ struct MilkymistMemcardState {
>      SysBusDevice parent_obj;
>=20
>      MemoryRegion regs_region;
> -    SDState *card;
> +    SDBus sdbus;
>=20
>      int command_write_ptr;
>      int response_read_ptr;
> @@ -105,7 +105,7 @@ static void=20
> memcard_sd_command(MilkymistMemcardState *s)
>      req.crc =3D s->command[5];
>=20
>      s->response[0] =3D req.cmd;
> -    s->response_len =3D sd_do_command(s->card, &req, s->response+1);
> +    s->response_len =3D sdbus_do_command(&s->sdbus, &req, s->response =
+=20
> 1);
>      s->response_read_ptr =3D 0;
>=20
>      if (s->response_len =3D=3D 16) {
> @@ -150,10 +150,10 @@ static uint64_t memcard_read(void *opaque, hwaddr=
=20
> addr,
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
> @@ -207,10 +207,10 @@ static void memcard_write(void *opaque, hwaddr
> addr, uint64_t value,
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
> @@ -251,10 +251,6 @@ static void milkymist_memcard_reset(DeviceState=20
> *d)
>      for (i =3D 0; i < R_MAX; i++) {
>          s->regs[i] =3D 0;
>      }
> -    /* Since we're still using the legacy SD API the card is not=20
> plugged
> -     * into any bus, and we must reset it manually.
> -     */
> -    device_reset(DEVICE(s->card));
>  }
>=20
>  static void milkymist_memcard_init(Object *obj)
> @@ -270,15 +266,23 @@ static void milkymist_memcard_init(Object *obj)
>  static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> +    DeviceState *carddev;
>      BlockBackend *blk;
>      DriveInfo *dinfo;
> +    Error *err =3D NULL;
>=20
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
> +        error_setg(errp, "failed to init SD card: %s",=20
> error_get_pretty(err));
>          return;
>      }
>      s->enabled =3D blk && blk_is_inserted(blk);
