Received: from eggs.gnu.org ([2001:4830:134:3::10]:44537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopZg-00069u-1I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopZa-00080r-GW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:02:08 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eopZa-00080B-BP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:02:02 -0500
Received: by mail-oi0-x244.google.com with SMTP id b8so3498455oib.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 04:02:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215220540.6556-7-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 12:01:40 +0000
Message-ID: <CAFEAcA9rkRtO7e9M8RTbmZDYf05EVdjyuDb9ftF63hUhk+QvKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/11] sdcard: do not trace CMD55 when
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  hw/sd/sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 564f7a9bfd..af4df2b104 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -818,13 +818,15 @@ static void sd_lock_command(SDState *sd)
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

The commit message says "don't trace CMD55 when expecting ACMD",
but the code says "don't trace CMD55 when *not* expecting ACMD" --
which is correct?

thanks
-- PMM
