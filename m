Received: from eggs.gnu.org ([2001:4830:134:3::10]:48079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee79M-0006EL-RK
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee79L-0006U6-7O
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:34:40 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:42810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee79K-0006SF-UW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:34:39 -0500
Received: by mail-lf0-x242.google.com with SMTP id q17so2646175lfa.9
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 14:34:38 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123030630.26613-5-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
	<20180123030630.26613-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:34:06 -0800
Message-ID: <CAKmqyKMe0QnJbVavdCm1zbsAfnSs5r3xKJA=8vJqf8Vf2yhUKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 04/14] sdbus: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>

On Mon, Jan 22, 2018 at 7:06 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/core.c       | 14 ++++++++++++--
>  hw/sd/trace-events |  5 +++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 295dc44ab7..498284f109 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -23,6 +23,12 @@
>  #include "hw/qdev-core.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/sd/sd.h"
> +#include "trace.h"
> +
> +static inline const char *sdbus_name(SDBus *sdbus)
> +{
> +    return sdbus->qbus.name;
> +}
>
>  static SDState *get_card(SDBus *sdbus)
>  {
> @@ -39,6 +45,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint=
8_t *response)
>  {
>      SDState *card =3D get_card(sdbus);
>
> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc)=
;
>      if (card) {
>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>
> @@ -52,6 +59,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
>  {
>      SDState *card =3D get_card(sdbus);
>
> +    trace_sdbus_write(sdbus_name(sdbus), value);
>      if (card) {
>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>
> @@ -62,14 +70,16 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
>  uint8_t sdbus_read_data(SDBus *sdbus)
>  {
>      SDState *card =3D get_card(sdbus);
> +    uint8_t value =3D 0;
>
>      if (card) {
>          SDCardClass *sc =3D SD_CARD_GET_CLASS(card);
>
> -        return sc->read_data(card);
> +        value =3D sc->read_data(card);
>      }
> +    trace_sdbus_read(sdbus_name(sdbus), value);
>
> -    return 0;
> +    return value;
>  }
>
>  bool sdbus_data_ready(SDBus *sdbus)
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 78d8707669..ea2746c8b7 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -1,5 +1,10 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# hw/sd/core.c
> +sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t c=
rc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
> +sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
> +sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
> +
>  # hw/sd/sdhci.c
>  sdhci_set_inserted(const char *level) "card state changed: %s"
>  sdhci_send_command(uint8_t cmd, uint32_t arg) "CMD%02u ARG[0x%08x]"
> --
> 2.15.1
>
>
