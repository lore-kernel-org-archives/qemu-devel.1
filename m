Received: from eggs.gnu.org ([2001:4830:134:3::10]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvSq-0007Gn-CV
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvSp-0000I5-A2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:42:24 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123035837.16578-5-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:41:51 -0800
Message-ID: <CAKmqyKMoUcPhkr8bM1DU1QeBaRbJ9kAfOp_j-vFxf1y8p=1AbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> using the sdbus_*() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/pl181.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 3ba1f7dd23..ce696c5d7d 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -33,6 +33,7 @@ typedef struct PL181State {
>      SysBusDevice parent_obj;
>
>      MemoryRegion iomem;
> +    SDBus sdbus;
>      SDState *card;

Shouludn't card be removed?

Alistair

>      uint32_t clock;
>      uint32_t power;
> @@ -179,7 +180,7 @@ static void pl181_send_command(PL181State *s)
>      request.cmd =3D s->cmd & PL181_CMD_INDEX;
>      request.arg =3D s->cmdarg;
>      DPRINTF("Command %d %08x\n", request.cmd, request.arg);
> -    rlen =3D sd_do_command(s->card, &request, response);
> +    rlen =3D sdbus_do_command(&s->sdbus, &request, response);
>      if (rlen < 0)
>          goto error;
>      if (s->cmd & PL181_CMD_RESPONSE) {
> @@ -223,12 +224,12 @@ static void pl181_fifo_run(PL181State *s)
>      int is_read;
>
>      is_read =3D (s->datactrl & PL181_DATA_DIRECTION) !=3D 0;
> -    if (s->datacnt !=3D 0 && (!is_read || sd_data_ready(s->card))
> +    if (s->datacnt !=3D 0 && (!is_read || sdbus_data_ready(&s->sdbus))
>              && !s->linux_hack) {
>          if (is_read) {
>              n =3D 0;
>              while (s->datacnt && s->fifo_len < PL181_FIFO_LEN) {
> -                value |=3D (uint32_t)sd_read_data(s->card) << (n * 8);
> +                value |=3D (uint32_t)sdbus_read_data(&s->sdbus) << (n * =
8);
>                  s->datacnt--;
>                  n++;
>                  if (n =3D=3D 4) {
> @@ -249,7 +250,7 @@ static void pl181_fifo_run(PL181State *s)
>                  }
>                  n--;
>                  s->datacnt--;
> -                sd_write_data(s->card, value & 0xff);
> +                sdbus_write_data(&s->sdbus, value & 0xff);
>                  value >>=3D 8;
>              }
>          }
> @@ -480,10 +481,6 @@ static void pl181_reset(DeviceState *d)
>
>      /* We can assume our GPIO outputs have been wired up now */
>      sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
> -    /* Since we're still using the legacy SD API the card is not plugged
> -     * into any bus, and we must reset it manually.
> -     */
> -    device_reset(DEVICE(s->card));
>  }
>
>  static void pl181_init(Object *obj)
> @@ -502,14 +499,26 @@ static void pl181_init(Object *obj)
>  static void pl181_realize(DeviceState *dev, Error **errp)
>  {
>      PL181State *s =3D PL181(dev);
> +    DeviceState *carddev;
>      DriveInfo *dinfo;
> +    Error *err =3D NULL;
> +
> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
> +                        dev, "sd-bus");
>
> +    /* Create and plug in the sd card */
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
> -    s->card =3D sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false=
);
> -    if (s->card =3D=3D NULL) {
> -        error_setg(errp, "sd_init failed");
> +    carddev =3D qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
> +    if (dinfo) {
> +        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo)=
, &err);
> +    }
> +    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
> +    if (err) {
> +        error_setg(errp, "failed to init SD card: %s", error_get_pretty(=
err));
> +        return;
>      }
> +    s->card =3D SD_CARD(carddev);
>  }
>
>  static void pl181_class_init(ObjectClass *klass, void *data)
> --
> 2.15.1
>
>
