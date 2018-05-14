Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFkC-0007Ov-9o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFkB-0003zU-Cl
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:50:36 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFkB-0003zI-77
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:50:35 -0400
Received: by mail-ot0-x242.google.com with SMTP id l12-v6so14834431oth.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:50:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509060104.4458-3-f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:50:14 +0100
Message-ID: <CAFEAcA9OykjJYCfQj5Bgh8Hq5cUbzuYHMwCLouq4Rae0Zd40GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] sdcard: Correct CRC16 offset in
 sd_function_switch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On 9 May 2018 at 07:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> Per the Physical Layer Simplified Spec. "4.3.10.4 Switch Function Status"=
:
>
>   The block length is predefined to 512 bits
>
> and "4.10.2 SD Status":
>
>   The SD Status contains status bits that are related to the SD Memory Ca=
rd
>   proprietary features and may be used for future application-specific us=
age.
>   The size of the SD Status is one data block of 512 bit. The content of =
this
>   register is transmitted to the Host over the DAT bus along with a 16-bi=
t CRC.
>
> Thus the 16-bit CRC goes at offset 64.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5fb4787671..24aaf0c767 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -791,7 +791,7 @@ static void sd_function_switch(SDState *sd, uint32_t =
arg)
>          sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
>      }
>      memset(&sd->data[17], 0, 47);
> -    stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
> +    stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
>  }
>
>  static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
> --

Oops, yes, off-by-one error that's been present forever (it was
there before we did the conversion to stw_be_p()).

Applied this one to target-arm.next.

thanks
-- PMM
