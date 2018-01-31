Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvGB-0008RL-6u
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvG9-0005r0-T3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:19 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:44621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvG9-0005qQ-LR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:17 -0500
Received: by mail-lf0-x242.google.com with SMTP id v188so21612629lfa.11
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:29:17 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123032135.28863-11-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
	<20180123032135.28863-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:28:45 -0800
Message-ID: <CAKmqyKMds=ebER8+5t+HKOA4xDVE+-MGjSkWZXVMa06LGw7ggQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/12] sdcard: rename sd_set_$REG()
 functions called once as sd_reset_$REG()
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

On Mon, Jan 22, 2018 at 7:21 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> All are only called once at reset.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I don't think this patch gets us anything, in the future someone might
use the functions to set values and then this new name will be
confusing. Can we drop this patch?

Alistair

> ---
>  hw/sd/sd.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c46e9c2818..8b5022a7db 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -269,7 +269,7 @@ static uint16_t sd_crc16(void *message, size_t width)
>      return shift_reg;
>  }
>
> -static void sd_set_ocr(SDState *sd)
> +static void sd_reset_ocr(SDState *sd)
>  {
>      /* All voltages OK, Standard Capacity SD Memory Card, not yet powere=
d up */
>      sd->ocr =3D 0x00ffff00;
> @@ -285,7 +285,7 @@ static void sd_ocr_powerup(void *opaque)
>      sd->ocr |=3D OCR_POWER_UP;
>  }
>
> -static void sd_set_scr(SDState *sd)
> +static void sd_reset_scr(SDState *sd)
>  {
>      sd->scr[0] =3D 0x00;         /* SCR Structure */
>      sd->scr[1] =3D 0x2f;         /* SD Security Support */
> @@ -304,7 +304,7 @@ static void sd_set_scr(SDState *sd)
>  #define MDT_YR 2006
>  #define MDT_MON        2
>
> -static void sd_set_cid(SDState *sd)
> +static void sd_reset_cid(SDState *sd)
>  {
>      sd->cid[0] =3D MID;          /* Fake card manufacturer ID (MID) */
>      sd->cid[1] =3D OID[0];       /* OEM/Application ID (OID) */
> @@ -336,7 +336,7 @@ static const uint8_t sd_csd_rw_mask[16] =3D {
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
>  };
>
> -static void sd_set_csd(SDState *sd, uint64_t size)
> +static void sd_reset_csd(SDState *sd, uint64_t size)
>  {
>      uint32_t csize =3D (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
>      uint32_t sectsize =3D (1 << (SECTOR_SHIFT + 1)) - 1;
> @@ -391,6 +391,11 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>      }
>  }
>
> +static void sd_reset_rca(SDState *sd)
> +{
> +    sd->rca =3D 0;
> +}
> +
>  static void sd_set_rca(SDState *sd)
>  {
>      sd->rca +=3D 0x4567;
> @@ -405,12 +410,12 @@ static void sd_set_rca(SDState *sd)
>  #define CARD_STATUS_B  0x00c01e00
>  #define CARD_STATUS_C  0xfd39a028
>
> -static void sd_set_cardstatus(SDState *sd)
> +static void sd_reset_cardstatus(SDState *sd)
>  {
>      sd->card_status =3D 0x00000100;
>  }
>
> -static void sd_set_sdstatus(SDState *sd)
> +static void sd_reset_sdstatus(SDState *sd)
>  {
>      memset(sd->sd_status, 0, 64);
>  }
> @@ -494,13 +499,13 @@ static void sd_reset(DeviceState *dev)
>      sect =3D sd_addr_to_wpnum(size) + 1;
>
>      sd->state =3D sd_idle_state;
> -    sd->rca =3D 0x0000;
> -    sd_set_ocr(sd);
> -    sd_set_scr(sd);
> -    sd_set_cid(sd);
> -    sd_set_csd(sd, size);
> -    sd_set_cardstatus(sd);
> -    sd_set_sdstatus(sd);
> +    sd_reset_rca(sd);
> +    sd_reset_ocr(sd);
> +    sd_reset_scr(sd);
> +    sd_reset_cid(sd);
> +    sd_reset_csd(sd, size);
> +    sd_reset_cardstatus(sd);
> +    sd_reset_sdstatus(sd);
>
>      g_free(sd->wp_groups);
>      sd->wp_switch =3D sd->blk ? blk_is_read_only(sd->blk) : false;
> --
> 2.15.1
>
>
