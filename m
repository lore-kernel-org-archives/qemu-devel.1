Received: from eggs.gnu.org ([2001:4830:134:3::10]:33525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Un-0001n5-AZ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ee7Ul-0008HB-2q
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:56:49 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ee7Uk-0008EM-LD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:56:46 -0500
Received: by mail-lf0-x244.google.com with SMTP id f136so2704097lff.8
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 14:56:46 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123032135.28863-7-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
	<20180123032135.28863-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:56:14 -0800
Message-ID: <CAKmqyKMDAMJXxtJ15uXhBf=d_nh4m2VBS2VCjQ2_QRCB5MFgZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/12] sdcard: do not trace CMD55 when
 expecting ACMD
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index dc4b2329e4..27c08aa894 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -816,13 +816,15 @@ static void sd_lock_command(SDState *sd)
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
> +    if (req.cmd !=3D 55 || sd->expecting_acmd) {
> +        trace_sdcard_normal_command(req.cmd, req.arg,
> +                                    sd_state_name(sd->state));
> +    }
>
>      /* Not interpreting this as an app command */
>      sd->card_status &=3D ~APP_CMD;
> --
> 2.15.1
>
>
