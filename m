Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2Tu-0008RD-W6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2Tt-0003aJ-Tk
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:11:58 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2Tt-0003a5-LK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:11:57 -0500
Received: by mail-lf0-x243.google.com with SMTP id a204so23474258lfa.2
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:11:57 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-10-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-10-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:11:25 -0800
Message-ID: <CAKmqyKM1FEgja40SQkOo9zHtx2Qv6GQcA=4VLSgnteGp3f4ZpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/18] sdcard: handles more commands in
 SPI mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:30 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
-
>  1 file changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 2eca999bc3..07424aa56e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1390,9 +1390,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>
>      /* Application specific commands (Class 8) */
>      case 55:   /* CMD55:  APP_CMD */
> -        if (sd->rca !=3D rca)
> -            return sd_r0;
> -
> +        if (!sd->spi) {
> +            if (sd->rca !=3D rca) {
> +                return sd_r0;
> +            }
> +        }
>          sd->expecting_acmd =3D true;
>          sd->card_status |=3D APP_CMD;
>          return sd_r1;
> @@ -1412,6 +1414,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>          }
>          break;
>
> +    case 58:    /* CMD58:   READ_OCR (SPI) */
> +        if (!sd->spi) {
> +            goto bad_cmd;
> +        }
> +        return sd_r3;
> +
> +    case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
> +        if (!sd->spi) {
> +            goto bad_cmd;
> +        }
> +        goto unimplemented_cmd;
> +
>      default:
>      bad_cmd:
>          qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
> @@ -1436,6 +1450,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>      sd->card_status |=3D APP_CMD;
>      switch (req.cmd) {
>      case 6:    /* ACMD6:  SET_BUS_WIDTH */
> +        if (sd->spi) {
> +            goto unimplemented_cmd;
> +        }
>          switch (sd->state) {
>          case sd_transfer_state:
>              sd->sd_status[0] &=3D 0x3f;
> @@ -1460,6 +1477,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>          }
>          break;
>
> +    case 18:

These should all have a comment describing what they are and for the
others as well.

> +        if (sd->spi) {
> +            goto unimplemented_cmd;
> +        }
> +        break;
> +
>      case 22:   /* ACMD22: SEND_NUM_WR_BLOCKS */
>          switch (sd->state) {
>          case sd_transfer_state:
> @@ -1485,6 +1508,19 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>          }
>          break;
>
> +    case 25:
> +    case 26:
> +        if (sd->spi) {
> +            goto unimplemented_cmd;
> +        }
> +        break;
> +
> +    case 38:
> +        if (sd->spi) {
> +            goto unimplemented_cmd;
> +        }
> +        break;
> +
>      case 41:   /* ACMD41: SD_APP_OP_COND */
>          if (sd->spi) {
>              /* SEND_OP_CMD */
> @@ -1542,6 +1578,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>          }
>          break;
>
> +    case 43 ... 49:
> +        if (sd->spi) {
> +            goto unimplemented_cmd;
> +        }
> +        break;
> +
>      case 51:   /* ACMD51: SEND_SCR */
>          switch (sd->state) {
>          case sd_transfer_state:
> @@ -1555,9 +1597,18 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>          }
>          break;
>
> +    case 55:    /* Not exist */
> +        break;
> +
>      default:
>          /* Fall back to standard commands.  */
>          return sd_normal_command(sd, req);
> +
> +    unimplemented_cmd:
> +        /* Commands that are recognised but not yet implemented in SPI m=
ode.  */

This should be unimplemented_spi_cmd then, to be more clear.

Alistair

> +        qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\=
n",
> +                      req.cmd);
> +        return sd_illegal;
>      }
>
>      qemu_log_mask(LOG_GUEST_ERROR, "SD: ACMD%i in a wrong state\n", req.=
cmd);
> --
> 2.15.1
>
>
