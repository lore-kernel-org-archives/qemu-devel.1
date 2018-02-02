Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehPik-0004MZ-HO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehPeG-0004EO-7c
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:00:50 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:38972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ehPeF-0004Ci-NL
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:56:11 -0500
Received: by mail-lf0-x244.google.com with SMTP id w27so29005979lfd.6
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 16:56:11 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-15-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-15-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 1 Feb 2018 16:55:39 -0800
Message-ID: <CAKmqyKNLv_7NgtYUDW1TcG029fc39dyv6YFh0MymAJh4KcAoLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/18] sdcard: simplify SD_SEND_OP_COND
 (ACMD41)
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
> replace switch(single case) -> if()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 56 ++++++++++++++++++++++++++------------------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 707c294169..6efcacb942 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1535,45 +1535,41 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>              sd->state =3D sd_transfer_state;
>              return sd_r1;
>          }
> -        switch (sd->state) {
> -        case sd_idle_state:
> -            /* If it's the first ACMD41 since reset, we need to decide
> -             * whether to power up. If this is not an enquiry ACMD41,
> -             * we immediately report power on and proceed below to the
> -             * ready state, but if it is, we set a timer to model a
> -             * delay for power up. This works around a bug in EDK2
> -             * UEFI, which sends an initial enquiry ACMD41, but
> -             * assumes that the card is in ready state as soon as it
> -             * sees the power up bit set. */
> -            if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
> -                if ((req.arg & ACMD41_ENQUIRY_MASK) !=3D 0) {
> -                    timer_del(sd->ocr_power_timer);
> -                    sd_ocr_powerup(sd);
> -                } else {
> -                    trace_sdcard_inquiry_cmd41();
> -                    if (!timer_pending(sd->ocr_power_timer)) {
> -                        timer_mod_ns(sd->ocr_power_timer,
> -                                     (qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL)
> -                                      + OCR_POWER_DELAY_NS));
> -                    }
> +        if (sd->state !=3D sd_idle_state) {
> +            break;
> +        }
> +        /* If it's the first ACMD41 since reset, we need to decide
> +         * whether to power up. If this is not an enquiry ACMD41,
> +         * we immediately report power on and proceed below to the
> +         * ready state, but if it is, we set a timer to model a
> +         * delay for power up. This works around a bug in EDK2
> +         * UEFI, which sends an initial enquiry ACMD41, but
> +         * assumes that the card is in ready state as soon as it
> +         * sees the power up bit set. */
> +        if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
> +            if ((req.arg & ACMD41_ENQUIRY_MASK) !=3D 0) {
> +                timer_del(sd->ocr_power_timer);
> +                sd_ocr_powerup(sd);
> +            } else {
> +                trace_sdcard_inquiry_cmd41();
> +                if (!timer_pending(sd->ocr_power_timer)) {
> +                    timer_mod_ns(sd->ocr_power_timer,
> +                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> +                                  + OCR_POWER_DELAY_NS));
>                  }
>              }
> +        }
>
> +        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
>              /* We accept any voltage.  10000 V is nothing.
>               *
>               * Once we're powered up, we advance straight to ready state
>               * unless it's an enquiry ACMD41 (bits 23:0 =3D=3D 0).
>               */
> -            if (req.arg & ACMD41_ENQUIRY_MASK) {
> -                sd->state =3D sd_ready_state;
> -            }
> -
> -            return sd_r3;
> -
> -        default:
> -            break;
> +            sd->state =3D sd_ready_state;
>          }
> -        break;
> +
> +        return sd_r3;
>
>      case 42:   /* ACMD42: SET_CLR_CARD_DETECT */
>          switch (sd->state) {
> --
> 2.15.1
>
>
