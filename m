Received: from eggs.gnu.org ([2001:4830:134:3::10]:45687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYf99-0002av-24
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eYf98-0005SK-6g
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:39:55 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103162400.10396-6-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 8 Jan 2018 13:39:19 -0800
Message-ID: <CAKmqyKO9GmnFhqkj1N9zmz3tik45oebztW8VhECF-X+_imn4sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/sd/ssi-sd: expose a SDBus and
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:23 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> using the sdbus_*() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/ssi-sd.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 24001dc3e6..c8b27add84 100644
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
>  /* State word bits.  */
> @@ -97,7 +97,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t=
 val)
>              request.arg =3D (s->cmdarg[0] << 24) | (s->cmdarg[1] << 16)
>                             | (s->cmdarg[2] << 8) | s->cmdarg[3];
>              DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
> -            s->arglen =3D sd_do_command(s->sd, &request, longresp);
> +            s->arglen =3D sdbus_do_command(&s->sdbus, &request, longresp=
);
>              if (s->arglen <=3D 0) {
>                  s->arglen =3D 1;
>                  s->response[0] =3D 4;
> @@ -174,7 +174,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
_t val)
>              DPRINTF("Response 0x%02x\n", s->response[s->response_pos]);
>              return s->response[s->response_pos++];
>          }
> -        if (sd_data_ready(s->sd)) {
> +        if (sdbus_data_ready(&s->sdbus)) {
>              DPRINTF("Data read\n");
>              s->mode =3D SSI_SD_DATA_START;
>          } else {
> @@ -187,8 +187,8 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
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
> @@ -239,14 +239,25 @@ static const VMStateDescription vmstate_ssi_sd =3D =
{
>  static void ssi_sd_realize(SSISlave *d, Error **errp)
>  {
>      ssi_sd_state *s =3D FROM_SSI_SLAVE(ssi_sd_state, d);
> +    DeviceState *carddev;
>      DriveInfo *dinfo;
> +    Error *err =3D NULL;
>
>      s->mode =3D SSI_SD_CMD;
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
> --
> 2.15.1
>
>
