Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvlV-0001Hu-2v
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvlR-0002tY-55
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:01:41 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:42264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvlQ-0002sV-TP
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:01:37 -0500
Received: by mail-lf0-x244.google.com with SMTP id q17so21772125lfa.9
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:01:36 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-8-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-8-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 09:01:03 -0800
Message-ID: <CAKmqyKPD6aXWyn_YOU8_DPG+nY8dv8o=6Z9d-zV_gOcE+GwcXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/18] sdcard: use the correct masked
 OCR in the R3 reply
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
> use the registerfields API to access the OCR register
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 23f5d47782..ee381540aa 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -47,8 +47,6 @@
>
>  //#define DEBUG_SD 1
>
> -#define ACMD41_ENQUIRY_MASK     0x00ffffff
> -
>  typedef enum {
>      sd_r0 =3D 0,    /* no response */
>      sd_r1,        /* normal response command */
> @@ -271,13 +269,26 @@ static uint16_t sd_crc16(void *message, size_t widt=
h)
>
>  #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
>
> +FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
> +FIELD(OCR, VDD_VOLTAGE_WIN_LO,          0,  8)
> +FIELD(OCR, DUAL_VOLTAGE_CARD,           7,  1)
> +FIELD(OCR, VDD_VOLTAGE_WIN_HI,          8, 16)
> +FIELD(OCR, ACCEPT_SWITCH_1V8,          24,  1) /* Only UHS-I */
> +FIELD(OCR, UHS_II_CARD,                29,  1) /* Only UHS-II */
>  FIELD(OCR, CARD_CAPACITY,              30,  1) /* 0:SDSC, 1:SDHC/SDXC */
>  FIELD(OCR, CARD_POWER_UP,              31,  1)
>
> +#define ACMD41_ENQUIRY_MASK     0x00ffffff
> +#define ACMD41_R3_MASK          (R_OCR_VDD_VOLTAGE_WIN_HI_MASK \
> +                               | R_OCR_ACCEPT_SWITCH_1V8_MASK \
> +                               | R_OCR_UHS_II_CARD_MASK \
> +                               | R_OCR_CARD_CAPACITY_MASK \
> +                               | R_OCR_CARD_POWER_UP_MASK)
> +
>  static void sd_reset_ocr(SDState *sd)
>  {
> -    /* All voltages OK, Standard Capacity SD Memory Card, not yet powere=
d up */
> -    sd->ocr =3D 0x00ffff00;
> +    /* All voltages OK */
> +    sd->ocr =3D R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
>  }
>
>  static void sd_ocr_powerup(void *opaque)
> @@ -450,7 +461,7 @@ static void sd_response_r1_make(SDState *sd, uint8_t =
*response)
>
>  static void sd_response_r3_make(SDState *sd, uint8_t *response)
>  {
> -    stl_be_p(response, sd->ocr);
> +    stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
>  }
>
>  static void sd_response_r6_make(SDState *sd, uint8_t *response)
> @@ -1634,7 +1645,13 @@ send_response:
>      }
>
>  #ifdef DEBUG_SD
> -    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
> +    if (rsplen) {
> +        int i;
> +        DPRINTF("Response:");
> +        for (i =3D 0; i < rsplen; i++)
> +            fprintf(stderr, " %02x", response[i]);
> +        fputc('\n', stderr);
> +    }
>  #endif
>
>      return rsplen;
> --
> 2.15.1
>
>
