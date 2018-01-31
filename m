Received: from eggs.gnu.org ([2001:4830:134:3::10]:54290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvTw-0008B3-BT
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvTv-0000id-Bc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:43:32 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:41998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvTu-0000hn-UE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:43:31 -0500
Received: by mail-lf0-x241.google.com with SMTP id q17so21679989lfa.9
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:43:30 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123035837.16578-6-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:42:59 -0800
Message-ID: <CAKmqyKONWkSrxLm_mXmVvaMNJ-rdQDNfpQGPgY7US-oyqH8x1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] hw/sd/ssi-sd: use the SDBus API,
 connect the SDCard to the bus
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
> On reset the bus will reset the card,
> we can now drop the device_reset() call.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/ssi-sd.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index f88f509e0a..ae04b6641b 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -47,7 +47,7 @@ typedef struct {
>      int32_t arglen;
>      int32_t response_pos;
>      int32_t stopping;
> -    SDState *sd;
> +    SDBus sdbus;
>  } ssi_sd_state;
>
>  #define TYPE_SSI_SD "ssi-sd"
> @@ -100,7 +100,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
_t val)
>              request.arg =3D (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
>                             | (s->cmdarg[2] << 8) | s->cmdarg[3];
>              DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
> -            s->arglen =3D sd_do_command(s->sd, &request, longresp);
> +            s->arglen =3D sdbus_do_command(&s->sdbus, &request, longresp=
);
>              if (s->arglen <=3D 0) {
>                  s->arglen =3D 1;
>                  s->response[0] =3D 4;
> @@ -177,7 +177,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
_t val)
>              DPRINTF("Response 0x%02x\n", s->response[s->response_pos]);
>              return s->response[s->response_pos++];
>          }
> -        if (sd_data_ready(s->sd)) {
> +        if (sdbus_data_ready(&s->sdbus)) {
>              DPRINTF("Data read\n");
>              s->mode =3D SSI_SD_DATA_START;
>          } else {
> @@ -190,8 +190,8 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
_t val)
>          s->mode =3D SSI_SD_DATA_READ;
>          return 0xfe;
>      case SSI_SD_DATA_READ:
> -        val =3D sd_read_data(s->sd);
> -        if (!sd_data_ready(s->sd)) {
> +        val =3D sdbus_read_data(&s->sdbus);
> +        if (!sdbus_data_ready(&s->sdbus)) {
>              DPRINTF("Data read end\n");
>              s->mode =3D SSI_SD_CMD;
>          }
> @@ -242,13 +242,24 @@ static const VMStateDescription vmstate_ssi_sd =3D =
{
>  static void ssi_sd_realize(SSISlave *d, Error **errp)
>  {
>      ssi_sd_state *s =3D FROM_SSI_SLAVE(ssi_sd_state, d);
> +    DeviceState *carddev;
>      DriveInfo *dinfo;
> +    Error *err =3D NULL;
>
> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
> +                        DEVICE(d), "sd-bus");
> +
> +    /* Create and plug in the sd card */
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
> -    s->sd =3D sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, true);
> -    if (s->sd =3D=3D NULL) {
> -        error_setg(errp, "Device initialization failed.");
> +    carddev =3D qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
> +    if (dinfo) {
> +        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo)=
, &err);
> +    }
> +    object_property_set_bool(OBJECT(carddev), true, "spi", &err);
> +    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
> +    if (err) {
> +        error_setg(errp, "failed to init SD card: %s", error_get_pretty(=
err));
>          return;
>      }
>  }
> @@ -264,11 +275,6 @@ static void ssi_sd_reset(DeviceState *dev)
>      s->arglen =3D 0;
>      s->response_pos =3D 0;
>      s->stopping =3D 0;
> -
> -    /* Since we're still using the legacy SD API the card is not plugged
> -     * into any bus, and we must reset it manually.
> -     */
> -    device_reset(DEVICE(s->sd));
>  }
>
>  static void ssi_sd_class_init(ObjectClass *klass, void *data)
> --
> 2.15.1
>
>
