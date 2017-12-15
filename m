Received: from eggs.gnu.org ([2001:4830:134:3::10]:59177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeQZ-0006xV-7i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeQY-0003NP-30
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:04:39 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePeQX-0003Mc-QP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:04:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id g75so14685428wme.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 17:04:37 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213204436.5379-7-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
	<20171213204436.5379-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 17:04:06 -0800
Message-ID: <CAKmqyKMTUKfXhU2qDPf+uG=RqMGq1WNW4H-HHeBZLNKjvJRM6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] sdbus: rename SDCardClass ->
 SDSlaveClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 12:44 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> By default a SD bus connect SD cards, however it may accept other SD devi=
ces
> like a SDIO device. The current class is not restricted to a SD "Card" de=
vice.
> To better reflect this is a SD bus slave, simply rename it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd-internal.h | 10 +++++-----
>  hw/sd/core.c        | 16 ++++++++--------
>  hw/sd/sd.c          |  4 ++--
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/hw/sd/sd-internal.h b/hw/sd/sd-internal.h
> index afd5dbf194..85a747ea64 100644
> --- a/hw/sd/sd-internal.h
> +++ b/hw/sd/sd-internal.h
> @@ -66,10 +66,10 @@ typedef enum {
>
>  typedef struct SDState SDState;
>
> -#define SD_CARD_CLASS(klass) \
> -    OBJECT_CLASS_CHECK(SDCardClass, (klass), TYPE_SD_CARD)
> -#define SD_CARD_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(SDCardClass, (obj), TYPE_SD_CARD)
> +#define SDBUS_SLAVE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(SDSlaveClass, (klass), TYPE_SD_CARD)
> +#define SDBUS_SLAVE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(SDSlaveClass, (obj), TYPE_SD_CARD)
>
>  typedef struct {
>      /*< private >*/
> @@ -83,7 +83,7 @@ typedef struct {
>      void (*enable)(SDState *sd, bool enable);
>      bool (*get_inserted)(SDState *sd);
>      bool (*get_readonly)(SDState *sd);
> -} SDCardClass;
> +} SDSlaveClass;
>
>  #define SD_BUS_CLASS(klass) OBJECT_CLASS_CHECK(SDBusClass, (klass), TYPE=
_SD_BUS)
>  #define SD_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(SDBusClass, (obj), TYPE_S=
D_BUS)
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index fc9ccfedb2..cd5b531cfa 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -49,7 +49,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint=
8_t *response)
>
>      trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc)=
;
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          sz =3D sc->do_command(card, req, response);
>          hexbuf =3D qemu_hexbuf_strdup(response, sz, NULL, "resp: ");
> @@ -67,7 +67,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
>
>      trace_sdbus_write(sdbus_name(sdbus), value);
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          sc->write_data(card, value);
>      }
> @@ -79,7 +79,7 @@ uint8_t sdbus_read_data(SDBus *sdbus)
>      uint8_t value =3D 0;
>
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          value =3D sc->read_data(card);
>      }
> @@ -93,7 +93,7 @@ bool sdbus_data_ready(SDBus *sdbus)
>      SDState *card =3D get_card(sdbus);
>
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          return sc->data_ready(card);
>      }
> @@ -106,7 +106,7 @@ bool sdbus_get_inserted(SDBus *sdbus)
>      SDState *card =3D get_card(sdbus);
>
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          return sc->get_inserted(card);
>      }
> @@ -119,7 +119,7 @@ bool sdbus_get_readonly(SDBus *sdbus)
>      SDState *card =3D get_card(sdbus);
>
>      if (card) {
> -        SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
> +        SDSlaveClass *sc =3D SDBUS_SLAVE_GET_CLASS(card);
>
>          return sc->get_readonly(card);
>      }
> @@ -150,7 +150,7 @@ void sdbus_set_readonly(SDBus *sdbus, bool readonly)
>  void sdbus_reparent_card(SDBus *from, SDBus *to)
>  {
>      SDState *card =3D get_card(from);
> -    SDCardClass *sc;
> +    SDSlaveClass *sc;
>      bool readonly;
>
>      /* We directly reparent the card object rather than implementing thi=
s
> @@ -165,7 +165,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
>          return;
>      }
>
> -    sc =3D SD_CARD_GET_CLASS(card);
> +    sc =3D SDBUS_SLAVE_GET_CLASS(card);
>      readonly =3D sc->get_readonly(card);
>
>      sdbus_set_inserted(from, false);
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9b7dee2ec4..97046df5c3 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1917,7 +1917,7 @@ static Property sd_properties[] =3D {
>  static void sd_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SDCardClass *sc =3D SD_CARD_CLASS(klass);
> +    SDSlaveClass *sc =3D SDBUS_SLAVE_CLASS(klass);
>
>      dc->realize =3D sd_realize;
>      dc->props =3D sd_properties;
> @@ -1938,7 +1938,7 @@ static const TypeInfo sd_info =3D {
>      .name =3D TYPE_SD_CARD,
>      .parent =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(SDState),
> -    .class_size =3D sizeof(SDCardClass),
> +    .class_size =3D sizeof(SDSlaveClass),
>      .class_init =3D sd_class_init,
>      .instance_init =3D sd_instance_init,
>      .instance_finalize =3D sd_instance_finalize,
> --
> 2.15.1
>
>
