Received: from eggs.gnu.org ([2001:4830:134:3::10]:50101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorme-0007n8-Tx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eormd-0007M2-PH
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:23:40 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:32802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eormd-0007LU-IL
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:23:39 -0500
Received: by mail-ot0-x241.google.com with SMTP id k7so4052675otj.0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:23:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215221325.7611-18-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-18-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:23:18 +0000
Message-ID: <CAFEAcA9f-GNqaSbxKa0=U+uJaK7pVU+acG-1F4kiA6ctA1P53g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 17/20] sdcard: add SD SEND_TUNING_BLOCK
 (CMD19)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2015.2]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sd.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 911aae6233..4b0bb7992d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1166,6 +1166,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd=
, SDRequest req)
>          }
>          break;
>
> +    case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
> +        if (sd->state =3D=3D sd_transfer_state) {
> +            sd->state =3D sd_sendingdata_state;
> +            sd->data_offset =3D 0;
> +            return sd_r1;
> +        }
> +        break;
> +
>      case 23:    /* CMD23: SET_BLOCK_COUNT */
>          switch (sd->state) {
>          case sd_transfer_state:
> @@ -1889,6 +1897,15 @@ void sd_write_data(SDState *sd, uint8_t value)
>      }
>  }
>
> +#define SD_TUNING_BLOCK_SIZE    64
> +
> +static const uint32_t sd_tunning_data[SD_TUNING_BLOCK_SIZE / 4] =3D {

Typo, s/tunning/tuning/.

> +    0xFF0FFF00, 0x0FFCC3CC, 0xC33CCCFF, 0xFEFFFEEF,
> +    0xFFDFFFDD, 0xFFFBFFFB, 0XBFFF7FFF, 0X77F7BDEF,

Can we have lowercase 'x' consistently here please?

> +    0XFFF0FFF0, 0X0FFCCC3C, 0XCC33CCCF, 0XFFEFFFEE,
> +    0XFFFDFFFD, 0XDFFFBFFF, 0XBBFFF7FF, 0XF77F7BDE,
> +};

A comment about what all these magic numbers are for would
be useful.


> +
>  uint8_t sd_read_data(SDState *sd)
>  {
>      /* TODO: Append CRCs */
> @@ -1968,6 +1985,13 @@ uint8_t sd_read_data(SDState *sd)
>          }
>          break;
>
> +    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
> +        if (sd->data_offset >=3D SD_TUNING_BLOCK_SIZE - 1) {
> +            sd->state =3D sd_transfer_state;
> +        }
> +        ret =3D ((uint8_t *)(&sd_tunning_data))[sd->data_offset++];

If you're going to treat it as a uint8_t buffer it might be
cleaner to just declare it as a uint8_t buffer rather than
uint32_t: you'd get to avoid the cast here and the / 4 in
the array definition.

> +        break;
> +
>      case 22:   /* ACMD22: SEND_NUM_WR_BLOCKS */
>          ret =3D sd->data[sd->data_offset ++];
>
> --
> 2.16.1
>

thanks
-- PMM
