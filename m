Received: from eggs.gnu.org ([2001:4830:134:3::10]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKCg-0005Hj-SW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKCf-00040C-SL
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:06 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euKCf-0003zx-N6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:05 -0500
Received: by mail-oi0-x242.google.com with SMTP id a207so7260267oii.10
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:45:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-2-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 15:44:44 +0000
Message-ID: <CAFEAcA_A+EKpc9BPbBOCU+-_Pw11D7ALDBZ5zDytzQPB6qp1QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] sdcard: Do not trace CMD55,
 except when we already expect an ACMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 933890e86f..4a9520e38e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -866,13 +866,18 @@ static void sd_lock_command(SDState *sd)
>          sd->card_status &=3D ~CARD_IS_LOCKED;
>  }
>
> -static sd_rsp_type_t sd_normal_command(SDState *sd,
> -                                       SDRequest req)
> +static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>  {
>      uint32_t rca =3D 0x0000;
>      uint64_t addr =3D (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : =
req.arg;
>
> -    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->stat=
e));
> +    /* CMD55 precedes an ACMD, so we are not interested in tracing it.
> +     * However there is no ACMD55, so we want to trace this particular c=
ase.
> +     */
> +    if (req.cmd !=3D 55 || sd->expecting_acmd) {
> +        trace_sdcard_normal_command(req.cmd, req.arg,
> +                                    sd_state_name(sd->state));
> +    }
>
>      /* Not interpreting this as an app command */
>      sd->card_status &=3D ~APP_CMD;
> --
> 2.16.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
