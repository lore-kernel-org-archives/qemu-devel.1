Received: from eggs.gnu.org ([2001:4830:134:3::10]:58890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvjz-0008Sp-LT
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvjv-0001Si-Qd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:00:07 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvjv-0001R5-Jr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:00:03 -0500
Received: by mail-lf0-x244.google.com with SMTP id w27so21788061lfd.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:00:03 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-6-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:59:31 -0800
Message-ID: <CAKmqyKPYH909azsP6EHn7-FmvbneJUE4kNGe1MqOimBLTHi6Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/18] sdcard: remove commands from
 unsupported old MMC specification
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
> This device does not model MMCA Specification previous to v4.2
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5d50d48097..3c66521862 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1044,24 +1044,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>          }
>          break;
>
> -    case 11:   /* CMD11:  READ_DAT_UNTIL_STOP */
> -        if (sd->spi)
> -            goto bad_cmd;
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            sd->state =3D sd_sendingdata_state;
> -            sd->data_start =3D req.arg;
> -            sd->data_offset =3D 0;
> -
> -            if (sd->data_start + sd->blk_len > sd->size)
> -                sd->card_status |=3D ADDRESS_ERROR;
> -            return sd_r0;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>      case 12:   /* CMD12:  STOP_TRANSMISSION */
>          switch (sd->state) {
>          case sd_sendingdata_state:
> @@ -1874,21 +1856,6 @@ uint8_t sd_read_data(SDState *sd)
>              sd->state =3D sd_transfer_state;
>          break;
>
> -    case 11:   /* CMD11:  READ_DAT_UNTIL_STOP */
> -        if (sd->data_offset =3D=3D 0)
> -            BLK_READ_BLOCK(sd->data_start, io_len);
> -        ret =3D sd->data[sd->data_offset ++];
> -
> -        if (sd->data_offset >=3D io_len) {
> -            sd->data_start +=3D io_len;
> -            sd->data_offset =3D 0;
> -            if (sd->data_start + io_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -                break;
> -            }
> -        }
> -        break;
> -
>      case 13:   /* ACMD13: SD_STATUS */
>          ret =3D sd->sd_status[sd->data_offset ++];
>
> --
> 2.15.1
>
>
